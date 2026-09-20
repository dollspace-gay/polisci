# Long-Run Democratization under Reversal

## Fixed-Cohort Evidence and Formal Conditions for Authoritarian Exit

Anonymous working paper | 20 September 2026

### Abstract

Does democratization remain visible over long historical horizons when authoritarian replacement and democratic reversal are counted correctly? This paper combines a descriptive reanalysis of two regime classifications with conditional, machine-checked models of authoritarian renewal. Using V-Dem's Regimes of the World classification as processed by Our World in Data, the democratic share of 105 territorial units continuously observed from 1900 to 2025 rises from 4.8% to 55.2%. A fixed 1950 cohort records 129 democratizations and 72 reversals, yielding 57 additional democracies. A matched comparison of 88 countries finds positive post-1950 gains under both V-Dem and Bjørnskov-Rode coding. An exploratory sweep of historical windows finds positive gains in all 137 qualifying century-long windows; 177 of 187 qualifying half-century windows show gains and ten are unchanged. These windows overlap and do not constitute independent replications. Both classifications record recent net democratic losses. Formal results identify conditions under which finite resources or recurrent political exposure preclude indefinite continuation of a specified authoritarian arrangement. The evidence establishes a persistent historical direction within the analyzed samples, while leaving the causal connection between renewal constraints and democratization open to direct estimation.

Keywords: democratization; autocracy; regime transitions; historical comparison; formal verification

## 1. Introduction

The long-run direction of institutional change is a different object of inquiry from the survival of an individual ruler. An authoritarian leader may be replaced without broadening political participation. Conversely, a democracy can experience a reversal and later recover. A claim about historical democratization therefore needs to track political institutions through both kinds of event. Counting fallen dictators alone cannot answer it.

This paper examines whether the historical balance of movement into and out of democracy is positive over long horizons. It also asks what a formal account of authoritarian renewal would have to establish to explain that balance. The empirical analysis uses fixed cohorts, two classifications, matched country samples, a stricter liberal-democracy threshold, and a sweep across starting dates. The theoretical analysis states explicit resource and exposure conditions under which continued operation becomes impossible.

The central empirical finding is a large net democratic gain over the twentieth century and the post-1950 period, alongside recent losses. This pattern survives the alternative classifications and coverage checks reported below. The finding contributes an auditable descriptive replication and robustness analysis. It is not presented as the first observation that democracy has expanded historically. The formal contribution is an explicit account of the assumptions needed to move from constraints on authoritarian renewal to claims about long-run political outcomes.

Three propositions guide the inquiry. First, democratic gains may exceed reversals over historically long intervals. Second, this balance may remain positive across reasonable choices of coding and sample. Third, particular material or organizational constraints may make an authoritarian arrangement unable to reproduce itself indefinitely. The first two propositions are evaluated with regime data. The third is analyzed within formal models. Their connection is a substantive research question rather than an inference supplied automatically by either method.

## 2. Related research and conceptual distinctions

Geddes, Wright, and Frantz (2014) distinguish leader replacement, authoritarian regime replacement, and democratization. Their distinction motivates the outcome definition here: a change within authoritarianism contributes no democratic gain. Their work concerns regime breakdown; the present analysis instead follows annual democratic status and its net change across a fixed population.

Measurement also matters. Lührmann, Tannenberg, and Lindberg (2018) distinguish closed and electoral autocracies from electoral and liberal democracies, with attention to classification uncertainty. Bjørnskov and Rode (2020) extend the Democracy-Dictatorship approach, including institutional and colonial information. Agreement across these measures is informative because their criteria differ. It is not evidence that their errors are independent or that either captures every dimension of political freedom.

Political-economy theories help formulate mechanisms without making the historical direction an assumption. Bueno de Mesquita et al. (1999) connect selectorate and winning-coalition size to policy incentives and leader survival. Such incentives motivate considering the resources required to retain essential supporters. Acemoglu and Robinson (2001) model democratization and reversal through distributive conflict, including conditions permitting oscillation between regime types. Together these approaches caution against identifying successful leader maintenance with the long-run reproduction of a political order.

The models in Section 5 isolate a narrower mechanism: the ability to replenish expertise, financial reserves, and governing capacity. They do not formalize these cited theories in their entirety. They also do not assume that more costly authoritarian renewal necessarily gives citizens enforceable political power. That final institutional connection requires evidence about the destinations of political transitions.

## 3. Data and research design

