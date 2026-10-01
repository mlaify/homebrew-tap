# mlaify Homebrew tap

```bash
brew install --cask mlaify/tap/grrclone
brew install mlaify/tap/attackmap            # AttackMap CLI, all 15 analyzer plugins
brew install --cask mlaify/tap/attackmap-app # AttackMap macOS app (installs the CLI too)
```

## attackmap

[AttackMap](https://github.com/mlaify/AttackMap) maps a codebase's attack surface
and writes an evidence-grounded defensive review. The formula installs from the
GitHub release tag into a Homebrew-managed virtualenv. AttackMap is not published
to PyPI. Its third-party dependencies are PyPI sdists pinned by sha256, `pydantic`
comes from homebrew-core's bottle (no Rust build), and the 15 official analyzer
plugins are pinned to the exact commits in AttackMap's `plugins_lock.py` for that
tag.

`.github/workflows/bump-attackmap.yml` opens a PR when AttackMap tags a new
release (daily check, manual dispatch, or a `repository_dispatch` of type
`attackmap-release`). It is driven by `scripts/bump_attackmap.sh` and
`scripts/plugin_resources.py`.

## attackmap-app

The native macOS front-end for AttackMap
([mlaify/AttackMap-mac](https://github.com/mlaify/AttackMap-mac)): the signed,
notarised DMG from its GitHub releases, SHA-256 pinned. It depends on the
`attackmap` formula, because the app drives the CLI rather than bundling it.

## grrclone

A free, open-source macOS menu bar app that connects [rclone](https://rclone.org)
remotes as Finder volumes. No licence key, no phone-home, no kernel extension, no
root. See [mlaify/grrclone](https://github.com/mlaify/grrclone).

Apple Silicon, macOS 14 or later. The cask installs the signed, notarised DMG from
the project's GitHub releases and pins its SHA-256.

### Why a tap rather than homebrew-cask

homebrew-cask requires a project to be "notable" — 75 stars, or 30 forks, or 30
watchers. grrclone is new and has none of those yet, and Homebrew is one of the ways
people would find it, so the requirement is circular for a young project. The cask
itself passes audit; only that rule fails.

This tap is the answer in the meantime. If grrclone clears the bar later, the same
cask can go to homebrew-cask unchanged and this tap can point at it.

### Updates

`brew upgrade --cask grrclone` — Homebrew owns installs here.

grrclone can be asked to *check* GitHub for new releases, which is off by default,
but it never replaces its own bundle. That is deliberate: two updaters owning one app
is how a self-updating app gets silently downgraded by the next `brew upgrade`. The
cask therefore does not declare `auto_updates`.

Pre-releases are not served by this cask. One cask serves one channel; a release
candidate has to be downloaded from the
[releases page](https://github.com/mlaify/grrclone/releases), and doing that replaces
the copy Homebrew is tracking.

## License

[MIT](LICENSE). Copyright (c) 2026 Matthew Davis and contributors.
