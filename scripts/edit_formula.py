#!/usr/bin/env python3
"""Edit Formula/attackmap.rb in place for scripts/bump_attackmap.sh.

  edit_formula.py url    <formula> <url> <sha256>
      Set the formula's main (first) url and sha256.
  edit_formula.py splice <formula> <marker> <file>
      Replace the block between "# BEGIN <marker>" and "# END <marker>"
      with the contents of <file>.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


def set_url(formula: Path, url: str, sha: str) -> None:
    text = formula.read_text(encoding="utf-8")
    text = re.sub(r'^  url ".*"$', f'  url "{url}"', text, count=1, flags=re.M)
    text = re.sub(r'^  sha256 ".*"$', f'  sha256 "{sha}"', text, count=1, flags=re.M)
    formula.write_text(text, encoding="utf-8")


def splice(formula: Path, marker: str, body_file: Path) -> None:
    text = formula.read_text(encoding="utf-8")
    body = body_file.read_text(encoding="utf-8").strip("\n")
    pattern = re.compile(
        rf"(  # BEGIN {re.escape(marker)}[^\n]*\n(?:  #[^\n]*\n)*)(.*?)(  # END {re.escape(marker)}\n)",
        re.S,
    )
    if not pattern.search(text):
        sys.exit(f"markers for {marker!r} not found in {formula}")
    text = pattern.sub(lambda m: m.group(1) + body + "\n" + m.group(3), text, count=1)
    formula.write_text(text, encoding="utf-8")


def main(argv: list[str]) -> None:
    if len(argv) == 5 and argv[1] == "url":
        set_url(Path(argv[2]), argv[3], argv[4])
    elif len(argv) == 5 and argv[1] == "splice":
        splice(Path(argv[2]), argv[3], Path(argv[4]))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
