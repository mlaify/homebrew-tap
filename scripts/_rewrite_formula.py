#!/usr/bin/env python3
"""Rewrite Formula/attackmap.rb in-place with fresh sdist + resources.

Invoked by scripts/regenerate.sh — kept separate so brew's shfmt style
check can format the shell script without misreading an embedded
Python heredoc (which was breaking indentation from mid-file onward).

The URL for the sdist tarball is fetched from the PyPI JSON API rather
than computed in bash; keeps every line of Python out of the shell
script so shfmt has clean bash to work with.

Usage:
    _rewrite_formula.py <formula_path> <version> <sdist_sha> <resources_path>
"""

from __future__ import annotations

import json
import pathlib
import re
import sys
import urllib.request


def fetch_sdist_url(version: str) -> str:
    with urllib.request.urlopen(f"https://pypi.org/pypi/attackmap/{version}/json") as fh:
        data = json.load(fh)
    for entry in data.get("urls", []):
        if entry.get("packagetype") == "sdist":
            return str(entry["url"])
    sys.exit(f"ERROR: PyPI JSON for attackmap {version} has no sdist entry")


def main() -> int:
    if len(sys.argv) != 5:
        sys.stderr.write(
            "Usage: _rewrite_formula.py <formula_path> <version> "
            "<sdist_sha> <resources_path>\n"
        )
        return 2

    formula_path, version, sha, resources_path = sys.argv[1:5]
    url = fetch_sdist_url(version)
    text = pathlib.Path(formula_path).read_text()
    resources_body = pathlib.Path(resources_path).read_text().rstrip() + "\n"

    # Replace the sdist region.
    sdist_block = (
        "# BEGIN sdist: managed by scripts/regenerate.sh — do not edit by hand\n"
        f'  url "{url}"\n'
        f'  sha256 "{sha}"\n'
        "  # END sdist"
    )
    text, sdist_n = re.subn(
        r"# BEGIN sdist:[^\n]*\n.*?# END sdist",
        lambda _m: sdist_block,
        text,
        count=1,
        flags=re.DOTALL,
    )
    if sdist_n != 1:
        sys.exit(f"ERROR: failed to replace sdist block (matches={sdist_n})")

    # Replace the resources region. Preserve the BEGIN/END marker lines
    # so the script can find them again next release.
    resources_block = (
        "# BEGIN resources: managed by scripts/regenerate.sh — do not edit by hand\n"
        f"{resources_body}"
        "  # END resources"
    )
    text, res_n = re.subn(
        r"# BEGIN resources:[^\n]*\n.*?# END resources",
        lambda _m: resources_block,
        text,
        count=1,
        flags=re.DOTALL,
    )
    if res_n != 1:
        sys.exit(f"ERROR: failed to replace resources block (matches={res_n})")

    tmp = pathlib.Path(formula_path + ".tmp")
    tmp.write_text(text)
    tmp.replace(formula_path)
    print(f"Rewrote {formula_path}  (sdist: {url})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