### 3.1 Sources and units

The first source is the V-Dem v16 Regimes of the World series distributed by Our World in Data, downloaded on 20 September 2026. The raw file contains 31,492 unit-year records over 1789-2025. Closed and electoral autocracies are coded zero; electoral and liberal democracies are coded one. The second source is the Bjørnskov-Rode version 7.2 workbook from the authors' data page. The analysis uses its Democracy indicator and retains observations coded Colony = 0. Rows for the incomplete calendar year 2026 are excluded.

For the V-Dem/OWID comparisons, the eligible universe consists of the 179 units observed in 2025. Each baseline-specific cohort contains units observed in every intervening year. This produces a stable denominator within a comparison. It also conditions on current territorial units and complete coverage; it is not a random sample of historical states.

OWID reconstructs parts of earlier territorial histories using predecessor or governing entities. Accordingly, the primary units are territories, including units that were not sovereign throughout the interval. The analysis does not interpret them as continuously independent states. The Bjørnskov-Rode non-colonial filter and matched-country comparisons address part of this concern. Colony = 0 is an operational filter, not a separate legal audit of sovereignty.

### 3.2 Estimands and transition accounting

Let d(i,t) equal one when unit i is democratic in year t and zero otherwise. For a fixed cohort C containing N units, define D(t) as the sum of d(i,t) over C and p(t) = D(t)/N. Define G(t) as the number of units moving from zero to one between consecutive years and L(t) as the number moving from one to zero. The endpoint change satisfies the exact identity:

D(T) - D(s) = Σ [G(t) - L(t)], for t = s+1,...,T. (1)

To see this, each unit's consecutive annual differences sum to its endpoint difference. Summing across units yields Equation (1). An authoritarian-to-authoritarian change has zero contribution, while a democratic gain followed by a reversal cancels. The script verifies this identity against the observed endpoint counts for every reported cohort.

Transition frequencies also depend on exposure. An annual entry rate divides democratic entries by preceding autocratic unit-years; an exit rate divides reversals by preceding democratic unit-years. Counts and rates answer different questions. A positive net gain can occur even if each autocratic unit has a lower transition probability than each democratic unit, when substantially more units begin under autocracy.

### 3.3 Comparisons and sensitivity analyses

The main comparisons begin in 1900 and 1950. Additional baselines are 1789, 1800, 1975, 2000, and 2010. The earliest cohorts are small and are reported as supplementary historical coverage. Matching uses three-letter ISO-coded country-years present in both sources, with complete annual coverage throughout each interval. A separate threshold analysis counts only liberal democracies.

Two further checks were added during manuscript development. The first requires observations only at both endpoints, rather than complete intervening coverage. This enlarges the sample for the endpoint estimand, but cannot supply a complete transition ledger. The second evaluates every available 50-year and 100-year window beginning in 1789 or later and ending by 2025. Within each window, units must have complete annual coverage; the summary retains windows containing at least 50 units. Window membership may vary. The minimum-size rule is exploratory and is not a power calculation.

These choices were not preregistered. Results from multiple horizons are reported together rather than used to select a favorable significance test. The study makes descriptive comparisons and does not estimate a causal effect of time, regime age, migration, or institutional design.

## 4. Results

### 4.1 Long-run democratic gains

Table 1 reports substantial net gains over the longer intervals. In the 1900 cohort, the number of democracies increases from five to 58 among 105 units, a gain of 50.5 percentage points. In the 1950 cohort, the count rises from 23 to 80 among 145 units, a gain of 39.3 points. The smaller 1789 cohort rises from zero to 19 democracies among 35 units; its limited coverage prevents interpreting it as a global census of the late eighteenth century.

Table 1. Democratic status in fixed V-Dem/OWID cohorts.

| Baseline to 2025 | N | Start count | End count | Start share | End share | Change, pp |
|---|---:|---:|---:|---:|---:|---:|
| 1789 | 35 | 0 | 19 | 0.0% | 54.3% | +54.3 |
| 1900 | 105 | 5 | 58 | 4.8% | 55.2% | +50.5 |
| 1950 | 145 | 23 | 80 | 15.9% | 55.2% | +39.3 |
| 1975 | 153 | 35 | 81 | 22.9% | 52.9% | +30.1 |
| 2000 | 172 | 84 | 87 | 48.8% | 50.6% | +1.7 |
| 2010 | 176 | 93 | 87 | 52.8% | 49.4% | -3.4 |

