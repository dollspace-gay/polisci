import AutocracyStability.PoliticalEconomy

/-!
Replacement expertise must come from people who are willing to supply it.
Outside options must actually be accessible. Values are normalized net values,
not raw salaries. Regime disadvantages can include lost liberties, insecurity,
and reduced professional autonomy; local advantages can include family ties.
A hard condition can rule out acceptance at any wage. None of these individual
preferences or their population distribution is inferred from a regime label.
-/
namespace AutocracyStability

structure TalentWorker where
  outsideValue : Nat
  regimeDisadvantages : Nat
  localAdvantages : Nat
  conditionsAcceptable : Bool
  deriving DecidableEq, Repr

def reservationWage (w : TalentWorker) : Nat :=
  w.outsideValue + w.regimeDisadvantages - w.localAdvantages

/-- Weak willingness, with ties allowed to accept. An offer cannot overcome
a hard condition by increasing its monetary component. -/
def AcceptsOffer (w : TalentWorker) (pay : Nat) : Prop :=
  w.conditionsAcceptable = true ∧
    w.outsideValue + w.regimeDisadvantages ≤ pay + w.localAdvantages

theorem acceptance_iff_reservation (w : TalentWorker) (pay : Nat) :
    AcceptsOffer w pay ↔ w.conditionsAcceptable = true ∧ reservationWage w ≤ pay := by
  simp only [AcceptsOffer, reservationWage]
  constructor
  · rintro ⟨conditions, value⟩
    exact ⟨conditions, by omega⟩
  · rintro ⟨conditions, value⟩
    exact ⟨conditions, by omega⟩

theorem lower_pay_and_worse_conditions_rejected (w : TalentWorker) (pay : Nat)
    (lowerPay : pay ≤ w.outsideValue)
    (worseConditions : w.localAdvantages < w.regimeDisadvantages) :
    ¬ AcceptsOffer w pay := by
  intro h
  have hb := h.2
  omega

theorem inadequate_premium_rejected (w : TalentWorker) (premium pay : Nat)
    (limitedPay : pay ≤ w.outsideValue + premium)
    (insufficient : premium + w.localAdvantages < w.regimeDisadvantages) :
    ¬ AcceptsOffer w pay := by
  intro h
  have hb := h.2
  omega

theorem hard_condition_blocks_every_wage (w : TalentWorker)
    (veto : w.conditionsAcceptable = false) : ∀ pay, ¬ AcceptsOffer w pay := by
  intro pay h
  have hc := h.1
  simp [veto] at hc

theorem higher_disadvantage_raises_reservation (a b : TalentWorker)
    (outside : a.outsideValue = b.outsideValue)
    (amenities : a.localAdvantages = b.localAdvantages)
    (worse : a.regimeDisadvantages ≤ b.regimeDisadvantages) :
    reservationWage a ≤ reservationWage b := by
  simp only [reservationWage]
  omega

def RecruitmentAcceptable (workers : List TalentWorker) (payments : List Nat) : Prop :=
  (∀ w ∈ workers, w.conditionsAcceptable = true) ∧
    Meets (workers.map reservationWage) payments

/-- Exact budget feasibility for this specified team, using the reservation
wages derived from its members' preferences. It does not manufacture a team
or assert that sufficient candidates exist in the labor market. -/
theorem recruitment_feasible_iff (workers : List TalentWorker) (budget : Nat) :
    (∃ payments, RecruitmentAcceptable workers payments ∧ payments.sum ≤ budget) ↔
    (∀ w ∈ workers, w.conditionsAcceptable = true) ∧
      (workers.map reservationWage).sum ≤ budget := by
  constructor
  · rintro ⟨payments, ⟨conditions, accepted⟩, funded⟩
    exact ⟨conditions, Nat.le_trans (meets_sum_le _ _ accepted) funded⟩
  · rintro ⟨conditions, funded⟩
    exact ⟨workers.map reservationWage, ⟨conditions, meets_self _⟩, funded⟩

