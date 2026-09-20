import AutocracyStability.Repair

/-!
Exact finite-horizon characterization, allowing arbitrary bursts and repairs.
No probabilistic independence or constant per-period deficit is assumed.
-/
namespace AutocracyStability

def netPrefix (arrival repair : Nat → Nat) (t : Nat) : Int :=
  (cumulative arrival t : Int) - (cumulative repair t : Int)

/-- Reflection floor: initial reserve or lowest subsequent net prefix. -/
def reflectionFloor (initial : Nat) (arrival repair : Nat → Nat) : Nat → Int
  | 0 => -(initial : Int)
  | t + 1 => min (reflectionFloor initial arrival repair t) (netPrefix arrival repair (t + 1))

theorem reflected_debt (initial : Nat) (arrival repair : Nat → Nat) (t : Nat) :
    (debt initial arrival repair t : Int) =
      netPrefix arrival repair t - reflectionFloor initial arrival repair t := by
  induction t with
  | zero => simp [debt, netPrefix, cumulative, reflectionFloor]
  | succ t ih =>
    have hn : netPrefix arrival repair (t + 1) =
        netPrefix arrival repair t + (arrival t : Int) - (repair t : Int) := by
      simp [netPrefix, cumulative]
      omega
    simp only [debt, reflectionFloor]
    omega

theorem floor_below_initial (initial : Nat) (arrival repair : Nat → Nat) (t : Nat) :
    reflectionFloor initial arrival repair t ≤ -(initial : Int) := by
  induction t with
  | zero => simp [reflectionFloor]
  | succ t ih => simp only [reflectionFloor]; omega

theorem floor_below_prefix (initial : Nat) (arrival repair : Nat → Nat)
    (s t : Nat) (h : s ≤ t) :
    reflectionFloor initial arrival repair t ≤ netPrefix arrival repair s := by
  induction t with
  | zero =>
    have hs : s = 0 := by omega
    subst s
    simp [reflectionFloor, netPrefix, cumulative]
  | succ t ih =>
    by_cases hs : s ≤ t
    · have hi := ih hs
      simp only [reflectionFloor]
      omega
    · have he : s = t + 1 := by omega
      subst s
      simp only [reflectionFloor]
      omega

theorem floor_attained (initial : Nat) (arrival repair : Nat → Nat) (t : Nat) :
    reflectionFloor initial arrival repair t = -(initial : Int) ∨
      ∃ s, s ≤ t ∧ reflectionFloor initial arrival repair t = netPrefix arrival repair s := by
  induction t with
  | zero => exact Or.inl rfl
  | succ t ih =>
    by_cases h : reflectionFloor initial arrival repair t ≤ netPrefix arrival repair (t + 1)
    · have hm : reflectionFloor initial arrival repair (t + 1) =
          reflectionFloor initial arrival repair t := by
        simp only [reflectionFloor]; omega
      rw [hm]
      cases ih with
      | inl hi => exact Or.inl hi
      | inr hi =>
        obtain ⟨s, hs, he⟩ := hi
        exact Or.inr ⟨s, by omega, he⟩
    · right
      refine ⟨t + 1, Nat.le_refl _, ?_⟩
      simp only [reflectionFloor]
      omega

/-- Exact criterion: cumulative initial burden AND every suffix burden must fit.
The second condition prevents treating unused past capacity as a stockpile. -/
theorem debt_le_iff_windows (initial bound : Nat) (arrival repair : Nat → Nat) (t : Nat) :
    debt initial arrival repair t ≤ bound ↔
      ((initial : Int) + netPrefix arrival repair t ≤ (bound : Int) ∧
      ∀ s, s ≤ t → netPrefix arrival repair t - netPrefix arrival repair s ≤ (bound : Int)) := by
  have hr := reflected_debt initial arrival repair t
  constructor
  · intro hb
    constructor
    · have hf := floor_below_initial initial arrival repair t
      omega
    · intro s hs
      have hf := floor_below_prefix initial arrival repair s t hs
      omega
  · rintro ⟨hi, hw⟩
    cases floor_attained initial arrival repair t with
    | inl hf => omega
    | inr hf =>
      obtain ⟨s, hs, he⟩ := hf
      have hh := hw s hs
      omega

theorem survival_iff_windows (initial bound : Nat) (arrival repair : Nat → Nat) :
    Survives initial arrival repair bound ↔
      ∀ t, ((initial : Int) + netPrefix arrival repair t ≤ (bound : Int) ∧
      ∀ s, s ≤ t → netPrefix arrival repair t - netPrefix arrival repair s ≤ (bound : Int)) := by
  constructor
  · intro h t; exact (debt_le_iff_windows initial bound arrival repair t).mp (h t)
  · intro h t; exact (debt_le_iff_windows initial bound arrival repair t).mpr (h t)

end AutocracyStability
