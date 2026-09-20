import Std

/-!
Deterministic paths and regime classes. A ranking function is a substantive
hypothesis, not something obtained merely from calling a state autocratic.
-/
namespace AutocracyStability

def orbit {S : Type} (next : S → S) (initial : S) : Nat → S
  | 0 => initial
  | t + 1 => next (orbit next initial t)

/-- A forward-closed class containing the starting state persists forever. -/
theorem invariant_forever {S : Type} (next : S → S) (P : S → Prop) (s : S)
    (h0 : P s) (closed : ∀ x, P x → P (next x)) :
    ∀ t, P (orbit next s t) := by
  intro t
  induction t with
  | zero => exact h0
  | succ t ih => exact closed _ ih

/-- If all states through t are autocratic and each such transition consumes
one unit of finite rank, rank remaining plus elapsed time is bounded. -/
theorem rank_bound {S : Type} (path : Nat → S) (A : S → Prop) (rank : S → Nat)
    (decreases : ∀ t, A (path t) → A (path (t + 1)) →
      rank (path (t + 1)) < rank (path t)) :
    ∀ t, (∀ i, i ≤ t → A (path i)) → rank (path t) + t ≤ rank (path 0) := by
  intro t
  induction t with
  | zero => intro _; omega
  | succ t ih =>
    intro ha
    have hp := ih (fun i hi => ha i (by omega))
    have hd := decreases t (ha t (by omega)) (ha (t + 1) (by omega))
    omega

/-- A finite-rank certificate rules out indefinite autocratic-to-autocratic
succession, irrespective of how many leaders or regime identities are used. -/
theorem exit_by_rank {S : Type} (path : Nat → S) (A : S → Prop) (rank : S → Nat)
    (decreases : ∀ t, A (path t) → A (path (t + 1)) →
      rank (path (t + 1)) < rank (path t)) :
    ∃ t, t ≤ rank (path 0) + 1 ∧ ¬ A (path t) := by
  classical
  apply Classical.byContradiction
  intro hn
  have hall : ∀ i, i ≤ rank (path 0) + 1 → A (path i) := by
    intro i hi
    apply Classical.byContradiction
    intro hni
    exact hn ⟨i, hi, hni⟩
  have hb := rank_bound path A rank decreases (rank (path 0) + 1) hall
  omega

/-- Leaving autocracy entails democracy only with an explicit classification
assumption. Staying democratic additionally needs a separate closure condition. -/
theorem durable_democracy_if_exit_and_closed {S : Type}
    (path : Nat → S) (A D : S → Prop) (rank : S → Nat)
    (decreases : ∀ t, A (path t) → A (path (t + 1)) →
      rank (path (t + 1)) < rank (path t))
    (classification : ∀ s, ¬ A s → D s)
    (closed : ∀ t, D (path t) → D (path (t + 1))) :
    ∃ t, t ≤ rank (path 0) + 1 ∧ ∀ j, D (path (t + j)) := by
  obtain ⟨t, ht, hn⟩ := exit_by_rank path A rank decreases
  refine ⟨t, ht, ?_⟩
  intro j
  induction j with
  | zero => simpa using classification (path t) hn
  | succ j ih =>
    simpa [Nat.add_assoc] using closed (t + j) ih

inductive Regime where
  | autocracy
  | democracy
  deriving DecidableEq, Repr

structure PoliticalState where
  regime : Regime
  leader : Nat
  deriving DecidableEq, Repr

/-- Countermodel: every period replaces the leader, preserving the regime class. -/
def succession (s : PoliticalState) : PoliticalState :=
  { regime := s.regime, leader := s.leader + 1 }

theorem succession_autocracy_forever :
    ∀ t, (orbit succession ⟨.autocracy, 0⟩ t).regime = .autocracy := by
  apply invariant_forever succession (fun s => s.regime = .autocracy)
  · rfl
  · intro s hs; exact hs

theorem succession_changes_leader (t : Nat) :
    (orbit succession ⟨.autocracy, 0⟩ t).leader = t := by
  induction t with
  | zero => rfl
  | succ t ih => simpa [orbit, succession] using congrArg Nat.succ ih

/-- A concrete counterexample to the claim that all regime paths eventually
leave autocracy. This is a logical countermodel, not a historical forecast. -/
theorem universal_autocratic_exit_false :
    ¬ (∀ path : Nat → PoliticalState,
      ∃ t, (path t).regime ≠ .autocracy) := by
  intro h
  obtain ⟨t, ht⟩ := h (orbit succession ⟨.autocracy, 0⟩)
  exact ht (succession_autocracy_forever t)

inductive BasinState where
  | stable
  | left
  | right
  deriving DecidableEq

def basinNext : BasinState → BasinState
  | .stable => .stable
  | .left => .right
  | .right => .left

/-- A stable outcome's existence does not imply a process ever reaches it. -/
theorem fixed_point_without_global_convergence :
    basinNext .stable = .stable ∧
    ∀ t, orbit basinNext .left t ≠ .stable := by
  refine ⟨rfl, ?_⟩
  apply invariant_forever basinNext (fun s => s ≠ .stable)
  · decide
  · intro s hs
    cases s with
    | stable => exact False.elim (hs rfl)
    | left => decide
    | right => decide

end AutocracyStability
