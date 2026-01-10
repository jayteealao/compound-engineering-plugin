---
name: find-code
description: Semantic code search using natural language queries powered by llm-tldr
argument-hint: "<query>"
allowed-tools: Skill(tldr-semantic-search), Skill(tldr-context)
---

# Find Code Command

Searches codebase using natural language queries powered by semantic embeddings.

## Usage

**Search for functionality:**
```bash
claude /find-code "JWT token validation"
```

**Find error handling:**
```bash
claude /find-code "error boundaries for API failures"
```

**Locate database code:**
```bash
claude /find-code "database connection pooling"
```

**Discover test utilities:**
```bash
claude /find-code "mock HTTP requests in tests"
```

## How It Works

1. Converts your query to 1024-dimensional embedding
2. Compares against all function embeddings in codebase
3. Returns top 10 matches ranked by semantic similarity
4. Extracts context for top matches using tldr-context
5. Presents results with drill-down options

## Implementation Steps

### Step 1: Validate Prerequisites

Check llm-tldr is installed and indexed:

```bash
command -v tldr || echo "Install: pip install llm-tldr"
[[ -d .tldr/cache ]] || echo "Index: tldr warm ."
```

### Step 2: Semantic Search

Execute semantic search:

```bash
RESULTS=$(mcp__tldr__semantic_search({
  query: "$USER_QUERY",
  project: ".",
  limit: 10
}))
```

### Step 3: Extract Context

For top 5 matches, extract detailed context:

```bash
for func in $TOP_5; do
  mcp__tldr__context({
    function: "$func",
    project: "."
  })
done
```

### Step 4: Present Results

Display ranked matches with:
- Similarity score (0-100%)
- File location with line number
- Function signature
- Summary description
- Key logic points
- Call graph (called by / calls)

### Step 5: Offer Actions

Ask user:
```
Found 10 matches. What would you like to do?
1. View full implementation for top match
2. Compare top 3 matches side-by-side
3. Export results to .claude/research/
4. Refine search with new query
```

## Example Output

```
# Search Results: "JWT token validation"

Found 10 semantic matches:

## 1. validate_token (src/auth/jwt.py:23) - 94% match

**Signature:** `def validate_token(token: str) -> Dict`

**Summary:** Verifies JWT signature and expiry using SECRET_KEY

**Key Logic:**
- Decode JWT using SECRET_KEY
- Verify HMAC signature
- Check exp claim against current time
- Return payload if valid, raise AuthError otherwise

**Complexity:** 8
**Called by:** authenticate (src/middleware/auth.py:45)
**Calls:** hmac_verify (src/crypto/utils.py:12)

---

## 2. authenticate (src/middleware/auth.py:45) - 87% match

**Signature:** `def authenticate(request: Request) -> User`

**Summary:** Validates JWT from request headers and loads user session

**Key Logic:**
- Extract Authorization header
- Call validate_token()
- Load user from database by ID
- Create session and return user object

**Complexity:** 12
**Called by:**
- login_handler (src/handlers/login.py:34)
- api_endpoint (src/api/routes.py:127)
- websocket_auth (src/websockets/auth.py:56)

---

## 3. refresh_session (src/handlers/auth.py:89) - 81% match

**Signature:** `def refresh_session(refresh_token: str) -> Dict`

**Summary:** Issues new JWT after validating refresh token

**Key Logic:**
- Validate refresh token format
- Check refresh token hasn't expired
- Load associated session from database
- Generate new access JWT
- Update session last_refreshed timestamp

**Complexity:** 10
**Called by:** refresh_endpoint (src/api/routes.py:203)

---

[... 7 more matches ...]

---

## Actions

What would you like to do?
1. **View full implementation** - Show complete code for validate_token
2. **Compare top 3** - Side-by-side comparison of validate_token, authenticate, refresh_session
3. **Export results** - Save to .claude/research/jwt-validation-search.md
4. **Refine search** - Try a different query
5. **Trace impact** - See what calls these functions (use /trace-impact)

[User selects: 1]

## Full Implementation: validate_token

Reading: src/auth/jwt.py:23-45

```python
def validate_token(token: str) -> Dict:
    """
    Verifies JWT signature and expiry using SECRET_KEY.

    Args:
        token: JWT token string

    Returns:
        Dict: Decoded payload

    Raises:
        AuthenticationError: If token invalid or expired
    """
    try:
        # Decode and verify signature
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])

        # Check expiry
        exp = payload.get('exp')
        if not exp or datetime.utcnow().timestamp() > exp:
            raise AuthenticationError("Token expired")

        return payload

    except jwt.InvalidTokenError as e:
        raise AuthenticationError(f"Invalid token: {e}")
```

**Would you like to:**
- See who calls this function? (`/trace-impact validate_token`)
- Find similar validation patterns? (`/find-code "token verification patterns"`)
- Review this code? (Spawn security-sentinel agent)
```

## Search Tips

### 1. Use Behavior Descriptions
✓ Good: "JWT token validation"
✗ Bad: "token" (too generic)

### 2. Focus on What, Not How
✓ Good: "retry failed HTTP requests"
✗ Bad: "while loop with try catch"

### 3. Use Domain Terms
✓ Good: "user authentication flow"
✗ Bad: "login stuff"

### 4. Be Specific
✓ Good: "database connection pooling"
✗ Bad: "database things"

### 5. Combine Concepts
✓ Good: "rate limiting middleware for APIs"
✗ Bad: "rate limit" OR "middleware"

## Semantic vs Keyword Search

| Query | Keyword (grep) | Semantic (find-code) |
|-------|----------------|----------------------|
| "JWT validation" | Files with "JWT" | All token verification code |
| "retry logic" | Files with "retry" | All retry implementations |
| "error handling" | "error" or "exception" | All error boundary code |
| "logging" | Files with "log" | All logging implementations |

Semantic search understands **meaning**, not just keywords.

## Use Cases

### 1. Exploring Unfamiliar Codebases
"What handles user authentication?"

### 2. Finding Patterns
"Show me all retry implementations"

### 3. Migration Planning
"Find all MySQL queries" (before PostgreSQL migration)

### 4. Security Audits
"Find password hashing logic"

### 5. Refactoring Discovery
"Locate all caching mechanisms"

## Requirements

- llm-tldr installed (`pip install llm-tldr`)
- Codebase indexed with embeddings (`tldr warm .`)
- Daemon running for fast queries (recommended)
- ~40MB for embeddings (1,000 functions)

## Performance

- **First search (cold):** 30 seconds
- **With daemon:** 100ms
- **Speedup:** 300x

## See Also

- [tldr-semantic-search skill](../skills/tldr-semantic-search/) - Semantic search
- [/code-map](./code-map.md) - Architecture overview
- [/trace-impact](./trace-impact.md) - Impact analysis
