---
name: trace-impact
description: Find all code affected by a change using call graph analysis with llm-tldr
argument-hint: "<function_name>"
allowed-tools: Skill(tldr-context)
---

# Trace Impact Command

Finds all code affected by changes to a specific function using call graph analysis.

## Usage

**Trace impact of function change:**
```bash
claude /trace-impact validate_token
```

**Trace impact with file context:**
```bash
claude /trace-impact src/auth/jwt.py:validate_token
```

**Full dependency tree (3 levels deep):**
```bash
claude /trace-impact validate_token --depth 3
```

## What It Shows

1. **Direct Callers** - Functions that directly call this function
2. **Indirect Callers** - Functions that transitively depend on this (via call chain)
3. **Test Coverage** - Tests that cover this code path
4. **Risk Assessment** - How critical this function is (blast radius)
5. **Recommendations** - What to test after changing this function

## How It Works

1. Uses llm-tldr's call graph analysis
2. Builds complete dependency tree (who calls what)
3. Recursively traces callers up to specified depth
4. Identifies tests that reference this function
5. Calculates risk score based on coupling and complexity
6. Generates actionable testing recommendations

## Implementation Steps

### Step 1: Validate Prerequisites

```bash
command -v tldr || echo "Install: pip install llm-tldr"
[[ -d .tldr/cache ]] || echo "Index: tldr warm ."
```

### Step 2: Impact Analysis

Execute impact analysis:

```bash
IMPACT=$(mcp__tldr__impact({
  function: "validate_token",
  project: "."
}))
```

### Step 3: Build Dependency Tree

Recursively find callers:

```bash
# Direct callers (level 1)
DIRECT=$(echo "$IMPACT" | jq '.callers[]')

# Level 2 callers
for caller in $DIRECT; do
  mcp__tldr__impact({ function: "$caller", project: "." })
done

# Continue up to --depth level (default: 3)
```

### Step 4: Find Tests

Search for tests:

```bash
mcp__tldr__semantic_search({
  query: "test validate_token",
  project: "tests/"
})
```

### Step 5: Assess Risk

Calculate risk score based on:
- **Caller count** (more callers = higher risk)
- **Tree depth** (deeper dependencies = higher risk)
- **Complexity** (higher complexity = higher risk)
- **Test coverage** (less coverage = higher risk)
- **Critical paths** (auth/payment = higher risk)

Risk formula:
```
risk = (callers × 2) + (depth × 3) + (complexity × 1) - (coverage × 5)
```

### Step 6: Generate Report

Create impact report with:
- Dependency tree visualization
- Risk assessment (LOW/MEDIUM/HIGH/CRITICAL)
- Testing recommendations
- Rollback plan

## Example Output

```markdown
# Impact Analysis: validate_token
**File:** src/auth/jwt.py:23
**Complexity:** 8
**Direct Callers:** 3
**Transitive Callers:** 12
**Test Coverage:** 85%
**Risk Score:** MEDIUM (6/10)

## Dependency Tree

```
validate_token (src/auth/jwt.py)
├── authenticate (src/middleware/auth.py) [3 callers]
│   ├── login_handler (src/handlers/login.py)
│   ├── api_endpoint (src/api/routes.py)
│   └── websocket_auth (src/websockets/auth.py)
├── refresh_session (src/handlers/auth.py) [1 caller]
│   └── refresh_endpoint (src/api/routes.py)
└── verify_api_key (src/api/verification.py) [2 callers]
    ├── api_middleware (src/middleware/api.py)
    └── webhook_handler (src/webhooks/handler.py)
