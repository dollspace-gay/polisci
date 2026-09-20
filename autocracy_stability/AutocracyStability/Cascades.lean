import Std

/-!
Progressive threshold participation. Response functions count total willing
participants, including any permanent initial participants. Participation does
not reverse within an episode. Policy changes may alter future responses.
-/
namespace AutocracyStability

def IncreasingResponse (response : Nat → Nat) : Prop :=
  ∀ a b, a ≤ b → response a ≤ response b

def evolvingCascade (response : Nat → Nat → Nat) (seed : Nat) : Nat → Nat
  | 0 => seed
  | t + 1 => max (evolvingCascade response seed t)
      (response t (evolvingCascade response seed t))

def cascade (response : Nat → Nat) (seed : Nat) : Nat → Nat :=
  evolvingCascade (fun _ => response) seed

theorem participation_persists (response : Nat → Nat → Nat) (seed t : Nat) :
    evolvingCascade response seed t ≤ evolvingCascade response seed (t + 1) := by
  exact Nat.le_max_left _ _

theorem seed_persists (response : Nat → Nat → Nat) (seed t : Nat) :
    seed ≤ evolvingCascade response seed t := by
  induction t with
  | zero => exact Nat.le_refl _
  | succ t ih => exact Nat.le_trans ih (participation_persists response seed t)

/-- A common upper barrier traps even an evolving response landscape. -/
theorem evolving_barrier (response : Nat → Nat → Nat) (seed barrier : Nat)
    (initial : seed ≤ barrier)
    (closed : ∀ t a, a ≤ barrier → response t a ≤ barrier) :
    ∀ t, evolvingCascade response seed t ≤ barrier := by
  intro t
  induction t with
  | zero => exact initial
  | succ t ih =>
    exact Nat.max_le.mpr ⟨ih, closed t _ ih⟩

theorem cascade_barrier (response : Nat → Nat) (seed barrier : Nat)
    (mono : IncreasingResponse response) (initial : seed ≤ barrier)
    (blocked : response barrier ≤ barrier) :
    ∀ t, cascade response seed t ≤ barrier := by
  exact evolving_barrier (fun _ => response) seed barrier initial
    (fun _ a ha => Nat.le_trans (mono a barrier ha) blocked)

/-- One new participant at every sub-target state gives a finite bound,
even if responses change between rounds. -/
theorem evolving_progress (response : Nat → Nat → Nat) (seed target : Nat)
    (growth : ∀ t a, seed ≤ a → a < target → a < response t a) :
    ∀ t, target ≤ evolvingCascade response seed t ∨
      seed + t ≤ evolvingCascade response seed t := by
  intro t
  induction t with
  | zero => exact Or.inr (Nat.le_refl _)
  | succ t ih =>
    have hp := participation_persists response seed t
    by_cases reached : target ≤ evolvingCascade response seed t
    · exact Or.inl (Nat.le_trans reached hp)
    · have hg := growth t _ (seed_persists response seed t) (by omega)
      have hr : response t (evolvingCascade response seed t) ≤
          evolvingCascade response seed (t + 1) := Nat.le_max_right _ _
      rcases ih with h | h
      · exact False.elim (reached h)
      · exact Or.inr (by omega)

theorem evolving_reaches (response : Nat → Nat → Nat) (seed target : Nat)
    (initial : seed ≤ target)
    (growth : ∀ t a, seed ≤ a → a < target → a < response t a) :
    target ≤ evolvingCascade response seed (target - seed) := by
  have h := evolving_progress response seed target growth (target - seed)
  omega

/-- Exact reachability criterion for a fixed monotone response. -/
theorem cascade_reaches_iff_no_barrier (response : Nat → Nat) (seed target : Nat)
    (mono : IncreasingResponse response) (initial : seed ≤ target) :
    (∃ t, target ≤ cascade response seed t) ↔
      (∀ b, seed ≤ b → b < target → b < response b) := by
  constructor
  · rintro ⟨t, ht⟩ b hb hbt
    by_cases h : b < response b
    · exact h
    · have trapped := cascade_barrier response seed b mono hb (by omega) t
      omega
  · intro growth
    exact ⟨target - seed, evolving_reaches (fun _ => response) seed target initial
      (fun _ => growth)⟩

def policyCascade {Policy : Type} (response : Policy → Nat → Nat)
    (schedule : Nat → Policy) (seed : Nat) : Nat → Nat :=
  evolvingCascade (fun t => response (schedule t)) seed

