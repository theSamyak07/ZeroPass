# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.x     | ✅        |

## Reporting a Vulnerability

Please report security vulnerabilities **privately** — do NOT open a public GitHub issue.

**Contact:** Open a [GitHub Security Advisory](https://github.com/theSamyak07/ZeroPass/security/advisories/new)

Include in your report:
- Description of the vulnerability
- Steps to reproduce
- Potential impact

We will respond within 48 hours.

## Privacy Invariants (by design)

ZeroPass enforces these invariants at the contract level:

1. `localSecret()` is always a ZK **witness** — never disclosed on-chain
2. No circuit passes `_secret` directly to `disclose()`
3. `authority` and `authorityName` are `sealed ledger` (not readable by circuit callers)
4. All public state mutations use `disclose()` explicitly
5. Authority-only circuits (`approveCredential`, `revokeCredential`) assert `authority == pubKey`
