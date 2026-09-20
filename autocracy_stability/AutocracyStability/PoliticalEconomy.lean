import AutocracyStability.Coalition
import AutocracyStability.Dynamics
import AutocracyStability.Repair
import AutocracyStability.Accumulation

/-!
Stylized political-economy mechanisms, not the full selectorate equilibrium.
The loyalty comparison assumes equal public benefits, risk neutrality,
credible challenger rewards, and replacement-coalition inclusion chance W/S.
Its political interpretation requires 0 < W <= S.

The reproduction model separates usable expertise, paid recruitment/training,
external skill inflows, actual departures or exclusion, essential coalition
rewards, and revenue. Paid recruitment costs at least one normalized unit per
skill unit. External skill inputs can be free to this budget. All funding and
replacement sources must be counted consistently, without double-counting.
-/
namespace AutocracyStability

def CoalitionLoyal (winning selectorate challengerReward incumbentReward : Nat) : Prop :=
  winning * challengerReward ≤ selectorate * incumbentReward

/-- A larger replacement pool lowers the outside option in this restricted
loyalty comparison, holding coalition size and rewards fixed. -/
theorem larger_selectorate_preserves_loyalty
    (winning small large challenger incumbent : Nat)
    (hs : small ≤ large) (loyal : CoalitionLoyal winning small challenger incumbent) :
    CoalitionLoyal winning large challenger incumbent := by
  exact Nat.le_trans loyal (Nat.mul_le_mul_right incumbent hs)

theorem smaller_coalition_preserves_loyalty
    (small large selectorate challenger incumbent : Nat)
    (hw : small ≤ large) (loyal : CoalitionLoyal large selectorate challenger incumbent) :
    CoalitionLoyal small selectorate challenger incumbent := by
  exact Nat.le_trans (Nat.mul_le_mul_right challenger hw) loyal

/-- A necessary aggregate budget condition for equal payments to W essential
supporters. This is a consequence of the loyalty comparison, not a claim that
all coalition reservation values are equal in real governments. -/
theorem loyalty_imposes_aggregate_budget
    (winning selectorate challenger incumbent budget : Nat)
    (loyal : CoalitionLoyal winning selectorate challenger incumbent)
    (funded : winning * incumbent ≤ budget) :
    winning * (winning * challenger) ≤ selectorate * budget := by
  have h1 := Nat.mul_le_mul_left winning loyal
  have h2 := Nat.mul_le_mul_left selectorate funded
  have h1' : winning * (winning * challenger) ≤ selectorate * (winning * incumbent) := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using h1
  exact Nat.le_trans h1' h2

/-- Obligatory coalition payments leave at most the residual budget for
recruiting replacement expertise and investing in control. -/
theorem coalition_limits_reproduction_budget
    (costs payments : List Nat) (recruits investment revenue : Nat)
    (loyal : Meets costs payments)
    (funded : payments.sum + recruits + investment ≤ revenue) :
    costs.sum + recruits + investment ≤ revenue := by
  have hc := meets_sum_le costs payments loyal
  omega

/-- Sustaining the expertise stock requires financing its actual losses as
well as the coalition and new investment. Stock conservation is explicit. -/
theorem maintained_talent_requires_replacement_budget
    (talent nextTalent recruits external departures investment revenue : Nat)
    (costs payments : List Nat)
    (accounting : nextTalent + departures = talent + recruits + external)
    (maintained : talent ≤ nextTalent)
    (loyal : Meets costs payments)
    (funded : payments.sum + recruits + investment ≤ revenue) :
    costs.sum + departures + investment ≤ revenue + external := by
  have hc := coalition_limits_reproduction_budget costs payments recruits investment
    revenue loyal funded
  omega

/-- If coalition obligations plus actual talent losses exceed revenue, then
any funded continuation loses usable expertise. No technology depreciation
assumption is used. -/
theorem coalition_drain_gap_reduces_talent
    (talent nextTalent recruits external departures investment revenue : Nat)
    (costs payments : List Nat)
    (accounting : nextTalent + departures = talent + recruits + external)
    (loyal : Meets costs payments)
    (funded : payments.sum + recruits + investment ≤ revenue)
    (gap : revenue + external + 1 ≤ costs.sum + departures) :
    nextTalent < talent := by
  have hc := coalition_limits_reproduction_budget costs payments recruits investment
    revenue loyal funded
  omega

