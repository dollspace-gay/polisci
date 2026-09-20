import AutocracyStability.LongHorizon

namespace AutocracyStability

/-- Exact survival for a time-varying conditional exit risk 1/d(n). -/
def riskNumerator (d : Nat → Nat) : Nat → Nat
  | 0 => 1
  | n + 1 => riskNumerator d n * (d n - 1)

def riskDenominatorProduct (d : Nat → Nat) : Nat → Nat
  | 0 => 1
  | n + 1 => riskDenominatorProduct d n * d n

theorem risk_product_denominator_positive (d : Nat → Nat)
    (positive : ∀ n, 0 < d n) : ∀ n, 0 < riskDenominatorProduct d n := by
  intro n
  induction n with
  | zero => simp [riskDenominatorProduct]
  | succ n ih => exact Nat.mul_pos ih (positive n)

theorem risk_product_valid (d : Nat → Nat) :
    ∀ n, riskNumerator d n ≤ riskDenominatorProduct d n := by
  intro n
  induction n with
  | zero => exact Nat.le_refl _
  | succ n ih => exact Nat.mul_le_mul ih (by omega)

theorem bounded_denominator_one_step (d bound : Nat)
    (positive : 0 < d) (limited : d ≤ bound) :
    bound * (d - 1) ≤ (bound - 1) * d := by
  have hp : 0 < bound := by omega
  have h1 : bound * (d - 1) + bound = bound * d := by
    calc
      _ = bound * ((d - 1) + 1) := by simp [Nat.mul_add]
      _ = bound * d := by rw [Nat.sub_add_cancel positive]
  have h2 : (bound - 1) * d + d = bound * d := by
    calc
      _ = ((bound - 1) + 1) * d := by simp [Nat.add_mul]
      _ = bound * d := by rw [Nat.sub_add_cancel hp]
  omega

/-- Every denominator at most bound means every risk is at least 1/bound.
The varying-risk product is dominated by the constant worst case. -/
theorem bounded_denominator_product_bound (d : Nat → Nat) (bound : Nat)
    (positive : ∀ n, 0 < d n) (limited : ∀ n, d n ≤ bound) :
    ∀ n, bound ^ n * riskNumerator d n ≤
      (bound - 1) ^ n * riskDenominatorProduct d n := by
  intro n
  induction n with
  | zero => exact Nat.le_refl _
  | succ n ih =>
    have hs := bounded_denominator_one_step (d n) bound (positive n) (limited n)
    have hm := Nat.mul_le_mul ih hs
    simpa [riskNumerator, riskDenominatorProduct, Nat.pow_succ,
      Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hm

/-- Exact rational survival tends to zero under a uniform denominator bound,
even though the conditional risk is permitted to change each round. -/
theorem bounded_denominators_force_vanishing (d : Nat → Nat) (bound : Nat)
    (two : 2 ≤ bound) (positive : ∀ n, 0 < d n)
    (limited : ∀ n, d n ≤ bound) :
    VanishingTail (riskNumerator d) (riskDenominatorProduct d) := by
  have hbound : (bound - 1) + 1 = bound := by omega
  have geometric : VanishingTail (fun n => (bound - 1) ^ n) (fun n => bound ^ n) := by
    have hg := recurrent_risk_vanishing_tail (fun n => (bound - 1) ^ n) (bound - 1)
      (by omega) (by simp) (fun n => by simp [Nat.pow_succ, Nat.mul_comm])
    simpa [hbound] using hg
  intro k hk
  obtain ⟨date, hd⟩ := geometric k hk
  refine ⟨date, ?_⟩
  intro n hn
  have compare := bounded_denominator_product_bound d bound positive limited n
  have h1 := Nat.mul_le_mul_left k compare
  have h2 := Nat.mul_le_mul_right (riskDenominatorProduct d n) (hd n hn)
  have joined : bound ^ n * (k * riskNumerator d n) ≤
      bound ^ n * riskDenominatorProduct d n := by
    have h1' : bound ^ n * (k * riskNumerator d n) ≤
        (k * (bound - 1) ^ n) * riskDenominatorProduct d n := by
      simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using h1
    exact Nat.le_trans h1' h2
  have hp : 0 < bound ^ n := by
    have hh := Nat.one_le_pow n bound (by omega)
    omega
  exact Nat.le_of_mul_le_mul_left joined hp

end AutocracyStability
