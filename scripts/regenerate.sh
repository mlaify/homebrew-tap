#!/usr/bin/env bash
#
# Regenerate Formula/attackmap.rb as a fully resource-pinned formula
# IN PLACE. Updates only the regions between marker comments:
#   "# BEGIN sdist" ... "# END sdist"
#   "# BEGIN resources" ... "# END resources"
# Everything else (license, head, install, test) is preserved.
#
# Run after AttackMap core and every official analyzer plugin are
# published to PyPI. Uses homebrew-pypi-poet to emit `resource` blocks
# with sha256s for every transitive dependency.
#
# All heavy lifting that touches the formula file (sdist URL lookup,
# regex-based marker rewrite) lives in _rewrite_formula.py — keeping
# Python OUT of this shell script so brew's shfmt style check doesn't
# misparse an embedded heredoc.
#
# Prereqs:
#   brew install python@3.12
#
# Usage:
#   scripts/regenerate.sh 0.2.0

set -euo pipefail

VERSION="${1:-}"
if [[ -z "${VERSION}" ]]
then
  echo "Usage: $0 <version>     # e.g. $0 0.2.0"
  exit 1
fi

# Every analyzer that ships in the attackmap[all] extra. Update this
# list when adding/removing official analyzers.
ANALYZERS=(
  attackmap-analyzer-atproto
  attackmap-analyzer-c
  attackmap-analyzer-cpp
  attackmap-analyzer-dotnet
  attackmap-analyzer-go
  attackmap-analyzer-iac
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
FORMULA="${REPO_ROOT}/Formula/attackmap.rb"
REWRITE="${REPO_ROOT}/scripts/_rewrite_formula.py"

if [[ ! -f "${FORMULA}" ]]
then
  echo "ERROR: ${FORMULA} not found" >&2
  exit 1
fi
if [[ ! -f "${REWRITE}" ]]
then
  echo "ERROR: ${REWRITE} not found" >&2
  exit 1
fi

# Sanity: bail early if the formula doesn't have the managed markers.
for marker in "# BEGIN sdist" "# END sdist" "# BEGIN resources" "# END resources"
do
  if ! grep -q "${marker}" "${FORMULA}"
  then
    echo "ERROR: marker '${marker}' missing from ${FORMULA}" >&2
    echo "Add the marker comments around the regions you want this script to manage." >&2
    exit 1
  fi
done

WORKDIR="$(mktemp -d)"
trap 'rm -rf "${WORKDIR}"' EXIT

cd "${WORKDIR}"
python3 -m venv venv
# shellcheck disable=SC1091
source venv/bin/activate
pip install --upgrade pip "setuptools<81"
# Install attackmap core + each analyzer explicitly. We do NOT install
# `attackmap[llm]` (which would pull anthropic → jiter, a Rust
# extension whose sdist needs maturin — homebrew's `--no-binary :all:`
# sandbox cannot bootstrap maturin). Users who want the API backend
# can `pip install anthropic` themselves after `brew install attackmap`,
# or use `--llm --llm-backend cli` which speaks to the `claude` CLI on
# PATH.
#
# poet must share a venv with the packages; its pkg_resources
# introspection cannot cross venv boundaries (the silent-zero-resources
# trap that bit us in 0.1.0).
pip install homebrew-pypi-poet "attackmap==${VERSION}"
for pkg in "${ANALYZERS[@]}"
do
  pip install "${pkg}"
done

# Top-level sdist sha256. Fetching the URL happens inside the Python
# helper — see _rewrite_formula.py.
pip download --no-deps --no-binary :all: "attackmap==${VERSION}" -d . >/dev/null
# shellcheck disable=SC2012  # `ls | head` is fine; the tarball name is well-known
SDIST_FILE="$(ls attackmap-*.tar.gz | head -1)"
SDIST_SHA="$(shasum -a 256 "${SDIST_FILE}" | awk '{print $1}')"

# poet -f attackmap walks attackmap's REQUIRED deps. Analyzer plugins
# live in an extra, so add each one with -a.
ALSO_FLAGS=()
for pkg in "${ANALYZERS[@]}"
do
  ALSO_FLAGS+=(-a "${pkg}")
done

POET_OUT="${WORKDIR}/poet.rb"
poet -f attackmap "${ALSO_FLAGS[@]}" >"${POET_OUT}"

RESOURCE_COUNT=$(grep -c '^  resource' "${POET_OUT}" || true)
EXPECTED=$((${#ANALYZERS[@]} + 3)) # 14 analyzers + typer/click/pydantic/... core deps
if [[ "${RESOURCE_COUNT}" -lt "${EXPECTED}" ]]
then
  echo "ERROR: poet emitted ${RESOURCE_COUNT} resources, expected ≥ ${EXPECTED}" >&2
  echo "Probable cause: poet pkg_resources introspection regression." >&2
  exit 1
fi

# Extract just the resource blocks from poet's output.
RESOURCES="${WORKDIR}/resources.rb"
awk '
  /^  resource / { in_block = 1 }
  in_block        { print }
  in_block && /^  end$/ { in_block = 0 }
' "${POET_OUT}" >"${RESOURCES}"

# `homebrew-pypi-poet` emits `resource "<python_module_name>"`, but
# `brew audit` requires the resource name to match the PyPI DIST name
# (hyphens, not underscores) for well-known packages. `pydantic_core`
# ships as `pydantic-core`. Normalize the known offenders in place —
# the URL still carries the actual sdist filename so nothing else needs
# to change.
sed -i.bak -E 's/^  resource "pydantic_core"/  resource "pydantic-core"/' "${RESOURCES}"
rm -f "${RESOURCES}.bak"

# In-place rewrite: fetches the sdist URL from PyPI and swaps the sdist
# + resources regions in the formula.
python3 "${REWRITE}" "${FORMULA}" "${VERSION}" "${SDIST_SHA}" "${RESOURCES}"

# Ruby syntax check.
if command -v ruby >/dev/null 2>&1
then
  if ! ruby -c "${FORMULA}" >/dev/null
  then
    echo "ERROR: ruby syntax check failed on ${FORMULA}" >&2
    exit 1
  fi
fi

# Optional: brew style if available (slow first time — installs gems).
if command -v brew >/dev/null 2>&1
then
  echo "Running brew style…"
  brew style "${FORMULA}" || echo "WARNING: brew style reported offenses (see above)" >&2
fi

echo ""
echo "  Formula:           ${FORMULA}"
echo "  Resources written: ${RESOURCE_COUNT}"
echo "  sha256:            ${SDIST_SHA}"
echo ""
echo "Review with: git diff Formula/attackmap.rb"
