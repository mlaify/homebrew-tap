# Contributing to the mlaify Homebrew tap

Thanks for your interest in improving this tap.

## Adding or updating a formula

1. Fork this repository.
2. Add or edit a file under `Formula/<name>.rb`.
3. Locally lint and test:
   ```bash
   brew install --build-from-source ./Formula/<name>.rb
   brew test ./Formula/<name>.rb
   brew audit --strict --new ./Formula/<name>.rb
   ```
4. Open a pull request using the [PR template](.github/PULL_REQUEST_TEMPLATE.md).

## Re-resourcing a Python formula

Formulae here that wrap PyPI packages should be re-resourced after each release
so every transitive dependency is pinned with a `sha256`. See
[`scripts/regenerate.sh`](scripts/regenerate.sh) for the workflow.

## Code of Conduct

This project adheres to the same standards as the AttackMap project. Report
unacceptable behavior to [matthewd@matthewd.xyz](mailto:matthewd@matthewd.xyz).

## Reporting security issues

Please do **not** open public issues for security vulnerabilities in our
formulae. Email [matthewd@matthewd.xyz](mailto:matthewd@matthewd.xyz) — see
[SECURITY.md](SECURITY.md) for the full disclosure policy.

## License

By contributing to this tap, you agree that your contributions will be licensed
under the [MIT License](LICENSE).
