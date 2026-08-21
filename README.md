# 🔐 ZeroPass

[![ZeroPass CI](https://github.com/theSamyak07/ZeroPass/actions/workflows/ci.yml/badge.svg)](https://github.com/theSamyak07/ZeroPass/actions/workflows/ci.yml)

> Confidential Credentials with Zero-Knowledge Proofs on the Midnight Network.

ZeroPass is a decentralized **Confidential Credentials** system built on the **Midnight Network** using **Compact Smart Contracts**, **React**, **TypeScript**, and the **Midnight.js SDK** connected to the **Lace Wallet** (Preprod Network). Users can request identity credentials and prove regulatory eligibility **without ever revealing their personal information** — the secret stays private, only its cryptographic commitment goes on-chain.

---

## 🎯 What This Does

ZeroPass provides privacy-preserving credential verification for applications that need compliance without requiring users to repeatedly expose sensitive identity documents. A user receives a cryptographic credential commitment after approval and can later prove eligibility using a zero-knowledge proof, allowing applications to verify compliance while keeping the underlying secret and user identity **completely private**.

---

## ✨ Features

- 🔒 Privacy-preserving credential verification using Zero-Knowledge Proofs (ZKPs)
- 📄 Request credentials (user action, ZK proof generated client-side)
- ✅ Authority approval workflow (on-chain Compact circuit)
- ❌ Credential revocation by authority
- 📜 On-chain credential registry (Midnight Preprod Testnet)
- 📊 Dynamic client audit history
- 🌐 React + TypeScript + Vite frontend with persistent Lace wallet connection
- ⚡ Node.js REST API backend
- 🧪 14/14 smart contract tests passing

---

## 📜 Contract Addresses

| Network | Contract Address | Status |
|---------|------------------|--------|
| **Preprod** | `1387bebdf07d4f8d5d9cc5d5f8e1e27db2a3a37e3b144daf4ec2413d5374abc0` | ✅ Active / Deployed |

---

## 🏗️ Architecture

```text
       React Frontend (Vite)
                 │
                 ▼
     REST API Server (Node.js)
                 │
                 ├─── Midnight JS SDK ──▶ Midnight Preprod Network (RPC / Indexer)
                 │                              │
                 │                        Compact Smart Contract
                 │                        (shadow-kyc.compact)
                 │
                 └─── ZK Proof Server (Docker / Host) — generates ZK proofs locally
```

> [!NOTE]
> For browser-based transaction execution, ZK proof generation is performed locally. The DApp client proxies proof generation requests to the local proof-server running on the user's machine at `http://127.0.0.1:6300`.

---

## 🔐 Privacy Model

The Compact smart contract separates what is public on-chain from what remains private as a zero-knowledge witness.

The user's private identity secret is used as a private witness during the ZK flow. A cryptographic commitment derived from the secret is used by the contract, allowing eligibility to be proven without revealing the underlying secret.

### Public — visible on-chain

| Field | Type | Description |
|---|---|---|
| `authority` | `Bytes<32>` | Authority dapp-specific public key |
| `authorityName` | `Opaque<string>` | Authority public name |
| `pendingCredentials` | `Set<Bytes<32>>` | Credential commitments awaiting approval |
| `credentials` | `Set<Bytes<32>>` | Approved credential commitments |
| `revokedCredentials` | `Set<Bytes<32>>` | Revoked credential commitments |
| `eligibilityCount` | `Uint<64>` | Public counter of eligibility proofs performed |

### Private — not revealed in on-chain state

| Element | Description |
|---|---|
| `localSecret()` witness | The caller's 32-byte secret used privately during proof generation; never exposed on-chain |
| User identity | The underlying identity information represented by the secret |

The credential commitment is computed inside the circuit using Midnight's built-in `persistentHash`.

### What the user proves without revealing

The `proveEligibility()` circuit proves that the user knows the secret corresponding to an approved credential commitment without revealing the secret itself ("Proved without revealing your input").

---

### 🔎 Privacy Claim

**What an on-chain observer can see**

An observer can see public contract state such as the authority name, credential commitments, pending and approved credential commitments, revoked credential commitments, and the eligibility proof counter.

**What an on-chain observer cannot see**

An observer cannot see the user's private secret or the underlying identity information represented by that secret. The user proves eligibility through a zero-knowledge proof without revealing the private witness.

---

## 🛠️ Tech Stack

| Layer | Technology |
|--------|------------|
| Smart Contract | Compact (Midnight DSL) |
| Blockchain | Midnight Preprod Testnet |
| Frontend | React + TypeScript + Vite |
| Backend | Node.js + REST API |
| Wallet | Lace Wallet (Chrome Extension, Preprod network) |
| ZK Proofs | Midnight Proof Server (Local Docker container, port 6300) |
| Testing | Vitest |

---

## 🚀 Getting Started

### Prerequisites

- Node.js >= 22
- Docker Desktop (with WSL2 integration enabled)
- **Lace Wallet** browser extension (set to **Preprod Testnet**)
- Compact compiler (from Midnight Developer Hub)

### Install

```bash
git clone https://github.com/theSamyak07/ZeroPass.git
cd ZeroPass
npm install
```

### Start Infrastructure (Docker)

```bash
npm run proof-server:start
```

This starts the `risein-proof-server` container for local ZK proof generation on port 6300.

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
npm run frontend:dev
```

Then open `http://localhost:5173`.

---

## ✅ Running Tests

```bash
npm test
```

Expected output:

```
✓ tests/shadow-kyc.test.ts (14 tests) ~330ms
Test Files  1 passed (1)
    Tests  14 passed (14)
```

---

### ⚙️ CI/CD

ZeroPass uses GitHub Actions to automatically validate the project on every push to `main` and every pull request.

The pipeline:
1. Checks out the repository
2. Sets up Node.js 22
3. Installs dependencies with `npm ci`
4. Compiles the Compact smart contract with `npm run compile`
5. Runs the 14-test Vitest suite with `npm test`
6. Runs the TypeScript build with `npm run build`

---

## 🌐 Deployment Status

| Service / Feature | Status | URL |
|---|---|---|
| **Vercel Frontend** | ✅ Active / Deployed | `https://zero-pass.vercel.app` |
| **Production API Backend** | 🔗 Tunnel Active | Cloudflare Quick Tunnel |
| **ZK Proof Server** | 💻 User Host | `http://127.0.0.1:6300` (Localhost requirement) |

> [!WARNING]
> The deployed Vercel frontend relies on a locally running ZK proof-server on the user's host (at `http://127.0.0.1:6300`) for generating client-side ZK transaction proofs. It is not fully serverless for proof generation.

---

## Level 3 — Tests + CI/CD + Production-Grade

ZeroPass is a production-grade dApp with:

- 14/14 smart contract tests passing
- CI/CD pipeline running on every push (GitHub Actions)
- Lace wallet connect/disconnect
- Midnight.js frontend integration
- Frontend circuit invocation
- Zero-knowledge proof generation
- Credential request, approval and revocation
- ZK eligibility verification
- Midnight Preprod deployment
- Transaction/audit history

### Level 3 Requirement Checklist

- [x] Fully functional dApp using Midnight's privacy model
- [x] Minimum 3 tests passing (14/14 passing)
- [x] CI/CD pipeline running (workflow file + passing runs)
- [x] Approved idea: **Confidential Credentials** — prove a credential is valid without disclosing it
- [x] Minimum 10 meaningful commits
- [x] Public GitHub repository with complete README
- [x] Live demo link
- [x] README "privacy model" section

### 📋 Product Proposal

ZeroPass is proposed under the Level 3 **Confidential Credentials** idea.

See [`PROPOSAL.md`](./PROPOSAL.md) for the product proposal, privacy rationale, data model, and Mainnet feasibility.

---

## 📂 Project Structure

```text
ZeroPass/
├── contracts/
│   ├── shadow-kyc.compact          # Compact smart contract source
│   └── managed/
│       └── shadow-kyc/             # Compiled artifacts (auto-generated)
│           ├── contract/           # JS circuit binaries
│           └── keys/               # Proving & verifying keys
├── frontend/                       # React + TypeScript + Vite frontend
│   └── src/
│       ├── App.tsx                 # Main UI component
│       ├── api.ts                  # API client
│       └── types.ts                # Type definitions
├── src/                            # Node.js backend
│   ├── api-server.ts               # REST API + static file server
│   ├── deploy.ts                   # Contract deployment script
│   ├── cli.ts                      # Interactive CLI
│   ├── network.ts                  # Network configuration
│   └── wallet.ts                   # Wallet management
├── tests/
│   └── shadow-kyc.test.ts          # 14 Vitest smart contract tests
├── compose.yml                     # Docker compose services
└── package.json
```

---

## 👨‍💻 Author

**Samyak**

GitHub: [https://github.com/theSamyak07](https://github.com/theSamyak07)

---

## 📜 License

This project is licensed under the MIT License.
