"""Exact, synthetic survival comparisons under the same annual investment.

These calculations illustrate the Lean models. They do not estimate country
risks or replace the checked infinite-horizon arguments.
"""

from fractions import Fraction
from pathlib import Path
import json


def scenario(depreciates: bool) -> dict:
    capital = 0
    survival = Fraction(1)
    snapshots = []
    for date in range(1001):
        if date in (0, 10, 100, 1000):
            snapshots.append({
                "date": date,
                "capital": capital,
                "cumulative_investment": date,
                "conditional_risk": str(Fraction(1, (capital + 2) ** 2)),
                "survival_exact": str(survival),
                "survival_decimal": float(survival),
            })
        survival *= 1 - Fraction(1, (capital + 2) ** 2)
        capital = (capital // 2 if depreciates else capital) + 1
    return {
        "model": "half_retention" if depreciates else "durable_accumulation",
        "annual_investment": 1,
        "initial_capital": 0,
        "risk_law": "1 / (capital + 2)^2",
        "snapshots": snapshots,
    }


def main() -> None:
    output = {
        "synthetic": True,
        "method": "Python Fraction, exact rational arithmetic",
        "note": "No empirical estimation; infinite-horizon claims use the Lean proofs.",
        "scenarios": [scenario(True), scenario(False)],
    }
    target = Path(__file__).parent / "evidence" / "resource-comparison.json"
    target.parent.mkdir(exist_ok=True)
    target.write_text(json.dumps(output, indent=2) + "\n")
    for model in output["scenarios"]:
        print(model["model"])
        for row in model["snapshots"]:
            print(f"  n={row['date']:4d}: capital={row['capital']:4d}, "
                  f"survival={row['survival_decimal']:.9g}")


if __name__ == "__main__":
    main()
