#!/usr/bin/env bash
# =============================================================================
# verify-contract.sh — Verify the compiled ZeroPass contract artifacts
#
# Checks that:
#   1. All expected artifact directories exist (contract/, keys/, zkir/)
#   2. contract/index.js exists and is non-empty
#   3. All 4 circuits are exported in the compiled output
#
# Usage:
#   bash scripts/verify-contract.sh
#
# Exit codes:
#   0 — all checks passed
#   1 — one or more checks failed
# =============================================================================

set -euo pipefail

MANAGED="contracts/managed/ZeroPass"
CONTRACT_JS="$MANAGED/contract/index.js"

echo "🔍 ZeroPass Contract Verification"
echo "=================================="
echo ""

PASS=0
FAIL=0

check() {
  local label="$1"
  local condition="$2"
  if eval "$condition"; then
    echo "  ✅ $label"
    ((PASS++))
  else
    echo "  ❌ $label"
    ((FAIL++))
  fi
}

# 1. Artifact directories
echo "Artifact directories:"
check "$MANAGED/contract/ exists" "[ -d '$MANAGED/contract' ]"
check "$MANAGED/keys/ exists"     "[ -d '$MANAGED/keys' ]"
check "$MANAGED/zkir/ exists"     "[ -d '$MANAGED/zkir' ]"

echo ""
echo "Contract JS:"
check "contract/index.js exists"  "[ -f '$CONTRACT_JS' ]"
check "contract/index.js non-empty" "[ -s '$CONTRACT_JS' ]"

echo ""
echo "Circuit exports:"
for circuit in issueCredential approveCredential proveEligibility revokeCredential; do
  check "circuit '$circuit' present" "grep -q '$circuit' '$CONTRACT_JS'"
done

echo ""
echo "=================================="
echo "Results: $PASS passed, $FAIL failed"
echo ""

if [ "$FAIL" -eq 0 ]; then
  echo "✅ All contract artifacts verified successfully"
  exit 0
else
  echo "❌ $FAIL check(s) failed — run: npm run compile"
  exit 1
fi
