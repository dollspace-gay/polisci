import AutocracyStability.Cascades
import AutocracyStability.Repair

/-!
An incumbent needs a positive amount of cooperating institutional capacity.
The withdrawal function is a separate bridge from participation to capacity;
a crowd count is not itself a measure of command or administrative power.
-/
namespace AutocracyStability

def CanGovern (total required withdrawn : Nat) : Prop :=
  required ≤ total - withdrawn

theorem support_loss_iff (total required withdrawn : Nat) (positive : 0 < required) :
    ¬ CanGovern total required withdrawn ↔ total < required + withdrawn := by
  unfold CanGovern
  omega

/-- Crossing the participation threshold is sufficient only when it causes
enough capacity to stop cooperating. Capacity and need are fixed in this model. -/
theorem cascade_ends_governing_capacity
    (response withdrawal : Nat → Nat) (seed target total required : Nat)
    (withdrawal_mono : IncreasingResponse withdrawal)
    (initial : seed ≤ target) (positive : 0 < required)
    (no_barrier : ∀ b, seed ≤ b → b < target → b < response b)
    (enough : total < required + withdrawal target) :
    ∃ t, t ≤ target - seed ∧
      ¬ CanGovern total required (withdrawal (cascade response seed t)) := by
  have reaches := evolving_reaches (fun _ => response) seed target initial
    (fun _ => no_barrier)
  have capacity := withdrawal_mono target (cascade response seed (target - seed)) reaches
  refine ⟨target - seed, Nat.le_refl _, ?_⟩
  apply (support_loss_iff total required _ positive).mpr
  omega

/-- Policies may change participation responses, available support, required
support, and the relation between participation and institutional withdrawal.
Every allowed policy must fail both to block the cascade and to restore support.
-/
theorem adaptive_cascade_ends_capacity {Policy : Type}
    (response withdrawal : Policy → Nat → Nat)
    (total required : Policy → Nat) (seed target : Nat)
    (withdrawal_mono : ∀ p, IncreasingResponse (withdrawal p))
    (initial : seed ≤ target) (positive : ∀ p, 0 < required p)
    (no_barrier : ∀ p b, seed ≤ b → b < target → b < response p b)
    (enough : ∀ p, total p < required p + withdrawal p target) :
    ∀ schedule, ∃ t, t ≤ target - seed ∧
      ¬ CanGovern (total (schedule t)) (required (schedule t))
        (withdrawal (schedule t) (policyCascade response schedule seed t)) := by
  intro schedule
  have reaches := evolving_reaches (fun t => response (schedule t)) seed target
    initial (fun t => no_barrier (schedule t))
  have capacity := withdrawal_mono (schedule (target - seed)) target
    (policyCascade response schedule seed (target - seed)) reaches
  have fails := enough (schedule (target - seed))
  refine ⟨target - seed, Nat.le_refl _, ?_⟩
  apply (support_loss_iff _ _ _ (positive (schedule (target - seed)))).mpr
  omega

/-- A separately stated political premise converts capacity loss into ending
a particular incumbent government. The theorem does not establish that premise. -/
theorem capacity_loss_implies_government_end
    (capacity incumbentContinues : Nat → Prop)
    (necessary : ∀ t, incumbentContinues t → capacity t)
    (loss : ∃ t, ¬ capacity t) :
    ∃ t, ¬ incumbentContinues t := by
  obtain ⟨t, ht⟩ := loss
  exact ⟨t, fun stays => ht (necessary t stays)⟩

/-- Institutional withdrawal can breach this support constraint even when the
earlier backlog model remains balanced forever. -/
theorem capacity_loss_without_correction_failure :
    Survives 0 (fun _ => 5) (fun _ => 5) 0 ∧
    CanGovern 4 2 0 ∧
    ¬ CanGovern 4 2 (cascade (thresholdResponse 0 [0, 1, 2, 3]) 0 4) := by
  refine ⟨adequate_repair_survives 0 0 (fun _ => 5) (fun _ => 5)
    (by decide) (fun _ => Nat.le_refl _), ?_⟩
  unfold CanGovern
  decide

end AutocracyStability
