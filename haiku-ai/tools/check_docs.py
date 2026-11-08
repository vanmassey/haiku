#!/usr/bin/env python3
"""Check Haiku AI Markdown files for basic repository hygiene."""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
FILES = sorted((ROOT).glob("*.md"))
errors = []

for path in FILES:
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError as exc:
        errors.append(f"{path.relative_to(ROOT)}: not valid UTF-8: {exc}")
        continue

    if not text.endswith("\n"):
        errors.append(f"{path.relative_to(ROOT)}: missing final newline")

    for number, line in enumerate(text.splitlines(), start=1):
        if line.rstrip(" \t") != line:
            errors.append(
                f"{path.relative_to(ROOT)}:{number}: trailing whitespace"
            )
        if line.startswith(("<<<<<<< ", "=======", ">>>>>>> ")):
            errors.append(
                f"{path.relative_to(ROOT)}:{number}: merge-conflict marker"
            )

if errors:
    print("\n".join(errors), file=sys.stderr)
    sys.exit(1)

print(f"Checked {len(FILES)} Markdown files: OK")
