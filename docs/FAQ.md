## ZeroPass — Frequently Asked Questions

### General

**Q: What is ZeroPass?**  
ZeroPass is a privacy-first identity compliance dApp on the Midnight Network. It lets users prove regulatory eligibility (KYC/AML) without revealing personal information, using Zero-Knowledge Proofs.

**Q: How does it protect my privacy?**  
Your identity is represented as a 32-byte local secret. Only the cryptographic hash (commitment) of that secret is ever stored on-chain. The secret itself is used only inside a ZK circuit during proof generation and is never transmitted, stored, or visible to any observer.

**Q: What wallets are supported?**  
- **1AM Wallet** (recommended) — native Midnight wallet
- **Lace Wallet** — also supported via the Midnight dApp Connector API

Set your wallet to **Preprod** network before connecting.

---

### Technical

**Q: What is a Compact circuit?**  
Compact is Midnight's privacy-first smart contract language. Circuits are functions that run inside a ZK proof system — they can take private inputs (witnesses) and produce public outputs (disclosures) without revealing the private inputs.

**Q: Why do I need to run a ZK proof server locally?**  
ZK proof generation is computationally intensive and contains your private secret as input. Running it locally ensures your secret never leaves your machine. The proof server runs in Docker on `http://127.0.0.1:6300`.

**Q: What does "sealed ledger" mean?**  
In Compact, `sealed ledger` fields (like `authority` and `authorityName`) cannot be read directly by other circuits — only by the contract's own circuits. This prevents leaking the authority's key.

**Q: How many tests are there?**  
14 Vitest unit tests covering: constructor state, credential issuance, authority approval, eligibility proof, revocation, duplicate prevention, and ZK privacy invariants (the secret must never appear in any output).

---

### Deployment

**Q: Is there a live demo?**  
Yes — the frontend is live at [https://zero-pass.vercel.app](https://zero-pass.vercel.app).

**Q: What is the contract address?**  
`1387bebdf07d4f8d5d9cc5d5f8e1e27db2a3a37e3b144daf4ec2413d5374abc0`  
Network: Midnight Preprod Testnet

**Q: Can I deploy my own instance?**  
Yes — see [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) for the step-by-step guide.