Note: Cohorts differ between rows. Percentages are equal-unit shares and cannot be joined across rows into one continuous series. Counts are the underlying exact values; percentages are rounded.

The historical gain is not monotonic. Within the fixed 1950 cohort, the 75-year total comprises 129 democratizations and 72 reversals. The largest contribution occurs in 1976-2000. The most recent interval contributes a net loss of three democracies (Table 2). Figure 1 displays the fixed-cohort trajectories and transition counts.

Table 2. Transition accounting for the same 145 units, 1950-2025.

| Transition years | Entries into democracy | Exits from democracy | Net change |
|---|---:|---:|---:|
| 1951-1975 | 20 | 8 | +12 |
| 1976-2000 | 62 | 22 | +40 |
| 2001-2010 | 20 | 12 | +8 |
| 2011-2025 | 27 | 30 | -3 |
| Total | 129 | 72 | +57 |

Note: Period lengths differ. The full reconciliation is 23 + 129 - 72 = 80. The count of -3 for 2011-2025 differs from Table 1's -6 because Table 1 uses a larger 2010 cohort.

![Figure 1. Democratic shares and transitions in fixed territorial cohorts.](figure1.png)

### 4.2 Classification and coverage checks

The Bjørnskov-Rode series records a post-1950 increase from 39 to 70 democracies in a complete cohort of 106 units. The matched comparison removes the difference in which countries the two sources include. Among 88 matched countries, V-Dem records 32 additional democracies and Bjørnskov-Rode records 27 (Table 3). Their differing initial levels illustrate why the coding comparison is necessary.

Table 3. Alternative classifications on identical country samples.

| Baseline to 2025 | Matched N | V-Dem start/end | V-Dem net | BR start/end | BR net |
|---|---:|---:|---:|---:|---:|
| 1950 | 88 | 22 / 54 | +32 | 33 / 60 | +27 |
| 1975 | 135 | 34 / 72 | +38 | 39 / 79 | +40 |
| 2000 | 164 | 83 / 84 | +1 | 89 / 93 | +4 |
| 2010 | 167 | 91 / 85 | -6 | 97 / 94 | -3 |

The stricter liberal-democracy threshold also produces long-run gains: three to 25 liberal democracies in the 1900 cohort, and 14 to 30 in the 1950 cohort. It produces a recent decline from 44 to 31 in the 2010 cohort. Neither the broader nor the stricter definition supports describing every recent period as democratic advance.

Relaxing complete annual coverage to endpoint availability increases the 1900 sample from 105 to 144 territories. The democratic count rises from five to 76, a gain of 49.3 percentage points. The analogous 1950 sample contains 170 units and rises from 23 to 84, a gain of 35.9 points. Both remain close in direction and broad magnitude to the complete-cohort comparisons. The endpoint-only 2010 comparison remains negative at -3.4 points among 178 units.

### 4.3 Historical windows and initially authoritarian units

The rolling-window analysis reduces dependence on particular starting dates. All 137 century-long windows meeting the minimum coverage criterion show positive democratic gains. Their changes range from +3.8 to +54.2 percentage points. Among 187 qualifying half-century windows, 177 show gains, ten are unchanged, and none show a decline; changes range from zero to +40.8 points. The starting dates range from 1789 to 1925 for century windows and from 1789 to 1975 for half-century windows.

These are highly overlapping views of the same historical record. They share observations and international events, their cohorts vary, and all are drawn from the 2025 territorial universe. Their positive signs establish robustness to the examined historical endpoints. They do not estimate the frequency with which an independent future century will democratize. Their compatibility with recent losses is straightforward: no 50-year window in the observed data can begin after 1975.

Initially authoritarian units also show a distinction between democratic experience and endpoint status. Of the 100 initially authoritarian units in the 1900 cohort, 67 experience democracy at least once and 53 are democratic in 2025. Of 122 initially authoritarian units in the 1950 cohort, 78 experience democracy and 57 are democratic in 2025. Units that remain authoritarian are retained in the denominator. These fixed-horizon proportions do not treat unfinished authoritarian histories as eventual successes.

## 5. Formal conditions for authoritarian exit

### 5.1 Renewal constraints

A political arrangement must reproduce the resources needed for continued operation. Let H(t) denote effective skilled capacity and B(t) denote reserves, both nonnegative integers. Let p be a lower bound on the cost of maintaining one unit of next-period skill, a an upper bound on resource production per current unit, r an upper bound on other receipts, and q a lower bound on essential coalition costs. Every permitted continuation is assumed to satisfy:

