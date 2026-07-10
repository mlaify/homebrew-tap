# Changelog

All notable changes to the mlaify Homebrew tap will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [0.4.2] — 2026-07-10

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to **0.4.2** (progress/status
  polish: determinate anomaly-pass progress + live spinner/timer for the CVE
  lookup and all LLM phases). sdist URL + sha256 updated; resource blocks
  unchanged (no dependency changes over 0.4.1).

## [0.4.1] — 2026-07-08

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to **0.4.1** (adds the
  `--progress-format {auto,json,none}` flag: NDJSON progress on stderr for the
  macOS GUI front-end). sdist URL + sha256 updated; resource blocks unchanged
  (no dependency changes over 0.4.0).

## [0.4.0] — 2026-07-06

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to **0.4.0** (precision +
  multi-language reach: Go/PHP taint, CVE→exploitability fusion, PR bot, LLM
  remediation, `--hunt --verify`). sdist URL + sha256 updated; resource blocks
  unchanged (no dependency changes over 0.3.x).

## [0.3.2] — 2026-07-05

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to **0.3.2** (weakness/secret
  precision patch: prototype_pollution write-context gate, vendored/minified
  exclusion, base64-charset secret guard). sdist URL + sha256 updated; resource
  blocks unchanged (no dependency changes over 0.3.1).

## [0.3.1] — 2026-07-05

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to **0.3.1** (taint precision
  patch: deserialization/eval/exec sinks no longer over-fire on static/local
  args). sdist URL + sha256 updated; resource blocks unchanged (no dependency
  changes over 0.3.0).

## [0.3.0] — 2026-07-05

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to **0.3.0** (vulnerability-hunting
  release: novel vuln-class detectors, anomaly/outlier detection, exploitability
  fusion, `--hunt`, live progress bar). sdist URL + sha256 updated; resource
  blocks unchanged (0.3.0 adds no new runtime dependencies over 0.2.0).

## [0.2.0] — 2026-07-05

### Changed

- `Formula/attackmap.rb` — bump AttackMap core to 0.2.0; dropped the `[llm]`
  (anthropic → jiter/maturin) tree from the pinned resources and added
  `depends_on "rust"` for pydantic-core's sdist build.

## [0.1.0] — 2026-06-25

### Added

- Initial tap scaffold.
- `Formula/attackmap.rb` — fully resource-pinned formula for AttackMap 0.1.0
  including all 13 analyzer plugins and the `[llm]` extra (anthropic).
  Generated via `scripts/regenerate.sh 0.1.0`.
