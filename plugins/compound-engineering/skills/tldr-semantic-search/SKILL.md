---
name: tldr-semantic-search
description: This skill should be used when searching for code using natural language queries powered by semantic embeddings
user-invocable: true
---

# tldr-semantic-search Skill

Finds relevant code using natural language queries powered by semantic embeddings.

## When to Use

Use this skill when you need to find code but:
- Don't know exact function names
- Want to search by behavior, not keywords
- Need to understand "what handles X" in the codebase
- Are exploring an unfamiliar codebase

## Examples

**Find authentication code:**
```bash
claude skill tldr-semantic-search "JWT token validation"
```

**Find database queries:**
```bash
claude skill tldr-semantic-search "database connection pooling"
```

**Find error handling:**
```bash
claude skill tldr-semantic-search "error boundary for API failures"
```

**Find testing utilities:**
```bash
claude skill tldr-semantic-search "mock HTTP requests in tests"
```

## How It Works

1. Generates 1024-dimensional embedding of your query
2. Compares against embeddings of all functions in codebase
3. Returns top-ranked matches by semantic similarity
4. Works regardless of naming conventions

## Output Format

```
Top 5 matches for "JWT token validation":

1. validate_token (src/auth/jwt.py) - Similarity: 0.94
   Verifies JWT signature and expiry using SECRET_KEY

2. authenticate (src/middleware/auth.py) - Similarity: 0.87
   Validates JWT from request headers and loads user

3. refresh_session (src/handlers/auth.py) - Similarity: 0.81
   Issues new JWT after validating refresh token

4. decode_jwt (src/utils/security.py) - Similarity: 0.76
   Decodes JWT payload without verification

5. check_token_expiry (src/auth/validation.py) - Similarity: 0.73
   Checks if JWT exp claim is in the future
```

## Integration with Research Agents

Research agents can use semantic search to find relevant code:

```
# Old pattern:
grep -r "token" . | grep "validate"  # Keyword matching (noisy)

# New pattern:
mcp__tldr__semantic_search({
  query: "JWT token validation logic",
  project: "."
})  # Semantic matching (precise)
```

## Semantic vs Keyword Search

| Feature | Keyword Search (grep) | Semantic Search (tldr) |
|---------|----------------------|------------------------|
| Exact matches | ✓ | ✓ |
| Synonyms | ✗ | ✓ |
| Behavior-based | ✗ | ✓ |
| Noise | High | Low |
| Understanding | None | Deep |

**Example:**
- Query: "authentication logic"
- Keyword finds: Files with "auth" in name
- Semantic finds: All authentication-related code (login, verify, session, token, etc.)

## Use Cases

### 1. Unfamiliar Codebases
"Where is the payment processing code?"
→ Finds all payment-related functions regardless of naming

### 2. Cross-cutting Concerns
"Find all logging implementations"
→ Discovers logging code even if named differently

### 3. Pattern Discovery
"Show me retry logic patterns"
→ Finds all retry implementations in codebase

### 4. API Surface Discovery
"What handles user registration?"
→ Locates all registration endpoints and handlers

### 5. Migration Planning
"Find all database queries"
→ Identifies code that needs updating during DB migration

## Requirements

- llm-tldr installed (`pip install llm-tldr`)
- Codebase indexed with semantic embeddings (`tldr warm .`)
- Daemon running for fast queries (optional but recommended)
- ~40MB disk space for embeddings (1,000 functions)

## Performance

- **Cold start:** 30 seconds
- **With daemon:** 100ms
- **Speedup:** 300x

## Languages Supported

Python, TypeScript, JavaScript, Go, Rust, Java, C, C++, Ruby, PHP, C#, Kotlin, Scala, Swift, Lua, Elixir
