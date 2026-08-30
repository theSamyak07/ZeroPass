# 🔐 ZeroPass

[![ZeroPass CI](https://github.com/theSamyak07/ZeroPass/actions/workflows/ci.yml/badge.svg)](https://github.com/theSamyak07/ZeroPass/actions/workflows/ci.yml)
[![Midnight Network](https://img.shields.io/badge/Midnight-Preprod-8b5cf6?logo=ethereum&logoColor=white)](https://midnight.network)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![X (Twitter)](https://img.shields.io/badge/X-@ZeroPass__00-black?logo=x&logoColor=white)](https://x.com/ZeroPass_00)

> **Confidential Credentials with Zero-Knowledge Proofs on the Midnight Network.**

ZeroPass is a decentralized **Confidential Credentials** dApp built on the **Midnight Network** using **Compact Smart Contracts**, **React**, **TypeScript**, and the **Midnight.js SDK**. Users request identity credentials and prove regulatory eligibility **without ever revealing personal information** — the secret stays private; only its cryptographic commitment goes on-chain.

🐦 Follow us on X: **[@ZeroPass_00](https://x.com/ZeroPass_00)**

---

## 🎯 What This Does

ZeroPass provides privacy-preserving credential verification for compliance use-cases. A user receives a cryptographic credential commitment after authority approval and later proves eligibility using a zero-knowledge proof — verifying compliance while keeping the underlying secret and user identity **completely private**.

---

## ✨ Features

- 🔒 Zero-Knowledge Proofs (ZKPs) — eligibility proven without revealing the secret
- 📄 Credential request workflow (user action, client-side ZK proof)
- ✅ Authority approval / ❌ revocation (on-chain Compact circuits)
- 📜 On-chain credential registry (Midnight Preprod Testnet)
- 📊 Live audit history with on-chain tx IDs and block heights
- 🌐 Minimal dark desktop UI — React + TypeScript + Vite
- 💳 Multi-wallet support — **1AM Wallet** (recommended) + Lace Wallet
- ⚡ Node.js REST API backend + local ZK proof-server
- 🧪 14/14 smart contract tests passing
- 🔄 CI/CD pipeline on every push (GitHub Actions)

---

## 🚀 Live Demo

| Resource | Link |
|---|---|
| **Frontend (Vercel)** | [https://zero-pass.vercel.app](https://zero-pass.vercel.app) |
| **GitHub Repo** | [https://github.com/theSamyak07/ZeroPass](https://github.com/theSamyak07/ZeroPass) |
| **X / Twitter** | [@ZeroPass_00](https://x.com/ZeroPass_00) |
| **CI/CD** | [GitHub Actions — Passing](https://github.com/theSamyak07/ZeroPass/actions) |

---

## 📜 Contract Address (Preprod)

```
1387bebdf07d4f8d5d9cc5d5f8e1e27db2a3a37e3b144daf4ec2413d5374abc0
```

Network: **Midnight Preprod Testnet** | Status: ✅ Active

---

## 🏗️ Architecture

```
  User Browser (React + Vite)
         │
         │  REST + WebSocket
         ▼
  API Server (Node.js / Express)
         │
         ├── Midnight JS SDK ──▶ Midnight Preprod (RPC / Indexer / Prover)
         │                              │
         │                        Compact Smart Contract
         │                        (ZeroPass credential circuits)
         │
         └── ZK Proof Server (localhost:6300) — local proof generation
```

> **Note:** ZK proof generation runs locally for privacy. The dApp client routes proof requests to the proof-server running on the user's machine at `http://127.0.0.1:6300`.

---

## 🔐 Privacy Model

The Compact smart contract separates **public on-chain state** from **private zero-knowledge witnesses**.

### Public — visible on-chain

| Field | Type | Description |
|---|---|---|
| `authority` | `Bytes<32>` | Authority dapp-specific public key |
| `authorityName` | `Opaque<string>` | Authority public name |
| `pendingCredentials` | `Set<Bytes<32>>` | Commitments awaiting approval |
| `credentials` | `Set<Bytes<32>>` | Approved credential commitments |
| `revokedCredentials` | `Set<Bytes<32>>` | Revoked credential commitments |
| `eligibilityCount` | `Uint<64>` | Public counter of proofs performed |

### Private — never revealed on-chain

| Element | Description |
|---|---|
| `localSecret()` witness | The caller's 32-byte secret — used only during proof generation, never stored or transmitted |
| User identity | The underlying identity information represented by the secret |

The commitment is computed inside the ZK circuit using Midnight's `persistentHash`. An observer sees only the commitment hash — never the secret.

### What a user proves without revealing

`proveEligibility()` proves that the user knows the secret corresponding to an approved commitment — **without revealing the secret itself**.

> An on-chain observer can see: authority name, commitment hashes, eligibility counter.  
> An on-chain observer **cannot** see: the private secret or any underlying identity information.

---

## 🛠️ Tech Stack

| Layer | Technology |
|--------|------------|
| Smart Contract | Compact (Midnight DSL) |
| Blockchain | Midnight Preprod Testnet |
| Frontend | React 18 + TypeScript + Vite |
| Backend | Node.js + Express REST API |
| Wallet | 1AM Wallet / Lace Wallet (Midnight dApp Connector API) |
| ZK Proofs | Midnight Proof Server (local Docker, port 6300) |
| Testing | Vitest (14 tests) |
| CI/CD | GitHub Actions |

---

## 🚀 Getting Started

### Prerequisites

- **Node.js** >= 22
- **Docker Desktop** (WSL2 integration enabled on Windows)
- **1AM Wallet** or **Lace Wallet** browser extension (set to Preprod Testnet)
- **Compact compiler** — install from [Midnight Developer Hub](https://docs.midnight.network)

### Clone & Install

```bash
git clone https://github.com/theSamyak07/ZeroPass.git
cd ZeroPass
npm install
```

### Environment Setup

```bash
cp .env.example .env
# Edit .env with your contract address and network config
```

### Start Infrastructure

```bash
# Start the local ZK proof-server (Docker required)
npm run proof-server:start
```

### Compile the Smart Contract

```bash
npm run compile
```

Expected output:
```
Compiling 4 circuits:
  circuit "approveCredential" (k=13, rows=4459)
  circuit "issueCredential"   (k=13, rows=2281)
  circuit "proveEligibility"  (k=13, rows=2631)
  circuit "revokeCredential"  (k=13, rows=4459)
```

### Start the API Server

```bash
npm run api:fresh
```

### Start the Frontend

```bash
cd frontend
npm install
npm run dev
```

Open `http://localhost:5173`

---

## 💳 Wallet Connection

ZeroPass supports all Midnight-compatible wallets via the `window.midnight` dApp Connector API:

| Wallet | Recommended | Download |
|---|---|---|
| **1AM Wallet** | ✅ Yes — native Midnight wallet | [1am.xyz](https://1am.xyz) |
| **Lace Wallet** | Also supported | [lace.io](https://lace.io) |

Set your wallet to the **Preprod** network before connecting.

---

## 📋 Usage Guide

### As a User

1. Open the dApp and connect your wallet (1AM or Lace)
2. Navigate to **User** tab
3. Click **Request Credential** — this generates a SHA-256 commitment from your local secret and submits it to the contract (pending)
4. Wait for the Authority to approve
5. Once approved, click **Prove Eligibility** to generate a ZK proof on-chain (eligibilityCount increments publicly, your secret stays private)

### As an Authority

1. Connect with the authority wallet
2. Navigate to **Authority** tab
3. View pending credentials — click **Approve** or **Revoke**

### Audit

The **Audit** tab shows all on-chain actions with transaction IDs and block heights.

---

## ✅ Running Tests

```bash
npm test
```

Expected output:

```
✓ tests/shadow-kyc.test.ts (14 tests) ~330ms
  ✓ Contract initializes with empty credential sets
  ✓ User can issue a credential commitment
  ✓ Authority can approve a credential commitment
  ✓ Approved credential appears in credentials set
  ✓ Authority can revoke an approved credential
  ✓ Revoked credential appears in revokedCredentials set
  ✓ User can prove eligibility for an approved credential
  ... (14 total)

Test Files  1 passed (1)
    Tests  14 passed (14)
```

---

## ⚙️ CI/CD

ZeroPass runs GitHub Actions on every push to `main` and every pull request:

1. Checkout repository
2. Setup Node.js 22
3. `npm ci` — install dependencies
4. `npm run compile` — compile Compact smart contract
5. `npm test` — run 14 Vitest tests
6. `npm run build` — TypeScript build check

[![ZeroPass CI](https://github.com/theSamyak07/ZeroPass/actions/workflows/ci.yml/badge.svg)](https://github.com/theSamyak07/ZeroPass/actions/workflows/ci.yml)

---

## 🌐 Deployment

| Service | Status | URL |
|---|---|---|
| **Frontend (Vercel)** | ✅ Live | [zero-pass.vercel.app](https://zero-pass.vercel.app) |
| **Preprod Contract** | ✅ Active | `1387bebdf0...` (see above) |
| **ZK Proof Server** | 💻 User-local | `http://127.0.0.1:6300` |

---

## 📂 Project Structure

```
ZeroPass/
├── contracts/
│   ├── shadow-kyc.compact          # Compact smart contract source
│   └── managed/ZeroPass/           # Compiled artifacts (CI-generated)
│       ├── contract/               # JS circuit binaries
│       └── keys/                   # Proving & verifying keys
├── frontend/                       # React + TypeScript + Vite frontend
│   └── src/
│       ├── App.tsx                 # Main UI — desktop layout, wallet modal
│       ├── index.css               # Design tokens (minimal dark)
│       ├── App.css                 # Component styles
│       ├── api.ts                  # API client
│       └── providers.ts            # Midnight.js client providers
├── src/                            # Node.js backend
│   ├── api-server.ts               # REST API + static file server
│   ├── deploy.ts                   # Contract deployment script
│   ├── cli.ts                      # Interactive CLI
│   ├── network.ts                  # Network configuration
│   └── wallet.ts                   # Wallet management
├── tests/
│   └── shadow-kyc.test.ts          # 14 Vitest smart contract tests
├── .github/workflows/ci.yml        # GitHub Actions CI/CD pipeline
├── compose.yml                     # Docker compose (proof-server)
├── PROPOSAL.md                     # Product proposal (Level 3)
└── package.json
```

---

## 📊 Submission Status

### Level 3 ✅ — First Quarter (Production-grade + Tests + CI/CD)

- [x] Fully functional dApp using Midnight's privacy model
- [x] 14/14 smart contract tests passing (minimum: 3)
- [x] CI/CD pipeline (GitHub Actions — passing)
- [x] Approved idea: **Confidential Credentials**
- [x] 15 meaningful commits
- [x] Public GitHub repository
- [x] Live demo link
- [x] Privacy model section in README
- [x] PROPOSAL.md

### Level 4 ✅ — Waxing Gibbous (MVP Live + Docs + X Profile)

- [x] Working MVP live on Preprod (contract address above)
- [x] Full documentation (README + setup + usage + privacy model)
- [x] CI/CD pipeline running with passing runs
- [x] Product X profile: [@ZeroPass_00](https://x.com/ZeroPass_00) — linked in README
- [x] 15+ meaningful commits
- [x] Public GitHub repository with complete documentation
- [x] Live Preprod demo link + contract address
- [x] CI/CD badge in README

---

## 👨‍💻 Author

**Samyak** — [@theSamyak07](https://github.com/theSamyak07)

🐦 Product X: [@ZeroPass_00](https://x.com/ZeroPass_00)

---

## 📜 License

MIT License — see [LICENSE](LICENSE)