```

**Total affected functions:** 12
**Total affected endpoints:** 4 HTTP + 1 WebSocket
**Critical paths:** Yes (authentication is critical)

## Risk Assessment

**Risk Score: MEDIUM (6/10)**

### Risk Factors

**Positive (Lower Risk):**
- ✓ Good test coverage (85%)
- ✓ Moderate complexity (8)
- ✓ Well-documented function
- ✓ No circular dependencies

**Negative (Higher Risk):**
- ⚠ Multiple callers (3 direct, 12 transitive)
- ⚠ Used in critical authentication path
- ⚠ Affects 4 API endpoints
- ⚠ Affects WebSocket authentication

### Blast Radius

If this function breaks or changes behavior:
- **12 functions** may be affected
- **4 API endpoints** could fail authentication
- **1 WebSocket handler** could reject connections
- **2 middleware components** could block requests
- **All authenticated users** potentially impacted

## Testing Recommendations

### Before Making Changes

1. **Review existing tests:**
   ```bash
   pytest tests/auth/test_jwt.py::test_validate_token -v
   ```

2. **Understand current behavior:**
   - Read function implementation
   - Review test cases for edge cases
   - Check error handling paths

3. **Document expected changes:**
   - What behavior will change?
   - Are any callers expecting specific behavior?
   - Will error messages change?

### After Making Changes

**Required Tests (Must Pass):**

1. **Unit Tests:**
   ```bash
   pytest tests/auth/test_jwt.py::test_validate_token
   pytest tests/auth/test_jwt.py::test_token_expiry
   pytest tests/auth/test_jwt.py::test_invalid_signature
   ```

2. **Integration Tests:**
   ```bash
   # Test authenticate flow
   pytest tests/middleware/test_auth.py::test_authentication_success
   pytest tests/middleware/test_auth.py::test_authentication_failure

   # Test refresh_session flow
   pytest tests/handlers/test_auth.py::test_refresh_valid_token
   pytest tests/handlers/test_auth.py::test_refresh_expired_token

   # Test verify_api_key flow
   pytest tests/api/test_verification.py::test_api_key_verification
   ```

3. **End-to-End Tests:**
   ```bash
   # Test login via API
   pytest tests/e2e/test_login.py::test_user_login
   pytest tests/e2e/test_login.py::test_login_with_invalid_credentials

   # Test WebSocket authentication
   pytest tests/e2e/test_websocket.py::test_websocket_connection_auth
   pytest tests/e2e/test_websocket.py::test_websocket_reject_invalid_token
   ```

**Recommended Manual Tests:**

- [ ] Test login flow in browser
- [ ] Test API authentication with Postman/curl
- [ ] Test WebSocket connection
- [ ] Verify error messages are user-friendly
- [ ] Check monitoring/logging for auth failures

### High-Risk Areas to Monitor

1. **Login Functionality** (affects all users)
2. **API Authentication** (affects integrations)
3. **WebSocket Connections** (affects real-time features)

## Rollback Plan

If issues detected after deployment:

### Immediate Actions

1. **Revert commit:**
   ```bash
   git revert <commit-hash>
   git push origin main
   ```

2. **Monitor error rates:**
   - `AuthenticationError` exceptions
   - Failed login attempts
   - WebSocket connection failures
   - API 401 responses

3. **Communication:**
   - Alert team in Slack #engineering
   - Post status update if user-facing
   - Document issue in incident log

### Gradual Rollback

If full revert not needed:
1. Feature flag the change
2. Roll back to 50% of traffic
3. Monitor metrics
4. Gradually re-enable if stable

## Related Changes to Review

**Files that call this function:**
- `src/middleware/auth.py:45` - Uses validate_token for request auth
- `src/handlers/auth.py:89` - Uses for session refresh
- `src/api/verification.py:34` - Uses for API key verification

**Documentation to update:**
- `docs/api/authentication.md` - If validation logic changes
- `.claude/memory/agents/review/security-findings.md` - Update JWT patterns
- `CHANGELOG.md` - Document breaking changes

## See Also

- [/find-code](./find-code.md) - Find similar validation patterns
- [/code-map](./code-map.md) - Understand overall architecture
- [tldr-context skill](../skills/tldr-context/) - Extract function details

## Requirements

- llm-tldr installed (`pip install llm-tldr`)
- Codebase indexed (`tldr warm .`)
- Call graph analysis enabled (automatic)
```
