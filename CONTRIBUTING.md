# Contributing to ZeroPass

Thank you for your interest in contributing to ZeroPass!

## Getting Started

1. **Fork** the repository
2. **Clone** your fork: `git clone https://github.com/YOUR_USERNAME/ZeroPass.git`
3. **Install** dependencies: `npm install && npm ci --prefix frontend`
4. **Compile** the contract: `npm run compile`
5. **Run tests**: `npm test` — all 14 must pass

## Development Workflow

```bash
git checkout -b feat/your-feature   # Create a branch
# ... make changes ...
npm test                             # All 14 tests must pass
npm run build                        # TypeScript must compile cleanly
git push origin feat/your-feature
# Open a Pull Request against main
```

## Privacy Requirements (Non-negotiable)

All contract changes **MUST**:

- Keep `localSecret()` declared as a private `witness`
- **Never** pass `_secret` directly to `disclose()`
- Maintain authority guards (`assert(authority == pubKey)`) on `approveCredential` and `revokeCredential`
- Add Vitest tests for any new circuit or changed behaviour

## Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

| Prefix | When to use |
|---|---|
| `feat:` | New feature or circuit |
| `fix:` | Bug fix |
| `docs:` | Documentation only |
| `ci:` | CI/CD workflow changes |
| `test:` | Adding or fixing tests |
| `refactor:` | Code refactor (no behaviour change) |
| `chore:` | Tooling, deps, config |

## Code Review

All PRs require:
- All CI checks passing
- Privacy checklist complete (see PR template)
- At least one approving review from @theSamyak07
