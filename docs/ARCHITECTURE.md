# ZeroPass Architecture

## Overview

ZeroPass is a privacy-preserving credential dApp on the Midnight Network.
It uses Zero-Knowledge Proofs (ZKPs) to let users prove regulatory eligibility
without revealing personal identity data.

## System Diagram

```
  User Browser (React 18 + Vite)
         │
         │  HTTP REST + WebSocket
         ▼
  API Server (Node.js + Express)  :8080
         │
         ├── Midnight.js SDK ──▶ Midnight Preprod RPC
         │                              │
         │                        Compact Smart Contract
         │                        shadow-kyc.compact
         │                        ┌─────────────────────────┐
         │                        │ issueCredential()       │
         │                        │ approveCredential()     │
         │                        │ proveEligibility()      │
         │                        │ revokeCredential()      │
         │                        └─────────────────────────┘
         │
         └── ZK Proof Server  :6300 (Docker, local)
```

## Components

### 1. Compact Smart Contract

**File:** `contracts/shadow-kyc.compact`
**Compiler:** Compact 0.31.1

| Circuit | Caller | Description |
|---|---|---|
| `issueCredential()` | Any user | Submits commitment = `persistentHash(secret)` |
| `approveCredential(commitment)` | Authority only | Moves from pending → approved |
| `proveEligibility(commitment)` | Any user | ZK proof of holding approved credential |
| `revokeCredential(commitment)` | Authority only | Moves from approved → revoked |

**Privacy invariants:**
- `localSecret()` is a ZK witness — proved inside circuit, never transmitted
- All ledger mutations use `disclose()` — deliberate public disclosure
- `authority` and `authorityName` are `sealed ledger`

### 2. Node.js API Server

**File:** `src/api-server.ts`  
**Port:** 8080

Bridges the React frontend to the Midnight Network via Midnight.js SDK.

### 3. React Frontend

**Directory:** `frontend/`  
**Stack:** React 18 + TypeScript + Vite

Three views: **User** | **Authority** | **Audit**

### 4. ZK Proof Server

Runs in Docker on port 6300. Performs local ZK proof generation for Compact circuits. Required for `issueCredential` and `proveEligibility`.

## Data Flow

1. User opens frontend, connects 1AM Wallet
2. User clicks "Request Credential" → API → `issueCredential` circuit → commitment stored in `pendingCredentials`
3. Authority approves → `approveCredential` circuit → commitment moves to `credentials`
4. User clicks "Prove Eligibility" → local ZK proof (via proof server on :6300) → `proveEligibility` circuit → `eligibilityCount` increments publicly
