#!/usr/bin/env bash
# Bump Formula/attackmap.rb to an AttackMap tag: url + sha256, the 15 pinned
# analyzer plugins (from plugins_lock.py at that tag) and the PyPI deps.
#
# Usage (from the tap root, with this checkout tapped as mlaify/tap):
#   scripts/bump_attackmap.sh 0.4.32
# Set SKIP_BREW=1 to only rewrite url/sha256 + plugins (no brew calls).
set -euo pipefail

VERSION="${1:?usage: bump_attackmap.sh <version>}"
TAG="v${VERSION#v}"
VERSION="${TAG#v}"
FORMULA="Formula/attackmap.rb"
URL="https://github.com/mlaify/AttackMap/archive/refs/tags/${TAG}.tar.gz"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

SHA="$(curl -fsSL "$URL" | shasum -a 256 | awk '{print $1}')"
echo "attackmap ${VERSION}: ${SHA}"

splice() {  # splice <marker> <file-with-blocks>
  python3 - "$FORMULA" "$1" "$2" <<'PY'
import re
import sys

formula, marker, body_file = sys.argv[1:]
text = open(formula).read()
body = open(body_file).read().strip("\n")
pattern = re.compile(rf"(  # BEGIN {marker}[^\n]*\n(?:  #[^\n]*\n)*)(.*?)(  # END {marker}\n)", re.S)
if not pattern.search(text):
    sys.exit(f"markers for {marker!r} not found in {formula}")
text = pattern.sub(lambda m: m.group(1) + body + "\n" + m.group(3), text, count=1)
open(formula, "w").write(text)
PY
}

# 1. The main package's url/sha256 (the first ones in the file). Done first so
#    update-python-resources resolves dependencies of the new version.
python3 - "$FORMULA" "$URL" "$SHA" <<'PY'
import re
import sys

formula, url, sha = sys.argv[1:]
text = open(formula).read()
text = re.sub(r'^  url ".*"$', f'  url "{url}"', text, count=1, flags=re.M)
text = re.sub(r'^  sha256 ".*"$', f'  sha256 "{sha}"', text, count=1, flags=re.M)
open(formula, "w").write(text)
PY

# 2. Analyzer plugins, pinned exactly like the [all] extra / plugins_lock.py.
python3 scripts/plugin_resources.py "$TAG" > "$WORK/plugins.rb"
splice "analyzer plugins" "$WORK/plugins.rb"

[[ "${SKIP_BREW:-}" == 1 ]] && exit 0

# 3. Third-party PyPI deps (pydantic & co. come from homebrew-core's bottle).
brew update-python-resources --print-only --package-name attackmap \
  --ignore-non-pypi-packages \
  --exclude-packages pydantic,pydantic-core,annotated-types,typing-extensions,typing-inspection \
  mlaify/tap/attackmap > "$WORK/pypi.rb"
grep -q 'resource "typer"' "$WORK/pypi.rb" || { cat "$WORK/pypi.rb"; echo "unexpected resource output" >&2; exit 1; }
splice "pypi resources" "$WORK/pypi.rb"

brew style --fix mlaify/tap/attackmap
brew audit --strict --online mlaify/tap/attackmap
