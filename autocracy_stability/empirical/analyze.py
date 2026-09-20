"""Reproduce descriptive democratization tests; Python 3, pandas, numpy, scipy, matplotlib, openpyxl (read only)."""
from pathlib import Path
import json, hashlib
import numpy as np
import pandas as pd
from scipy.stats import binomtest
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
P=Path(__file__).resolve().parent
raw=pd.read_csv(P/'regimes.csv')
assert not raw.duplicated(['Entity','Year']).any()
assert set(raw['Political regime'].unique())=={0,1,2,3}
v=raw.rename(columns={'Entity':'country','Year':'year'})
v['democracy']=(v['Political regime']>=2).astype(int)
# Keep current territorial units to avoid mixing predecessors and successors in global shares.
current=set(v.loc[v.year==2025,'country'])
v=v[v.country.isin(current)].copy()
b=pd.read_excel(P/'br.xlsx',sheet_name='Regime characteristics')
assert not b.duplicated(['country','year']).any()
# Complete calendar years only; independent observations only in the BR sensitivity.
b=b[(b.year<=2025)&(b.Colony==0)&b.Democracy.notna()].rename(columns={'Democracy':'democracy'})
b['democracy']=b.democracy.astype(int)
assert set(b.democracy.unique())=={0,1}

def cohort(d,start,end):
 x=d[d.year.between(start,end)]
 names=x.groupby('country').year.nunique()
 names=names[names==end-start+1].index
 return x[x.country.isin(names)].sort_values(['country','year']).copy()

def transitions(x):
 x=x.sort_values(['country','year']).copy()
 x['prev']=x.groupby('country').democracy.shift()
 x['prev_year']=x.groupby('country').year.shift()
 return x[x.year==x.prev_year+1].copy()

def summary(x,start,end):
 x=cohort(x,start,end); t=transitions(x)
 a=x[x.year==start].set_index('country').democracy
 z=x[x.year==end].set_index('country').democracy.reindex(a.index)
 gain=int(((t.prev==0)&(t.democracy==1)).sum());loss=int(((t.prev==1)&(t.democracy==0)).sum())
 up=int(((a==0)&(z==1)).sum());down=int(((a==1)&(z==0)).sum())
 assert gain-loss==int(z.sum()-a.sum())==up-down
 # Bootstrap entire country trajectories, not country-years. Descriptive sensitivity, not population sampling inference.
 rng=np.random.default_rng(20260920)
 delta=(z-a).to_numpy(); ci=np.quantile(rng.choice(delta,(10000,len(delta)),replace=True).mean(axis=1),[.025,.975])
 return dict(start=start,end=end,n=len(a),democratic_start=int(a.sum()),democratic_end=int(z.sum()),share_start=float(a.mean()),share_end=float(z.mean()),gains=gain,losses=loss,net=gain-loss,endpoint_up=up,endpoint_down=down,delta_bootstrap95=ci.tolist(),paired_binomial_p=float(binomtest(up,up+down,.5).pvalue) if up+down else 1.0)

results={'vdem_raw_rows':len(raw),'vdem_current_units':len(current),'classification':'V-Dem RoW: democracy=2 or 3; BR: Democracy=1, Colony=0; both through 2025','vdem_cohorts':[],'br_cohorts':[]}
for start in [1789,1800,1900,1950,1975,2000,2010]:
 results['vdem_cohorts'].append(summary(v,start,2025))
for start in [1950,1975,2000,2010]:results['br_cohorts'].append(summary(b,start,2025))
# Fixed population since 1950, eras selected before calculation (not fit to peaks).
fixed=cohort(v,1950,2025); t=transitions(fixed)
period=[]
for lo,hi in [(1951,1975),(1976,2000),(2001,2010),(2011,2025)]:
 q=t[t.year.between(lo,hi)]
 gain=int(((q.prev==0)&(q.democracy==1)).sum()); loss=int(((q.prev==1)&(q.democracy==0)).sum())
 ea=int((q.prev==0).sum());ed=int((q.prev==1).sum())
 period.append(dict(start=lo,end=hi,gains=gain,losses=loss,net=gain-loss,autocratic_exposure=ea,democratic_exposure=ed,annual_A_to_D=gain/ea,annual_D_to_A=loss/ed))
