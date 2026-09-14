# ZeroPass REST API Reference

Base URL: `http://localhost:8080`

## Endpoints

### `GET /api/status`

Returns current contract address and network connectivity info.

**Response 200:**
```json
{
  "contractAddress": "1387bebdf07d4f8d5d9cc5d5f8e1e27db2a3a37e3b144daf4ec2413d5374abc0",
  "network": "TestNet",
  "proofServer": "http://127.0.0.1:6300",
  "status": "connected"
}
```

---

### `GET /api/ledger`

Fetches the current public on-chain state.

**Response 200:**
```json
{
  "authorityName": "ZeroPass Authority",
  "pendingCredentials": [],
  "credentials": ["0xabc123..."],
  "revokedCredentials": [],
  "eligibilityCount": 3
}
```

---

### `POST /api/credential/issue`

Submits a credential request (generates commitment from local secret, calls `issueCredential` circuit).

**Headers:** Wallet must be connected.

**Response 200:**
```json
{
  "txId": "0xdeadbeef...",
  "commitment": "0xbbcc...",
  "status": "pending"
}
```

---

### `POST /api/credential/approve`

Authority approves a pending credential commitment.

**Body:**
```json
{ "commitment": "0xbbcc..." }
```

**Response 200:**
```json
{ "txId": "0xffee...", "status": "approved" }
```

---

### `POST /api/credential/prove`

User proves eligibility (ZK proof via local proof server on :6300).

**Body:**
```json
{ "commitment": "0xbbcc..." }
```

**Response 200:**
```json
{
  "txId": "0xffee...",
  "eligibilityCount": 4,
  "status": "proved"
}
```

---

### `POST /api/credential/revoke`

Authority revokes an approved credential.

**Body:**
```json
{ "commitment": "0xbbcc..." }
```

**Response 200:**
```json
{ "txId": "0x1234...", "status": "revoked" }
```

---

### `GET /api/history`

Returns indexed on-chain transaction history.

**Response 200:**
```json
[
  {
    "type": "issueCredential",
    "txId": "0xdeadbeef...",
    "blockHeight": 1234,
    "timestamp": "2026-09-01T10:00:00Z"
  },
  {
    "type": "approveCredential",
    "txId": "0xfeed...",
    "blockHeight": 1240,
    "timestamp": "2026-09-01T11:30:00Z"
  }
]
```

---

## Error Responses

All endpoints return errors in this shape:

```json
{ "error": "Human readable error message" }
```

| Status | Meaning |
|---|---|
| 400 | Bad request (missing or invalid body) |
| 403 | Not authorized (caller is not authority) |
| 409 | Conflict (credential already exists / already pending) |
| 500 | Internal server error |
