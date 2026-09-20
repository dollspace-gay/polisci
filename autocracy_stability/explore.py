#!/usr/bin/env python3
"""Deterministic illustrations, not fitted political forecasts or a data analysis."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent

def evaluate(name, arrivals, repairs, bound=10, initial=0):
    trajectory = [initial]
    for a, c in zip(arrivals, repairs, strict=True):
        trajectory.append(max(0, trajectory[-1] + a - c))
    first_breach = next((t for t, v in enumerate(trajectory) if v > bound), None)
    return dict(name=name, initial=initial, bound=bound, arrival=arrivals, repair=repairs,
                trajectory=trajectory, first_breach=first_breach,
                status="synthetic illustration; no empirical calibration")

results = [
    evaluate("Persistent correction shortfall", [5]*20, [4]*20),
    evaluate("Same load, adequate correction", [5]*20, [5]*20),
    evaluate("Temporary backlog, periodic repair", [5]*20, [4, 6]*10),
    evaluate("Long-run balance but an early breach", [20]+[0]*19, [0, 20]+[0]*18),
    evaluate("External support fills the shortfall", [5]*20, [5]*20),
    evaluate("Any regime overwhelmed", [8]*20, [5]*20),
]
(ROOT / "evidence" / "experiments.json").write_text(json.dumps(results, indent=2) + "\n")
print("| Synthetic scenario | First threshold breach | Maximum backlog |")
print("|---|---:|---:|")
for r in results:
    first = r['first_breach'] if r['first_breach'] is not None else "None in 20 steps"
    print(f"| {r['name']} | {first} | {max(r['trajectory'])} |")

def participation(name, seed, thresholds, rounds=5, change_at=None):
    """Thresholds exclude the seed participants, exactly as in Cascades.lean."""
    trajectory = [seed]
    for t in range(rounds):
        willing = seed + sum(threshold <= trajectory[-1] for threshold in thresholds)
        if change_at is not None and t >= change_at:
            willing = seed  # Hypothetical complete accommodation of unseeded people.
        trajectory.append(max(trajectory[-1], willing))
    return dict(name=name, seed=seed, unseeded_thresholds=thresholds,
                population=seed + len(thresholds), trajectory=trajectory,
                response_changes_at=change_at,
                status="synthetic illustration; irreversible participation; no calibration")

cascades = [
    participation("Conditional willingness without an initial participant", 0, [1, 1, 1, 1]),
    participation("Spontaneous cascade", 0, [0, 1, 2, 3]),
    participation("One of four people is now a permanent seed", 1, [1, 1, 1]),
    participation("Change only the first threshold", 0, [4, 1, 2, 3]),
    participation("Hypothetical accommodation after two rounds", 0, [0, 1, 2, 3], change_at=2),
]
(ROOT / "evidence" / "cascades.json").write_text(json.dumps(cascades, indent=2) + "\n")
print("\n| Synthetic participation scenario | Active at rounds 0 through 5 |")
print("|---|---|")
for r in cascades:
    print(f"| {r['name']} | {', '.join(map(str, r['trajectory']))} |")
