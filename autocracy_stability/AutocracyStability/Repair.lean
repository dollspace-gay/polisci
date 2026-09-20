import Std

/-!
A regime-neutral, discrete backlog model. Quantities are nonnegative integer units.
"Survival" is a *model definition*: backlog never exceeds a fixed tolerance.
These theorems do not identify any real regime's parameters.
-/
namespace AutocracyStability

/-- New unresolved demands arrive before correction; subtraction saturates at zero. -/
def debt (initial : Nat) (arrival repair : Nat → Nat) : Nat → Nat
  | 0 => initial
  | t + 1 => (debt initial arrival repair t + arrival t) - repair t

def Survives (initial : Nat) (arrival repair : Nat → Nat) (bound : Nat) : Prop :=
  ∀ t, debt initial arrival repair t ≤ bound

/-- Cumulative arrivals or correction capacity in the first t periods. -/
def cumulative (f : Nat → Nat) : Nat → Nat
  | 0 => 0
  | t + 1 => cumulative f t + f t

/-- Capacity may be wasted at zero backlog, hence inequality rather than equality. -/
theorem cumulative_balance (initial : Nat) (arrival repair : Nat → Nat) (t : Nat) :
    initial + cumulative arrival t ≤ debt initial arrival repair t + cumulative repair t := by
  induction t with
  | zero => simp [cumulative, debt]
  | succ t ih =>
    simp only [cumulative, debt]
    omega

/-- A finite cumulative shortfall already certifies a threshold breach. -/
theorem cumulative_shortfall_breach (initial bound t : Nat)
    (arrival repair : Nat → Nat)
    (h : bound + cumulative repair t < initial + cumulative arrival t) :
    bound < debt initial arrival repair t := by
  have hb := cumulative_balance initial arrival repair t
  omega

/-- Sustained per-period excess has a linear lower bound, even with varying inputs. -/
theorem persistent_shortfall_growth (initial : Nat) (arrival repair : Nat → Nat)
    (h : ∀ t, repair t + 1 ≤ arrival t) (t : Nat) :
    initial + t ≤ debt initial arrival repair t := by
  induction t with
  | zero => simp [debt]
  | succ t ih =>
    have ht := h t
    simp only [debt]
    omega

/-- Uniform positive shortfall precludes indefinite survival under a finite bound. -/
theorem persistent_shortfall_not_survives (initial bound : Nat)
    (arrival repair : Nat → Nat) (h : ∀ t, repair t + 1 ≤ arrival t) :
    ¬ Survives initial arrival repair bound := by
  intro hs
  have hg := persistent_shortfall_growth initial arrival repair h (bound + 1)
  have hb := hs (bound + 1)
  omega

/-- Adequate correction preserves the initial bound despite varying arrivals. -/
theorem adequate_repair_bound (initial : Nat) (arrival repair : Nat → Nat)
    (h : ∀ t, arrival t ≤ repair t) (t : Nat) :
    debt initial arrival repair t ≤ initial := by
  induction t with
  | zero => simp [debt]
  | succ t ih =>
    have ht := h t
    simp only [debt]
    omega

theorem adequate_repair_survives (initial bound : Nat) (arrival repair : Nat → Nat)
    (hi : initial ≤ bound) (h : ∀ t, arrival t ≤ repair t) :
    Survives initial arrival repair bound := by
  intro t
  exact Nat.le_trans (adequate_repair_bound initial arrival repair h t) hi

/-- Coupling comparison: same shocks, more repair never yields more backlog. -/
theorem repair_dominance (initial : Nat) (arrival low high : Nat → Nat)
    (h : ∀ t, low t ≤ high t) (t : Nat) :
    debt initial arrival high t ≤ debt initial arrival low t := by
  induction t with
  | zero => simp [debt]
  | succ t ih =>
    have ht := h t
    simp only [debt]
    omega

/-- The same external burden can overwhelm one capacity and spare another. -/
theorem comparative_capacity (initial bound : Nat) (arrival low high : Nat → Nat)
    (hi : initial ≤ bound)
    (hl : ∀ t, low t + 1 ≤ arrival t)
    (hh : ∀ t, arrival t ≤ high t) :
    (¬ Survives initial arrival low bound) ∧ Survives initial arrival high bound := by
  exact ⟨persistent_shortfall_not_survives initial bound arrival low hl,
    adequate_repair_survives initial bound arrival high hi hh⟩

/-- A bounded burst followed by enough repair can be absorbed and cleared. -/
theorem burst_cleared (initial burst : Nat) (arrival repair : Nat → Nat)
    (ha : arrival 0 = burst) (hr : initial + burst ≤ repair 0) :
    debt initial arrival repair 1 = 0 := by
  simp only [debt]
  omega

end AutocracyStability