/-- Exact conservation over a finite window; departures are actual losses,
so there is no subtraction of nonexistent people after the stock is empty. -/
theorem talent_conservation_through
    (talent recruits external departures : Nat → Nat) (n : Nat)
    (accounting : ∀ t, t < n →
      talent (t + 1) + departures t = talent t + recruits t + external t) :
    talent n + cumulative departures n =
      talent 0 + cumulative recruits n + cumulative external n := by
  induction n with
  | zero => simp [cumulative]
  | succ n ih =>
    have old := ih (fun t ht => accounting t (by omega))
    have now := accounting n (by omega)
    simp only [cumulative]
    omega

theorem cumulative_reproduction_budget
    (recruits investment revenue : Nat → Nat)
    (costs payments : Nat → List Nat) (n : Nat)
    (loyal : ∀ t, t < n → Meets (costs t) (payments t))
    (funded : ∀ t, t < n →
      (payments t).sum + recruits t + investment t ≤ revenue t) :
    cumulative (fun t => (costs t).sum) n + cumulative recruits n +
      cumulative investment n ≤ cumulative revenue n := by
  induction n with
  | zero => simp [cumulative]
  | succ n ih =>
    have old := ih (fun t ht => loyal t (by omega)) (fun t ht => funded t (by omega))
    have now := coalition_limits_reproduction_budget (costs n) (payments n)
      (recruits n) (investment n) (revenue n) (loyal n (by omega)) (funded n (by omega))
    simp only [cumulative]
    omega

/-- Losses, coalition obligations, retained expertise, and new control
investment share one lifetime resource constraint. Good and bad periods
can be interspersed; there is no per-period net-decline requirement. -/
theorem joint_talent_fiscal_bound
    (talent recruits external departures investment revenue : Nat → Nat)
    (costs payments : Nat → List Nat) (n : Nat)
    (accounting : ∀ t, t < n →
      talent (t + 1) + departures t = talent t + recruits t + external t)
    (loyal : ∀ t, t < n → Meets (costs t) (payments t))
    (funded : ∀ t, t < n →
      (payments t).sum + recruits t + investment t ≤ revenue t) :
    talent n + cumulative departures n + cumulative (fun t => (costs t).sum) n +
      cumulative investment n ≤ talent 0 + cumulative revenue n + cumulative external n := by
  have hc := talent_conservation_through talent recruits external departures n accounting
  have hb := cumulative_reproduction_budget recruits investment revenue costs payments n loyal funded
  omega

/-- A cumulative shortfall certifies that the specified arrangement cannot
have continued through the entire window. Savings enter as initial reserves
or as spending capacity in revenue; they must not be double-counted. -/
theorem cumulative_reproduction_gap_forces_exit
    (continues : Nat → Prop)
    (talent recruits external departures investment revenue : Nat → Nat)
    (costs payments : Nat → List Nat) (n : Nat)
    (accounting : ∀ t, continues t → continues (t + 1) →
      talent (t + 1) + departures t = talent t + recruits t + external t)
    (loyal : ∀ t, continues t → continues (t + 1) → Meets (costs t) (payments t))
    (funded : ∀ t, continues t → continues (t + 1) →
      (payments t).sum + recruits t + investment t ≤ revenue t)
    (shortfall : talent 0 + cumulative revenue n + cumulative external n < cumulative departures n +
      cumulative (fun t => (costs t).sum) n) :
    ∃ t, t ≤ n ∧ ¬ continues t := by
  classical
  apply Classical.byContradiction
  intro none
  have hall : ∀ t, t ≤ n → continues t := by
    intro t ht
    apply Classical.byContradiction
    intro hn
    exact none ⟨t, ht, hn⟩
  have bound := joint_talent_fiscal_bound talent recruits external departures investment revenue
    costs payments n
    (fun t ht => accounting t (hall t (by omega)) (hall (t + 1) (by omega)))
    (fun t ht => loyal t (hall t (by omega)) (hall (t + 1) (by omega)))
    (fun t ht => funded t (hall t (by omega)) (hall (t + 1) (by omega)))
  omega

/-- A rent stream that already covers coalition requirements can finance
that coalition even when revenue from expertise is zero. This only checks
payments; it does not establish complete political or technical viability. -/
theorem rents_can_insulate_coalition (costs : List Nat) (rents talentRevenue : Nat)
    (covered : costs.sum ≤ rents) :
    ∃ payments, Meets costs payments ∧ payments.sum ≤ rents + talentRevenue := by
  apply (coalition_feasible_iff costs (rents + talentRevenue)).mpr
  omega

def skillRevenue (productivity rents talent : Nat) : Nat := productivity * talent + rents

