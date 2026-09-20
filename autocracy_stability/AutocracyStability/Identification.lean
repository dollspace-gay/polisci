import AutocracyStability.LongHorizon

/-!
An arbitrarily long finite survival prefix can be shared by examples with
different infinite-horizon outcomes. This does not rule out inference under additional
structural assumptions. It separates those assumptions from the finite data.
-/
namespace AutocracyStability

def continuationNumerator (cutoff n : Nat) : Nat :=
  if n ≤ cutoff then 1 else n - cutoff + 2

def continuationDenominator (cutoff n : Nat) : Nat :=
  if n ≤ cutoff then n + 1 else (cutoff + 1) * (2 * (n - cutoff) + 2)

/-- This continuation agrees with survival 1/(n+1) through any chosen cutoff. -/
theorem indistinguishable_finite_prefix (cutoff n : Nat) (hn : n ≤ cutoff) :
    continuationNumerator cutoff n = 1 ∧ continuationDenominator cutoff n = n + 1 := by
  simp [continuationNumerator, continuationDenominator, hn]

theorem continuation_valid (cutoff n : Nat) :
    0 < continuationDenominator cutoff n ∧
    continuationNumerator cutoff n ≤ continuationDenominator cutoff n := by
  by_cases hn : n ≤ cutoff
  · simp [continuationNumerator, continuationDenominator, hn]
  · simp only [continuationNumerator, continuationDenominator, if_neg hn]
    have hbase : 0 < 2 * (n - cutoff) + 2 := by omega
    have hmul := Nat.mul_le_mul_right (2 * (n - cutoff) + 2)
      (show 1 ≤ cutoff + 1 by omega)
    simp only [Nat.one_mul] at hmul
    constructor <;> omega

theorem continuation_initial_probability_one (cutoff : Nat) :
    continuationNumerator cutoff 0 = continuationDenominator cutoff 0 := by
  simp [continuationNumerator, continuationDenominator]

/-- Both continuations are valid decreasing survival probabilities, with
strictly positive exit risk at each finite date. -/
theorem continuation_strictly_decreases (cutoff n : Nat) :
    continuationNumerator cutoff (n + 1) * continuationDenominator cutoff n <
      continuationNumerator cutoff n * continuationDenominator cutoff (n + 1) := by
  by_cases before : n + 1 ≤ cutoff
  · have old : n ≤ cutoff := by omega
    simp [continuationNumerator, continuationDenominator, before, old]
  · by_cases boundary : n ≤ cutoff
    · have hn : n = cutoff := by omega
      subst n
      simp [continuationNumerator, continuationDenominator, before]
      omega
    · have diff : n + 1 - cutoff = (n - cutoff) + 1 := by omega
      simp only [continuationNumerator, continuationDenominator,
        if_neg before, if_neg boundary, diff]
      have h := Nat.mul_lt_mul_of_pos_left
        (shrinking_risk_strictly_decreases (n - cutoff)) (by omega : 0 < cutoff + 1)
      simpa [Nat.add_assoc, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using h

theorem continuation_survival_does_not_vanish (cutoff : Nat) :
    ¬ VanishingTail (continuationNumerator cutoff) (continuationDenominator cutoff) := by
  intro h
  have hk : 0 < 3 * (cutoff + 1) := Nat.mul_pos (by decide) (by omega)
  obtain ⟨date, hd⟩ := h (3 * (cutoff + 1)) hk
  let n := date + cutoff + 1
  have hn : cutoff < n := by omega
  have bad := hd n (by omega)
  simp only [continuationNumerator, continuationDenominator, if_neg (by omega : ¬ n ≤ cutoff)] at bad
  have bad' : (cutoff + 1) * (3 * (n - cutoff + 2)) ≤
      (cutoff + 1) * (2 * (n - cutoff) + 2) := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using bad
  have impossible := Nat.le_of_mul_le_mul_left bad' (by omega : 0 < cutoff + 1)
  omega

/-- No finite prefix alone determines whether these survival tails vanish. -/
theorem finite_prefix_does_not_determine_infinite_tail (cutoff : Nat) :
    (∀ n, n ≤ cutoff → continuationNumerator cutoff n = 1 ∧
      continuationDenominator cutoff n = n + 1) ∧
    VanishingTail (fun _ => 1) (fun n => n + 1) ∧
    ¬ VanishingTail (continuationNumerator cutoff) (continuationDenominator cutoff) := by
  exact ⟨fun n hn => indistinguishable_finite_prefix cutoff n hn,
    decreasing_risk_can_still_vanish, continuation_survival_does_not_vanish cutoff⟩

end AutocracyStability
