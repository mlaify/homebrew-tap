#!/usr/bin/env bash
#
# Regenerate Formula/attackmap.rb as a fully resource-pinned formula
# IN PLACE. Updates only the regions between marker comments:
#   "# BEGIN sdist" ... "# END sdist"
#   "# BEGIN resources" ... "# END resources"
# Everything else (license, head, install, test) is preserved.
#
# Run after AttackMap core and every official analyzer plugin are published
# to PyPI. Uses homebrew-pypi-poet to emit `resource` blocks with sha256s
# for every transitive dependency (core + 13 analyzers + [llm] extra).
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

if [ ! -f "${FORMULA}" ]; then
  echo "ERROR: ${FORMULA} not found" >&2
  exit 1
fi

# Sanity: bail early if the formula doesn't have the managed markers.
for marker in "# BEGIN sdist" "# END sdist" "# BEGIN resources" "# END resources"; do
  if ! grep -q "${marker}" "${FORMULA}"; then
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
# poet must share a venv with attackmap[all]; its pkg_resources
# introspection cannot cross venv boundaries (the silent-zero-resources
# trap that bit us in 0.1.0).
# Install attackmap core + each analyzer explicitly. We do NOT install
# `attackmap[llm]` (which would pull anthropic → jiter, a Rust extension
# whose sdist needs maturin — homebrew's `--no-binary :all:` sandbox
# can't bootstrap maturin). Users who want the API backend can
# `pip install anthropic` themselves after `brew install attackmap`, or
# use `--llm --llm-backend cli` which speaks to the `claude` CLI.
pip install homebrew-pypi-poet "attackmap==${VERSION}"
for pkg in "${ANALYZERS[@]}"; do
  pip install "${pkg}"
done

# Top-level sdist url + sha256.
pip download --no-deps --no-binary :all: "attackmap==${VERSION}" -d . >/dev/null
SDIST_FILE="$(ls attackmap-*.tar.gz | head -1)"
SDIST_SHA="$(shasum -a 256 "${SDIST_FILE}" | awk '{print $1}')"
SDIST_URL="$(python3 -c "
import json, urllib.request
data = json.loads(urllib.request.urlopen(
    f'https://pypi.org/pypi/attackmap/${VERSION}/json'
).read())
for u in data['urls']:
    if u['packagetype'] == 'sdist':
        print(u['url']); break
")"

# poet -f attackmap walks attackmap's REQUIRED deps. Analyzer plugins
# live in an extra, so add each one with -a.
#
# We intentionally do NOT vendor `anthropic` here. It pulls a Rust
# extension (`jiter`) whose sdist requires maturin, which homebrew's
# `--no-binary :all:` sandbox cannot bootstrap. Users who want the API
# backend can `pip install anthropic` into the attackmap venv, or use
# `--llm --llm-backend cli` which speaks to the `claude` CLI on PATH.
ALSO_FLAGS=()
for pkg in "${ANALYZERS[@]}"; do
  ALSO_FLAGS+=(-a "${pkg}")
done

POET_OUT="${WORKDIR}/poet.rb"
poet -f attackmap "${ALSO_FLAGS[@]}" > "${POET_OUT}"

RESOURCE_COUNT=$(grep -c '^  resource' "${POET_OUT}" || true)
EXPECTED=$((${#ANALYZERS[@]} + 3))  # 14 analyzers + typer/click/pydantic/... core deps
if [ "${RESOURCE_COUNT}" -lt "${EXPECTED}" ]; then
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
' "${POET_OUT}" > "${RESOURCES}"

# `homebrew-pypi-poet` emits `resource "<python_module_name>"`, but
# homebrew's `brew audit` requires the resource name to match the PyPI
# DIST name (hyphens, not underscores) for well-known packages.
# `pydantic_core` on PyPI ships as `pydantic-core`; audit rejects the
# underscore form. Normalize the known offenders in place — the URL
# still carries the actual sdist filename so nothing else needs to
# change.
sed -i.bak -E '
  s/^  resource "pydantic_core"/  resource "pydantic-core"/
' "${RESOURCES}"
rm -f "${RESOURCES}.bak"

# In-place rewrite using a Python helper — multi-line replace in shell is
# misery. Atomic write via temp + mv.
python3 - "${FORMULA}" "${SDIST_URL}" "${SDIST_SHA}" "${RESOURCES}" <<'PY'
import sys, pathlib, re

formula_path, url, sha, resources_path = sys.argv[1:5]
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

# Replace the resources region. Preserve the BEGIN/END marker lines so the
# script can find them again next release.
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
print(f"Rewrote {formula_path}")
PY

# Ruby syntax check.
if command -v ruby >/dev/null 2>&1; then
  if ! ruby -c "${FORMULA}" >/dev/null; then
    echo "ERROR: ruby syntax check failed on ${FORMULA}" >&2
    exit 1
  fi
fi

# Optional: brew style if available (slow first time — installs gems).
if command -v brew >/dev/null 2>&1; then
  echo "Running brew style…"
  brew style "${FORMULA}" || {
    echo "WARNING: brew style reported offenses (see above)" >&2
  }
fi

echo ""
echo "  Formula:           ${FORMULA}"
echo "  Resources written: ${RESOURCE_COUNT}"
echo "  Top-level sdist:   ${SDIST_URL}"
echo "  sha256:            ${SDIST_SHA}"
echo ""
echo "Review with: git diff Formula/attackmap.rb"
