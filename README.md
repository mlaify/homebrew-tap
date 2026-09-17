# mlaify Homebrew tap

```bash
brew install --cask mlaify/tap/grrclone
```

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

## AttackMap

No longer distributed through Homebrew. Install from source —
[AttackMap](https://github.com/mlaify/AttackMap) (CLI) and
[AttackMap-mac](https://github.com/mlaify/AttackMap-mac) (macOS app).

## License

[MIT](LICENSE). Copyright (c) 2026 Matthew Davis and contributors.
