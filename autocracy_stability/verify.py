#!/usr/bin/env python3
"""Build the pinned Lean project and audit every theorem's axiom dependencies."""
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
os.chdir(ROOT)
OUT = ROOT / "evidence"
OUT.mkdir(exist_ok=True)
lake = os.environ.get("STABILITY_LAKE") or shutil.which("lake")
if not lake:
    sys.exit("Install Lean 4.22.0 with elan, or set STABILITY_LAKE to its lake executable.")

def run(args, filename):
    p = subprocess.run(args, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    (OUT / filename).write_text(p.stdout)
    if p.returncode:
        print(p.stdout)
        sys.exit(p.returncode)
    return p.stdout

version = run([lake, "env", "lean", "--version"], "lean-version.txt")
if "version 4.22.0," not in version:
    sys.exit("Expected pinned Lean 4.22.0. Found: " + version)

sources = sorted((ROOT / "AutocracyStability").glob("*.lean"))
names = []
for path in sources:
    content = path.read_text()
    # No proof gaps, arbitrary axioms, or evaluation-based trust shortcuts.
    for forbidden in (r"\bsorry\b", r"\badmit\b", r"^\s*axiom\s", r"\bnative_decide\b",
                      r"^\s*unsafe\s"):
        if re.search(forbidden, content, re.M):
            sys.exit(f"Forbidden construct {forbidden} in {path.name}")
    names.extend(re.findall(r"^theorem (\w+)", content, re.M))

(ROOT / "Audit.lean").write_text("import AutocracyStability\n\n" +
    "".join(f"#print axioms AutocracyStability.{name}\n" for name in names))
build = run([lake, "build"], "build.log")
audit = run([lake, "env", "lean", "Audit.lean"], "axioms.log")
allowed = {"propext", "Classical.choice", "Quot.sound"}
for group in re.findall(r"depends on axioms: \[([^]]*)\]", audit):
    actual = {a.strip() for a in group.split(",") if a.strip()}
    if actual - allowed:
        sys.exit("Unexpected axiom dependencies: " + str(actual - allowed))
checked = re.findall(r"'AutocracyStability\.(\w+)'", audit)
if sorted(checked) != sorted(names):
    sys.exit("Axiom audit did not cover all declared theorems.")

metadata = {
    "lean_version": version.strip(), "build_exit_code": 0,
    "theorem_count": len(names), "theorems": names,
    "allowed_standard_axioms": sorted(allowed),
    "custom_axioms": False, "proof_gaps": False, "native_decide": False,
    "dependencies": "Lean 4.22.0 bundled Std; no Mathlib or network dependencies",
    "source_sha256": {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                      for p in sources + [ROOT / "AutocracyStability.lean", ROOT / "Audit.lean"]},
    "interpretation": "Kernel-checked conditional mathematics, not empirical validation."
}
(OUT / "verification.json").write_text(json.dumps(metadata, indent=2) + "\n")
print(f"PASS: {len(names)} theorems built and axiom-audited with Lean 4.22.0.")

