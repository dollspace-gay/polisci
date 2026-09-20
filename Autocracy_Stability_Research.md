# Can autocracy be proved unstable over a sufficiently long horizon?

Research report and checked mathematical models  
20 September 2026 · Extended with endogenous institutional change and the competence–participation dilemma

## Empirical update: long-run democratization

The new empirical analysis tests the balance of democratization and reversal, treating authoritarian-to-authoritarian replacement as continued authoritarianism. In a fixed cohort of 105 territories observed throughout 1900–2025, V-Dem/OWID records a rise from 5 to 58 democracies (4.8% to 55.2%). In the fixed 1950 cohort, 129 democratic transitions and 72 reversals yield a net gain of 57. A second classification, Bjørnskov–Rode, confirms a substantial post-1950 gain, including when restricted to identical countries. Both classifications record a small net decline since 2010. This supports a large historical shift toward democracy while showing that progress is episodic. It does not establish inevitable future convergence or identify brain drain as the cause.

See `empirical/Empirical_Democratization_Test.md` for the full findings, coverage limitations, and methods; `empirical/analyze.py` reproduces the calculations from the included raw data. The historical series includes territorial reconstruction, and the earliest balanced cohort is small. Numerical empirical results are distinct from the existing Lean-checked model results.

## Findings from the model investigation

The latest investigation targets the universal claim directly. The strongest combined argument is that an autocracy must either consume the capacity it needs to govern or renew that capacity in ways that repeatedly expose it to organized challenges. The new `ExitDichotomy.lean` checks why alternating between those responses cannot ensure indefinite survival **if** a uniform attrition-and-exposure constraint holds and exposed opportunities retain sufficient conditional exit risk. The reviewed research supports parts of this mechanism, but also identifies selective concessions and coalition broadening that can stabilize authoritarian rule. It does not establish that all such adaptations eventually exhaust themselves or necessarily transfer enforceable power to citizens. The universal inevitability claim is therefore still unproved; the missing premise is now explicit rather than hidden in a replacement-cost or risk parameter.

Peaceful uprising adds a distinct mechanism: a government can remain administratively capable yet lose power when citizens and essential institutions withdraw cooperation. A successful participation cascade need not wait for bankruptcy, war, or the accumulated correction failure modeled in the first version of this report. The extension proves an exact cascade criterion, allows changing government responses, and separates ending a particular government from the political order that follows.

The long-horizon objection materially improves the argument: a coordination barrier in one episode does not establish indefinite survival across centuries. The new `LongHorizon.lean` proves that recurrent opportunities with a persistent positive lower bound on conditional exit risk make the survival tail vanish. Opportunities may be arbitrarily widely spaced. Political exit events need not be independent. Thus repeated opportunities can defeat obstacles that are decisive in a single episode.

The resource extension derives a risk floor **inside an explicit resource model**: bounded investment, depreciation of control capability, and a specified relationship between capability and exit risk force the survival tail to vanish. Its opposing model permits durable improvements and a nonvanishing survival tail. That countermodel is logically valid, but its political interpretation was incomplete: it did not account for how a government retains and replaces the expertise producing those improvements.

The brain-drain objection identifies the missing connection. Brain drain, political exclusion of competent people, and the need to reward an essential coalition can restrict the reproduction of expertise and the resources available for further improvement. `PoliticalEconomy.lean` joins these constraints. A further consideration identifies another necessary condition: replacement workers must actually prefer to come or stay. `TalentChoice.lean` therefore derives recruitment constraints from accessible outside options, disadvantages associated with the regime, local advantages, and hard conditions a worker will not waive for money. It proves both rejection of inadequate offers and insufficient recruitment when enough acceptable offers cannot be funded.

The project now contains **149 Lean-checked named results across eighteen modules**, including supporting lemmas, conditional results, and counterexamples. The political-economy and talent-choice extensions add 28 results. All compile with Lean 4.22.0 and pass an axiom audit. There are no omitted proofs, custom axioms, or `native_decide` shortcuts. Only Lean's bundled standard library is used. These are elementary model results developed for this investigation, not a claim of novel political-science discovery or a formalization of the cited researchers' full theories.

The universal political claim remains unestablished. No result shows that every real autocracy obeys the depreciation and risk laws or must develop an uncorrectable reproduction deficit. Conversely, the countermodels do not show that any real autocracy can achieve unlimited durable improvement. What is resolved is the logical insufficiency of time plus bounded annual resources alone, and a concrete way political and human-capital constraints can close that escape route. A further checked construction shows why finite observations alone cannot identify the infinite-horizon outcome without restrictions on future dynamics. The earlier model investigation did not include country-level statistical analysis; the empirical extension below now supplies a separate descriptive test of long-run democratization. Lean checks exact rational survival bounds and their limit criterion; the infinite sample-space measure is not constructed in this package.

## The heart of the claim: must renewal undermine authoritarian control?

The central issue is not whether dictators make mistakes, whether skilled people value liberty, or whether the passage of centuries creates more opportunities for change. It is whether every indefinitely renewable authoritarian arrangement is impossible. The strongest candidate argument is a dilemma:

- Restricting competence, information, and autonomous organization damages the capacity needed to reproduce the system.
- Preserving or expanding those capacities empowers people who can organize, withhold cooperation, and demand accountable government.

For this dilemma to prove inevitable exit, its branches must cover every sustainable policy sequence. A ruler must not be able to alternate repression and selective investment in a way that renews capacity while making effective challenges progressively negligible. Succession must not create an uncounted reset. Those requirements are stronger than evidence that each branch sometimes causes trouble.

### What the closest existing research actually establishes

**Endogenous selectorate responses.** Bueno de Mesquita and Smith's *Political Survival and Endogenous Institutional Change* (2009; online 2008) directly models revolutionary pressure. Revenue dependence matters: their findings associate revenue requiring citizen labor with concessions and democratization under pressure, while rents and aid can support suppression and greater authoritarianism. This is evidence for a conditional political dependence mechanism, not a claim that rulers always choose suppression or always concede accountability. The publisher abstract and notes were inspected; the full strategic model was not re-formalized here. [Article](https://journals.sagepub.com/doi/10.1177/0010414008323330)

**Human capital and political organization.** Glaeser, Ponzetto, and Shleifer (2007) provide a close theoretical match to the second branch. Their Proposition 1 makes higher human capital favor the more inclusive contestant; Proposition 2 makes the most threatening challenger's size rise with human capital. Their specification can produce democratic competition at sufficiently high human capital. But they explicitly distinguish participation from democratic preferences, noting educated support for authoritarian movements. The result relies on assumptions about incentives, participation, group inclusion, and how support translates into victory. It does not derive inevitable, universal accumulation to the relevant threshold. Sections 1, 4, and the proposition proofs were inspected in the author-hosted published paper. [Published paper](https://glaeser.scholars.harvard.edu/sites/g/files/omnuum7706/files/glaeser/files/democracy_final_jeg_1.pdf)

