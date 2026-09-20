# Autocracy, peaceful uprisings, and institutional stability

Research and Lean 4 project, 20 September 2026.

Extended to 149 checked named results (including supporting lemmas) in eighteen modules.
The extension proves an exact threshold-cascade criterion, an equivalence for
arbitrary policy switching, a bounded-adaptation result, and conditional loss of
governing capacity through withdrawal of institutional cooperation. It also
checks coordination-failure and effective-reform countermodels.
The long-horizon extension proves rational survival-tail convergence under
recurrent conditional risk, even with arbitrarily spaced opportunities, and
checks diminishing-risk examples with different infinite-horizon outcomes.
The resource extension derives vanishing survival under specified depreciation
and risk laws, constructs an endogenous accumulation countermodel with bounded
annual investment, and checks indistinguishable finite prefixes with different
infinite-horizon outcomes.
The political-economy extension connects essential coalition payments to
replacement of lost expertise. It proves cumulative resource bounds and
conditional exit without requiring technology depreciation, while allowing
external talent entry, rents, and balanced replacement of gross departures.
The talent-choice extension makes replacement depend on workers' accessible
outside options, local advantages, regime disadvantages, and hard conditions.
It checks rejected offers, minimum acceptable payrolls, recruitment shortfalls,
and zero supply from a pool with no willing, affordable candidates.

The renewal extension derives conditional finite-time exit while allowing reserves,
coalition adjustment within explicit bounds, and unrestricted leader succession.
It identifies the stationary budget boundary and the empirical conditions needed
to interpret that boundary politically.

The dilemma extension joins capacity attrition to politically exposed renewal.
It proves that recovery periods and arbitrary switching do not avoid recurring
exposure under an explicit accounting certificate, then transfers a supplied
opportunity risk bound to calendar survival. The literature review tests the
universal premise instead of treating it as an established historical law.

Read `Autocracy_Stability_Research.md` for findings, assumptions, source notes,
and the mapping from political questions to formal statements.

The package proves conditional results and explicit countermodels. It does not
prove that all actual autocracies inevitably fail or that democracy is inevitable.
These are elementary, independently developed model results, not claims of a new
political-science breakthrough or a re-formalization of the cited papers.

## Reproduce

Install Lean using the official instructions at https://lean-lang.org/install/.
The `lean-toolchain` file pins `leanprover/lean4:v4.22.0`.

```bash
python3 verify.py
python3 explore.py
python3 long_horizon.py
python3 resource_experiments.py
```

Alternatively point `STABILITY_LAKE` at an existing Lean 4.22.0 `lake` binary.
No Mathlib, pip packages, or additional Lake packages are required. The compiler
must be present; no compiler binary is bundled in this archive.

`verify.py` builds the project, runs `#print axioms` for every named theorem,
rejects proof gaps and nonstandard axioms, and writes source hashes and logs to
`evidence/`. The audit permits Lean's standard `propext`, `Classical.choice`,
and `Quot.sound`; it does not claim an axiom-free foundation.

`explore.py` writes six deterministic illustrations to `evidence/experiments.json`.
It also writes five participation scenarios to `evidence/cascades.json`.
These are synthetic scenarios, not estimated country trajectories.
`long_horizon.py` writes three exact rational survival scenarios to
`evidence/long-horizon.json`.
`resource_experiments.py` writes an exact comparison of depreciating and durable
capability, with the same annual investment, to `evidence/resource-comparison.json`.

## Modules

- `Repair.lean`: cumulative accounting, finite-time overload, sufficient repair,
  and same-shock comparison.
- `Windows.lean`: exact backlog reflection formula and necessary-and-sufficient
  interval criterion, including bursts and intermittent correction.
- `Incentives.lean`: two-action best responses connected to correction capacity.
- `Coalition.lean`: necessary-and-sufficient feasibility of an essential coalition's
  reservation payments under a fixed budget.
- `Dynamics.lean`: closed regime classes, rank-based exit, additional conditions
  for lasting democracy, and counterexamples separating leader and regime change.
- `Counterexamples.lean`: perpetual balanced operation, late repair after a breach,
  and a concrete common-shock incentive comparison.
