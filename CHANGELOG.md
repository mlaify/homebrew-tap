# Changelog

All notable changes to the mlaify Homebrew tap will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

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