**Transitions and consolidation.** Acemoglu and Robinson's *A Theory of Political Transitions* (2001) supplies an unusually direct answer. Proposition 1 contains different parameter regions for persistent nondemocracy, consolidated democracy, and recurrent switching. Section III also models concessions that prevent democratization. Their analysis explains when changing institutions makes commitments credible and how distribution affects actors' incentives. It does not select permanent democracy in every environment. Proposition 1, its discussion and appendix proof, and relevant consolidation sections were inspected in a copy of the published paper. [Publisher record](https://www.aeaweb.org/articles?id=10.1257/aer.91.4.938) · [Published text](https://www.rochelleterman.com/ComparativeExam/sites/default/files/Bibliography%20and%20Summaries/Acameglu%20and%20Robinson%202001.pdf)

**Coalitions over more than two centuries.** Knutsen, Dahlum, Rasmussen, and Wig's *Who Rules? Support Coalitions and Regime Survival, 1789–2020* (online 2025; issue 2026) finds larger and more diverse support coalitions associated with greater durability, including in autocratic subsamples. This uses direct measures of regime supporters, not an identical measure of the minimum winning coalition. Abstract, measurement discussion, main results, and autocratic subsample results were inspected. The observational findings do not establish infinite survival or an intervention's causal effect, but challenge the shortcut that broader cooperation necessarily democratizes a regime. [Article](https://journals.sagepub.com/doi/10.1177/00104140251369338)

**Performance and reversals.** Acemoglu, Naidu, Restrepo, and Robinson (2019) find positive long-run effects of democratization on GDP per capita using several empirical strategies. That supports benefits of democracy, but does not establish an automatic process selecting the better-performing system. [Publisher abstract](https://www.journals.uchicago.edu/doi/10.1086/700936) Lührmann and Lindberg's 2019 study documents both abrupt and gradual autocratization using data through 2017. Reversals are thus an observed process that a claim of permanent victory must explain, not a purely invented alternative. The authors' uploaded paper's methods and results were inspected. [Author-uploaded paper](https://www.researchgate.net/publication/331456057_A_third_wave_of_autocratization_is_here_what_is_new_about_it)

These findings cannot simply be assembled into a universal theorem. They use different actors, institutional definitions, mechanisms, and identifying assumptions. In particular, expert competence, regime support, and public power to remove rulers are distinct variables. A complete theory must explain their connection instead of identifying them by definition. This is the investigation's inference from the literature, not a claim that any cited author proves authoritarian immortality.

### The combined argument, checked without assuming continuous decline

Earlier results let resources offset decline, but did not integrate the idea that restoration itself can generate political exposure. The new module checks that combination.

Let `C_t` be a nonnegative, discrete accounting stock of capacity usable for continued authoritarian operation, and let `K_t` count politically exposed opportunities up to time `t`. A proposed certificate is

\[
C_{t+1}+1\leq C_t+(R+1)(K_{t+1}-K_t),\qquad K_0=0.
\]

Here `K` is nondecreasing; the formal implementation uses the equivalent addition-only inequality to avoid truncated subtraction. An interval with no new opportunity consumes at least one capacity unit. An interval with one opportunity can restore up to `R` units net. Capacity need not decrease on every interval. `R` must uniformly bound the restoration per opportunity across every allowed reform and successor, with aid, technology, recruitment, and reorganization counted. The time and resource units are part of the model, not estimated years or currency.

Telescoping gives

\[
C_t+t\leq C_0+(R+1)K_t.
\]

Hence continued operation for arbitrarily long time requires arbitrarily many opportunities. For any proposed upper bound `k` on opportunities, time greater than `C_0+(R+1)k` is incompatible with nonnegative capacity. This rules out an indefinitely safe sequence made by repeatedly alternating the two branches while obeying the certificate.

The existing opportunity-indexed survival results then apply if exposure retains sufficient conditional exit risk. A uniform positive lower bound, conditional on the full preceding history and the chosen policy, is one sufficient condition. Independence of separate exit events is unnecessary. The new `attrition_exposure_and_risk_force_vanishing` explicitly requires an opportunity-indexed vanishing survival tail and a valid comparison with calendar survival. This comparison is important when different surviving histories contain different numbers of opportunities: the theorem does not silently substitute one representative trajectory for all of them. Positive denominators are explicit; a probability-space interpretation additionally requires valid probabilities and the usual interpretation of the survival limit.

The three new named results are:

| Lean result | What it checks |
| --- | --- |
| `attrition_or_exposure_accounting` | The cumulative capacity bound, including recovery periods. |
| `attrition_forces_unbounded_exposure` | An infinite admissible trajectory cannot keep its opportunity count bounded. |
| `attrition_exposure_and_risk_force_vanishing` | The cumulative constraint plus a justified risk comparison forces calendar survival to vanish. |

This certificate is an independently developed way to connect the two proposed branches. It is not a re-formalization of the cited political-economy models. Nor is it a proof that real political opportunity arrives according to this accounting law. Calling competence loss “capacity consumption” is insufficient unless its size and replenishment constraints are independently supported.

### Exactly where the proposed universal proof fails

The mathematical implication is sound. What the reviewed research does not provide is a universal certificate that every safe authoritarian interval consumes an irreplaceable resource, or that every way of restoring capacity exposes the regime to an exit risk that cannot become sufficiently small. The coalition evidence makes this especially consequential: accommodating additional people can sometimes make an autocracy more durable rather than more vulnerable. The competence–participation connection therefore cannot be treated as a universally destabilizing law.

A second obligation concerns permanent democratic victory. Even an eventual-exit result must address replacement by another autocracy and later authoritarian return. A self-enforcing democratic equilibrium is an existing theoretical result under specified incentives; an unavoidable path from every initial condition to that equilibrium is a different claim. This project already records the additional classification and closure requirements in `Dynamics.lean`.

The research verdict is consequently specific. There is a coherent conditional theorem linking finite capacity, politically exposed renewal, and eventual exit, and the new proofs show that alternating policies need not defeat it. There are also established mechanisms favoring democratization and consolidation. There is no established universal law in the reviewed sources that forces every authoritarian system into those conditions. Treating that absence as an algebraic blank would place the desired conclusion into the assumptions.

A genuine empirical advance would identify a measure of renewable authoritarian capacity, estimate how each feasible restoration changes effective citizen bargaining and organization, and test whether the resulting exposure remains unavoidable across survival cases as well as collapses. No such universal empirical result or new country-level estimation is claimed here. The central target remains open; the conditional theorem must not be presented as its solution.

## What it means for mathematics to answer to history

A correct proof does not establish that its assumptions describe an actual government. Historical research supplies and challenges those assumptions; mathematics establishes their joint consequences. A hypothetical stable path is useful for identifying a missing premise, but it is not evidence that any real autocracy can follow that path. Conversely, a history of failures is evidence about actual risks and mechanisms, but does not by itself identify which mechanism caused each failure or the fate of every future authoritarian arrangement. Finite-history nonidentification is a limit on assumption-free inference, not a reason to reject well-supported causal inference.

The appropriate task is to compare explanations against history, including cases of survival and recovery, and then derive consequences under the best-supported conditions. It is not to demand a mathematical proof of a historical premise. Nor should every observed adaptation be relabeled sustainable: a temporary reprieve and a process that continually renews its own resources are different claims.

### Evidence that constrains the model

| Evidence | What it supports | What it does not establish |
| --- | --- | --- |
| Bueno de Mesquita, Morrow, Siverson, and Smith (1999), foundational selectorate study | The study reports better growth with larger winning coalitions, but political survival under poor performance can favor leaders with large selectorates. | A universal downward trajectory of governing capacity, or inevitable failure of all small-coalition systems. |
| Egorov and Sonin's loyalty–competence model, already discussed below | Under the specified incentives, appointing less competent associates can protect an insecure ruler from betrayal. | A calibrated, unavoidable net loss of all useful expertise across every authoritarian institution. |
| East Germany's emigration and border restrictions | The Berlin Wall Foundation documents mass emigration, coercive efforts to prevent it, continued escape attempts, and the eventual end of the dictatorship. Both the pressure and the adaptation occurred. | That talent loss alone explains the eventual outcome, or that the response could have sustained the system indefinitely. |
| Wright, Frantz, and Geddes (2015; online 2013), oil and regime survival | Their statistical analysis links oil wealth to lower risk of replacement by rival autocratic groups, with military spending as a suggested channel. | Infinite survival, or proof that rents can finance any amount of replacement expertise. |
| Geddes, Wright, and Frantz (2014), regime transitions | Their data distinguish changes of leader, replacement by another autocracy, and democratization. | That counting every leader departure measures the disappearance of authoritarian government. |

Sources: [selectorate study](https://journals.sagepub.com/doi/10.1177/0022002799043002002); [Egorov–Sonin working paper](https://www.ias.edu/sites/default/files/sss/papers/econpaper53.pdf); [Berlin Wall Foundation](https://www.stiftung-berliner-mauer.de/en/topics/berlin-wall); [oil and autocratic survival](https://doi.org/10.1017/S0007123413000252); [regime transitions](https://doi.org/10.1017/S1537592714000851). The three journal studies were checked against their publisher abstracts and available notes, not newly replicated. The Wall Foundation account is institutional historical interpretation, not a causal estimate. No new country-level data were fitted for this extension.

The historical response to emigration matters in both directions. It makes a model of unrestricted worker mobility inappropriate for the GDR after the Wall. It also makes a model of costless, voluntary worker retention inappropriate. Restrictions, enforcement costs, worker cooperation, domestic training, and outside support must be represented. These are observations and measurable mechanisms, not arbitrary mathematical escape clauses.

### Renewal, reserves, and changing leaders

The new `Renewal.lean` addresses a specific weakness in the earlier argument: losing resources this year need not imply immediate failure when a government can use reserves or reduce its obligations. The model permits both. Its five checked statements formalize an optimistic budget envelope and its consequences, without claiming a complete selectorate equilibrium.

Let each period be a defined workforce-renewal interval. Let `H` denote effective expertise and `B` spendable reserves. The next period's workforce must be retained, trained, or recruited at total cost at least `p H_next`. This includes incumbent retention, not just foreign hires. Available revenue is at most `a H + r`; essential coalition and operating obligations cost at least `q`. Costs must not double-count employees who also belong to the coalition. Any subsidies, remittances available to this budget, credit drawdowns, technology gains, or external expertise must be included consistently.

Every permitted continuation then obeys

\[
pH_{t+1}+B_{t+1}+q\leq aH_t+r+B_t.
\]

These are uniform bounds across the allowed policy choices, not a claim that actual spending or productivity is constant. Shrinking the coalition is allowed down to `q`; improving productivity is allowed up to `a`; changing leaders is unrestricted. A reform outside these bounds requires revising the model. `p` must be a defensible lower bound after accounting for domestic training and retention as well as worker choice. A salary premium for some foreign recruits cannot establish this bound for an entire workforce.

In the parameter region `p = a + g`, where `g` is nonnegative, define the accounting quantity

\[
V_t=pH_t+B_t.
\]

This is a proof device, not a claim that expertise can actually be sold at price `p`. The budget gives

\[
V_{t+1}\leq V_t+r-q-gH_t.
\]

Suppose continuing operation requires `H_t ≥ h`, and the empirically justified bounds satisfy

\[
r<q+gh.
\]

Then every continuing transition consumes at least one discrete unit of `V`. Consequently, operation must cease within `V_0+1` modeled intervals. The bound is coarse and depends on the chosen resource units; it is not a historical forecast in years. Reserves can delay failure and expertise can temporarily increase, but their combined accounting quantity cannot increase under these conditions.

`renewal_shortfall_forces_exit` checks this argument. Its operating predicate must be justified independently: to infer exit from the authoritarian class, one must establish that *every* authoritarian continuation requires the stated expertise and budget conditions. Failure of a particular administrative arrangement alone does not establish democratization.

The same module checks the exact stationary budget boundary:

\[
q+gH\leq r.
\]

At that boundary or above it, maintaining a specified workforce and reserve stock is budget-feasible in the model. That establishes neither a sufficient supply of willing qualified workers nor a political equilibrium. It identifies what the evidence must rule out before this mechanism yields inevitable failure. Pure leader replacement leaves the budget inequality unchanged; a successor who actually changes productivity, support, costs, or workforce requirements may change its parameters.

### How the proposed mechanism can be tested

The decisive empirical question is whether even the best available authoritarian adaptation leaves a recurring renewal deficit. Evidence of lower growth relative to democracy is insufficient: a slower-growing system can still renew itself. Evidence of skilled departures is also insufficient on its own: the relevant quantity is the loss of usable expertise after domestic training, retention, and inflows.

A historical test should trace those quantities before and after coalition changes, emigration restrictions, succession, and reform. It should also examine survival cases, external financing, and periods of recovery. A finding that renewal recovered without democratization would challenge a claim that the particular deficit was unavoidable. A finding that apparent recovery merely consumed reserves or depended on a terminating subsidy would instead support the delayed-failure mechanism.

This extension therefore identifies a more demanding, testable condition than “autocracy performs badly.” It has not estimated its parameters or established that every autocracy satisfies it. That distinction is the practical meaning of making the mathematics answer to the real world.

## Replacement talent must choose to come or stay

The objection is about voluntary supply. A replacement budget does not make a qualified person willing to move to an authoritarian state, nor make a newly trained resident willing to remain when a better option is accessible. The earlier replacement example assumed successful recruitment at an assigned price. It had not demonstrated that any relevant worker would accept that offer. Allowing an external talent input in an accounting equation also does not establish that the input can occur.

### Workers compare complete offers

For each worker, the new model records an accessible outside option `X`, disadvantages of the authoritarian option `L`, local advantages `A`, and offered pay `w`. These are normalized net values: earnings should reflect taxes and living costs, while the other terms can include security, civil liberties, professional autonomy, career prospects, family ties, and moving costs. The comparison is:

\[
w+A\geq X+L.
\]

An offer must additionally satisfy any hard condition the worker has. The model can therefore represent a person who refuses particular conditions at every wage, without pretending that all preferences can be purchased. It does not assume that all workers have such a veto, or estimate how common it is. An outside option must actually be available; an inaccessible job or destination is not a feasible alternative.

`lower_pay_and_worse_conditions_rejected` proves that pay no better than the outside option, combined with a disadvantage exceeding local advantages, cannot yield voluntary acceptance. `inadequate_premium_rejected` checks the stronger example: even an offer up to `X+N` is rejected when `N+A<L`. `hard_condition_blocks_every_wage` checks the nonnegotiable case.

For workers without a hard veto, `acceptance_iff_reservation` derives the minimum weakly acceptable wage:

\[
r_i=\max(0,X_i+L_i-A_i).
\]

Equal utility is treated as permitting acceptance; it does not guarantee that the person chooses to accept. The impossibility results remain valid if people require a strict improvement. `higher_disadvantage_raises_reservation` proves that increasing a worker's disadvantage cannot lower this reservation wage, holding the other components fixed.

### Enough willing people must be affordable

For a specified team of distinct qualified workers `T`, essential-coalition requirements `Q`, investment `I`, and available resources `Y`, the exact feasibility result is:

\[
\text{all workers' hard conditions are satisfied}
\quad\text{and}\quad Q+\sum_{i\in T}r_i+I\leq Y.
\]

`coalition_and_talent_feasible_iff` proves necessity and sufficiency for the specified team under the stated payment model. Sufficiency means an acceptable payment allocation exists; it does not assert that the team exists in the relevant labor market, that payments are credible indefinitely, or that the workers provide every required complementary skill. Those are additional requirements. The list must represent distinct people, and each proposed team must be drawn from the actual candidate pool.

The obstruction does not require universal refusal. `reservation_floor_limits_recruitment` proves that when relevant workers require at least `r` each, a budget below `Q+k·r+I` cannot recruit `k` such workers. Some candidates can be willing and the government can still lack enough of them. Where skill categories are not interchangeable, apply separate requirements to each indispensable category; adding unrelated workers does not fill a missing specialist role.

`unwilling_pool_supplies_no_recruits` handles complete refusal. If every candidate either rejects a hard condition or needs more than the entire residual budget, any voluntarily accepted and funded recruitment list drawn from that pool is empty. Its contribution to the external-inflow term is consequently zero. This removes the option of inserting replacement talent into the accounting simply because replacement would help the regime survive.

### What changes in the long-run argument

The proposed feedback is now more specific: authoritarian conditions can raise the compensation required by mobile skilled people, while coalition obligations limit the resources available to provide it. Departures and refused offers can reduce usable expertise; lower expertise can reduce future productive capacity and funding. Paying more, importing workers, and training replacements each require an actual supply response and funding. Training someone does not establish that they will remain.

This supports a stronger research target than counting emigrants: determine whether any politically feasible combination of pay and conditions can attract and retain **enough of the necessary skills** after coalition obligations are met. Improvements in rights or professional autonomy must be modeled as policies that change workers' choices, with their political feasibility examined in turn. The proof must cover feasible responses, rather than assume either successful recruitment or inevitable refusal.

The evidence reviewed above and below establishes reasons liberties and repression matter; it does not estimate the fraction of all skilled workers who would refuse every authoritarian offer. There is also evidence that some cross-border recruitment succeeds: Huang and colleagues' 2024 preprint studies participants in a Chinese talent program and reports subsequent research-performance differences using matching designs. We read its abstract. This establishes a reason not to assume universally zero recruitment; it does not establish adequate net replacement, general willingness, or perpetual capability growth. [Huang et al., 2024 preprint](https://arxiv.org/abs/2403.00107)

The previous balanced-replacement example therefore remains conditional accounting, not a demonstrated escape from the brain-drain argument. It is politically admissible only if its replacement workers satisfy the new willingness and affordability constraints. The model now exposes precisely what that assertion would require.

## How brain drain and coalition incentives change the result

### What was missing

Earlier sections cited the loyalty–competence tradeoff and selectorate reasoning, but those ideas did not constrain the durable-accumulation example. Its capability stock increased by one unit every period, with no labor supply, replacement training, appointment incentives, or competition for the investment budget. That example answers a narrow logical question about bounded spending. It is insufficient as an account of a politically feasible route to perpetual authoritarian improvement.

The stronger political hypothesis is that preserving personal or coalition power can undermine the people and institutions needed to reproduce that power. Emigration removes expertise; exclusion and loyalty-based appointments can prevent remaining expertise from being used; coalition rewards can crowd out its replacement. Lost capability can then reduce the resources available to repair the damage. These mechanisms require modeling jointly, including responses that might offset them.

### What the literature supports

**Loyalty can compete with competence.** Egorov and Sonin derive a reason insecure rulers may prefer less capable subordinates: capable agents can also be more effective participants in a successful challenge. Their dynamic treatment includes succession incentives. We consulted the 2011 publisher's abstract as well as the previously reviewed working-paper version. This supports making access to competent administration a political choice, rather than a free input. It does not imply that every authoritarian appointment sacrifices competence. [Egorov & Sonin, 2011](https://onlinelibrary.wiley.com/doi/10.1111/j.1542-4774.2011.01033.x)

**Losing experts can damage the production of future experts.** Waldinger uses the expulsion of mathematics professors in Nazi Germany to study the effect of faculty quality on doctoral outcomes. The publisher's abstract reports substantial effects on students' subsequent academic careers. This is relevant to reproduction of expertise, beyond the immediate number of people removed. It studies an identifiable historical mechanism, not an inevitable trajectory for every autocracy. We read the abstract; we did not independently reproduce its estimates. [Waldinger, 2010](https://www.journals.uchicago.edu/doi/10.1086/655976)

**Selectorate theory separates national performance from rulers' survival.** Bueno de Mesquita and colleagues model the selectorate and winning coalition, and report evidence that institutional arrangements which protect leaders can coexist with policy failure. Their 1999 study associates larger winning coalitions with higher growth and shorter leader tenure, while larger selectorates lengthen tenure. We read the publisher's abstract and methodological notes, alongside the book's publisher description. The implication is that poor performance need not remove an incumbent if essential supporters remain satisfied. Coalition rewards and broad productive investment can pull in different directions. [Bueno de Mesquita et al., 1999](https://journals.sagepub.com/doi/10.1177/0022002799043002002), [*The Logic of Political Survival*](https://mitpress.mit.edu/9780262524407/the-logic-of-political-survival/)

**The relevant quantity is net retention and reproduction, not gross departures.** Docquier's research synthesis describes losses of human capital and fiscal capacity, alongside offsetting education incentives, return migration, remittances, and diaspora networks. It also discusses feedback between economic decline and skilled emigration. We read its mechanisms and limitations sections. Its heterogeneous findings support a model with separate outflows and replacement channels; they do not justify treating all migration as a fixed net loss or assuming that closing borders restores development. [Docquier, 2014](https://wol.iza.org/articles/brain-drain-from-developing-countries/long)

**Emigration has competing political effects.** Miller and Peters find that expected economic emigration can support authoritarian survival, while migration disproportionately directed toward democracies predicts democratization. Their explanation includes selection of a more loyal resident population and economic links abroad, alongside exposure to democratic institutions. We read the publisher's abstract. The lesson for this project is to distinguish productive capacity, domestic opposition, and diaspora influence. They need not move together. [Miller & Peters, 2020; first published online 2018](https://www.cambridge.org/core/journals/british-journal-of-political-science/article/restraining-the-huddled-masses-migration-policy-and-autocratic-survival/21B69A5B42F8AD2C33F8083EE97623C0)

### The new joint resource model

The formal extension tracks the following quantities separately:

| Quantity | Meaning in this model |
|---|---|
| `H_t` | Usable expertise available at the start of a period |
| `G_t` | Paid recruitment or training that actually produces replacement expertise |
| `E_t` | Additional expertise arriving without charge to the modeled budget |
| `D_t` | Actual expertise lost through departure or exclusion |
| `Q_t` | Minimum essential-coalition payments, the sum of reservation requirements |
| `P_t` | Actual coalition payments, meeting those requirements |
| `I_t` | Additional investment in control capability |
| `Y_t` | Resources available for these expenditures |

Actual skill conservation and the budget constraint are:

\[
H_{t+1}+D_t=H_t+G_t+E_t,
\qquad Q_t\leq P_t,
\qquad P_t+G_t+I_t\leq Y_t.
\]

These are normalized integer units: one unit of paid replacement expertise costs at least one budget unit. The model does not equate a person's intrinsic worth with a price. It tracks a limited productive input. `E_t` permits entrants, returnees, or externally financed training whose cost does not fall on this budget. Expertise excluded from useful work belongs in `D_t` only if it leaves the modeled usable stock; it need not involve literal emigration. Overlapping losses must not be counted twice.

`maintained_talent_requires_replacement_budget` proves that maintaining the stock requires:

\[
H_{t+1}\geq H_t\quad\Longrightarrow\quad
Q_t+D_t+I_t\leq Y_t+E_t.
\]

This directly qualifies the earlier accumulation scenario. Funding another unit of control is insufficient unless the expertise producing and operating it can also be reproduced. `coalition_drain_gap_reduces_talent` proves that if coalition obligations plus actual skill losses exceed resources plus free skill entry by at least one normalized unit, expertise must decline under every funded allocation satisfying these constraints.

The stronger result permits alternating good and bad periods. `joint_talent_fiscal_bound` checks the finite-window inequality:

\[
H_n+\sum_{t<n}D_t+\sum_{t<n}Q_t+\sum_{t<n}I_t
\leq H_0+\sum_{t<n}Y_t+\sum_{t<n}E_t.
\]

Consequently, if cumulative coalition obligations and skill losses exceed initial expertise plus all available resources and external skill inputs, the arrangement cannot satisfy its continuation conditions throughout that window. This is `cumulative_reproduction_gap_forces_exit`. `selectorate_drain_gap_forces_exit` also proves a finite bound for the special case of a persistent per-period gap. Neither theorem requires technological capability itself to depreciate.

The political bridge is explicit: continued rule must require the specified stock accounting, essential-support payments, and financing constraints. A model of a whole economy must include private resources and alternative training institutions consistently. Coalition payments that return as investment cannot simply disappear from the accounts; their subsequent contribution must be recorded without double-counting. Borrowing, drawdowns of reserves, and external transfers must likewise enter available spending capacity. Failure of this resource arrangement becomes regime exit only when its requirements are necessary for that regime's continuation.

### Feedback, loyalty, and escape mechanisms

The extension also defines a simple revenue law, `skillRevenue = productivity × expertise + rents`. Lean checks that losing expertise reduces this revenue when productivity is positive. Under fixed coalition obligations, departures, external entry, productivity, and rents, a replacement deficit cannot be cured by a further fall in expertise. This establishes a feedback within the specified model. It does not prove that every autocracy enters the deficit region, nor that those other quantities remain fixed.

For coalition incentives, `CoalitionLoyal` is an explicitly restricted comparison: an incumbent payment is compared with a challenger's reward weighted by the chance of inclusion in a replacement coalition. With coalition size `W` and selectorate size `S`, it is represented exactly as `W × challengerReward ≤ S × incumbentReward`. This assumes risk neutrality, equal public benefits, credible rewards, and inclusion probability `W/S`, with `0 < W ≤ S`. Lean checks how enlarging the selectorate or shrinking the coalition makes this inequality easier to satisfy, and derives a necessary aggregate payment budget. These are elementary implications of the specified comparison, not the full selectorate model or a solved dynamic political equilibrium.

This matters because coalition requirements are not necessarily an ever-growing burden. A small coalition with weak outside options can be inexpensive to retain. `rents_can_insulate_coalition` checks that a rent stream covering its requirements can keep those payments feasible even when expertise-dependent revenue is absent. It proves financial feasibility of the coalition payments only; functioning institutions and control require additional conditions.

The accounting example pays for its stipulated inputs. With revenue of three units per period, it spends one on coalition rewards, one replacing a departing unit of expertise, and one on control investment. Talent stays constant despite positive gross departures, and durable capability continues to accumulate. `brain_drain_and_patronage_can_coexist_with_learning` checks those conditions together with the previous nonvanishing survival sequence. It assumes successful replacement at that price. The talent-choice extension above identifies when this assumption fails, so this example is not itself a demonstrated recruitment equilibrium or a politically feasible escape path.

### Revised conclusion

The earlier infinite-improvement example cannot establish that real authoritarian adaptation escapes the user's argument: it omitted the political economy needed to sustain its inputs. Brain drain and selectorate incentives provide concrete mechanisms for a self-undermining process and can invalidate that path. The new proofs show how a sufficiently large cumulative reproduction deficit defeats continued operation even when technological gains are durable.

What remains to be established is that authoritarian institutions necessarily generate an uncorrectable deficit after accounting for replacement, rents, coalition changes, and alternative ways of obtaining expertise. Selectorate theory helps explain both harmful allocation and survival despite harm. Gross emigration does not establish net depletion, and net national decline does not automatically establish loss of the ruling coalition. The next empirical target is the joint constraint and its feedbacks, not an isolated migration count or an assumption of costless authoritarian learning.

## The final question: can adaptation outrun recurrent exit risk?

### State the target precisely

Choose what is supposed to end: an incumbent government, a ruling organization, or an autocratic selection system. Then allow its feasible responses to include concessions, bureaucratic improvements, replacement supporters, leadership succession, and investments in control. A universal inevitability claim must survive all such responses, across all societies within its claimed scope. A single unsuccessful response, or even many failed historical regimes, does not establish that quantifier.

The new models treat exit as loss of the selected ruling arrangement. The conditional state path describes what happens **if that arrangement is still surviving**. Leadership can change on this path without being counted as the target event. The risk variable can represent peaceful displacement if that is how the model is applied, but the resource equations do not themselves derive a peaceful-uprising mechanism. Connecting their risk law to coordination and institutional withdrawal remains a substantive political assumption.

### A derived risk floor under depreciating control

Let `C_t` be effective control capability and `I_t` investment during period `t`. Consider the explicit laws:

\[
C_{t+1}=\lfloor C_t/2\rfloor+I_t,\qquad 0\leq I_t\leq B,
\qquad q_t=\frac{1}{(C_t+2)^2}.
\]

The halving is a modeling choice: capability needs renewal because its effectiveness decays. Neither the halving rate nor the inverse-square risk law is an empirical estimate. Each period is an abstract model period, not necessarily one year. Investment may vary arbitrarily subject to the budget.

`depreciating_capital_bounded` proves that every such investment schedule satisfies:

\[
C_t\leq 2(C_0+B).
\]

`depreciating_capital_risk_floor` proves the resulting denominator bound, which gives the positive risk floor:

\[
q_t\geq\frac{1}{\bigl(2(C_0+B)+2\bigr)^2}.
\]

`RationalRisk.lean` defines exact survival numerators and denominators by multiplication at each period. `bounded_denominators_force_vanishing` proves their vanishing-tail criterion whenever risk denominators have a finite uniform bound. Combining these results, **`depreciation_and_budget_force_vanishing` proves vanishing survival without taking a separate persistent-risk hypothesis as an input**. The resource dynamics and stipulated risk law supply it.

This advances the earlier conditional argument. It explains how a limit on replenishment could prevent indefinite risk reduction. It also exposes the assumptions that must be defended: control effectiveness depreciates as specified, investment remains bounded, and finite capability leaves positive exit risk according to the risk law. Those assumptions are not consequences of calling a government autocratic. The same arithmetic applies to another regime label with the same dynamics.

There is a second resource result. `bounded_average_has_recurring_low_effort` proves that if cumulative recurring expenditure never exceeds `B` times the number of elapsed periods, then arbitrarily late periods spend at most `B`. Expenditure here is integer-valued, so permanently exceeding `B` means spending at least `B+1` each period. This theorem permits saving and intermittent bursts. If those low-expenditure periods retain a common positive exit chance, `bounded_average_and_recurring_risk_force_vanishing` proves vanishing survival even if the opportunities become widely separated. That version still explicitly assumes the behavioral connection between low expenditure and exit risk; durable capital can break that connection.

### An endogenous accumulation countermodel

Keep the same risk law and start with zero capability, but make improvements durable:

\[
C_{t+1}=C_t+1,\qquad I_t=1,\qquad
q_t=\frac{1}{(C_t+2)^2}.
\]

`Accumulation.lean` proves that installed capability equals elapsed periods and cumulative spending is exactly one unit per period. Its state includes a leader who is replaced every period and an unchanged autocratic regime label. The risk law is time invariant: risk falls because capability grows, rather than because a declining time series is inserted as an unexplained input.

`learning_survival_follows_risk` checks the exact conditional survival recurrence for:

\[
S_n=\frac{n+2}{2n+2}.
\]

The existing long-horizon results check that these are valid, strictly decreasing survival probabilities, with positive exit risk at every finite date, and that their excess above one half tends to zero. `bounded_annual_investment_does_not_force_vanishing` joins the investment bound, continuing autocratic selection rules, risk law, and nonvanishing tail in one statement. Thus bounded investment flow plus recurrent positive risk does not logically imply eventual exit with probability one.

**This countermodel assumes no depreciation and unlimited cumulative improvement in effective capability.** It is not evidence that an actual ruler can achieve either. It disproves an inference from the weaker premises, not the stronger claim that all physically realizable authoritarian systems eventually fail. A bound on physical stock would exclude this specific unbounded-stock construction. To derive exit from a stock bound, one would still need to establish positive residual exit risk at every attainable control state, or another condition preventing a permanently closed autocratic class. Physical finiteness by itself does not establish that political reachability condition.

The exact-arithmetic script `resource_experiments.py` illustrates the difference while holding initial capability, annual investment, and the risk function fixed. These are synthetic probabilities, not historical estimates.

| Capability dynamics, investment fixed at one per period | Survival after 10 periods | After 100 | After 1,000 | Limiting survival |
|---|---:|---:|---:|---:|
| Half the previous stock retained | 0.259830 | 0.00000647085 | 5.93870 × 10⁻⁵² | 0 |
| All previous stock retained | 0.545455 | 0.504950 | 0.500500 | 1/2 |

Long-run conclusions come from the formal results. The finite calculations only illustrate them. Under the usual probability interpretation, the second row leaves a one-half chance of never leaving the specified arrangement. It does not assert certain survival.

### What the adaptation literature establishes

The strongest objection to the universal claim is not simply that some regimes have lasted a long time. It is that governance improvement and preservation of concentrated power need not be mutually exclusive.

King, Pan, and Roberts find that Chinese censorship in their study targeted content with collective-action potential while allowing substantial criticism of government. This distinguishes the information needed to correct performance from the information that enables coordinated challenge. We read the author-hosted paper, including its abstract and initial methods discussion. It supports a selective-control mechanism, not a claim that control becomes perfect or that future risk is summable. [King, Pan & Roberts, 2013](https://gking.harvard.edu/files/gking/files/censored.pdf)

Lorentzen's formal model explains how a government can permit investigative reporting that improves governance while limiting opportunities for coordinated uprising. We consulted the publisher's abstract, not an independently reproduced proof. Its relevance is that openness, correction, and authoritarian survival can coexist under specified conditions. It does not establish perpetual survival. [Lorentzen, 2014](https://onlinelibrary.wiley.com/doi/10.1111/ajps.12065)

Beraja, Kao, Yang, and Yuchtman examine Chinese procurement of facial-recognition AI. Their abstract reports that unrest predicts procurement, procurement reduces subsequent unrest, and contracts stimulate innovation by recipient firms. We read the publisher's abstract and MIT's institutional account. The latter explains an indirect test using the relationship between weather and unrest. These findings support investigating feedback between technical improvement and political control; they do not measure an infinite-horizon exit probability or validate the inverse-square law used here. [Beraja et al., 2023](https://academic.oup.com/qje/article-abstract/138/3/1349/7076890), [MIT account of the study](https://news.mit.edu/2023/how-ai-tocracy-emerges-0713)

Our inference from these sources is limited: a proof cannot assume that all useful learning requires democratization, or that control investment merely consumes resources without improving future effectiveness. Equally, these sources do not establish that improvements can continue indefinitely, avoid decay, or outpace citizens' own learning. The decisive asymptotic comparison remains unmeasured.

### Why another century of observations cannot settle the universal claim alone

`Identification.lean` constructs two valid, strictly decreasing survival sequences. Both start at one and can agree through **any chosen finite cutoff**. One is the harmonic survival sequence `1/(n+1)`, which vanishes. The other has an identical prefix followed by a rescaled version of the nonvanishing inverse-square-risk example. Lean checks the matching prefix, valid probabilities, strict decrease of the constructed continuation, and its nonvanishing tail in `finite_prefix_does_not_determine_infinite_tail` and supporting lemmas.

This is stronger than observing that a dataset is incomplete: even knowing the exact survival probabilities through a finite date does not determine the unrestricted continuation. It does not make historical research useless. Evidence can reject models, estimate mechanisms, and support comparative forecasts. Extrapolating to an infinite horizon requires structural restrictions on what can happen afterward; the data alone cannot supply that conclusion.

### Resolution and remaining boundary

The strongest completed result is now: **under the specified depreciation and risk laws, bounded replenishment forces the survival tail to zero for every admissible investment schedule.** The proof derives its risk floor. The companion countermodel shows why replacing those laws with the vague phrase “limited resources” is insufficient.

The universal political question is therefore not solved affirmatively, and this investigation has not disproved it for the real world. To establish it, one must justify a restriction that prevents every feasible authoritarian response from eliminating or reducing future exit risk sufficiently fast. To establish eventual democracy, one must additionally exclude persistent authoritarian replacement or restoration. Neither follows from the passage of time alone.

## Time changes the question: repeated opportunities across centuries

### The strongest version of the argument

A government does not need to lose the first confrontation. It needs to avoid losing every consequential confrontation that follows. Temporary reform, a failed uprising, or a change of leader need not provide permanent protection. Earlier static countermodels held their inputs fixed; they do not answer a claim involving recurring shocks, new generations, learning, or renewed coordination opportunities.

The relevant sufficient condition is: after every surviving history, including the reforms and successions already used, some recurring opportunity retains a positive minimum chance of ending the specified government or ruling arrangement. Under that condition, survival probability tends to zero. This permits a long run of unsuccessful uprisings and does not predict a particular date of exit.

For a finite, time-homogeneous Markov model, this has a familiar stronger structural form: if every nonterminal state can reach an absorbing exit state, eventual absorption has probability one. Finite state space and fixed transition probabilities allow a common block length and a common positive exit chance to be obtained from the possible paths. Grinstead and Snell prove this in Theorem 11.3. We read that proof; our Lean code independently checks an arithmetic survival-bound version, not the book's full Markov-chain theorem. [Grinstead & Snell, *Introduction to Probability*, §11.2](https://math.dartmouth.edu/~prob/prob/prob.pdf)

The political interpretation remains conditional. A state description must include resources and adaptation relevant to future risk, and a policy that creates an inescapable autocratic class would invalidate the reachability premise. A fixed finite-state model also excludes indefinitely improving defenses unless those improvements are represented in its state space.

### What Lean checks about repeated risk

The implementation uses exact fractions represented by natural numerators and positive denominators. This avoids numerical rounding and requires no external mathematics library. For a positive integer `b`, let `v(n)` count surviving histories among `(b+1)^n` equally weighted histories. Suppose `v(0) ≤ 1` and:

\[
v(n+1)\leq b\,v(n).
\]

One interpretation is that each surviving history has `b+1` equally weighted extensions and at least one ends the government. Which extensions end it may depend on its entire history. The condition also permits more exits than the minimum. It is a conditional-risk assumption, not an assumption that political outcomes are independent.

`survival_count_bound` proves `v(n) ≤ b^n`, giving:

\[
S_n=\frac{v(n)}{(b+1)^n}\leq\left(\frac b{b+1}\right)^n.
\]

`recurrent_risk_vanishing_tail` proves that this tends to zero. Convergence is stated explicitly in the code: for every positive integer `k`, there is a horizon after which `k·v(n) ≤ (b+1)^n`, so survival is at most `1/k`. The proof even provides the conservative horizon `k·b`; the geometric bound is usually much sharper.

`unbounded_opportunities_preserve_vanishing` proves that the opportunities need not occur every year or at regular intervals. If their cumulative count eventually exceeds every finite number, the tail still vanishes in calendar time. The spacing affects how long one waits, not the limiting result under these assumptions.

The formal boundary matters: the package proves exact rational inequalities and this all-tolerances convergence criterion. It does not construct an infinite probability space or formalize continuity of probability for decreasing survival events. In the standard probability interpretation, that continuity identifies the vanishing tail with probability-zero eternal survival, hence probability-one eventual exit. That identification is explained here rather than claimed as a separately kernel-checked measure-theory theorem.

The lower bound must survive adaptation. It is not enough to estimate a historical average risk and assume that the same risk applies after every future reform. Conversely, no independence objection defeats the conditional-bound argument: government learning, opposition learning, and dependence on previous events may all be present as long as the bound continues to hold.

### Even shrinking risks can support the argument

A constant minimum risk is sufficient, but it is not necessary. Consider a conditional exit risk at opportunity `n` of `1/(n+2)`. Its survival probability after `n` opportunities is `1/(n+1)`, which tends to zero. The code checks the recurrence and the convergence in `decreasing_risk_recurrence` and `decreasing_risk_can_still_vanish`.

This matters politically: showing that adaptation lowers risk does not establish indefinite survival. It has to lower risk enough, for long enough, to prevent the survival tail from vanishing.

### The precise limit of “time overcomes it”

There is also a fully explicit contrasting sequence. Let the conditional exit risk at opportunity `n` be:

\[
q_n=\frac1{(n+2)^2}.
\]

Each risk is strictly positive. Starting with survival probability one, the resulting exact survival sequence is:

\[
S_n=\frac{n+2}{2n+2}=\frac12+\frac1{2n+2}.
\]

Lean checks valid probability bounds, strict decrease at every round, the cross-multiplied conditional recurrence, and convergence of the excess above one half. It also proves that this survival tail does not vanish. Thus the sequence represents a model with endlessly recurring positive risks but a one-half limiting chance of never exiting. It does not assert that any real autocracy achieves this risk trajectory.

The distinction is substantive: **temporary survival does not defeat the centuries-long argument; permanent suppression or sufficiently rapid reduction of future conditional risk could.** The task is to determine whether autocratic institutions can achieve the latter, rather than pointing to the former as though it settled the matter.

`long_horizon.py` computes these synthetic examples using exact fractions. The table displays rounded survival probabilities; none is an estimated country forecast.

| Conditional exit risk at opportunity n | Survival after 10 opportunities | After 100 | After 1,000 | Limit |
|---|---:|---:|---:|---:|
| 1/100 | 0.904382 | 0.366032 | 0.0000431712 | 0 |
| 1/(n+2) | 0.0909091 | 0.00990099 | 0.000999001 | 0 |
| 1/(n+2)² | 0.545455 | 0.504950 | 0.500500 | 1/2 |

Probability-one eventual exit is not a guaranteed finite deadline. Nor does it establish that democracy is the destination. For this model, exit means that the specified government or ruling arrangement has ended at least once; that past event remains true even if an authoritarian successor later appears. If the target is permanent disappearance of autocracy as a regime class, restoration requires separate analysis.

### The remaining research obligation is now narrower

The strongest version worth pursuing is that authoritarian control cannot make all future peaceful exits inaccessible or make their conditional risks shrink sufficiently quickly forever. Potential foundations include bounded institutional control, persistent variation in human preferences and behavior, and recurrent changes in information and coordination. These must be derived from an explicit political model and assessed against adaptation and replacement support; they are not consequences of the label “autocracy.”

The single-episode results below characterize what a successful opportunity could consist of. The long-horizon results show how recurring opportunities could establish eventual exit even when many individual episodes fail. The resource extension above derives persistent risk from explicit depreciation and investment laws. Deriving those laws, or another sufficient restriction, from autocratic institutions remains open.

## Peaceful uprising: the additional route to government exit

### What ends, and what follows, are different questions

The earlier focus on whether regime failure establishes democracy was too narrow for the question about ways a government can end. The new capacity model refers to a particular incumbent government's ability to govern. It makes no assumption about its successor's regime type.

| Event or mechanism | What may end or change | What must be recorded separately |
|---|---|---|
| Peaceful mobilization and withdrawal of cooperation | An incumbent's ability to command sufficient institutional support | Resignation, negotiated departure, continued resistance, and successor institutions |
| Negotiated constitutional transformation | An exclusionary ruling arrangement; some personnel may stay | Whether effective accountability and competitive replacement actually emerge |
| Electoral defeat and accepted transfer | A government's term in office | Whether the wider constitutional order continues |
| Coup or elite displacement | Leadership, governing coalition, or ruling organization | Whether autocratic selection rules persist |
| Conquest or occupation | Domestic control of government | State continuity, external authority, and subsequent institutions |
| Dissolution, secession, or merger | A state or its territorial authority | Successor states and their governments |

These categories can overlap. Peaceful protest can lead to a negotiation, which leads to constitutional change. A study should record the mechanism, the object that ends, and the destination as separate fields. Counting more exit routes does not itself show any route must eventually occur.

### What the research contributes

**Hidden opposition and sudden change.** Kuran's account of the 1989 East European revolutions distinguishes private preferences from public expression. Suppressed opposition can leave observers, including participants, mistaken about the potential for collective action. This explains how apparent calm can coexist with vulnerability. We consulted the publisher's abstract and author record; we do not claim to reproduce the full model. [Kuran, 1991](https://www.cambridge.org/core/journals/world-politics/article/now-out-of-never-the-element-of-surprise-in-the-east-european-revolution-of-1989/B947420222BF565D0B2D93099E704BF2)

**A public event can change coordination.** Tucker analyzes post-communist color revolutions through collective action: electoral fraud can change the perceived costs and benefits of challenging a government and provide a shared occasion for doing so. This supports examining credible public signals, rather than treating grievances alone as sufficient. It is a mechanism explanation, not a theorem that every disputed election produces successful mobilization. We read the publisher's abstract and introductory argument. [Tucker, 2007](https://www.cambridge.org/core/journals/perspectives-on-politics/article/enough-electoral-fraud-collective-action-problems-and-postcommunist-colored-revolutions/7D77E56D2AC79DBCEB649CE698BA5584)

**Coordination can help enforce replacement rules.** Little, Tucker, and LaGatta model elections as public signals and citizens as potential protesters. Their model permits both rule-based and other forms of alternation in power; electoral rules can serve as equilibrium-selection focal points under specified conditions. We read their 2013 preprint's introduction and model setup. Its Bayesian equilibrium analysis is not formalized here. [Little, Tucker & LaGatta, 2013 preprint](https://arxiv.org/html/1302.0250v1)

**Threshold structure matters.** Macy and Evtushenko revisit threshold models and show why strong collective interest may coexist with failed mobilization, while individual randomness can change instigation and predictability. This motivates examining the distribution of participation thresholds and separating a deterministic model from a stochastic one. We consulted their abstract. [Macy & Evtushenko, 2020](https://sociologicalscience.com/articles-v7-26-628/)

**Institutional cooperation connects participation to political power.** Chenoweth describes nonviolent movements inducing withdrawals of support among security forces, economic actors, and other institutions. The same article reports declining campaign effectiveness in the 2010s and discusses both government adaptation and movement capabilities. This supports modeling the connection between participation and institutional cooperation explicitly. It does not justify a fixed success probability or a universal crowd-size threshold. We read the article's discussion of mechanisms, outcomes, and adaptation; its historical claims describe the period studied, not an updated 2026 estimate. [Chenoweth, 2020](https://www.journalofdemocracy.org/articles/the-future-of-nonviolent-resistance-2/)

### The participation model and its exact criterion

Let `s` be the initial number of permanent participants. Each remaining person has a participation threshold: the number of already-active people at which they become willing to join. Define `R(a)` as the total number willing to be active when current participation is `a`, including the original participants. The corresponding Lean definitions are `readyCount`, `thresholdResponse`, and `cascade`.

\[
R(a)=s+\#\{i:\theta_i\leq a\},\qquad
a_0=s,\qquad a_{t+1}=\max(a_t,R(a_t)).
\]

The threshold list excludes the original participants, preventing double counting. The maximum makes participation irreversible within an episode. People observe participation sufficiently well to apply their thresholds; the model does not derive those thresholds from noisy private information or solve a Bayesian learning problem. Threshold responses are nondecreasing, and the checked `population_bound` keeps participation within the modeled population.

For a target participation level `K` with `s ≤ K`, the central result is:

\[
\boxed{\exists t:\ a_t\geq K
\quad\Longleftrightarrow\quad
\forall b\in\{s,\ldots,K-1\}:\ R(b)>b.}
\]

This is `cascade_reaches_iff_no_barrier`. In words: **the cascade reaches the target exactly when no intermediate participation level can contain it.**

The necessity direction uses monotonicity. If `R(b) ≤ b`, every participation count at or below `b` produces another count at or below `b`. The process cannot jump over that barrier. Conversely, if every sub-target state produces more participants, integer participation grows by at least one per round until the target is reached. `evolving_reaches` checks the bound of at most `K − s` rounds. These are model rounds, not predicted days or years.

### Allow the government to reform or change leaders

Freezing the government's response would evade the hardest part of the question. The extension therefore lets an allowed policy `p` choose a response function `R_p`; a different policy can be selected each round. A realized sequence can represent reactions to previous events. The progressive update remains in force.

For monotone responses, `all_policy_paths_reach_iff` proves:

\[
\boxed{\text{Every policy sequence reaches }K
\quad\Longleftrightarrow\quad
\forall p\ \forall b\in\{s,\ldots,K-1\}:\ R_p(b)>b.}
\]

This equivalence is specific to the model: any allowed policy may be maintained indefinitely, and responses depend on current participation and the chosen policy. If a policy can create a barrier, holding that policy supplies an escape path. If none can, arbitrary switching still reaches the target within the same bound.

The adaptive model tracks counts rather than participant identities. When a policy changes which people are willing, the union of existing participants and newly willing people can be larger than the maximum of the two counts. An application with that behavior needs a model of participant sets or a justification for nested groups. The stated equivalence is exact for the scalar update defined here, not for every possible individual-level mobilization process.

The result identifies a substantive obligation rather than satisfying it automatically: **show that every feasible reform, concession, succession, or other response leaves every relevant barrier open.** A history-dependent resource constraint could rule out maintaining some policies indefinitely, but would need a richer state model. The current equivalence should not be applied unchanged to that case.

A second theorem, `bounded_adaptation_cannot_stop`, gives a usable sufficient condition. Suppose every policy can reduce the baseline response by at most `B` participants, and the baseline response exceeds current participation by more than `B` at every sub-target state:

\[
R_0(a)\leq R_p(a)+B,\qquad a+B<R_0(a).
\]

Then every policy sequence reaches `K`. The bound `B` measures response-changing capacity, not money unless an additional cost model connects them. The theorem does not establish that authoritarian resources or policy effects obey such a bound.

### Participation must affect institutional cooperation

A large public gathering is not identical to loss of governing capacity. Let `T` be available institutional capacity, `M > 0` the minimum cooperating capacity needed to govern, and `W(a)` the capacity withdrawn at participation `a`. `CanGovern` is defined by the remaining support requirement:

\[
\operatorname{CanGovern}(a)\iff M\leq\max(0,T-W(a)).
\]

`support_loss_iff` proves that this constraint fails exactly when `T < M + W(a)`. If withdrawal is nondecreasing and support is insufficient at `K`, the cascade criterion implies loss of governing capacity by the participation bound. This is `cascade_ends_governing_capacity`.

The stronger `adaptive_cascade_ends_capacity` allows policy to change **all four quantities**: the participation response, total support, required support, and the relationship between participation and institutional withdrawal. Its hypotheses require every allowed policy to leave the cascade unobstructed and to leave support insufficient at the target. Thus a successor gaining new allies, or outside support replacing withdrawn capacity, is included only if the hypotheses continue to hold. The theorem does not silently forbid these responses.

Ending an incumbent government still requires the explicit premise that this modeled capacity is necessary for its continuation. `capacity_loss_implies_government_end` checks that final implication. Reserves, replacement institutions, temporary paralysis, and outside assistance matter when assessing the premise. No successor regime is specified, and no democratic outcome is inferred.

`capacity_loss_without_correction_failure` supplies a checked example in which the earlier backlog stays at zero forever while the participation cascade breaches the cooperation constraint. This verifies that the new route is logically independent of accumulated administrative failure.

### Counterexamples to the attempted necessity argument

First, everyone can prefer a coordinated change while remaining in a quiet equilibrium. In `Coordination.lean`, two people choose quiet or peaceful participation. The payoffs are:

| Choices | First person's payoff | Second person's payoff |
|---|---:|---:|
| Both quiet | 0 | 0 |
| First participates alone | −1 | 0 |
| Second participates alone | 0 | −1 |
| Both participate | 2 | 2 |

Lean checks that both quiet and both participating are Nash equilibria, and that both people prefer joint participation to joint quiet. A unilateral departure from the quiet equilibrium is costly. This is a counterexample to the inference from shared preference to inevitable coordinated action; it is not an account of every real protester's motivations.

Second, an effective policy change can stop a cascade. The checked example `adaptive_escape_counterexample` permits accommodation to remove unseeded willingness while leaving political selection rules unspecified. Whether such accommodation is possible in a real autocracy is an empirical question. A sharper finite example, `single_threshold_change_blocks`, shows that changing only one participant's threshold can stop the entire four-person cascade. Preventing coordination need not require satisfying every opponent.

`explore.py` reproduces these artificial trajectories in `evidence/cascades.json`:

| Scenario, with four people throughout | Initial permanent participants | Thresholds of the remaining people | Active at rounds 0–5 |
|---|---:|---|---|
| Everyone waits for someone else | 0 | 1, 1, 1, 1 | 0, 0, 0, 0, 0, 0 |
| A complete activation chain | 0 | 0, 1, 2, 3 | 0, 1, 2, 3, 4, 4 |
| One person becomes a permanent participant | 1 | 1, 1, 1 | 1, 4, 4, 4, 4, 4 |
| Only the first threshold changes | 0 | 4, 1, 2, 3 | 0, 0, 0, 0, 0, 0 |
| Accommodation after two rounds | 0 | Initially 0, 1, 2, 3; subsequent response becomes zero | 0, 1, 2, 2, 2, 2 |

The first four scenarios have exact checked counterparts. The last is a finite illustration of policy switching, not a separately proved infinite-horizon claim. Participants already active remain active by assumption.

### Where the necessity argument now stands

| Attempted implication | Result of the investigation |
|---|---|
| Concentrated political power necessarily produces universal private opposition | Not derived; performance, preferences, identity, and distributional benefits can differ. |
| Private opposition necessarily becomes public coordinated action | Fails without more assumptions; the checked quiet equilibrium and threshold barrier show why. |
| Public signals eventually remove every coordination barrier | A candidate mechanism in the literature, but no universal recurrence or informativeness condition is established. |
| Every feasible reform or succession fails to stop coordination | The exact policy theorem states the required condition; the effective-reform countermodel shows it cannot simply be presumed. |
| Sufficient participation necessarily removes institutional support | Requires the separately modeled withdrawal relationship and limits on replacing support. |
| Loss of necessary support ends a particular incumbent government | Checked conditional implication; does not require a democratic successor. |
| More time alone makes the cascade inevitable | False in the fixed deterministic countermodels; time does not change their inputs. |

Random mistakes, new public signals, generational replacement, and repeated challenges can change the final row. The long-horizon section above now supplies the relevant conditional survival results. The deterministic examples do not refute a probability-one conclusion under justified recurring-risk assumptions.

The strongest conclusion from this extension is conditional but broader than the earlier correction argument: **an incumbent cannot sustain the modeled governing capacity when peaceful participation has no stopping barrier under any available response, and every response leaves insufficient institutional cooperation at the target.** The unresolved research problem is whether some well-defined class of autocracies necessarily enters that region, even after endogenous reform and succession. The word “autocracy” alone supplies neither condition.

The new theorems do not use a regime label. They apply to any government with the specified response and cooperation structure. Establishing a distinctive vulnerability of autocracy therefore requires a further institutional argument or comparative evidence. Routine replacement of an elected government may preserve the democratic order rather than indicate its instability.

### How to test this mechanism empirically

Extend the outcome coding below to distinguish peaceful mobilization, negotiated exits, constitutional transformation, coups, state dissolution, and their successors. Include unsuccessful campaigns and governments that face no campaign; observing only successful color revolutions would select on the outcome.

Measure public signals, participation, institutional withdrawals, concessions, and replacement support separately and in temporal order. Compare an information-and-coordination explanation with the earlier correction-deficit explanation. A government exiting despite adequate administrative performance is compatible with the former; a large protest that leaves decisive institutions cooperating tests the proposed participation-to-capacity bridge. Reform may respond to mobilization, so simple before-and-after associations will not identify its causal effect.

Pre-specify what ends a government and how temporary paralysis is handled. Treat private preferences and participation thresholds as uncertain latent quantities rather than reading them directly from turnout. Estimate mechanisms and competing outcomes on finite horizons; neither a finite survival curve nor a collection of successful uprisings establishes inevitability over an unlimited future.

## What exactly would the original claim mean?

Five distinct propositions are easily conflated:

| Claim | Outcome being tracked | Status here |
|---|---|---|
| Every dictator eventually leaves office | Individual tenure | Insufficient for the question; replacement can preserve autocracy. |
| Every particular authoritarian regime eventually ends | Ruling organization or constitutional order | Still compatible with another autocracy taking over. |
| Autocracy cannot persist as a regime class | Continued exclusion from competitive, accountable rule | The ambitious target; not established by available evidence or our model. |
| Autocratic institutions fail more often under specified stresses | Comparative resilience | A conditional, empirically testable proposition. |
| Certain democratic institutions can sustain themselves | Institutional viability and compliance | Requires its own incentives, enforcement, and recovery conditions. |

We also distinguish static coalition stability, bounded operating performance, institutional persistence, and convergence toward a democratic state. None automatically implies the others. Calling a regime stable says nothing by itself about whether it is just or desirable.

## Primary research: what supports the mechanism and what obstructs it?

### Authoritarian replacement is not democratic transition

Geddes, Wright, and Frantz distinguish leader replacement within a continuing regime, replacement by another autocracy, and democratization. Their original dataset covers 280 autocratic regimes during 1946–2010. They report that transitions to another autocracy account for about half of regime changes in that setting. This is direct evidence that regime breakdown and democratization must be separate outcomes. It does not estimate infinite-horizon probabilities. [Geddes, Wright & Frantz, 2014](https://www.cambridge.org/core/journals/perspectives-on-politics/article/autocratic-breakdown-and-regime-transitions-a-new-data-set/EBDB9E5E64CF899AD50B9ACC630B593F)

### Institutions can make autocracy more durable

Boix and Svolik model how parties, councils, and related institutions help authoritarian elites monitor and sustain power-sharing. In their account, institutional arrangements work subject to credible leverage by the ruler's allies. This supplies both a vulnerability and a repair mechanism. We read their 2008 working paper; the subsequent publication is *Institutions, Commitment, and Power-Sharing in Dictatorships* (2013). This project does not reproduce either paper's equilibrium proof. [Author-hosted working paper](https://www.princeton.edu/~piirs/Dictatorships042508/Boix%20and%20Svolik.pdf), [published article](https://www.journals.uchicago.edu/doi/abs/10.1017/s0022381613000029)

Gandhi and Przeworski argue that partisan legislatures can incorporate potential opponents and expand support for rulers. Their analysis of authoritarian rulers in 1946–1996 finds evidence of greater tenure associated with the relevant institutions. The outcome is primarily ruler survival, not a guarantee of regime-class permanence. The result nevertheless contradicts any model that assumes authoritarian institutions are incapable of adaptation. We consulted the publisher's abstract and available notes, not an unrestricted full article. [Gandhi & Przeworski, 2007](https://journals.sagepub.com/doi/10.1177/0010414007305817)

### Protecting the ruler can conflict with governing well

Egorov and Sonin model a loyalty–competence tradeoff: a more capable subordinate can also be a more threatening one. Their working paper analyzes how insecure rulers may favor loyalty over competence and examines succession incentives. This motivates a model in which personally rational choices reduce corrective capacity. It does not prove that such degradation is inevitable or unbounded. We read the April 2005 working-paper version, rather than treating it as identical to the later publication. [Egorov & Sonin, working paper](https://www.ias.edu/sites/default/files/sss/papers/econpaper53.pdf)

### Democracy needs incentives to obey the rules

Fearon models electoral democracy as self-enforcing only when incumbents and other actors have incentives to accept its procedures. Public electoral signals can help citizens coordinate; prospects of future victories can help make present defeat acceptable. Military power and subtle fraud create difficulties. This supports modeling compliance and correction explicitly, rather than assigning democracy automatic stability. Our source access here was the publisher's detailed abstract; we did not replicate the full game. [Fearon, 2011](https://academic.oup.com/qje/article-abstract/126/4/1661/1923169)

Hyde and Marinov examine how credible election observation can help distinguish fraud from an unsuccessful candidate's unsupported challenge, affecting coordination after elections. This identifies a concrete information institution for further testing. Observation is not itself a universal enforcement mechanism. [Hyde & Marinov, 2014](https://www.cambridge.org/core/journals/international-organization/article/information-and-selfenforcing-democracy-the-role-of-international-election-observation/BC101F8BBE1464D25732210BEBA5A566)

### Selectorate reasoning remains relevant

*The Logic of Political Survival* examines how leadership selection and political incentives influence resource allocation and the persistence of poorly performing rulers. Its framework motivates a distinction between satisfying essential supporters and serving the whole population. For this report, the book is background; we consulted the publisher's description, not all of its formal appendices. Our coalition-budget lemma is independently specified and is not presented as a formalization of selectorate theory. [Bueno de Mesquita, Smith, Siverson & Morrow, 2003](https://mitpress.mit.edu/9780262524407/the-logic-of-political-survival/)

## The checked correction model

Use discrete periods and nonnegative integer quantities:

- `initial`: the starting unresolved burden.
- `arrival(t)`: new demands, errors, or shocks entering during period `t`.
- `repair(t)`: available correction capacity in that period.
- `bound`: a fixed tolerated backlog.

The model is:

\[
Q_0=q_0,\qquad Q_{t+1}=\max(0,Q_t+a_t-c_t).
\]

Lean's natural-number subtraction implements the zero floor. New burdens arrive before that period's repair. Spare repair capacity is not stored for later periods. Work is interchangeable and divisible into integer units; it does not decay or multiply by itself. These are modeling decisions, not established properties of political grievances.

`Survives` means that `Q(t) ≤ bound` at every time. In this model, exceeding the bound is a failure of a viability constraint. Calling it a coup, revolution, loss of legitimacy, or democratic transition would require a separately justified rule. The recurrence can continue after a breach, but later recovery does not erase the earlier breach.

### Result 1: persistent correction deficits force a finite breach

If correction falls short of new burdens by at least one unit every period, then:

\[
c_t+1\le a_t\quad\text{for all }t
\quad\Longrightarrow\quad Q_t\ge q_0+t.
\]

Therefore some breach occurs no later than period `bound + 1`. This is a conservative bound, not a predicted calendar date. No independence, random shocks, or constant inputs are assumed.

Checked as `persistent_shortfall_growth` and `persistent_shortfall_not_survives` in `Repair.lean`.

The result is regime-neutral. An elected government can satisfy the failure assumptions. An autocratic government can fail to satisfy them. The substantive political work is explaining when institutional incentives produce a persistent shortfall.

### Result 2: correction can preserve viability

If the initial burden is within tolerance and every period has enough capacity to handle its new burden, backlog never exceeds its initial value. With the same arrivals and initial condition, increasing repair capacity cannot increase backlog.

Checked as `adequate_repair_survives` and `repair_dominance`. `comparative_capacity` combines survival of a higher-capacity institution and failure of a lower-capacity institution under the same sequence of arrivals.

This rules out a misleading comparison that gives democracy easy shocks and autocracy hard ones. It also does not make daily sufficiency necessary; intermittent repair can work.

### Result 3: an exact interval criterion handles intermittent repair

Define the cumulative net burden:

\[
N_t=\sum_{j<t}a_j-\sum_{j<t}c_j.
\]

At any particular time `t`, the exact criterion is:

\[
Q_t\le B
\quad\Longleftrightarrow\quad
\left(q_0+N_t\le B\right)
\ \land\
\left(\forall s\le t,\ N_t-N_s\le B\right).
\]

Applying this at every time gives a necessary-and-sufficient criterion for `Survives`. These formulas are formalized in `netPrefix`, `debt_le_iff_windows`, and `survival_iff_windows` in `Windows.lean`; the supporting reflection identity is `reflected_debt`.

The first inequality checks the burden inherited from the starting point. The second checks every subsequent interval. A period of unused capacity cannot be credited against a crisis arriving much later. Conversely, periodic institutional reforms can sustain the model if adverse intervals remain within the buffer. This is more informative than assuming deterioration in every period.

### Result 4: a personally rational correction trap

An actor chooses between `protect` and `correct`. The first preserves personal control but supplies a lower repair capacity; the second supplies a higher capacity. Payoffs are arbitrary integers, interpreted either as current utilities or already-computed continuation values.

`BestResponse` requires the chosen action to maximize those two payoffs. If protection is strictly preferred at every period, every best response chooses protection. When its capacity is persistently inadequate, the backlog theorem entails a breach. If correction is strictly preferred and its capacity is adequate, an initially viable system stays viable.

Checked as `strict_protect_selected`, `strict_correct_selected`, `incentive_trap`, and `accountable_correction` in `Incentives.lean`.

For benefits `b` and political costs `p`, the preference inequality can be written:

\[
b_{\mathrm{correct}}+p_{\mathrm{protect}}
<b_{\mathrm{protect}}+p_{\mathrm{correct}}
\quad\Longrightarrow\quad
b_{\mathrm{correct}}-p_{\mathrm{correct}}
<b_{\mathrm{protect}}-p_{\mathrm{protect}}.
\]

That arithmetic step is `preference_from_costs`. The political question is whether those cost differences persist as conditions deteriorate. The code does not assume a farsighted ruler will ignore approaching collapse: if utilities represent lifetime returns, that threat must already be included. We have not solved a dynamic game that endogenously generates the utility rankings.

### Result 5: a coalition resource constraint

For a fixed list of distinct essential supporters, suppose each has a reservation payment and all must be satisfied. A feasible vector of payments exists exactly when the sum of reservation payments fits the available budget. The proof explicitly constructs a feasible allocation in one direction and sums individual requirements in the other.

Checked as `coalition_feasible_iff` and `coalition_budget_obstruction` in `Coalition.lean`.

This identifies a resource obstruction without assuming it is ever reached. The model excludes coercion, ideological attachment, public-goods utility, supporter substitution, and endogenous coalition size. Those omissions make it unsuitable as a complete model of an authoritarian coalition. In particular, it does not prove that required payments inevitably outgrow resources.

## The harder theorem: preventing autocracy from reproducing itself

A sequence of failed dictatorships could remain authoritarian forever. To exclude that possibility, a proof needs a property of transitions between autocratic states, not merely of one ruler's tenure.

`Dynamics.lean` defines a general path through arbitrary states, an autocratic-state predicate, and a natural-number rank. Suppose the rank strictly decreases on every transition whose endpoints are both autocratic. Then the path must reach a non-autocratic state within at most its initial rank plus one steps.

Checked as `rank_bound` and `exit_by_rank`. The path can change leaders and regime organizations; the rank condition applies across those replacements.

The challenge is constructing a politically meaningful rank that cannot be restored by succession, institutional reform, coercive innovation, external aid, or economic growth. No such universal rank has been identified here. Naming a quantity "legitimacy" or "remaining authoritarian capacity" does not prove that it decreases.

Even an exit theorem needs two additional assumptions to establish lasting democracy: non-autocratic states must be classified as democratic, and subsequent transitions must preserve democracy. `durable_democracy_if_exit_and_closed` states these premises explicitly. Real models may need transitional, failed-state, occupied, or hybrid categories, and democratic backsliding must remain possible unless a mechanism rules it out.

This result clarifies the missing proof obligation. It does not disguise an assumption of eventual democratization as a discovery.

## Checked counterexamples and boundary tests

| Formal counterexample | What it establishes | What it does not establish |
|---|---|---|
| `succession_autocracy_forever` with `succession_changes_leader` | Every leader can be replaced while the regime class persists forever. | That real autocracy will last forever. |
| `permanent_viability_counterexample` | Nonzero arrivals can be balanced indefinitely. | That autocracy normally achieves adequate repair. |
| `average_balance_does_not_ensure_survival` | An early overload can cross the threshold even when later repair fully balances arrivals. | That recovery after political crises is impossible. |
| `fixed_point_without_global_convergence` | A stable state can exist while another starting state stays in a cycle. | That the election algorithm from the motivating paper cycles. |
| `same_shocks_different_incentives` | Different incentive rankings can produce different viability outcomes under identical burdens. | That a regime label determines those incentives. |

`universal_autocratic_exit_false` rejects an unrestricted mathematical statement about all labeled paths by exhibiting a persistent path. Its universe has no substantive political restrictions. It is therefore a countermodel to a logically unsupported universal inference, not an empirical disproof of every carefully specified theory of autocratic decline.

## Reproducible synthetic illustrations

`explore.py` computes six deterministic scenarios, each over 20 periods with initial backlog zero and tolerance 10. Units and periods are artificial. The values illustrate mechanisms; they are not fitted to countries.

| Scenario | Inputs | First breach | Peak backlog |
|---|---|---:|---:|
| Persistent shortfall | Five new units; four repaired each period | 11 | 20 |
| Adequate correction | Five new units; five repaired | None | 0 |
| Periodic repair | Five new units; repair alternates four and six | None | 1 |
| Late repair | Twenty arrive initially; twenty repaired next period | 1 | 20 |
| External support fills the shortfall | Four domestic units plus one external unit of repair, against five arrivals | None | 0 |
| Any regime overwhelmed | Eight new units; five repaired | 4 | 60 |

The external-support case is arithmetically identical to adequate correction: the present model records total repair, not its origin. It is included to expose that limitation rather than claim an independent finding. The finite runs are illustrations; infinite-horizon conclusions come only from the Lean theorems and their assumptions.

## Connection to the fair-election result

Becker, Greger, and Peters report that an approval-based committee always has a core outcome and give a polynomial-time method using harmonic entropy. Their paper reports a Lean verification of its existence theorem. Epoch credits the key idea and proof to extended human–AI collaboration. We read the paper and the update, but did not independently compile their separate formalization. [Committee paper](https://arxiv.org/html/2609.11912v1), [Epoch update](https://epoch.ai/frontiermath/open-problems/committee-election)

For government design, that is one component: selection of representatives satisfying a specific coalition-fairness criterion. It does not establish that representatives govern well, that incumbents accept defeat, that preferences stay fixed, or that a population reaches a stable political settlement dynamically.

Our interpretation is that a broader design needs distinct mechanisms for representation, information, incentives to correct, and compliance with replacement procedures. The fair-selection rule could address the first. The models here describe proof obligations for parts of the others. No formal composition theorem joining the election result to regime resilience has been proved in this project.

## Assumption audit

| Bridge needed for a political conclusion | Why it is not automatic | How it could be investigated |
|---|---|---|
| Concentrated power persistently discourages correction | Some autocrats delegate, reform, or institutionalize elite bargaining. | Measure how threats to incumbents affect appointment quality and policy reversals. |
| Unresolved burdens accumulate in comparable units | Grievances may decay, interact, or become politically irrelevant. | Compare additive backlog models with decay, nonlinear amplification, and multiple issue dimensions. |
| A fixed tolerance predicts regime failure | Repression, legitimacy, wealth, and foreign support can change tolerance. | Estimate thresholds out of sample and allow time-varying buffers. |
| Coalition costs outrun resources | Supporters can be replaced and resources can expand. | Model coalition substitution and external rents rather than holding both fixed. |
| Successors cannot restore the exhausted resource | New rulers may reset expectations or adopt reforms. | Track institutional continuity and resource replenishment across autocratic transitions. |
| Bounded spending bounds effective control | Durable investment can accumulate despite a fixed annual budget. | Estimate persistence, replacement costs, obsolescence, and returns to control investment. |
| Authoritarian incentives undermine reproduction of expertise | Some governments preserve technical institutions, replace departures, or import expertise. | Track appointments, occupational emigration, training outcomes, returnees, and who finances replacement. |
| National decline destabilizes the essential coalition | Rents and low outside options can sustain insiders despite broad deterioration. | Separate coalition funding from aggregate output and public welfare. |
| Bounded control leaves recurring exit risk | A capability bound alone does not exclude a closed autocratic class. | Specify and test how bounded control affects coordination, institutional withdrawal, and exit. |
| Democratic correction remains incentive-compatible | Incumbents can capture institutions or reject replacement. | Model enforcement actors and their incentives, including loss of office. |
| An exit is a durable democratic transition | Alternative autocracies, hybrids, and reversals remain possible. | Separate exit destinations and subsequent regime trajectories. |

For the original regime-class hypothesis, the first, fifth, and seventh bridges are especially demanding. The peaceful-uprising extension adds coordination and support-withdrawal bridges; its narrower government-exit result does not require the seventh bridge about durable democracy.

## Empirical research design that would discriminate between explanations

The literature review and formal work are completed here. No new country-level regression, survival estimate, or causal identification is claimed. The following is a concrete protocol for the next empirical study, not a description of tests already run.

Use the Geddes–Wright–Frantz data to distinguish leader, organization, and regime-class changes. Use one frozen release of V-Dem for measures of political institutions and information conditions. V-Dem's current download page identifies version 16, published March 2026; it warns against comparing absolute scores across releases. Archive the selected codebook, measurement uncertainties, and data hashes when downloading. [V-Dem dataset and guidance](https://www.v-dem.net/data/the-v-dem-dataset/)

1. **Specify outcomes before fitting.** Track leader exit, incumbent-government exit, authoritarian-organizational breakdown, state dissolution, democratization, and authoritarian restoration separately. Code peaceful mobilization and negotiation as possible exit mechanisms. Do not count a coup as democratic success.
2. **Measure mechanisms before outcomes.** Candidate proxies include appointment turnover, media restrictions, error correction after public evidence, policy reversals, and institutionalized elite bargaining. A democracy index alone is not a direct measure of repair capacity.
3. **Allow different authoritarian structures.** Personalist, military, party-based, and hereditary arrangements should not be pooled without checking heterogeneous mechanisms.
4. **Include surviving spells.** Handle right censoring, uncertain historical starts, repeated transitions, and dependence among observations within countries. An analysis of only collapsed regimes cannot estimate general durability.
5. **Distinguish shocks from choices.** Compare responses to similar external stresses, with explicit attention to exposure and selection. Do not automatically treat institutions adopted during crisis as the cause of that crisis.
6. **Model replenishment and adaptation.** Foreign backing, revenue windfalls, bureaucratic reforms, coalition substitution, and leadership succession can invalidate permanent-depletion assumptions.
7. **Hold out entire trajectories.** Assess predictions on countries or time blocks excluded from fitting. Report calibration, sensitivity to regime coding, and alternative specifications.
8. **Try to falsify the favored explanation.** Seek authoritarian cases with repeated successful correction and democratic cases with blocked correction. If regime differences disappear after modeling the actual mechanisms, report that.

For the brain-drain extension, measure skill outflows and successful replacement separately, by occupation and cohort. Examine whether the loss of teachers, managers, or technical mentors reduces later replacement capacity. Track coalition obligations, rent income, and domestic tax capacity alongside these quantities. Test whether shortfalls predict both reduced capability and coalition defections; do not substitute declining GDP for the latter. Measure accessible outside offers, real compensation, rejection rates, retention after training, and responses to changes in liberties or professional autonomy. Migration barriers, selective retention programs, private training, and imported services are candidate responses to evaluate, not exclusions to impose for a preferred result.

Finite historical records can test comparative hazards and proposed mechanisms. They cannot by themselves establish a claim about every possible society over an infinite future. A substantive asymptotic theorem would still need justified assumptions about future adaptation and transitions.

## What this suggests for election-system design

The design objective supported by this investigation is to make correction feasible and politically rewarding while keeping institutional replacement peaceful and credible. A core-based selection rule is a candidate for representation; independent verification, contestable information, and enforceable replacement rules need separate analysis.

An ambitious next model would include citizens, representatives, enforcement actors, and potential successors in one repeated game. All regime types would face common shocks, bounded resources, strategic reporting, and endogenous choices about delegation. The target would be to derive correction incentives from those institutions, rather than assign them by hand. It should permit authoritarian stabilization and democratic capture, then identify the parameter regions where one arrangement withstands shocks better.

The correction model establishes that persistent incentive-driven shortfalls exceed a fixed buffer. The participation model establishes conditions under which cooperation withdrawal removes governing capacity even without a correction shortfall. The resource model establishes vanishing survival under specified depreciation, budget, and risk laws, while durable accumulation supplies a countermodel to bounded spending alone. Whether concentrated power inevitably creates one of these failure mechanisms remains unresolved.

## Verification record and reproducibility

The checked source lives in `AutocracyStability/`. `Audit.lean` lists every theorem for axiom inspection. `evidence/verification.json` records the compiler version, source hashes, theorem names, and audit status. `evidence/build.log` and `evidence/axioms.log` contain the tool output. `evidence/experiments.json` contains correction scenarios, `evidence/cascades.json` contains participation scenarios, `evidence/long-horizon.json` contains exact survival fractions, and `evidence/resource-comparison.json` compares depreciating and durable investment. The archive includes source and verification evidence, not a compiler binary.

Run:

```bash
python3 verify.py
python3 explore.py
python3 long_horizon.py
python3 resource_experiments.py
```

The toolchain is pinned to Lean 4.22.0. No Mathlib download is needed. The audit permits the standard logical axioms `propext`, `Classical.choice`, and `Quot.sound`; it rejects custom axioms and incomplete proofs. It checks every named theorem, including counterexamples. Formal correctness is conditional on Lean's kernel and its standard foundations, and empirical adequacy remains a separate question.
