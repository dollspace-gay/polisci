import AutocracyStability.Repair
import AutocracyStability.LongHorizon
import AutocracyStability.RationalRisk

/-!
Resource limits have different implications for recurring expenditure and
durable accumulated capability. These results make the distinction explicit.
-/
namespace AutocracyStability

/-- A tail of uniformly expensive periods has a linearly growing cost. -/
theorem expensive_tail_cost (effort : Nat → Nat) (start cost : Nat)
    (expensive : ∀ t, start ≤ t → cost ≤ effort t) :
    ∀ n, cost * n ≤ cumulative effort (start + n) := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
    have he := expensive (start + n) (by omega)
    simpa [Nat.add_assoc, cumulative, Nat.mul_add] using Nat.add_le_add ih he

/-- Bounded average recurring expenditure forces infinitely many periods
whose expenditure is at most the average budget. -/
theorem bounded_average_has_recurring_low_effort (effort : Nat → Nat) (budget : Nat)
    (funded : ∀ n, cumulative effort n ≤ budget * n) :
    ∀ start, ∃ t, start ≤ t ∧ effort t ≤ budget := by
  intro start
  apply Classical.byContradiction
  intro hn
  have expensive : ∀ t, start ≤ t → budget + 1 ≤ effort t := by
    intro t ht
    by_cases he : effort t ≤ budget
    · exact False.elim (hn ⟨t, ht, he⟩)
    · omega
  have lower := expensive_tail_cost effort start (budget + 1) expensive (budget * start + 1)
  have upper := funded (start + (budget * start + 1))
  have bad := Nat.le_trans lower upper
  simp only [Nat.add_mul, Nat.mul_add, Nat.one_mul, Nat.mul_one] at bad
  omega

def opportunityCount (qualifies : Nat → Bool) : Nat → Nat
  | 0 => 0
  | t + 1 => opportunityCount qualifies t + if qualifies t then 1 else 0

theorem opportunity_count_monotone (qualifies : Nat → Bool) {a b : Nat}
    (hab : a ≤ b) : opportunityCount qualifies a ≤ opportunityCount qualifies b := by
  induction b with
  | zero =>
    have ha : a = 0 := by omega
    subst a
    exact Nat.le_refl _
  | succ b ih =>
    by_cases eq : a = b + 1
    · subst a; exact Nat.le_refl _
    · have hprev := ih (by omega)
      simp only [opportunityCount]
      omega

/-- Infinitely recurring qualifying dates make their cumulative count
eventually exceed every prescribed count. -/
theorem recurrent_dates_give_unbounded_count (qualifies : Nat → Bool)
    (recurs : ∀ start, ∃ t, start ≤ t ∧ qualifies t = true) :
    ∀ bound, ∃ date, ∀ t, date ≤ t → bound ≤ opportunityCount qualifies t := by
  intro bound
  induction bound with
  | zero => exact ⟨0, fun _ _ => Nat.zero_le _⟩
  | succ bound ih =>
    obtain ⟨date, hd⟩ := ih
    obtain ⟨nextDate, hn, hq⟩ := recurs date
    have oldCount := hd nextDate hn
    have newCount : bound + 1 ≤ opportunityCount qualifies (nextDate + 1) := by
      simp [opportunityCount, hq]
      omega
    exact ⟨nextDate + 1, fun t ht => Nat.le_trans newCount (opportunity_count_monotone qualifies ht)⟩

/-- This combines the resource constraint with recurring-risk convergence.
The risk bound applies at the low-effort opportunities; it is still an
explicit behavioral premise about the effectiveness of available control. -/
theorem bounded_average_and_recurring_risk_force_vanishing
    (effort survivors : Nat → Nat) (budget safeBranches : Nat)
    (funded : ∀ n, cumulative effort n ≤ budget * n)
    (positive : 0 < safeBranches) (initial : survivors 0 ≤ 1)
    (conditional : ∀ n, survivors (n + 1) ≤ safeBranches * survivors n) :
    let count := opportunityCount (fun t => decide (effort t ≤ budget))
    VanishingTail (fun t => survivors (count t))
      (fun t => (safeBranches + 1) ^ count t) := by
  apply unbounded_opportunities_preserve_vanishing
  · exact recurrent_risk_vanishing_tail survivors safeBranches positive initial conditional
  · apply recurrent_dates_give_unbounded_count
    intro start
    obtain ⟨t, ht, he⟩ := bounded_average_has_recurring_low_effort effort budget funded start
    exact ⟨t, ht, by simp [he]⟩

def depreciatingCapital (initial : Nat) (investment : Nat → Nat) : Nat → Nat
  | 0 => initial
  | t + 1 => depreciatingCapital initial investment t / 2 + investment t

/-- A deliberately explicit depreciation law: half the stock is retained.
Uniformly bounded investment then bounds the stock for all time. -/
theorem depreciating_capital_bounded (initial budget : Nat) (investment : Nat → Nat)
    (funded : ∀ t, investment t ≤ budget) :
    ∀ t, depreciatingCapital initial investment t ≤ 2 * (initial + budget) := by
  intro t
  induction t with
  | zero => simp [depreciatingCapital]; omega
  | succ t ih =>
    have hb := funded t
    simp only [depreciatingCapital]
    omega

/-- In the stipulated risk law q=1/(capital+2)^2, a stock bound supplies
a positive uniform risk floor. This is its denominator comparison. -/
theorem bounded_capital_bounds_risk_denominator (capital cap : Nat) (h : capital ≤ cap) :
    (capital + 2) * (capital + 2) ≤ (cap + 2) * (cap + 2) := by
  exact Nat.mul_le_mul (by omega) (by omega)

theorem depreciating_capital_risk_floor (initial budget : Nat) (investment : Nat → Nat)
    (funded : ∀ t, investment t ≤ budget) :
    ∀ t, (depreciatingCapital initial investment t + 2) *
      (depreciatingCapital initial investment t + 2) ≤
      (2 * (initial + budget) + 2) * (2 * (initial + budget) + 2) := by
  intro t
  exact bounded_capital_bounds_risk_denominator _ _
    (depreciating_capital_bounded initial budget investment funded t)

/-- A complete conditional model theorem: bounded replenishment plus the
specified depreciation and risk laws force the exact survival tail to vanish.
No additional persistent-risk hypothesis is supplied to this theorem. -/
theorem depreciation_and_budget_force_vanishing
    (initial budget : Nat) (investment : Nat → Nat)
    (funded : ∀ t, investment t ≤ budget) :
    let d := fun t => (depreciatingCapital initial investment t + 2) *
      (depreciatingCapital initial investment t + 2)
    VanishingTail (riskNumerator d) (riskDenominatorProduct d) := by
  let cap := 2 * (initial + budget) + 2
  apply bounded_denominators_force_vanishing _ (cap * cap)
  · have hc : 2 ≤ cap := by omega
    have hm := Nat.mul_le_mul hc hc
    omega
  · intro t
    exact Nat.mul_pos (by omega) (by omega)
  · exact depreciating_capital_risk_floor initial budget investment funded

end AutocracyStability