- `Cascades.lean`: progressive participation, exact barriers, arbitrary policy
  switching, bounded adaptation, finite populations, and response comparisons.
- `Coordination.lean`: two-person Nash equilibria, shared preferences with failed
  coordination, and policies or single threshold changes that stop a cascade.
- `Cooperation.lean`: institutional support thresholds, capacity loss under fixed
  and changing responses, and an explicit premise linking capacity to incumbency.
- `LongHorizon.lean`: conditional survival bounds, an explicit vanishing-tail
  criterion, unbounded opportunity counts, and positive but diminishing risks.
- `RationalRisk.lean`: exact products for varying conditional risks, a comparison
  bound, and vanishing survival under bounded risk denominators.
- `ResourceLimits.lean`: recurring low-expenditure periods under an average
  budget, depreciating capital bounds, and derived survival-tail convergence.
- `Accumulation.lean`: durable investment, succession, an endogenous risk law,
  and nonvanishing survival despite bounded annual spending.
- `Identification.lean`: valid decreasing survival sequences agreeing through
  any chosen finite cutoff but with different infinite-horizon outcomes.
- `PoliticalEconomy.lean`: restricted selectorate loyalty comparisons, joint
  talent and fiscal accounting, cumulative reproduction deficits, revenue
  feedback, rent insulation, and a funded replacement countermodel.
- `TalentChoice.lean`: voluntary recruitment and retention, reservation wages,
  hard conditions, coalition-plus-payroll feasibility, and insufficient supply.

- `Renewal.lean`: workforce renewal, actual-budget envelopes, finite reserves,
  succession, conditional exit, and the stationary budget boundary.

- `ExitDichotomy.lean`: capacity attrition or political exposure, unbounded
  opportunity counts, and a conditional calendar-survival comparison.

## Trust boundary

Lean verifies deductions from definitions and hypotheses. It cannot establish
that regime labels imply utility rankings, that governance failures are additive,
that a threshold predicts political collapse, or that successor regimes cannot
reset capacity. The report identifies those unproved empirical bridges explicitly.
The participation model assumes observable participation and no withdrawal within
an episode. Institutional cooperation is modeled separately from crowd size.
Policy effects and support requirements are assumptions, not inferred from the
word autocracy. The long-horizon proofs check exact rational probabilities and
their vanishing-tail criterion. They do not construct an infinite sample-space
measure or formally identify its survival event with that limit. The report
distinguishes these proofs from the standard probability-one interpretation.
No Bayesian information model or universal autocratic-risk premise is proved.
The resource theorem assumes half-retention of capability and an inverse-square
risk law; neither is estimated from data. The accumulation countermodel assumes
no depreciation and unbounded cumulative effectiveness. It disproves an inference
from bounded annual flow alone, not an empirical claim about every possible
government. Finite-prefix nonidentification does not preclude inference under
additional structural assumptions.
The political-economy proofs assume explicit resource accounting and a minimum
cost of paid skill replacement, with free external skill inflows represented
separately. Political continuation must require the stated constraints. They
do not derive all appointments, migration choices, or coalition requirements
from a complete strategic equilibrium, or prove that every autocracy develops
an uncorrectable reproduction deficit. The report distinguishes these results
from a formalization of the cited selectorate and loyalty-competence theories.
Talent preferences are specified individually, not inferred from a regime label.
Candidate availability, qualification, and access to outside jobs must be
established in an application. The replacement countermodel remains conditional
unless its workers satisfy these willingness and affordability constraints.

The renewal model uses a complete workforce-renewal interval and uniform bounds
on payroll, receipts, essential obligations, and minimum operational skill.
Those bounds must cover all allowed reforms and successors. They are not
estimated from historical data or derived from the authoritarian label.

The dilemma certificate assumes unavoidable attrition outside exposed renewal
and a uniform restoration bound. The empirical assertion that every possible
authoritarian adaptation obeys these constraints remains unestablished.
Opportunity risk and its comparison with calendar survival are explicit premises;
an infinite probability-space construction is not added by this extension.

The core-election theorem discussed in the report is an external result. Its
authors report a separate Lean verification. It is not imported, independently
compiled, or reproduced in this package.
