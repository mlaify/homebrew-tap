#!/usr/bin/env bash
#
# Regenerate Formula/attackmap.rb as a fully resource-pinned formula.
#
# Run after AttackMap core and every official analyzer plugin are published
# to PyPI. Uses homebrew-pypi-poet to emit `resource` blocks with sha256s
# for every transitive dependency (core + 13 analyzers + [llm] extra).
#
# poet is installed into the same throwaway venv as attackmap[all] so its
# pkg_resources introspection can actually see the installed packages.
# setuptools is pinned <81 because poet still imports pkg_resources, which
# setuptools 81+ removed.
#
# Prereqs:
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

# Every analyzer that ships in the attackmap[all] extra. Update this list
# when adding/removing official analyzers.
ANALYZERS=(
  attackmap-analyzer-atproto
  attackmap-analyzer-c
  attackmap-analyzer-cpp
  attackmap-analyzer-dotnet
  attackmap-analyzer-go
  attackmap-analyzer-java-spring
  attackmap-analyzer-node-service
  attackmap-analyzer-omeka-s
  attackmap-analyzer-php-laminas
  attackmap-analyzer-php-web
  attackmap-analyzer-python
  attackmap-analyzer-rust
  attackmap-analyzer-terraform
)

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "${WORKDIR}"' EXIT

cd "${WORKDIR}"
python3 -m venv venv
# shellcheck disable=SC1091
source venv/bin/activate
pip install --upgrade pip "setuptools<81"
# Install poet INSIDE this venv so its pkg_resources introspection sees
# the same site-packages that attackmap[all] is installed into.
pip install homebrew-pypi-poet "attackmap[all]==${VERSION}"

# Compute the sha256 of the upstream sdist for the top-level url.
pip download --no-deps --no-binary :all: "attackmap==${VERSION}" -d . >/dev/null
SDIST_FILE="$(ls attackmap-*.tar.gz | head -1)"
SDIST_SHA="$(shasum -a 256 "${SDIST_FILE}" | awk '{print $1}')"
# The PyPI download URL (used in the formula's top-level `url` field) is
# read from the JSON API since pip stopped surfacing it cleanly in newer
# versions.
SDIST_URL="$(python3 -c "
import json, urllib.request, sys
data = json.loads(urllib.request.urlopen(
    f'https://pypi.org/pypi/attackmap/${VERSION}/json'
).read())
for u in data['urls']:
    if u['packagetype'] == 'sdist':
        print(u['url']); break
")"

# poet -f attackmap walks attackmap's REQUIRED deps. Analyzers + anthropic
# live in extras, so add each one with -a so they (and their transitive
# deps) end up in the resource list.
ALSO_FLAGS=(-a anthropic)
for pkg in "${ANALYZERS[@]}"; do
  ALSO_FLAGS+=(-a "${pkg}")
done

OUT="${REPO_ROOT}/Formula/attackmap.poet.rb"
poet -f attackmap "${ALSO_FLAGS[@]}" > "${OUT}"

RESOURCE_COUNT=$(grep -c '^  resource' "${OUT}" || true)

echo ""
echo "Wrote ${OUT}"
echo "Resources emitted: ${RESOURCE_COUNT}  (expect ≥ $((${#ANALYZERS[@]} + 24)))"
echo "Top-level sdist:   ${SDIST_URL}"
echo "sha256:            ${SDIST_SHA}"
echo ""
echo "Next: merge resource blocks from Formula/attackmap.poet.rb into"
echo "Formula/attackmap.rb, update the url + sha256 to the values above,"
echo "and verify with: brew style ./Formula/attackmap.rb"