/-- In this explicit linear revenue law, losing one skill unit removes at
least productivity units of revenue. Talent-independent rents are unchanged. -/
theorem talent_loss_reduces_skill_revenue (productivity rents current next : Nat)
    (loss : next + 1 ≤ current) :
    skillRevenue productivity rents next + productivity ≤
      skillRevenue productivity rents current := by
  have h := Nat.mul_le_mul_left productivity loss
  simp only [Nat.mul_add, Nat.mul_one] at h
  simp only [skillRevenue]
  omega

/-- Once a reproduction gap holds, lower expertise cannot cure it under
fixed productivity, rents, coalition obligations, departures, and free entry.
This is a feedback result, not proof that every system enters this region. -/
theorem reproduction_gap_persists_under_talent_loss
    (productivity rents current next external coalition departures : Nat)
    (loss : next ≤ current)
    (gap : skillRevenue productivity rents current + external + 1 ≤ coalition + departures) :
    skillRevenue productivity rents next + external + 1 ≤ coalition + departures := by
  have h := Nat.mul_le_mul_left productivity loss
  simp only [skillRevenue] at *
  omega

/-- A substantive continuation criterion can include successive leaders and
changing policies. If every such continuation obeys the joint constraints
and has a strict reproduction gap, it cannot last indefinitely.

The link from political continuation to the constraints is supplied by the
premises; the word autocracy does not establish any of them.
-/
theorem selectorate_drain_gap_forces_exit
    (continues : Nat → Prop)
    (talent recruits external departures investment revenue : Nat → Nat)
    (costs payments : Nat → List Nat)
    (accounting : ∀ t, continues t → continues (t + 1) →
      talent (t + 1) + departures t = talent t + recruits t + external t)
    (loyal : ∀ t, continues t → continues (t + 1) → Meets (costs t) (payments t))
    (funded : ∀ t, continues t → continues (t + 1) →
      (payments t).sum + recruits t + investment t ≤ revenue t)
    (gap : ∀ t, continues t → continues (t + 1) →
      revenue t + external t + 1 ≤ (costs t).sum + departures t) :
    ∃ t, t ≤ talent 0 + 1 ∧ ¬ continues t := by
  apply exit_by_rank (fun t => t) continues talent
  intro t ht hn
  exact coalition_drain_gap_reduces_talent (talent t) (talent (t + 1))
    (recruits t) (external t) (departures t) (investment t) (revenue t) (costs t) (payments t)
    (accounting t ht hn) (loyal t ht hn) (funded t ht hn) (gap t ht hn)

/-- More exits or exclusions reduce retained expertise, with initial stock
and all replacement inputs held fixed. -/
theorem greater_brain_drain_reduces_talent
    (initial : Nat) (replacement lowLoss highLoss : Nat → Nat)
    (moreLoss : ∀ t, lowLoss t ≤ highLoss t) (t : Nat) :
    debt initial replacement highLoss t ≤ debt initial replacement lowLoss t := by
  exact repair_dominance initial replacement lowLoss highLoss moreLoss t

/-- Positive gross departures need not deplete the stock if replacements
match them. This is a model possibility, not an estimated migration effect. -/
theorem replaced_departures_preserve_talent (initial : Nat) (flow : Nat → Nat) :
    ∀ t, debt initial flow flow t = initial := by
  intro t
  induction t with
  | zero => rfl
  | succ t ih => simp [debt, ih]

/-- A feasible illustration with gross brain drain, coalition payments,
replacement spending, and continuing durable capability accumulation.
The incumbent pays one supporter one unit, replaces one departing skill
unit, and invests one unit. Annual revenue is three. This is feasibility
under specified preferences and technology, not a full dynamic equilibrium.
-/
theorem brain_drain_and_patronage_can_coexist_with_learning :
    CoalitionLoyal 1 10 10 1 ∧
    Meets [1] [1] ∧
    (∀ t, debt 2 (fun _ => 1) (fun _ => 1) t = 2) ∧
    (1 + 1 + 1 ≤ (3 : Nat)) ∧
    (∀ t, (learningPath t).capital = t) ∧
    FollowsRiskLaw learningPath (fun n => n + 2) (fun n => 2 * n + 2) ∧
    ¬ VanishingTail (fun n => n + 2) (fun n => 2 * n + 2) := by
  exact ⟨by unfold CoalitionLoyal; decide, meets_self [1], replaced_departures_preserve_talent 2 (fun _ => 1),
    by decide, learning_capital, learning_survival_follows_risk, shrinking_risk_not_vanishing⟩

end AutocracyStability