results['vdem_fixed1950_periods']=period
# Count ever reaching democracy separately from status at endpoint.
follow=[]
for start in [1900,1950,1975,2000]:
 x=cohort(v,start,2025); names=set(x.loc[(x.year==start)&(x.democracy==0),'country']); x=x[x.country.isin(names)]
 follow.append(dict(start=start,initial_autocratic=len(names),ever_democratic=int(x.groupby('country').democracy.max().sum()),democratic_2025=int(x.loc[x.year==2025,'democracy'].sum())))
results['autocracy_cohorts']=follow
# Liberal-democracy threshold sensitivity with same current territorial universe.
lib=v.copy();lib['democracy']=(lib['Political regime']==3).astype(int)
results['liberal_only']=[summary(lib,s,2025) for s in [1900,1950,2010]]
# Matched ISO-coded independent country-years isolate coding differences from coverage.
vv=raw[raw.Code.str.fullmatch('[A-Z]{3}',na=False)].rename(columns={'Code':'iso','Year':'year'})
vv['vd']=(vv['Political regime']>=2).astype(int)
bb=b.rename(columns={'country isocode':'iso','democracy':'br'})
matched=vv.merge(bb[['iso','year','br']],on=['iso','year'],validate='one_to_one')
comparison=[]
for start in [1950,1975,2000,2010]:
    x=matched[matched.year.between(start,2025)]; counts=x.groupby('iso').year.nunique()
    x=x[x.iso.isin(counts[counts==2026-start].index)]
    comparison.append(dict(start=start,n=x.iso.nunique(),vdem_start=int(x.loc[x.year==start,'vd'].sum()),vdem_end=int(x.loc[x.year==2025,'vd'].sum()),br_start=int(x.loc[x.year==start,'br'].sum()),br_end=int(x.loc[x.year==2025,'br'].sum())))
results['matched_classifications']=comparison
(P/'matched_classifications.json').write_text(json.dumps(comparison,indent=2)+'\n')
for start in [1789,1900,1950,2010]:
    cohort(v,start,2025)[['country','year','democracy']].to_csv(P/f'vdem_cohort_{start}.csv',index=False)
results['sha256']={f:hashlib.sha256((P/f).read_bytes()).hexdigest() for f in ['regimes.csv','br.xlsx']}
(P/'results.json').write_text(json.dumps(results,indent=2)+'\n')
for name,data in [('vdem_cohorts',results['vdem_cohorts']),('br_cohorts',results['br_cohorts']),('periods',period),('autocracy_cohorts',follow)]:
 pd.DataFrame(data).to_csv(P/(name+'.csv'),index=False)
t.loc[t.prev!=t.democracy,['country','year','prev','democracy']].to_csv(P/'vdem_fixed1950_transitions.csv',index=False)
fig,axs=plt.subplots(1,2,figsize=(12,4.6))
for start,color in [(1900,'#126c85'),(1950,'#ba5b22')]:
 x=cohort(v,start,2025); s=x.groupby('year').democracy.mean()*100
 axs[0].plot(s.index,s.values,label=f'Fixed {start} cohort (n={x.country.nunique()})',color=color,lw=2)
axs[0].set(title='Democratic share of fixed territorial cohorts',ylabel='Electoral or liberal democracy (%)',xlabel='Year',ylim=(0,100));axs[0].legend(frameon=False,fontsize=8)
labels=[f"{r['start']}–{r['end']}" for r in period];xs=np.arange(len(labels))
axs[1].bar(xs-.18,[r['gains'] for r in period],.36,label='Autocracy → democracy',color='#126c85')
axs[1].bar(xs+.18,[r['losses'] for r in period],.36,label='Democracy → autocracy',color='#ba5b22')
axs[1].set(title=f'Transitions in fixed 1950 cohort (n={fixed.country.nunique()})',ylabel='Transitions (period lengths differ)',xticks=xs,xticklabels=labels);axs[1].legend(frameon=False,fontsize=8)
for ax in axs:ax.spines[['top','right']].set_visible(False)
fig.text(.01,.01,'Source: V-Dem v16 (2026), processed by Our World in Data. Historical territorial imputation included. Equal unit weights.',fontsize=8)
fig.tight_layout(rect=(0,.04,1,1));fig.savefig(P/'democratization.png',dpi=180)
print(json.dumps(results,indent=2))
