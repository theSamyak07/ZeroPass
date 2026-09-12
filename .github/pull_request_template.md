## Description

Briefly describe the changes in this PR and why they're needed.

## Type of Change

- [ ] 🐛 Bug fix (non-breaking change that fixes an issue)
- [ ] ✨ New feature (non-breaking change that adds functionality)
- [ ] 📚 Documentation update
- [ ] ⚙️ CI/CD update
- [ ] ♻️ Refactor (no behaviour change)
- [ ] 🔒 Security fix

## Privacy Checklist (required for contract changes)

- [ ] `localSecret()` remains a private `witness` — not changed to `export` or `ledger`
- [ ] `_secret` is **never** passed directly to `disclose()`
- [ ] Authority guards (`assert(authority == pubKey)`) intact on `approveCredential` and `revokeCredential`
- [ ] Any new public state mutation uses `disclose()` explicitly
- [ ] New circuits have corresponding Vitest tests

## Testing

- [ ] All 14 existing tests pass (`npm test`)
- [ ] TypeScript compiles cleanly (`npm run build`)
- [ ] New tests added for changed/new behaviour
- [ ] Contract security audit passes locally (if contracts changed)

## Related Issues

Closes #

## Screenshots / Demo

If applicable, add screenshots or a short description of the visible changes.
