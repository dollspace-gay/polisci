import AutocracyStability.Repair
import AutocracyStability.Incentives

namespace AutocracyStability

/-- Stable nonzero repair workload: a perfectly persistent model is admissible. -/
theorem balanced_capacity_forever (initial workload t : Nat) :
    debt initial (fun _ => workload) (fun _ => workload) t = initial := by
  induction t with
  | zero => rfl
  | succ t ih => simp [debt, ih]

theorem permanent_viability_counterexample :
    Survives 0 (fun _ => 5) (fun _ => 5) 10 := by
  exact adequate_repair_survives 0 10 _ _ (by decide) (fun _ => Nat.le_refl 5)

/-- Net cumulative balance is insufficient: late repair cannot undo an early
threshold crossing. This blocks a common average-capacity argument. -/
def burstArrival (t : Nat) : Nat := if t = 0 then 20 else 0
def lateRepair (t : Nat) : Nat := if t = 1 then 20 else 0

theorem average_balance_does_not_ensure_survival :
    cumulative burstArrival 2 = cumulative lateRepair 2 ∧
    debt 0 burstArrival lateRepair 1 > 10 ∧
    debt 0 burstArrival lateRepair 2 = 0 := by
  decide

/-- Corrective incentives can be reversed in either regime: no label is used. -/
def preservationPayoff : Action → Int
  | .protect => 4
  | .correct => 3

def correctionPayoff : Action → Int
  | .protect => 3
  | .correct => 4

theorem same_shocks_different_incentives :
    (¬ Survives 0 (fun _ => 5)
      (fun _ => capacity 4 5 .protect) 10) ∧
    Survives 0 (fun _ => 5)
      (fun _ => capacity 4 5 .correct) 10 := by
  constructor
  · apply incentive_trap 0 10 4 5 (fun _ => 5)
      (fun _ => preservationPayoff) (fun _ => .protect)
    · intro t; decide
    · intro t a; cases a <;> decide
    · intro t; decide
  · apply accountable_correction 0 10 4 5 (fun _ => 5)
      (fun _ => correctionPayoff) (fun _ => .correct)
    · decide
    · intro t; decide
    · intro t a; cases a <;> decide
    · intro t; decide

end AutocracyStability
