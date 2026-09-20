import AutocracyStability.LongHorizon

/-!
An accounting certificate for a proposed competence/participation dilemma.
A unit of time consumes one unit of capacity. Each politically exposed
opportunity can restore at most a bounded number of units. The substantive
claim that all possible authoritarian renewal satisfies this law is an
empirical hypothesis, not a consequence of the political label.

The probability statement uses a supplied opportunity-indexed survival tail
and a uniform calendar-time comparison. It does not construct a stochastic
process or infer those premises from a particular historical case.
-/
namespace AutocracyStability

/-- Capacity may recover in exposed periods; no monotone decline is assumed.
Telescoping yields a bound on how long finite capacity can fund continuation.
-/
theorem attrition_or_exposure_accounting
    (capacity opportunities : Nat → Nat) (restoration : Nat)
    (initial : opportunities 0 = 0)
    (transition : ∀ t,
      capacity (t + 1) + (restoration + 1) * opportunities t + 1 ≤
        capacity t + (restoration + 1) * opportunities (t + 1)) :
    ∀ t, capacity t + t ≤
      capacity 0 + (restoration + 1) * opportunities t := by
  intro t
  induction t with
  | zero => simp [initial]
  | succ t ih =>
    have hs := transition t
    omega

/-- Every infinite trajectory obeying the certificate has unbounded exposure,
even when it alternates suppression with restoration as often as it likes.
-/
theorem attrition_forces_unbounded_exposure
    (capacity opportunities : Nat → Nat) (restoration : Nat)
    (initial : opportunities 0 = 0)
    (transition : ∀ t,
      capacity (t + 1) + (restoration + 1) * opportunities t + 1 ≤
        capacity t + (restoration + 1) * opportunities (t + 1)) :
    ∀ bound, ∃ date, ∀ t, date ≤ t → bound ≤ opportunities t := by
  intro bound
  refine ⟨capacity 0 + (restoration + 1) * bound + 1, ?_⟩
  intro t ht
  have account := attrition_or_exposure_accounting capacity opportunities
    restoration initial transition t
  apply Classical.byContradiction
  intro hn
  have hm := Nat.mul_le_mul_left (restoration + 1)
    (show opportunities t ≤ bound by omega)
  omega

/-- If every surviving calendar history has enough exposed opportunities to
justify the supplied probability comparison, the calendar survival tail
vanishes. Count variation across histories is not silently ignored: that
comparison is an explicit obligation for an application.
-/
theorem attrition_exposure_and_risk_force_vanishing
    (capacity opportunities : Nat → Nat) (restoration : Nat)
    (initial : opportunities 0 = 0)
    (transition : ∀ t,
      capacity (t + 1) + (restoration + 1) * opportunities t + 1 ≤
        capacity t + (restoration + 1) * opportunities (t + 1))
    (exposedNum exposedDen calendarNum calendarDen : Nat → Nat)
    (exposedRisk : VanishingTail exposedNum exposedDen)
    (positive : ∀ t, 0 < exposedDen (opportunities t))
    (comparison : ∀ t,
      calendarNum t * exposedDen (opportunities t) ≤
        exposedNum (opportunities t) * calendarDen t) :
    VanishingTail calendarNum calendarDen := by
  have exposure := attrition_forces_unbounded_exposure capacity opportunities
    restoration initial transition
  have tail := unbounded_opportunities_preserve_vanishing
    exposedNum exposedDen opportunities exposedRisk exposure
  intro k hk
  obtain ⟨date, hd⟩ := tail k hk
  refine ⟨date, ?_⟩
  intro t ht
  have h1 := Nat.mul_le_mul_left k (comparison t)
  have h2 := Nat.mul_le_mul_right (calendarDen t) (hd t ht)
  have joined : exposedDen (opportunities t) * (k * calendarNum t) ≤
      exposedDen (opportunities t) * calendarDen t := by
    have h1' : exposedDen (opportunities t) * (k * calendarNum t) ≤
        (k * exposedNum (opportunities t)) * calendarDen t := by
      simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using h1
    exact Nat.le_trans h1' h2
  exact Nat.le_of_mul_le_mul_left joined (positive t)

end AutocracyStability
