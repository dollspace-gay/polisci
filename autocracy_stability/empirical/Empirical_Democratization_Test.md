# Testing the long-run democratization hypothesis

20 September 2026

## Result

**The data support a large long-run shift toward democracy, even after counting democratic reversals and treating authoritarian-to-authoritarian changes as continued authoritarianism.** This result appears under two different classifications and survives using the same countries in both. The gains are concentrated in earlier periods; both classifications show a small net decline since 2010. These are descriptive findings about the observed historical direction, not an estimated guarantee of future convergence.

## What was tested

The question is whether the balance of political change over long periods favors democracy. Individual dictators' deaths and replacement by another dictatorship do not count as democratization.

The primary outcome is the share of a fixed set of territorial units classified as electoral or liberal democracies. Each comparison includes only units with observations in **every year** from the baseline through 2025. This prevents new entries into the dataset from mechanically driving the trend. Every unit receives equal weight. These are not population-weighted estimates.

The main source is V-Dem v16, processed by Our World in Data (31,492 raw unit-year rows). It distinguishes closed autocracy, electoral autocracy, electoral democracy, and liberal democracy. The first two are coded 0 and the latter two 1 for this analysis. The secondary source is Bjørnskov–Rode version 7.2, using its Democracy indicator and excluding colonial observations. Its 2026 rows are excluded because that calendar year is incomplete.

The V-Dem/OWID analysis retains territorial units present in 2025, then constructs balanced cohorts. Historical observations can be reconstructed from the political entity previously governing a territory. A territory need not have been an independent country throughout the interval. Thus, these cohorts should not be described as fixed sets of sovereign states since 1789. The secondary and matched analyses help assess this coverage issue.

## Long-run results

| Data and period | Fixed units | Democratic at start | Democratic in 2025 | Percentage-point change |
|---|---:|---:|---:|---:|
| V-Dem/OWID, 1789–2025 | 35 | 0 / 35 (0.0%) | 19 / 35 (54.3%) | +54.3 |
| V-Dem/OWID, 1900–2025 | 105 | 5 / 105 (4.8%) | 58 / 105 (55.2%) | +50.5 |
| V-Dem/OWID, 1950–2025 | 145 | 23 / 145 (15.9%) | 80 / 145 (55.2%) | +39.3 |
| V-Dem/OWID, 1975–2025 | 153 | 35 / 153 (22.9%) | 81 / 153 (52.9%) | +30.1 |
| V-Dem/OWID, 2000–2025 | 172 | 84 / 172 (48.8%) | 87 / 172 (50.6%) | +1.7 |
| V-Dem/OWID, 2010–2025 | 176 | 93 / 176 (52.8%) | 87 / 176 (49.4%) | −3.4 |
| Bjørnskov–Rode, 1950–2025 | 106 | 39 / 106 (36.8%) | 70 / 106 (66.0%) | +29.2 |
| Bjørnskov–Rode, 2010–2025 | 193 | 115 / 193 (59.6%) | 112 / 193 (58.0%) | −1.6 |

The 1789 cohort is small and selected. The 1900 and 1950 comparisons provide broader coverage. Different rows have different cohorts; their percentages must not be joined into one continuous time series.

### Check using identical countries

For the 88 ISO-coded countries with continuous matched observations from 1950–2025 and no colonial years in the Bjørnskov–Rode series:

- V-Dem: 22 democracies became 54, a net gain of 32.
- Bjørnskov–Rode: 33 democracies became 60, a net gain of 27.

The classifiers disagree on levels, but both show substantial gains on exactly the same sample. For the 167-country matched 2010–2025 sample, V-Dem records a net loss of six and Bjørnskov–Rode a net loss of three.

### A stricter definition

Counting only liberal democracies, the fixed 1900 cohort rises from 3 to 25 of 105. The fixed 1950 cohort rises from 14 to 30 of 145. The fixed 2010 cohort falls from 44 to 31 of 176. The broad long-run direction therefore also appears under this stricter threshold, alongside a sharper recent deterioration.

## The accounting test

Let D_t be the number of democracies in a fixed cohort, G_t the number moving from autocracy to democracy, and L_t the reverse. Then:

D_T − D_0 = sum over years of (G_t − L_t).

