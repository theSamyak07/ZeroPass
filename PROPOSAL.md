# Product Proposal — ZeroPass

## What is the product, and who uses it?

ZeroPass is a privacy-preserving Confidential Credentials system built on Midnight. It allows a credential authority to issue and approve a credential for a user without putting the user's underlying identity information on-chain. The user can later prove that they possess an approved credential without revealing the private secret behind it.

The primary users are individuals who need to prove regulatory eligibility or membership, and organizations that need to verify compliance without unnecessarily exposing sensitive identity information. A trusted authority is responsible for issuing, approving, and revoking credentials.

## Why Midnight specifically?

ZeroPass specifically uses Midnight because credential information is sensitive and should not be exposed on a transparent blockchain. A transparent chain could make credential activity and associated information publicly observable. Midnight allows the application to keep the user's secret as private witness data while using a cryptographic commitment and zero-knowledge proof to verify eligibility.

This allows ZeroPass to provide verifiable compliance without requiring the user to reveal the underlying private credential information.

## Idea Category

ZeroPass falls under the **Confidential Credentials** category — prove a credential is valid without disclosing it.

## Data Model

| Data Point | Type | Disclosed To |
|------------|------|--------------|
| Authority name | Public ledger | Everyone |
| Credential commitment | Public ledger | Everyone |
| Pending credential commitments | Public ledger | Everyone |
| Approved credential commitments | Public ledger | Everyone |
| Revoked credential commitments | Public ledger | Everyone |
| Eligibility proof count | Public ledger | Everyone |
| User secret | Private witness | User only |
| Underlying identity information | Private | User only |
| Eligibility proof | Zero-knowledge proof | Verifiable without revealing secret |

## Mainnet Feasibility

The current ZeroPass implementation demonstrates the core privacy and credential-verification flow on Midnight Preprod. Reaching Mainnet would be realistic as the project progresses, but additional work would be required before production deployment.

This would include production-grade proof infrastructure, security testing and smart-contract auditing, reliable wallet and network integration, monitoring and error handling, and additional testing under realistic usage. The current implementation therefore provides a feasible foundation for a Mainnet version rather than claiming to already be production-ready.