theorem coalition_and_talent_feasible_iff
    (costs : List Nat) (workers : List TalentWorker) (investment revenue : Nat) :
    (∃ coalitionPayments workerPayments,
      Meets costs coalitionPayments ∧ RecruitmentAcceptable workers workerPayments ∧
      coalitionPayments.sum + workerPayments.sum + investment ≤ revenue) ↔
    (∀ w ∈ workers, w.conditionsAcceptable = true) ∧
      costs.sum + (workers.map reservationWage).sum + investment ≤ revenue := by
  constructor
  · rintro ⟨cp, wp, coalition, ⟨conditions, accepted⟩, funded⟩
    have hc := meets_sum_le costs cp coalition
    have hw := meets_sum_le (workers.map reservationWage) wp accepted
    exact ⟨conditions, by omega⟩
  · rintro ⟨conditions, funded⟩
    exact ⟨costs, workers.map reservationWage, meets_self _,
      ⟨conditions, meets_self _⟩, funded⟩

theorem reservation_floor_bounds_payroll (workers : List TalentWorker) (floor : Nat)
    (minimum : ∀ w ∈ workers, floor ≤ reservationWage w) :
    workers.length * floor ≤ (workers.map reservationWage).sum := by
  induction workers with
  | nil => simp
  | cons w ws ih =>
    have hw := minimum w (by simp)
    have ht := ih (fun v hv => minimum v (by simp [hv]))
    simp only [List.length_cons, List.map_cons, List.sum_cons, Nat.add_mul, Nat.one_mul]
    omega

/-- Some workers may accept, yet the regime can still be unable to recruit
the required headcount at the minimum acceptable wages for this skill pool. -/
theorem reservation_floor_limits_recruitment
    (workers : List TalentWorker) (workerPayments costs coalitionPayments : List Nat)
    (floor investment revenue needed : Nat)
    (minimum : ∀ w ∈ workers, floor ≤ reservationWage w)
    (accepted : RecruitmentAcceptable workers workerPayments)
    (loyal : Meets costs coalitionPayments)
    (funded : coalitionPayments.sum + workerPayments.sum + investment ≤ revenue)
    (shortage : revenue < costs.sum + needed * floor + investment) :
    workers.length < needed := by
  have hfloor := reservation_floor_bounds_payroll workers floor minimum
  have hw := meets_sum_le _ _ accepted.2
  have hc := meets_sum_le _ _ loyal
  by_cases enough : needed ≤ workers.length
  · have hm := Nat.mul_le_mul_right floor enough
    omega
  · omega

theorem no_affordable_offer_after_coalition
    (w : TalentWorker) (pay coalition revenue : Nat)
    (funded : coalition + pay ≤ revenue)
    (unaffordable : revenue < coalition + reservationWage w) :
    ¬ AcceptsOffer w pay := by
  intro accepted
  have hw := ((acceptance_iff_reservation w pay).mp accepted).2
  omega

/-- External arrivals cannot be inserted as an arbitrary input when every
candidate refuses the conditions or requires more than the entire residual
budget. The pool can also represent residents considering whether to stay. -/
theorem unwilling_pool_supplies_no_recruits
    (pool workers : List TalentWorker) (workerPayments costs coalitionPayments : List Nat)
    (investment revenue : Nat)
    (fromPool : ∀ w ∈ workers, w ∈ pool)
    (unwilling : ∀ w ∈ pool,
      w.conditionsAcceptable = false ∨ revenue < costs.sum + reservationWage w)
    (accepted : RecruitmentAcceptable workers workerPayments)
    (loyal : Meets costs coalitionPayments)
    (funded : coalitionPayments.sum + workerPayments.sum + investment ≤ revenue) :
    workers = [] := by
  cases workers with
  | nil => rfl
  | cons w ws =>
    have offered := unwilling w (fromPool w (by simp))
    have conditions := accepted.1 w (by simp)
    have hw := meets_sum_le _ _ accepted.2
    have hc := meets_sum_le _ _ loyal
    simp only [List.map_cons, List.sum_cons] at hw
    cases offered with
    | inl veto => simp [veto] at conditions
    | inr tooExpensive => omega

end AutocracyStability
