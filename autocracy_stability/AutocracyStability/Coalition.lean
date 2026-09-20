import Std

namespace AutocracyStability

/-- Each entry is one distinct essential supporter's reservation payment.
This simple model excludes force, loyalty, and public goods from the utility. -/
def Meets : List Nat → List Nat → Prop
  | [], [] => True
  | c :: cs, p :: ps => c ≤ p ∧ Meets cs ps
  | _, _ => False

theorem meets_sum_le (costs payments : List Nat) (h : Meets costs payments) :
    costs.sum ≤ payments.sum := by
  induction costs generalizing payments with
  | nil => simp
  | cons c cs ih =>
    cases payments with
    | nil => simp [Meets] at h
    | cons p ps =>
      have hh : c ≤ p ∧ Meets cs ps := h
      have ht := ih ps hh.2
      simp only [List.sum_cons]
      omega

theorem meets_self (costs : List Nat) : Meets costs costs := by
  induction costs with
  | nil => trivial
  | cons c cs ih => exact ⟨Nat.le_refl c, ih⟩

/-- Exact feasibility criterion, not an assumption that an autocrat runs out. -/
theorem coalition_feasible_iff (costs : List Nat) (budget : Nat) :
    (∃ payments, Meets costs payments ∧ payments.sum ≤ budget) ↔ costs.sum ≤ budget := by
  constructor
  · rintro ⟨payments, hm, hb⟩
    exact Nat.le_trans (meets_sum_le costs payments hm) hb
  · intro h
    exact ⟨costs, meets_self costs, h⟩

theorem coalition_budget_obstruction (costs : List Nat) (budget : Nat)
    (h : budget < costs.sum) :
    ¬ ∃ payments, Meets costs payments ∧ payments.sum ≤ budget := by
  intro hf
  have hc := (coalition_feasible_iff costs budget).mp hf
  omega

end AutocracyStability