p H(t+1) + B(t+1) + q ≤ a H(t) + r + B(t). (2)

The envelope permits leadership replacement and reallocations between skill and reserves. It does not independently assert that skilled workers are willing to accept employment. In the accompanying talent-choice model, willingness also depends on outside options, local advantages, disadvantages, and nonnegotiable conditions.

Proposition 1 (renewal shortfall). Suppose p = a + g for a nonnegative integer g, operation requires H(t) ≥ h, and r < q + gh. Then no trajectory satisfying Equation (2) while operating can operate forever.

Proof. Define V(t) = pH(t) + B(t). Equation (2) implies V(t+1) ≤ V(t) + r - q - gH(t). While operating, r - q - gH(t) < 0. Thus the nonnegative integer V decreases strictly at each operating continuation. Such decreases cannot persist indefinitely. The Lean theorem renewal_shortfall_forces_exit supplies a bound of V(0) + 1 on a date by which the operating predicate fails.

This proposition derives a conclusion from a uniform shortfall; it does not derive the shortfall from the label autocracy. Its empirical application requires bounds that cover alternative policies, succession, outside support, and technological change. The accompanying stationary_renewal_iff result identifies the exact budget boundary for maintaining a given skill and reserve stock: q + gH ≤ r. This boundary is useful for testing which material arrangements fall within the shortfall mechanism.

### 5.2 Renewal through political exposure

A second model allows recovery of governing capacity. Let C(t) be nonnegative integer capacity and K(t) a cumulative count of politically exposed renewal opportunities, with K(0) = 0. Let R be a nonnegative integer. Assume every continuation satisfies:

C(t+1) + (R+1)K(t) + 1 ≤ C(t) + (R+1)K(t+1). (3)

Proposition 2 (attrition or recurrent exposure). Equation (3) implies C(t) + t ≤ C(0) + (R+1)K(t). Consequently, along an infinite trajectory, K(t) eventually exceeds every fixed bound.

Proof. Sum the one-step inequality through time, cancelling intermediate capacity and opportunity terms. Since C(t) is nonnegative, time cannot grow without bound while K(t) remains bounded. The Lean results attrition_or_exposure_accounting and attrition_forces_unbounded_exposure check the discrete argument.

If a separately justified opportunity-indexed survival bound vanishes, and calendar-time survival is uniformly bounded by it at the applicable opportunity count, the accompanying attrition_exposure_and_risk_force_vanishing theorem transfers that limit to calendar time. A persistent conditional exit risk is one sufficient route to such an opportunity bound. The implementation uses exact rational representations and a vanishing-tail criterion; it does not construct an infinite probability space.

These propositions allow renewal and succession rather than treating them as omissions. Their substantive burden is the proposed relationship between replenishing capacity and political exposure. Moreover, exit from an operating arrangement can lead to another autocracy. None of the propositions alone identifies democracy as the destination. The transition data measure the net institutional outcome that a complete theory must explain.

## 6. Interpretation and limitations

The empirical results support persistent long-run democratization across the samples and horizons examined. They also reject a description of uninterrupted progress. The comparison across classifications, endpoint-only samples, and rolling windows strengthens the historical finding without establishing a universal law of convergence.

Several limitations delimit the estimand. Conditioning on the 2025 territorial universe excludes disappeared units and can duplicate histories inherited from larger governing entities. Requiring complete annual coverage can select unusual survivors. The endpoint-only check addresses missing intervening observations but does not remove selection on current units. A separate analysis of historically sovereign entities and their succession would answer a complementary question.

Equal unit weighting also differs from weighting people. A change in a small territory contributes the same amount as a change in a populous country. No claim about the share of humanity living in democracy follows directly from these counts. The categorical threshold similarly leaves changes within democratic or authoritarian categories uncounted. Classification-bound uncertainty available in the broader V-Dem framework is not propagated by the downloaded categorical series.

The observations are not independent draws from a population of possible histories. International shocks, diffusion, shared institutions, and reconstructed territorial histories induce dependence. Accordingly, headline findings rely on exact descriptive counts rather than a significance threshold. Exploratory country-resampling intervals and paired tests retained in the original replication outputs are not interpreted as calibrated uncertainty about world history or the future. The rolling-window sweep likewise supplies no independent-test p-value.

