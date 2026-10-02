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
trap 'rm -rf "${WORK}"' EXIT

SHA="$(curl -fsSL "${URL}" | shasum -a 256 | awk '{print $1}')"
echo "attackmap ${VERSION}: ${SHA}"

# 1. The main package's url/sha256 (the first ones in the file). Done first so
#    update-python-resources resolves dependencies of the new version.
python3 scripts/edit_formula.py url "${FORMULA}" "${URL}" "${SHA}"

# 2. Analyzer plugins, pinned exactly like the [all] extra / plugins_lock.py.
python3 scripts/plugin_resources.py "${TAG}" >"${WORK}/plugins.rb"
python3 scripts/edit_formula.py splice "${FORMULA}" "analyzer plugins" "${WORK}/plugins.rb"

[[ "${SKIP_BREW:-}" == 1 ]] && exit 0

# 3. Third-party PyPI deps (pydantic & co. come from homebrew-core's bottle).
brew update-python-resources --print-only --package-name attackmap \
  --ignore-non-pypi-packages \
  --exclude-packages pydantic,pydantic-core,annotated-types,typing-extensions,typing-inspection \
  mlaify/tap/attackmap >"${WORK}/pypi.rb"
if ! grep -q 'resource "typer"' "${WORK}/pypi.rb"
then
  cat "${WORK}/pypi.rb"
  echo "unexpected resource output" >&2
  exit 1
fi
python3 scripts/edit_formula.py splice "${FORMULA}" "pypi resources" "${WORK}/pypi.rb"

brew style --fix mlaify/tap/attackmap
brew audit --strict --online mlaify/tap/attackmap
