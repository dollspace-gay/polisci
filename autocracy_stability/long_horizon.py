#!/usr/bin/env python3
"""Exact synthetic survival probabilities; not country-level hazard estimates."""
from fractions import Fraction
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
MODELS = (
    ("Persistent conditional exit risk of 1/100", lambda n: Fraction(1, 100)),
    ("Conditional exit risk 1/(n+2)", lambda n: Fraction(1, n + 2)),
    ("Conditional exit risk 1/(n+2)^2", lambda n: Fraction(1, (n + 2) ** 2)),
)
snapshots = {0, 10, 100, 1000}
results = []
for name, hazard in MODELS:
    survival = Fraction(1)
    points = []
    for n in range(max(snapshots) + 1):
        if n in snapshots:
            points.append({"opportunities": n, "survival_exact": str(survival),
                           "survival_decimal": float(survival)})
        survival *= 1 - hazard(n)
    results.append({"name": name, "points": points,
                    "status": "synthetic conditional hazards; no empirical calibration"})
(ROOT / "evidence" / "long-horizon.json").write_text(json.dumps(results, indent=2) + "\n")
print("| Synthetic risk model | Survival after 10 | After 100 | After 1000 |")
print("|---|---:|---:|---:|")
for model in results:
    values = [f"{p['survival_decimal']:.6g}" for p in model['points'] if p['opportunities']]
    print("| " + model['name'] + " | " + " | ".join(values) + " |")
