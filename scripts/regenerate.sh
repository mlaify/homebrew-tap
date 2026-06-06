#!/usr/bin/env bash
#
# Regenerate Formula/attackmap.rb as a fully resource-pinned formula.
#
# Run this once after AttackMap (and every official analyzer plugin) is
# published to PyPI. It uses homebrew-pypi-poet to emit `resource` blocks
# with sha256s for every transitive dependency.
#
# Prereqs:
#   pipx install homebrew-pypi-poet     # or `pip install --user homebrew-pypi-poet`
#   brew install python@3.12
#
# Usage:
#   scripts/regenerate.sh 0.1.0

set -euo pipefail

VERSION="${1:-}"
if [ -z "${VERSION}" ]; then
  echo "Usage: $0 <version>     # e.g. $0 0.1.0"
  exit 1
fi

if ! command -v poet >/dev/null 2>&1; then
  echo "homebrew-pypi-poet is not installed."
  echo "Install with: pipx install homebrew-pypi-poet"
  exit 1
fi

WORKDIR="$(mktemp -d)"
trap 'rm -rf "${WORKDIR}"' EXIT

cd "${WORKDIR}"
python3 -m venv venv
# shellcheck disable=SC1091
source venv/bin/activate
pip install --upgrade pip
pip install "attackmap[all]==${VERSION}"

# Compute the sha256 of the upstream sdist for the top-level url.
SDIST_URL="$(pip download --no-deps --no-binary :all: "attackmap==${VERSION}" -d . 2>&1 \
  | awk '/^  Downloading / {print $2}' | tail -1)"
SDIST_FILE="$(ls attackmap-*.tar.gz | head -1)"
SDIST_SHA="$(shasum -a 256 "${SDIST_FILE}" | awk '{print $1}')"

# Emit resource blocks for every transitive dep.
poet -f attackmap > "${OLDPWD}/Formula/attackmap.poet.rb"

echo ""
echo "Wrote Formula/attackmap.poet.rb."
echo "Top-level sdist:  ${SDIST_URL}"
echo "sha256:           ${SDIST_SHA}"
echo ""
echo "Next: manually merge the resource blocks from Formula/attackmap.poet.rb"
echo "into Formula/attackmap.rb, update the url + sha256, and remove the"
echo "loose '.pip_install \"attackmap[all]==...\"' line."
