# mlaify Homebrew tap

The official [Homebrew](https://brew.sh) tap for [mlaify](https://github.com/mlaify)
projects.

## Install

```bash
brew tap mlaify/tap
brew install mlaify/tap/attackmap
```

Or in one step:

```bash
brew install mlaify/tap/attackmap
```

## Formulae

| Formula | What it is |
|---|---|
| [`attackmap`](Formula/attackmap.rb) | AI-assisted defensive security analyzer for codebases. See [AttackMap](https://github.com/mlaify/AttackMap). |

## Maintenance

Formulae here that wrap PyPI packages can be re-resourced (pinning every
transitive dependency with `sha256`) after each release using
[`homebrew-pypi-poet`](https://github.com/tdsmith/homebrew-pypi-poet). See
[`scripts/regenerate.sh`](scripts/regenerate.sh) for the workflow.

## License

[MIT](LICENSE). Copyright (c) 2026 Matthew Davis and AttackMap Contributors.