The computation explicitly checks this equality against the endpoint counts. Authoritarian replacement contributes zero. Repeated democratization and reversal both count; their net contribution is not inflated by repeatedly counting the same country as a success.

For the **same 145-unit cohort throughout 1950–2025**:

| Transition years | Autocracy → democracy | Democracy → autocracy | Net gain |
|---|---:|---:|---:|
| 1951–1975 | 20 | 8 | +12 |
| 1976–2000 | 62 | 22 | +40 |
| 2001–2010 | 20 | 12 | +8 |
| 2011–2025 | 27 | 30 | −3 |
| Total | 129 | 72 | +57 |

23 starting democracies + 129 entries − 72 exits = 80 democracies in 2025. The periods differ in length, so transition counts are not annual transition rates. The saved results also report entries divided by preceding autocratic unit-years and exits divided by preceding democratic unit-years. The relevant balance depends on both rates **and how many units are exposed to each**.

The long-run increase is substantial, but the recent balance changes sign. That is compatible with a historical long-run advance containing reversals. This dataset alone cannot determine whether the current setback will eventually be recovered.

## What happened to initially authoritarian territories?

Among the 100 initially authoritarian units in the complete 1900–2025 cohort, 67 experienced democracy at least once, and 53 were democratic in 2025. Among 122 initially authoritarian units in the complete 1950 cohort, 78 experienced democracy and 57 were democratic in 2025.

This separates reaching democracy from retaining or recovering it. Units still authoritarian in 2025 remain in the denominator; they are not discarded as unfinished cases or classified as future successes. These are fixed-horizon cohort proportions, not survival estimates or estimates of the probability of eventual democratization.

## Statistical uncertainty and scope

The historical changes are calculated directly from the selected observations. They are not estimates from a random sample of world history. A country-trajectory bootstrap with 10,000 resamples gives a descriptive 95% interval of +41.0 to +60.0 percentage points for the 1900-cohort gain; for the 1950 cohort it gives +31.0 to +47.6 points. These intervals describe sensitivity to country composition under independent country resampling. They do not capture shared international shocks, dependence among reconstructed territorial histories, coder uncertainty, or selection from missing data.

The results file also includes exploratory paired binomial tests on endpoint status changes. Their independence and symmetric-direction assumptions are not credible as a complete model of geopolitical history. They are not used to certify the substantive conclusion or to assign a probability to inevitable victory. Several horizons and definitions were examined; this was not a preregistered test.

Coverage requires caution: complete-case cohorts exclude units with gaps, current-unit selection excludes disappeared states, and earlier historical coding is less comprehensive. The 1789–2025 series cannot establish an all-civilizations claim extending back to Sumer. Equal territorial weighting also cannot answer what share of humanity lives under democracy.

No brain-drain, productivity, repression-cost, or selectorate variable was fitted here. These results support the observed direction of institutional change; they do not identify the causal mechanism. A large historical net gain and universal eventual convergence are different hypotheses. The latter needs a validated model of future transitions, not merely a line extrapolated from these endpoints.

## Reproduction and checks

Run `python3 analyze.py` in this directory. Required packages: pandas, numpy, scipy, matplotlib, and openpyxl for reading the original workbook. Inputs are the unmodified `regimes.csv` and `br.xlsx`; source addresses and SHA-256 hashes are recorded in `sources.json` and `results.json`. No download is needed to rerun the included snapshot.

The script checks unique unit-years, permitted binary codes, complete annual coverage, one-to-one country-year matching, and exact reconciliation of transition and endpoint totals. It saves cohort memberships, the post-1950 transition ledger, aggregate results, and a figure. The figure was visually checked.

These are numerical empirical calculations. They are not Lean-certified statistical estimates. The existing project's 149 checked mathematical results remain conditional model deductions and are not converted into empirical proofs by these findings.

## Sources

- [V-Dem/OWID political-regime data and processing notes](https://ourworldindata.org/grapher/political-regime), V-Dem v16 (2026), retrieved 20 September 2026.
- [Bjørnskov–Rode author data page](https://sites.google.com/unav.es/martin-rode/home/data), version 7.2, retrieved 20 September 2026.
- [Bjørnskov and Rode (2020), dataset methods](https://link.springer.com/article/10.1007/s11558-019-09345-1).
