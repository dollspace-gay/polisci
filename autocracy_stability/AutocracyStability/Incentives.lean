import AutocracyStability.Repair

/-!
A two-action, myopic or reduced-form continuation-value model.
Political labels play no role in the mathematics. Utility differences must be
independently justified; they are NOT inferred from "autocracy" or "democracy".
-/
namespace AutocracyStability

inductive Action where
  | protect
  | correct
  deriving DecidableEq, Repr

def BestResponse (u : Action → Int) (chosen : Action) : Prop :=
  ∀ alternative, u alternative ≤ u chosen

theorem strict_protect_selected (u : Action → Int) (a : Action)
    (h : u .correct < u .protect) (hb : BestResponse u a) : a = .protect := by
  cases a with
  | protect => rfl
  | correct =>
    have hx := hb .protect
    omega

theorem strict_correct_selected (u : Action → Int) (a : Action)
    (h : u .protect < u .correct) (hb : BestResponse u a) : a = .correct := by
  cases a with
  | correct => rfl
  | protect =>
    have hx := hb .correct
    omega

def capacity (low high : Nat) : Action → Nat
  | .protect => low
  | .correct => high

/-- A power-preservation incentive plus inadequate low capacity implies failure.
The conclusion is derived from choices; no failure assumption appears here. -/
theorem incentive_trap (initial bound low high : Nat)
    (arrival : Nat → Nat) (u : Nat → Action → Int) (choice : Nat → Action)
    (hp : ∀ t, u t .correct < u t .protect)
    (hb : ∀ t, BestResponse (u t) (choice t))
    (hl : ∀ t, low + 1 ≤ arrival t) :
    ¬ Survives initial arrival (fun t => capacity low high (choice t)) bound := by
  apply persistent_shortfall_not_survives
  intro t
  rw [strict_protect_selected (u t) (choice t) (hp t) (hb t)]
  exact hl t

/-- Rewarding correction, adequate high capacity, and an initially viable state
jointly suffice for viability in this model. -/
theorem accountable_correction (initial bound low high : Nat)
    (arrival : Nat → Nat) (u : Nat → Action → Int) (choice : Nat → Action)
    (hi : initial ≤ bound)
    (hp : ∀ t, u t .protect < u t .correct)
    (hb : ∀ t, BestResponse (u t) (choice t))
    (hh : ∀ t, arrival t ≤ high) :
    Survives initial arrival (fun t => capacity low high (choice t)) bound := by
  apply adequate_repair_survives initial bound arrival _ hi
  intro t
  rw [strict_correct_selected (u t) (choice t) (hp t) (hb t)]
  exact hh t

/-- The two-action preference can be expressed as benefits minus political costs. -/
theorem preference_from_costs (benefitProtect costProtect benefitCorrect costCorrect : Int)
    (h : benefitCorrect + costProtect < benefitProtect + costCorrect) :
    benefitCorrect - costCorrect < benefitProtect - costProtect := by
  omega

end AutocracyStability
