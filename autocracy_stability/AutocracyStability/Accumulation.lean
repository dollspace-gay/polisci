import AutocracyStability.Dynamics
import AutocracyStability.LongHorizon
import AutocracyStability.Repair

/-!
A constructive countermodel to deriving vanishing survival from a bounded
annual investment flow. Capability accumulates without depreciation. The
risk law is explicit and time invariant; it depends on installed capability.
This is a logical model, not an empirical claim about a real government.
-/
namespace AutocracyStability

structure LearningState where
  regime : Regime
  capital : Nat
  leader : Nat
  deriving DecidableEq, Repr

def investAndSucceed (s : LearningState) : LearningState :=
  { regime := s.regime, capital := s.capital + 1, leader := s.leader + 1 }

def learningPath : Nat → LearningState :=
  orbit investAndSucceed ⟨.autocracy, 0, 0⟩

theorem learning_capital (t : Nat) : (learningPath t).capital = t := by
  induction t with
  | zero => rfl
  | succ t ih => simpa [learningPath, orbit, investAndSucceed] using congrArg Nat.succ ih

theorem learning_preserves_selection_rules :
    ∀ t, (learningPath t).regime = .autocracy := by
  apply invariant_forever investAndSucceed (fun s => s.regime = .autocracy)
  · rfl
  · intro s hs; exact hs

theorem learning_changes_leader (t : Nat) : (learningPath t).leader = t := by
  induction t with
  | zero => rfl
  | succ t ih => simpa [learningPath, orbit, investAndSucceed] using congrArg Nat.succ ih

theorem unit_investment_budget (t : Nat) : cumulative (fun _ => 1) t = t := by
  induction t with
  | zero => rfl
  | succ t ih => simp [cumulative, ih]

def riskDenominator (s : LearningState) : Nat := (s.capital + 2) * (s.capital + 2)

theorem endogenous_risk_denominator (t : Nat) :
    riskDenominator (learningPath t) = (t + 2) * (t + 2) := by
  simp [riskDenominator, learning_capital]

/-- Exact cross-multiplied survival recurrence for risk 1/riskDenominator.
The initial survival fraction is one. -/
def FollowsRiskLaw (path : Nat → LearningState) (numerator denominator : Nat → Nat) : Prop :=
  numerator 0 = denominator 0 ∧
  ∀ n, numerator (n + 1) * denominator n * riskDenominator (path n) =
    numerator n * denominator (n + 1) * (riskDenominator (path n) - 1)

theorem learning_survival_follows_risk :
    FollowsRiskLaw learningPath (fun n => n + 2) (fun n => 2 * n + 2) := by
  refine ⟨rfl, ?_⟩
  intro n
  have hd := shrinking_risk_positive n
  have hs : (n + 2) * (n + 2) - 1 = (n + 1) * (n + 3) := by omega
  simp only [endogenous_risk_denominator, hs]
  simpa [Nat.add_assoc] using shrinking_risk_recurrence n

theorem learning_stock_unbounded :
    ∀ cap, ∃ t, cap < (learningPath t).capital := by
  intro cap
  exact ⟨cap + 1, by rw [learning_capital]; omega⟩

/-- This conditional survival path spends one unit each period, retains
autocratic selection rules, replaces leaders, and faces a positive exit
risk at every finite date. Its survival tail nevertheless does not vanish.
The path describes the state conditional on still surviving, not an outcome
asserted to occur with certainty. -/
theorem bounded_annual_investment_does_not_force_vanishing :
    (∀ t, cumulative (fun _ => 1) t ≤ t) ∧
    (∀ t, (learningPath t).regime = .autocracy) ∧
    (∀ t, 0 < riskDenominator (learningPath t)) ∧
    FollowsRiskLaw learningPath (fun n => n + 2) (fun n => 2 * n + 2) ∧
    ¬ VanishingTail (fun n => n + 2) (fun n => 2 * n + 2) := by
  refine ⟨fun t => by simp [unit_investment_budget], learning_preserves_selection_rules,
    ?_, learning_survival_follows_risk, shrinking_risk_not_vanishing⟩
  intro t
  rw [endogenous_risk_denominator]
  exact Nat.mul_pos (by omega) (by omega)

/-- The same transition mechanics preserve either regime label. Thus the
resource arithmetic does not itself identify a regime-specific effect. -/
theorem learning_preserves_any_regime (r : Regime) :
    ∀ t, (orbit investAndSucceed ⟨r, 0, 0⟩ t).regime = r := by
  apply invariant_forever investAndSucceed (fun s => s.regime = r)
  · rfl
  · intro s hs; exact hs

end AutocracyStability
