import AutocracyStability.Cascades

/-!
Two citizens choose quiet (false) or peaceful participation (true).
Participation alone costs one; joint participation benefits both by two.
Quiet gives zero. This stylized game separates preferences from coordination.
-/
namespace AutocracyStability

def civicPayoff (own other : Bool) : Int :=
  if own then (if other then 2 else -1) else 0

def civicNash (a b : Bool) : Prop :=
  (∀ alternative, civicPayoff alternative b ≤ civicPayoff a b) ∧
  (∀ alternative, civicPayoff alternative a ≤ civicPayoff b a)

theorem quiet_is_equilibrium : civicNash false false := by
  constructor <;> intro alternative <;> cases alternative <;> decide

theorem participation_is_equilibrium : civicNash true true := by
  constructor <;> intro alternative <;> cases alternative <;> decide

theorem participation_pareto_better :
    civicPayoff false false < civicPayoff true true := by decide

theorem individual_departure_costly :
    civicPayoff true false < civicPayoff false false := by decide

/-- Unanimously preferring the coordinated outcome does not exclude a quiet
Nash equilibrium. No infinite historical inference is made from this game. -/
theorem unanimous_preference_with_coordination_failure :
    civicNash false false ∧ civicNash true true ∧
    civicPayoff false false < civicPayoff true true :=
  ⟨quiet_is_equilibrium, participation_is_equilibrium, participation_pareto_better⟩

inductive ResponsePolicy where
  | unchanged
  | accommodate
  deriving DecidableEq, Repr

def reformResponse : ResponsePolicy → Nat → Nat
  | .unchanged => thresholdResponse 0 [0, 1, 2, 3]
  | .accommodate => fun _ => 0

theorem reform_responses_monotone (p : ResponsePolicy) :
    IncreasingResponse (reformResponse p) := by
  cases p with
  | unchanged => exact threshold_response_mono _ _
  | accommodate => intro a b _; exact Nat.le_refl _

theorem unchanged_policy_reaches :
    policyCascade reformResponse (fun _ => .unchanged) 0 4 = 4 := by decide

theorem accommodating_policy_blocks :
    ∀ t, policyCascade reformResponse (fun _ => .accommodate) 0 t = 0 := by
  intro t
  have hb := evolving_barrier (fun _ => reformResponse .accommodate) 0 0
    (by decide) (fun _ _ _ => Nat.le_refl 0) t
  change policyCascade reformResponse (fun _ => .accommodate) 0 t ≤ 0 at hb
  omega

/-- This model allows the response to change while political selection rules
remain concentrated. Whether such accommodation is feasible is empirical. -/
theorem adaptive_escape_counterexample :
    (∃ t, 4 ≤ policyCascade reformResponse (fun _ => .unchanged) 0 t) ∧
    (∃ schedule, ∀ t, policyCascade reformResponse schedule 0 t < 4) := by
  refine ⟨⟨4, by decide⟩, fun _ => .accommodate, ?_⟩
  intro t
  rw [accommodating_policy_blocks]
  decide

/-- Changing one threshold can block this four-person cascade. -/
theorem single_threshold_change_blocks :
    cascade (thresholdResponse 0 [0, 1, 2, 3]) 0 4 = 4 ∧
    ∀ t, cascade (thresholdResponse 0 [4, 1, 2, 3]) 0 t = 0 := by
  refine ⟨by decide, ?_⟩
  intro t
  have hb := cascade_barrier (thresholdResponse 0 [4, 1, 2, 3]) 0 0
    (threshold_response_mono _ _) (by decide) (by decide) t
  omega

end AutocracyStability
