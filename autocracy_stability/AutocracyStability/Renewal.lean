import AutocracyStability.Dynamics

/-!
A cohort-renewal model, not an estimated law of authoritarian politics.
One period includes replacing/retaining the entire effective workforce.
Money and skill are discrete. All sources of support belong in the budget.
Uniform bounds must cover every allowed coalition, reform, and successor.
-/
namespace AutocracyStability

structure RenewalState where
  skill : Nat
  reserves : Nat
  leader : Nat
  deriving Repr

/-- An optimistic resource envelope for any permitted continuation.
The next reserve stock may grow; there is no assumption it falls separately.
The payroll floor includes the cost of retaining or replacing next-period skill.
-/
def RenewalFeasible (price productivity rents coalitionFloor : Nat)
    (s next : RenewalState) : Prop :=
  price * next.skill + next.reserves + coalitionFloor ≤
    productivity * s.skill + rents + s.reserves

def renewalPotential (price : Nat) (s : RenewalState) : Nat :=
  price * s.skill + s.reserves

/-- Actual spending and revenue bounds imply the optimistic envelope.
Coalition membership, wage offers, and leadership may vary arbitrarily.
-/
theorem actual_budget_implies_renewal_envelope
    (price productivity rents coalitionFloor payroll coalition revenue : Nat)
    (s next : RenewalState)
    (wages : price * next.skill ≤ payroll)
    (essential : coalitionFloor ≤ coalition)
    (receipts : revenue ≤ productivity * s.skill + rents)
    (budget : payroll + coalition + next.reserves ≤ revenue + s.reserves) :
    RenewalFeasible price productivity rents coalitionFloor s next := by
  unfold RenewalFeasible
  omega

/-- An externally justified positive reproduction gap consumes the combined
skill/reserve potential, even if one component temporarily increases.
-/
theorem renewal_gap_consumes_potential
    (productivity gap rents coalitionFloor skillFloor : Nat)
    (s next : RenewalState)
    (operating : skillFloor ≤ s.skill)
    (shortfall : rents < coalitionFloor + gap * skillFloor)
    (funded : RenewalFeasible (productivity + gap) productivity rents
      coalitionFloor s next) :
    renewalPotential (productivity + gap) next <
      renewalPotential (productivity + gap) s := by
  have hg := Nat.mul_le_mul_left gap operating
  unfold RenewalFeasible at funded
  unfold renewalPotential
  simp only [Nat.add_mul] at funded ⊢
  omega

/-- Every permitted continuation consumes finite potential. A path can use
any number of successors, coalition revisions, and reserve reallocations.
The conclusion concerns the supplied operating predicate, whose political
interpretation must be independently justified.
-/
theorem renewal_shortfall_forces_exit
    (productivity gap rents coalitionFloor skillFloor : Nat)
    (path : Nat → RenewalState) (operating : RenewalState → Prop)
    (skills : ∀ s, operating s → skillFloor ≤ s.skill)
    (shortfall : rents < coalitionFloor + gap * skillFloor)
    (continuation : ∀ t, operating (path t) → operating (path (t + 1)) →
      RenewalFeasible (productivity + gap) productivity rents coalitionFloor
        (path t) (path (t + 1))) :
    ∃ t, t ≤ renewalPotential (productivity + gap) (path 0) + 1 ∧
      ¬ operating (path t) := by
  apply exit_by_rank path operating (renewalPotential (productivity + gap))
  intro t ht hn
  exact renewal_gap_consumes_potential productivity gap rents coalitionFloor
    skillFloor (path t) (path (t + 1)) (skills _ ht) shortfall
    (continuation t ht hn)

/-- The exact boundary for maintaining a specified skill and reserve stock.
This is budget feasibility, not political equilibrium or worker availability.
-/
theorem stationary_renewal_iff
    (productivity gap rents coalitionFloor : Nat) (s : RenewalState) :
    RenewalFeasible (productivity + gap) productivity rents coalitionFloor s s ↔
      coalitionFloor + gap * s.skill ≤ rents := by
  unfold RenewalFeasible
  simp only [Nat.add_mul]
  omega

/-- Leader replacement alone does not alter these material constraints. -/
theorem succession_preserves_renewal_feasibility
    (price productivity rents coalitionFloor leader : Nat) (s : RenewalState) :
    RenewalFeasible price productivity rents coalitionFloor s
      { s with leader := leader } ↔
    RenewalFeasible price productivity rents coalitionFloor s s := by
  rfl

end AutocracyStability
