# Changelog

All notable changes to ZeroPass are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [1.0.0] — 2026-09-01

### Added
- ZeroPass Compact smart contract (`shadow-kyc.compact`) with 4 ZK circuits:
  - `issueCredential` — user submits commitment (hash of secret)
  - `approveCredential` — authority approves pending commitment
  - `proveEligibility` — user ZK-proves knowledge of approved credential
  - `revokeCredential` — authority revokes a credential
- React 18 + TypeScript + Vite frontend with minimal dark UI
- Node.js + Express REST API server (8 endpoints)
- 14 Vitest smart contract tests — 100% passing
- GitHub Actions CI/CD — 3 workflows:
  - `ci.yml` — 6-job pipeline (lint, compile, test, security, frontend, gate)
  - `contract-audit.yml` — automated privacy/access/replay audit
  - `cd.yml` — release packaging and Vercel deployment
- MVP live on Midnight Preprod Testnet
- 1AM Wallet + Lace Wallet support via dApp Connector API
- Local ZK proof-server via Docker (port 6300)
- Full documentation (README, ARCHITECTURE, API, DEPLOYMENT)
- Product X profile: [@ZeroPass_00](https://x.com/ZeroPass_00)

### Security
- `localSecret()` is a private ZK witness — never transmitted or stored
- All public mutations use `disclose()` explicitly
- Authority guards on admin-only circuits
