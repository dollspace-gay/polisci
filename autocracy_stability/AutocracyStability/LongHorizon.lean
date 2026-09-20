import Std

/-!
Exact rational survival tails, represented by natural numerators and positive
denominators. Cross multiplication avoids floating-point arithmetic. No
infinite probability-space construction is imported: VanishingTail is the
explicit epsilon criterion for survival probabilities tending to zero.
-/
namespace AutocracyStability

def VanishingTail (numerator denominator : Nat → Nat) : Prop :=
  ∀ k, 0 < k → ∃ horizon, ∀ n, horizon ≤ n → k * numerator n ≤ denominator n

/-- With b+1 equally weighted extensions per surviving history and at most b
surviving extensions, the survival numerator is bounded by b^n. The identity
of fatal extensions may depend on the full past. -/
theorem survival_count_bound (survivors : Nat → Nat) (b : Nat)
    (initial : survivors 0 ≤ 1)
    (conditional : ∀ n, survivors (n + 1) ≤ b * survivors n) :
    ∀ n, survivors n ≤ b ^ n := by
  intro n
  induction n with
  | zero => simpa using initial
  | succ n ih =>
    have hm := Nat.mul_le_mul_left b ih
    have hs := conditional n
    simpa [Nat.pow_succ, Nat.mul_comm] using Nat.le_trans hs hm

/-- An elementary bound sufficient to prove the geometric tail vanishes. -/
theorem geometric_tail_bound (b n : Nat) :
    b ^ n * (b + n) ≤ b * (b + 1) ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
    have hp := Nat.pow_le_pow_left (Nat.le_succ b) n
    have h1 := Nat.mul_le_mul_left b ih
    have h2 := Nat.mul_le_mul_left b hp
    have hsum := Nat.add_le_add h1 h2
    simpa [Nat.pow_succ, Nat.mul_add, Nat.add_mul, Nat.mul_assoc,
      Nat.mul_comm, Nat.mul_left_comm, Nat.add_assoc] using hsum

/-- Recurrent conditional risk bounded below by 1/(b+1) makes survival tend
to zero. No independence of government-exit events is used. -/
theorem recurrent_risk_vanishing_tail (survivors : Nat → Nat) (b : Nat)
    (positive : 0 < b) (initial : survivors 0 ≤ 1)
    (conditional : ∀ n, survivors (n + 1) ≤ b * survivors n) :
    VanishingTail survivors (fun n => (b + 1) ^ n) := by
  intro k _
  refine ⟨k * b, ?_⟩
  intro n hn
  have hs := survival_count_bound survivors b initial conditional n
  have hb := geometric_tail_bound b n
  have hleft := Nat.mul_le_mul_right (b ^ n) (show k * b ≤ b + n by omega)
  have hbig : b * (k * b ^ n) ≤ b * (b + 1) ^ n := by
    have hb' : (b + n) * b ^ n ≤ b * (b + 1) ^ n := by
      simpa [Nat.mul_comm] using hb
    have ht := Nat.le_trans hleft hb'
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using ht
  have hcancel := Nat.le_of_mul_le_mul_left hbig positive
  exact Nat.le_trans (Nat.mul_le_mul_left k hs) hcancel

/-- Opportunity counts may grow arbitrarily slowly in calendar time, provided
they eventually exceed every finite number. -/
theorem unbounded_opportunities_preserve_vanishing
    (numerator denominator opportunities : Nat → Nat)
    (vanishes : VanishingTail numerator denominator)
    (recurs : ∀ bound, ∃ date, ∀ t, date ≤ t → bound ≤ opportunities t) :
    VanishingTail (fun t => numerator (opportunities t))
      (fun t => denominator (opportunities t)) := by
  intro k hk
  obtain ⟨n, hn⟩ := vanishes k hk
  obtain ⟨date, hd⟩ := recurs n
  exact ⟨date, fun t ht => hn (opportunities t) (hd t ht)⟩

/-- Constant positive risk need not impose a finite deterministic deadline:
the full safe-branch bound still allows surviving paths at every finite depth. -/
theorem positive_survival_at_every_finite_horizon (b : Nat) (hb : 0 < b) :
    ∀ n, 0 < b ^ n := by
  intro n
  have h := Nat.one_le_pow n b hb
  omega

/-- A diminishing conditional risk can still force exit: the survival fraction
1/(n+1) tends to zero. -/
theorem decreasing_risk_can_still_vanish :
    VanishingTail (fun _ => 1) (fun n => n + 1) := by
  intro k _
  exact ⟨k, fun n hn => by simp; omega⟩

/-- For S_n=1/(n+1), the conditional survival factor is (n+1)/(n+2),
so conditional exit risk is 1/(n+2). -/
theorem decreasing_risk_recurrence (n : Nat) :
    1 * (n + 1) * (n + 2) = 1 * (n + 2) * (n + 1) := by
  simp [Nat.mul_comm]

theorem survival_denominators_positive (b n : Nat) :
    0 < (b + 1) ^ n := by
  have h := Nat.one_le_pow n (b + 1) (by omega)
  omega

theorem shrinking_risk_valid_probabilities (n : Nat) :
    0 < 2 * n + 2 ∧ n + 2 ≤ 2 * n + 2 := by omega

/-- The survival probability falls strictly at every finite round; remaining
above one half does not depend on a risk-free round. -/
theorem shrinking_risk_strictly_decreases (n : Nat) :
    (n + 3) * (2 * n + 2) < (n + 2) * (2 * (n + 1) + 2) := by
  simp [Nat.mul_add, Nat.add_mul]
  omega

/-- Strictly decreasing survival does not suffice. These exact probabilities
are (n+2)/(2n+2), which remain strictly above one half. -/
theorem shrinking_risk_survival_floor (n : Nat) :
    2 * n + 2 < 2 * (n + 2) := by omega

theorem shrinking_risk_not_vanishing :
    ¬ VanishingTail (fun n => n + 2) (fun n => 2 * n + 2) := by
  intro h
  obtain ⟨horizon, hh⟩ := h 3 (by decide)
  have impossible := hh horizon (Nat.le_refl _)
  dsimp at impossible
  omega

/-- Cross multiplication verifies the exact conditional survival recurrence:
S_(n+1) / S_n = 1 - 1/(n+2)^2. Thus exit risk is positive every round. -/
theorem shrinking_risk_recurrence (n : Nat) :
    (n + 3) * (2 * n + 2) * ((n + 2) * (n + 2)) =
      (n + 2) * (2 * (n + 1) + 2) * ((n + 1) * (n + 3)) := by
  have h1 : 2 * n + 2 = 2 * (n + 1) := by omega
  have h2 : 2 * (n + 1) + 2 = 2 * (n + 2) := by omega
  rw [h1, h2]
  simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]

theorem shrinking_risk_positive (n : Nat) :
    (n + 1) * (n + 3) + 1 = (n + 2) * (n + 2) := by
  simp [Nat.mul_add, Nat.add_mul]
  omega

/-- Surviving mass approaches one half: its excess is 1/(2n+2).
This identity is cross multiplied; the excess satisfies VanishingTail. -/
theorem shrinking_survival_half_plus_excess (n : Nat) :
    2 * (n + 2) = (2 * n + 2) + 2 := by omega

theorem shrinking_survival_excess_vanishes :
    VanishingTail (fun _ => 1) (fun n => 2 * n + 2) := by
  intro k _
  exact ⟨k, fun n hn => by simp; omega⟩

end AutocracyStability
