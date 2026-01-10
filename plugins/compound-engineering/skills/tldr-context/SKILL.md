---
name: tldr-context
description: This skill should be used when needing LLM-optimized context for specific functions or files with 99% token reduction
user-invocable: true
---

# tldr-context Skill

Extracts structured, token-efficient context for code analysis.

## When to Use

Use this skill INSTEAD of reading entire files when you need:
- Function implementation details
- Class structure
- Interface definitions
- Module exports
- API surface area

**Token savings:** 99% reduction (21,000 tokens → 175 tokens for function context)

## Usage

**Single function:**
```bash
claude skill tldr-context login
```

**Multiple functions:**
```bash
claude skill tldr-context "authenticate, validate_token, refresh_session"
```

**Entire file:**
```bash
claude skill tldr-context --file src/auth/middleware.py
```

## Integration with Agents

Agents can use tldr-context via MCP:

```
# Instead of:
Read file: src/auth/middleware.py (3,500 tokens)

# Use:
mcp__tldr__context({ function: "authenticate", project: "." })
# Returns: 175 tokens with structure preserved
```

## Output Format

The skill returns structured context including:

- **Function signature** - Parameters, return type
- **Summary** - What the function does
- **Key logic** - Step-by-step algorithm
- **Dependencies** - Functions it calls
- **Callers** - Functions that call it
- **Complexity** - Cyclomatic complexity score
- **Error handling** - Exception cases

Example output:

```yaml
---
function: authenticate
file: src/auth/middleware.py
language: python
complexity: 12
calls: [validate_token, get_user, create_session]
called_by: [login_handler, api_endpoint]
---

# Function: authenticate

## Signature
def authenticate(request: Request) -> User

## Summary
Validates JWT token from request headers and returns authenticated user.

## Key Logic
1. Extract token from Authorization header
2. Verify token signature using SECRET_KEY
3. Check token expiry
4. Load user from database
5. Create session

## Dependencies
- validate_token() - Token verification
- get_user(id) - User lookup
- create_session(user) - Session creation

## Error Handling
- Raises AuthenticationError if token invalid
- Returns 401 if token expired
- Returns 404 if user not found

## Related Code
Called by:
- login_handler (src/handlers/login.py:45)
- api_endpoint (src/api/routes.py:127)

Calls:
- validate_token (src/auth/jwt.py:23)
- get_user (src/models/user.py:89)
```

## Supported Languages

Python, TypeScript, JavaScript, Go, Rust, Java, C, C++, Ruby, PHP, C#, Kotlin, Scala, Swift, Lua, Elixir

## Benefits vs Full File Read

| Metric | Full File Read | tldr-context |
|--------|----------------|--------------|
| Tokens | 3,500 | 175 |
| Reduction | - | 95% |
| Structure | No | Yes |
| Call graph | No | Yes |
| Complexity | No | Yes |

## Requirements

- llm-tldr installed (`pip install llm-tldr`)
- Codebase indexed (`tldr warm .`)
- MCP server running (automatic via plugin.json)