Finally, neither dataset used here contains the measures needed to estimate the proposed skill-renewal mechanism. A mechanism test would need observations on recruitment and retention costs, productivity, coalition obligations, other receipts, and the institutional consequences of renewal. It would also need to distinguish democratizing pressure from regime replacement and from reforms that preserve authoritarian control. The formal propositions make those empirical obligations explicit and provide conditions that can be contradicted as well as supported.

## 7. Conclusion

Democratization is a substantial long-run feature of the historical samples analyzed here. In a fixed 1950 cohort, democratic entries exceed reversals by 57; matched classifications confirm positive gains; and all qualifying historical century-long windows show increases. Recent losses coexist with this longer-run pattern. Conditional formal models identify ways in which renewal constraints can preclude indefinite authoritarian continuation, but the causal explanation of the observed democratic balance remains open. The resulting contribution is a reproducible historical finding and a precisely stated framework for testing its proposed mechanism.

## Data, code, and AI-assistance statement

The companion package includes the downloaded inputs, source addresses and hashes, analysis scripts, cohort and transition outputs, the rolling-window extension, manuscript source, and the existing Lean project. The Python analysis and manuscript were developed with assistance from OpenAI ChatGPT, including literature retrieval, coding, drafting, and numerical checks. Computational validation reported here consists of executed consistency checks and existing Lean verification evidence; independent external review has not been performed. No author name or affiliation is included in this circulation version.

## References

Acemoglu, Daron, and James A. Robinson. 2001. A Theory of Political Transitions. American Economic Review 91(4): 938-963. https://doi.org/10.1257/aer.91.4.938

Bjørnskov, Christian, and Martin Rode. 2020. Regime types and regime change: A new dataset on democracy, coups, and political institutions. The Review of International Organizations 15: 531-551. https://doi.org/10.1007/s11558-019-09345-1. Updated dataset: version 7.2, retrieved 20 September 2026, https://sites.google.com/unav.es/martin-rode/home/data

Bueno de Mesquita, Bruce, James D. Morrow, Randolph M. Siverson, and Alastair Smith. 1999. Policy Failure and Political Survival: The Contribution of Political Institutions. Journal of Conflict Resolution 43(2). https://doi.org/10.1177/0022002799043002002

Coppedge, Michael, et al. 2026. V-Dem Country-Year Dataset v16. Varieties of Democracy Project. https://doi.org/10.23696/vdemds26. Categorical series accessed through Our World in Data; the source page supplies the complete dataset citation.

Geddes, Barbara, Joseph Wright, and Erica Frantz. 2014. Autocratic Breakdown and Regime Transitions: A New Data Set. Perspectives on Politics 12(2): 313-331. https://doi.org/10.1017/S1537592714000851

Lührmann, Anna, Marcus Tannenberg, and Staffan I. Lindberg. 2018. Regimes of the World (RoW): Opening New Avenues for the Comparative Study of Political Regimes. Politics and Governance 6(1). https://doi.org/10.17645/pag.v6i1.1214

Our World in Data. 2026. Democracy: political-regime data page. V-Dem (2026), processed by Our World in Data. Retrieved 20 September 2026. https://ourworldindata.org/grapher/political-regime

## Appendix A. Formal verification map

The accompanying project contains 149 named results across 18 substantive modules, including elementary supporting lemmas. This count is not a count of independent political discoveries. Lean 4.22.0 verification records show a successful build, no proof gaps or custom axioms, and only the standard logical axioms identified by the audit. The source hashes were checked against that evidence for this manuscript. The formal sources were not changed in preparing the paper.

| Paper component | Source module | Checked result |
|---|---|---|
| Renewal envelope | Renewal.lean | actual_budget_implies_renewal_envelope |
| Proposition 1 | Renewal.lean | renewal_shortfall_forces_exit |
| Stationary boundary | Renewal.lean | stationary_renewal_iff |
| Proposition 2 accounting | ExitDichotomy.lean | attrition_or_exposure_accounting |
| Recurrent exposure | ExitDichotomy.lean | attrition_forces_unbounded_exposure |
| Calendar-time transfer | ExitDichotomy.lean | attrition_exposure_and_risk_force_vanishing |

The mapping does not assert that the Python estimates are kernel-verified. Equation (1) is ordinary transition accounting checked numerically in the analysis. The broad mathematical project includes additional conditional models and counterexamples; only the results needed for this paper's argument are summarized here.
