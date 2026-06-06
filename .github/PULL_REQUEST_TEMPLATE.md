## Summary

<!-- One or two sentences describing the change. -->

## Type of change

- [ ] New formula
- [ ] Update existing formula (version bump or resource refresh)
- [ ] Documentation / tooling

## Verification

- [ ] `brew install --build-from-source ./Formula/<name>.rb` succeeds
- [ ] `brew test ./Formula/<name>.rb` passes
- [ ] `brew audit --strict --new ./Formula/<name>.rb` passes
- [ ] Added a CHANGELOG entry under `[Unreleased]`