/-- Reform and succession are permitted to choose a different response every
round. This is an equivalence for this progressive, memoryless model. -/
theorem all_policy_paths_reach_iff {Policy : Type}
    (response : Policy → Nat → Nat) (seed target : Nat)
    (mono : ∀ p, IncreasingResponse (response p)) (initial : seed ≤ target) :
    (∀ schedule : Nat → Policy, ∃ t, target ≤ policyCascade response schedule seed t) ↔
      (∀ p b, seed ≤ b → b < target → b < response p b) := by
  constructor
  · intro hall p
    have hfixed : ∃ t, target ≤ cascade (response p) seed t := hall (fun _ => p)
    exact (cascade_reaches_iff_no_barrier (response p) seed target (mono p) initial).mp hfixed
  · intro growth schedule
    exact ⟨target - seed, evolving_reaches (fun t => response (schedule t)) seed target
      initial (fun t => growth (schedule t))⟩

/-- If policy can reduce the baseline response by at most a fixed number,
an activation margin larger than that number defeats every policy schedule.
The bound on policy efficacy is an explicit hypothesis, not a regime property. -/
theorem bounded_adaptation_cannot_stop {Policy : Type}
    (baseline : Nat → Nat) (response : Policy → Nat → Nat)
    (seed target budget : Nat) (initial : seed ≤ target)
    (limited : ∀ p a, baseline a ≤ response p a + budget)
    (margin : ∀ a, seed ≤ a → a < target → a + budget < baseline a) :
    ∀ schedule, target ≤ policyCascade response schedule seed (target - seed) := by
  intro schedule
  apply evolving_reaches (fun t => response (schedule t)) seed target initial
  intro t a hsa hat
  have hlimit := limited (schedule t) a
  have hmargin := margin a hsa hat
  omega

/-- Pointwise greater responses and a larger starting group cannot shrink a
progressive cascade. The larger response must be monotone. -/
theorem cascade_comparison (low high : Nat → Nat) (small large : Nat)
    (mono : IncreasingResponse high) (responses : ∀ a, low a ≤ high a)
    (seeds : small ≤ large) :
    ∀ t, cascade low small t ≤ cascade high large t := by
  intro t
  induction t with
  | zero => exact seeds
  | succ t ih =>
    have hr := Nat.le_trans (responses (cascade low small t))
      (mono _ _ ih)
    change max (cascade low small t) (low (cascade low small t)) ≤
      max (cascade high large t) (high (cascade high large t))
    exact Nat.max_le.mpr ⟨Nat.le_trans ih (Nat.le_max_left _ _),
      Nat.le_trans hr (Nat.le_max_right _ _)⟩

def readyCount : List Nat → Nat → Nat
  | [], _ => 0
  | threshold :: rest, active =>
      (if threshold ≤ active then 1 else 0) + readyCount rest active

theorem ready_count_mono (thresholds : List Nat) : IncreasingResponse (readyCount thresholds) := by
  intro a b hab
  induction thresholds with
  | nil => exact Nat.le_refl _
  | cons threshold rest ih =>
    simp only [readyCount]
    by_cases ha : threshold ≤ a <;> by_cases hb : threshold ≤ b <;>
      simp [ha, hb] <;> omega

theorem ready_count_bounded (thresholds : List Nat) (active : Nat) :
    readyCount thresholds active ≤ thresholds.length := by
  induction thresholds with
  | nil => exact Nat.le_refl _
  | cons threshold rest ih =>
    simp only [readyCount, List.length_cons]
    split <;> omega

/-- Thresholds list only the unseeded people, so seeds are never counted twice. -/
def thresholdResponse (seed : Nat) (thresholds : List Nat) (active : Nat) : Nat :=
  seed + readyCount thresholds active

theorem threshold_response_mono (seed : Nat) (thresholds : List Nat) :
    IncreasingResponse (thresholdResponse seed thresholds) := by
  intro a b hab
  exact Nat.add_le_add_left (ready_count_mono thresholds a b hab) seed

theorem population_bound (seed : Nat) (thresholds : List Nat) :
    ∀ t, cascade (thresholdResponse seed thresholds) seed t ≤ seed + thresholds.length := by
  apply evolving_barrier
  · omega
  · intro t a _
    exact Nat.add_le_add_left (ready_count_bounded thresholds a) seed

theorem stalled_unanimity :
    ∀ t, cascade (thresholdResponse 0 [1, 1, 1, 1]) 0 t = 0 := by
  intro t
  have h := cascade_barrier (thresholdResponse 0 [1, 1, 1, 1]) 0 0
    (threshold_response_mono _ _) (by decide) (by decide) t
  omega

theorem spontaneous_threshold_cascade :
    cascade (thresholdResponse 0 [0, 1, 2, 3]) 0 4 = 4 := by decide

/-- One of four people becomes a permanent seed; the other three retain
threshold one. The population size stays four. -/
theorem seeded_threshold_cascade :
    cascade (thresholdResponse 1 [1, 1, 1]) 1 1 = 4 := by decide

end AutocracyStability
