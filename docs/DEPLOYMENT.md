# ZeroPass Deployment Guide

## Overview

This guide covers deploying ZeroPass locally for development and to the Midnight Preprod Testnet.

## Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| Node.js | >= 22 | Backend + frontend |
| Docker Desktop | Latest | ZK proof server |
| Compact compiler | 0.31.1 | Contract compilation |
| 1AM Wallet or Lace | Latest | Transaction signing |

## Step 1 — Install Compact Compiler

```bash
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/midnightntwrk/compact/releases/latest/download/compact-installer.sh | sh
compact update 0.31.1
```

## Step 2 — Clone & Install

```bash
git clone https://github.com/theSamyak07/ZeroPass.git
cd ZeroPass
npm install
npm ci --prefix frontend
```

## Step 3 — Configure Environment

```bash
cp .env.example .env
```

Edit `.env`:
```
MIDNIGHT_RPC_URL=https://rpc.testnet.midnight.network
PROOF_SERVER_URL=http://127.0.0.1:6300
INDEXER_URL=https://indexer.testnet.midnight.network
AUTHORITY_NAME=ZeroPass Authority
```

## Step 4 — Compile the Smart Contract

```bash
npm run compile
# Outputs: contracts/managed/ZeroPass/{contract,keys,zkir}/
```

## Step 5 — Start ZK Proof Server

```bash
npm run proof-server:start
# Starts midnight-proof-server on port 6300 via Docker
```

## Step 6 — Deploy to Preprod

```bash
npm run deploy
# Signs with your wallet, deploys shadow-kyc.compact
# Output: Contract address (save this!)
```

Update `.env` with the new contract address.

## Step 7 — Start the API Server

```bash
npm run api:start
# http://localhost:8080
```

## Step 8 — Start the Frontend

```bash
cd frontend && npm run dev
# http://localhost:5173
```

---

## Live Deployment (Vercel)

Frontend is auto-deployed to Vercel via `.github/workflows/cd.yml` on version tags.

**Live URL:** https://zero-pass.vercel.app  
**Contract (Preprod):** `1387bebdf07d4f8d5d9cc5d5f8e1e27db2a3a37e3b144daf4ec2413d5374abc0`
