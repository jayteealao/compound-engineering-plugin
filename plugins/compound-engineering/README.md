# Compounding Engineering Plugin

**Make each unit of engineering work easier than the last.**

AI-powered development tools that get smarter with every use. Transform feature ideas into production code through systematic planning, execution, review, and knowledge capture workflows.

## Components

| Component | Count |
|-----------|-------|
| Agents | 17 |
| Commands | 9 |
| Skills | 6 |
| MCP Servers | 3 |

## Installation

```bash
claude /plugin install compound-engineering
```

**📖 [Read the Complete Workflow Guide](../../FLOW.md)** - Comprehensive visual guide with workflow diagrams, parallel execution patterns, and advanced usage.

---

## Quick Start: Your First Feature in 5 Steps

Get productive with the plugin in under 10 minutes. Here's the complete workflow from idea to documented solution:

### 1. Plan a Feature

```bash
claude /workflows:plan "Add OAuth login"
```

**What happens:**
- Spawns 3 parallel research agents:
  - `repo-research-analyst` - Finds similar code in your repo
  - `best-practices-researcher` - Gathers industry best practices
  - `framework-docs-researcher` - Researches framework-specific patterns
- Creates `.claude/plans/add-oauth-login.md` with structured implementation plan

**Output:** 200-line plan with problem statement, solution approach, file references, and acceptance criteria.

---

### 2. Deepen the Plan (Optional but Recommended)

```bash
claude /deepen-plan .claude/plans/add-oauth-login.md
```

**What happens:**
- Spawns 40+ parallel research agents for comprehensive enhancement
- Adds security considerations (PKCE flow, token storage)
- Adds performance tips (caching, rate limits)
- Adds code examples from similar projects
- Adds edge cases (expired tokens, network failures)

**Result:** Plan grows from 200 → 400 lines with actionable implementation details.

**When to use:** Complex features (OAuth, payments, migrations). Skip for simple bug fixes.

---

### 3. Review the Plan (Optional Validation)

```bash
claude /plan_review .claude/plans/add-oauth-login.md
```

**What happens:**
- Multi-agent validation (5-10 reviewers)
- Checks architectural consistency
- Identifies security vulnerabilities
- Finds performance bottlenecks
- Suggests simplicity improvements

**When to use:** Before implementing large features or when uncertain about approach.

---

### 4. Execute the Work

```bash
claude /workflows:work .claude/plans/add-oauth-login.md
```

**What happens:**
- Creates feature branch
- Breaks plan into tasks (tracked with TodoWrite)
- Implements following similar code patterns from plan
- Writes tests continuously
- Runs linting and quality checks
- Commits incrementally
- Creates PR (with screenshots for UI changes)

**Time:** 30-60 minutes for typical feature.

---

### 5. Document the Solution

```bash
claude /workflows:compound
```

**What happens:**
- Analyzes conversation for key learnings
- Extracts error messages, root causes, solutions
- Creates prevention guidance
- Writes to `.claude/solutions/[category]/[problem-description].md`

**Why document:**
- Future planning auto-discovers these learnings
- `/deepen-plan` injects relevant solutions into new plans
- Team knowledge compounds over time

---

## Core Workflow Commands

### /workflows:plan - Create Implementation Plans

**What it does:** Transforms feature descriptions into structured markdown plans following project conventions. Spawns 3 parallel research agents to ground plans in your repository's existing patterns.

**When to use:**
- Starting a new feature
- Planning a bug fix approach
- Documenting a refactor strategy
- Proposing architectural changes

**Usage:**
```bash
claude /workflows:plan "Add Google OAuth login with PKCE flow"
```

**What it produces:**
`.claude/plans/add-google-oauth-login.md` containing:
- **Problem statement** - Clear description of what needs to be built
- **Proposed solution** - High-level approach with technology choices
- **Technical approach** - Step-by-step implementation details
- **File references** - Links to similar code (e.g., `app/auth/github_oauth.rb:15`)
- **External resources** - Best practices articles, framework docs
- **Acceptance criteria** - Testable requirements

**Next steps:**
1. **(Optional)** Run `/deepen-plan` to enhance with 40+ research agents
2. **(Optional)** Run `/plan_review` for multi-agent validation
3. Run `/workflows:work` to implement the plan

**Tip:** Be specific in your description. Instead of "Add OAuth", say "Add Google OAuth with PKCE flow and refresh tokens" to get better research results.

---

### /workflows:work - Execute Plans or Todos

**What it does:** Systematically implements plans or todos by following existing code patterns, writing tests continuously, and committing incrementally. Can work on either planning artifacts (`.claude/plans/*.md`) or review todos (`.claude/todos/*.md`).

**When to use:**
- After creating a plan with `/workflows:plan`
- To fix issues from `/workflows:review` (work on approved todos)
- To implement any structured markdown work item

**Usage:**
```bash
# Execute a plan
claude /workflows:work .claude/plans/add-oauth-login.md

# Fix a specific todo from code review
claude /workflows:work .claude/todos/001-ready-p1-csrf-token-missing.md
```

**What it does:**
1. Reads the plan/todo and asks clarifying questions
2. Creates feature branch (or works in current branch)
3. Breaks work into tasks (shown in TodoWrite progress tracker)
4. Implements following similar code patterns referenced in plan
5. Writes tests as it goes (not after)
6. Runs linting and quality checks
7. Commits incrementally with descriptive messages
8. Creates PR with summary (includes screenshots for UI changes)

**Next steps:**
1. Create PR from the feature branch
2. Run `/workflows:review` on the PR for comprehensive code review
3. Run `/triage` to prioritize review findings
4. Work on critical issues, then re-review

**Tip:** Let the plan guide you. The plan contains references to similar code - reading those patterns ensures consistency with your codebase.

---

### /workflows:review - Comprehensive Code Review

**What it does:** Spawns 9-11 parallel review agents to comprehensively analyze code changes. Creates structured todos in `.claude/todos/` with priority levels (P1/P2/P3) and detailed fix guidance.

**When to use:**
- After creating a PR (review before merging)
- After fixing issues (verify fixes worked)
- For architectural review of major changes

**Usage:**
```bash
claude /workflows:review 123        # Review PR #123
claude /workflows:review PR-123     # Also works with PR- prefix
```

**What happens:**
- Spawns 9-11 parallel review agents:
  - **Always run (9 agents):**
    - `senior-code-reviewer` - General code quality
    - `security-sentinel` - Security vulnerabilities
    - `performance-oracle` - Performance issues
    - `architecture-strategist` - Design consistency
    - `pattern-recognition-specialist` - Code patterns
    - `data-integrity-guardian` - Database safety
    - `git-history-analyzer` - Historical context
    - `framework-conventions-reviewer` - Framework compliance
    - `kieran-typescript-reviewer` - TypeScript quality
  - **Conditional (spawned when needed):**
    - `data-migration-expert` - For database migrations
    - `deployment-verification-agent` - For risky data changes
    - `test-coverage-analyzer` - For test changes
    - `code-simplicity-reviewer` - Final simplicity pass

**Output:** Creates todos in `.claude/todos/`:
```
001-pending-p1-csrf-token-missing.md      (CRITICAL - blocks merge)
002-pending-p2-add-rate-limiting.md       (IMPORTANT - should fix)
003-pending-p3-extract-oauth-module.md    (NICE-TO-HAVE - optional)
```

**File naming:** `{id}-{status}-{priority}-{description}.md`
- Status: `pending` (needs triage) → `ready` (approved) → `complete` (done)
- Priority: `p1` (critical), `p2` (important), `p3` (nice-to-have)

**Next steps:**
1. Run `/triage` to review and approve/skip each finding
2. Work on `ready` todos with `/workflows:work`
3. Re-run `/workflows:review` to verify fixes

**Tip:** P1 findings should block merge. P2 findings should be addressed. P3 findings are optional improvements.

---

### /workflows:compound - Document Solved Problems

**What it does:** Analyzes the current conversation to extract solved problems and creates permanent documentation in `.claude/solutions/`. Future planning automatically discovers and applies these learnings.

**When to use:**
- After solving any non-trivial problem
- When you've discovered a tricky bug fix
- After implementing a complex feature successfully
- When you want to prevent repeating mistakes

**Usage:**
```bash
claude /workflows:compound
```

**What it captures:**
- Exact error messages and symptoms
- Investigation attempts (what didn't work)
- Root cause analysis
- Solution with code examples
- Prevention guidance for future

**Output:** `.claude/solutions/[category]/[problem-description]-[YYYYMMDD].md`

Example:
```
.claude/solutions/authentication-issues/oauth-pkce-implementation-20260111.md
```

**Why this matters:**
1. **Knowledge compounds:** Future `/deepen-plan` runs auto-discover these solutions
2. **Prevents repeats:** Team won't make the same mistake twice
3. **Searchable:** Use `grep -r "error message" .claude/solutions/`
4. **Version controlled:** Part of your repo's permanent knowledge

**Tip:** Document the non-obvious. Typo fixes don't need docs, but tricky OAuth token refresh logic does.

---

## Utility Commands

### /triage - Prioritize Todos Interactively

**What it does:** Presents each todo (from `/workflows:review` or elsewhere) one-by-one for approval. Approved todos change status from `pending` to `ready`, making them actionable for `/workflows:work`.

**When to use:**
- Immediately after `/workflows:review` to prioritize findings
- To review and categorize any findings list
- To decide which issues to work on first

**Usage:**
```bash
claude /triage
```

**Workflow:**
1. Reads all `pending` todos from `.claude/todos/`
2. Presents each finding with:
   - Severity (🔴 P1 Critical / 🟡 P2 Important / 🔵 P3 Nice-to-have)
   - Category (Security/Performance/Architecture/etc.)
   - Problem description
   - Location (`file_path:line_number`)
   - Proposed solution
   - Estimated effort
3. Asks user to decide:
   - **yes** - Approve (renames `pending → ready`, ready to work on)
   - **next** - Skip (deletes the todo)
   - **custom** - Modify priority/description before approving

**Output:**
- Approved todos renamed: `001-ready-p1-csrf-token.md`
- Skipped todos deleted
- Customized todos updated and renamed to `ready`

**Next steps:**
Work on ready todos with `/workflows:work .claude/todos/001-ready-p1-*.md`

**Tip:** Triage immediately after review. Don't let `.claude/todos/` accumulate untr

iaged findings.

---

### /deepen-plan - Enhance Plans with Research

**What it does:** Takes an existing plan and enhances it by spawning 40+ parallel research agents. Each agent adds specific expertise: security patterns, performance tips, framework conventions, edge cases, code examples, and auto-discovered solutions from `.claude/solutions/`.

**When to use:**
- For complex features (OAuth, payments, data migrations)
- When you need comprehensive best practices
- Before implementing unfamiliar patterns
- Skip for simple bug fixes or trivial features

**Usage:**
```bash
claude /deepen-plan .claude/plans/add-oauth-login.md
```

**What happens:**
- Spawns 40+ parallel agents including:
  - **All skills** (test-patterns, refactoring-patterns, framework-conventions-guide, etc.)
  - **Learning discovery** (searches `.claude/solutions/` for related problems)
  - **Review agents** (for pre-implementation validation)
  - **Framework experts** (for framework-specific patterns)
- Plan grows from 200 → 400+ lines with:
  - Security considerations (PKCE requirements, token storage patterns)
  - Performance tips (caching strategies, rate limiting)
  - Edge cases (expired tokens, revoked access, network failures)
  - Code examples from similar projects
  - Prevention guidance from past solutions

**Time:** ~2-5 minutes (all agents run in parallel)

**Next steps:**
1. Review enhanced plan
2. Run `/plan_review` for validation (optional)
3. Run `/workflows:work` to implement

**Tip:** First run scans all plugins (~10 seconds for skill discovery). Subsequent runs are cached and fast.

---

### /plan_review - Validate Plan Quality

**What it does:** Multi-agent plan validation before implementation. Spawns 5-10 review agents to check architectural consistency, security, performance, and simplicity opportunities.

**When to use:**
- Before implementing large features
- When uncertain about architectural approach
- To catch issues before writing code
- After `/deepen-plan` for comprehensive validation

**Usage:**
```bash
claude /plan_review .claude/plans/add-oauth-login.md
```

**Review agents check for:**
- Architectural consistency with existing patterns
- Security vulnerabilities in proposed approach
- Performance bottlenecks
- Over-engineering or complexity issues
- Missing edge cases

**Output:**
- Inline feedback in conversation
- Suggestions for plan improvements
- Warnings about potential issues

**Next steps:**
1. Address any critical concerns
2. Update plan if needed
3. Run `/workflows:work` to implement

**Tip:** Use this when you want a second opinion before committing to an approach.

---

### /generate-tests - Create Test Files

**What it does:** Generates comprehensive test files following your project's testing conventions. Uses the `test-patterns` skill to match your existing test structure, naming, and assertion styles.

**When to use:**
- When adding tests for new features
- To achieve better test coverage
- After fixing bugs (add regression tests)

**Usage:**
```bash
claude /generate-tests src/auth/oauth.ts
claude /generate-tests "OAuth login flow"
```

**What it produces:**
- Unit tests following project conventions
- Integration tests where appropriate
- Mock/fixture data
- Edge case tests

**Patterns it follows:**
- Your project's test file naming (e.g., `*.test.ts` vs `*_spec.rb`)
- Your assertion library (Jest, RSpec, pytest, etc.)
- Your test organization (AAA pattern, describe/it blocks)
- Your mocking patterns

**Next steps:**
Run tests to verify they pass

**Tip:** The command learns from your existing tests, so it naturally matches your project's style.

---

### /debug - Systematic Error Analysis

**What it does:** 5-phase systematic debugging workflow that analyzes errors, categorizes them, finds root causes, generates fix recommendations, and creates actionable todos.

**When to use:**
- When stuck on a tricky bug
- For systematic error investigation
- To get fix recommendations for errors
- When you need root cause analysis

**Usage:**
```bash
claude /debug "TypeError: Cannot read property 'id' of undefined"
claude /debug  # Will ask for error details
```

**5-Phase Analysis:**
1. **Parse Error Information**
   - Extracts error type, message, stack trace
   - Identifies error location

2. **Categorize Error Type**
   - TypeError, ReferenceError, logic error, etc.
   - Determines severity and impact

3. **Root Cause Analysis**
   - Traces error through call stack
   - Identifies why the error occurs
   - Finds related code patterns

4. **Generate Fix Recommendations**
   - Suggests multiple solution approaches
   - Provides code examples
   - Estimates implementation effort

5. **Create Action Items**
   - Creates structured todos for fixes
   - Includes verification steps
   - Suggests tests to prevent regression

**Output:**
- Detailed error analysis
- Root cause explanation
- Fix recommendations with code examples
- Optional: todos in `.claude/todos/` if requested

**Tip:** Include full error messages and stack traces for best results.

---

## Complete Workflow Example: Adding OAuth Login

This end-to-end example shows the full workflow from idea to merged PR, with timing and exact command sequences.

### Step 1: Planning (5 minutes)

```bash
claude /workflows:plan "Add Google OAuth login"
```

**Output:** `.claude/plans/add-google-oauth-login.md` (200 lines)

**What the plan includes:**
```markdown
## Problem Statement
Users need to authenticate with Google accounts for single sign-on

## Proposed Solution
OAuth 2.0 flow with PKCE for enhanced security

## Technical Approach
Similar to GitHub OAuth in `app/auth/github_oauth.rb:15`
- Use omniauth-google-oauth2 gem (Rails convention)
- Store tokens encrypted in database
- Handle token refresh automatically

## Acceptance Criteria
- Users can login with Google
- Users can logout
- Profile syncs (email, name, avatar)
- Token refresh works silently
```

---

### Step 2: Deepening (10 minutes, optional for complex features)

```bash
claude /deepen-plan .claude/plans/add-google-oauth-login.md
```

**What happens:**
- Spawns 40+ parallel agents
- Each agent contributes specialized knowledge

**Enhanced sections added:**
```markdown
## Security Considerations (from security-sentinel agent)
- Use PKCE flow (RFC 7636) to prevent authorization code interception
- Store refresh tokens encrypted at rest using Rails encrypted attributes
- Implement CSRF protection with state parameter
- Set httpOnly cookies for session management

## Performance Considerations (from performance-oracle agent)
- Cache user profile data (TTL: 1 hour)
- Implement exponential backoff for token refresh failures
- Rate limit: 100 OAuth attempts per IP per hour

## Edge Cases (from research agents)
- Handle expired tokens gracefully
- Handle revoked access (user removes app permissions)
- Handle network failures during OAuth callback
- Handle race conditions with simultaneous logins

## Code Examples (from repo-research and best-practices agents)
[Links to omniauth gem examples, PKCE flow implementations]
```

**Result:** Plan grows from 200 → 400 lines with comprehensive implementation details

---

### Step 3: Validation (3 minutes, optional)

```bash
claude /plan_review .claude/plans/add-google-oauth-login.md
```

**Review agents check:**
- ✅ Architecture matches existing auth patterns
- ✅ Security: PKCE flow is correct
- ⚠️  Performance: Suggested adding Redis caching for tokens
- ✅ Simplicity: No over-engineering detected

**Feedback incorporated into plan**

---

### Step 4: Implementation (30-60 minutes)

```bash
claude /workflows:work .claude/plans/add-google-oauth-login.md
```

**Execution:**
```
Creating branch: feature/google-oauth-login
Reading plan and understanding requirements...

TodoWrite Progress:
1. Install omniauth-google-oauth2 gem - in_progress
2. Add Google OAuth credentials to environment - pending
3. Create OauthController following GithubOauthController pattern - pending
4. Add encrypted token storage to User model - pending
5. Implement token refresh logic - pending
6. Add login/logout routes - pending
7. Write integration tests - pending
8. Update UI with Google login button - pending
```

**As work progresses:**
- Implements following `app/auth/github_oauth.rb` patterns
- Writes tests continuously (not after)
- Runs `rubocop` after each file
- Commits incrementally:
  ```
  feat: add omniauth-google-oauth2 gem
  feat: add Google OAuth controller following GitHub OAuth pattern
  feat: add encrypted token storage to User model
  test: add OAuth integration tests
  feat: add Google login button to auth page
  ```

**Final step:**
Creates PR with description:
```markdown
## Summary
Adds Google OAuth login with PKCE flow following existing GitHub OAuth patterns

## Implementation
- OAuth controller: app/controllers/oauth/google_controller.rb
- Token storage: encrypted refresh_token in users table
- Tests: 15 new integration tests (100% coverage)

## Screenshots
[Screenshot of Google login button]
[Screenshot of profile sync]

## References
Similar to GitHub OAuth (#234)
Plan: .claude/plans/add-google-oauth-login.md
```

---

### Step 5: Code Review (15 minutes)

```bash
claude /workflows:review 123
```

**Review agents spawn in parallel:**
```
Spawning 11 review agents...
✓ senior-code-reviewer
✓ security-sentinel
✓ performance-oracle
✓ architecture-strategist
✓ pattern-recognition-specialist
✓ data-integrity-guardian
✓ git-history-analyzer
✓ framework-conventions-reviewer
✓ kieran-typescript-reviewer (skipped - no TypeScript changes)
✓ data-migration-expert (spawned - detected migration)
✓ code-simplicity-reviewer

Creating findings in .claude/todos/...
```

**Findings created:**
```
.claude/todos/001-pending-p1-csrf-token-missing.md
.claude/todos/002-pending-p2-add-rate-limiting.md
.claude/todos/003-pending-p2-cache-with-redis.md
.claude/todos/004-pending-p3-extract-oauth-base-class.md
```

**Sample finding (`001-pending-p1-csrf-token-missing.md`):**
```yaml
---
status: pending
priority: p1
issue_id: "001"
tags: [security, csrf]
---

# Missing CSRF Token Validation

## Problem
OAuth callback doesn't validate state parameter, vulnerable to CSRF attacks.

## Location
app/controllers/oauth/google_controller.rb:24

## Solution
Add state parameter validation:
```ruby
def callback
  # Validate state parameter
  unless params[:state] == session[:oauth_state]
    raise SecurityError, "Invalid OAuth state"
  end

  # Rest of callback logic...
end
```

## Effort
Small (< 30 minutes)
```

---

### Step 6: Triage (5 minutes)

```bash
claude /triage
```

**Interactive review:**
```
═══════════════════════════════════════════════
Issue #1: Missing CSRF Token Validation

Severity: 🔴 P1 (CRITICAL)
Category: Security
Location: app/controllers/oauth/google_controller.rb:24

Description:
OAuth callback doesn't validate state parameter, vulnerable to CSRF attacks

Solution:
Add state parameter validation

Effort: Small (< 30 minutes)
═══════════════════════════════════════════════
Do you want to add this to the todo list?
1. yes - create todo file
2. next - skip this item
3. custom - modify before creating

User: yes
```

**Result:** `001-ready-p1-csrf-token-missing.md` (status changed to `ready`)

```
═══════════════════════════════════════════════
Issue #2: Add Rate Limiting

Severity: 🟡 P2 (IMPORTANT)
...

User: yes
```

**Result:** `002-ready-p2-add-rate-limiting.md`

```
═══════════════════════════════════════════════
Issue #3: Cache with Redis

Severity: 🟡 P2 (IMPORTANT)
...

User: yes
```

**Result:** `003-ready-p2-cache-with-redis.md`

```
═══════════════════════════════════════════════
Issue #4: Extract OAuth Base Class

Severity: 🔵 P3 (NICE-TO-HAVE)
...

User: next  # Skip - not essential
```

**Result:** `004-pending-p3-extract-oauth-base-class.md` deleted

---

### Step 7: Fix Issues (20 minutes)

```bash
# Fix P1 first (critical, blocks merge)
claude /workflows:work .claude/todos/001-ready-p1-csrf-token-missing.md
```

**Work proceeds:**
```
Reading todo: CSRF token validation
Implementing fix following todo guidance...
✓ Added state parameter validation
✓ Added tests for CSRF protection
✓ Committed: fix(oauth): add CSRF state parameter validation
```

**File renamed:** `001-complete-p1-csrf-token-missing.md` (status: complete)

```bash
# Fix P2 issues
claude /workflows:work .claude/todos/002-ready-p2-add-rate-limiting.md
```

**After all fixes:** Re-review to verify

```bash
claude /workflows:review 123
```

**Result:** All critical issues resolved ✓

---

### Step 8: Document Solution (2 minutes)

```bash
claude /workflows:compound
```

**Analysis:**
```
Analyzing conversation for solved problems...
Found: OAuth PKCE implementation with CSRF protection
Category: authentication-issues
```

**Output:** `.claude/solutions/authentication-issues/oauth-pkce-implementation-20260111.md`

```yaml
---
title: OAuth PKCE Flow with CSRF Protection
category: authentication-issues
tags: [oauth, pkce, security, csrf]
date: 2026-01-11
---

# OAuth PKCE Flow with CSRF Protection

## Problem
Needed to implement Google OAuth login securely following best practices

## Investigation
- Researched PKCE flow (RFC 7636)
- Analyzed existing GitHub OAuth implementation
- Identified CSRF vulnerability in initial implementation

## Root Cause
Missing state parameter validation in OAuth callback allowed CSRF attacks

## Solution
```ruby
# Generate state in authorization request
session[:oauth_state] = SecureRandom.hex(32)

# Validate state in callback
unless params[:state] == session[:oauth_state]
  raise SecurityError, "Invalid OAuth state"
end
```

## Prevention
- Always validate state parameter in OAuth callbacks
- Use cryptographically secure random values
- Clear state after validation

## References
- RFC 7636 (PKCE): https://tools.ietf.org/html/rfc7636
- Plan: .claude/plans/add-google-oauth-login.md
- PR: #123
```

**Why this matters:**
Future `/deepen-plan` runs will auto-discover this solution when planning similar OAuth implementations.

---

### Step 9: Merge and Close (2 minutes)

```bash
git checkout main
git merge feature/google-oauth-login
git push origin main
```

**Total time:** ~90 minutes from idea to production-ready, documented code

---

## Understanding .claude/ File Structure

All plugin artifacts are organized in `.claude/` following consistent naming conventions:

```
.claude/
├── plans/                           # From /workflows:plan
│   ├── add-oauth-login.md
│   ├── fix-n-plus-one-query.md
│   └── refactor-auth-module.md
│
├── solutions/                       # From /workflows:compound
│   ├── authentication-issues/
│   │   ├── oauth-pkce-implementation-20260111.md
│   │   └── session-fixation-fix-20260108.md
│   ├── performance-issues/
│   │   ├── n-plus-one-briefs-20260110.md
│   │   └── slow-dashboard-query-20260105.md
│   └── patterns/
│       └── common-patterns.md
│
├── todos/                           # From /workflows:review, /triage
│   ├── 001-ready-p1-csrf-token.md      # Approved (ready to work on)
│   ├── 002-pending-p2-rate-limit.md    # Needs triage
│   └── 003-complete-p1-sql.md          # Completed
│
└── settings.json                    # MCP server configuration
```

### File Naming Conventions

**Plans:**
```
[feature-description].md
```
Examples:
- `add-oauth-login.md`
- `fix-n-plus-one-queries.md`
- `refactor-authentication-module.md`

**Solutions:**
```
[problem-description]-[YYYYMMDD].md
```
Examples:
- `oauth-pkce-implementation-20260111.md`
- `n-plus-one-briefs-20260110.md`
- `session-fixation-fix-20260108.md`

**Todos:**
```
{id}-{status}-{priority}-{description}.md
```
Components:
- `id`: Sequential number (001, 002, 003...)
- `status`: `pending` | `ready` | `complete`
- `priority`: `p1` (critical) | `p2` (important) | `p3` (nice-to-have)
- `description`: Brief kebab-case description

Examples:
- `001-pending-p1-csrf-token-missing.md` - Needs triage
- `042-ready-p2-add-rate-limiting.md` - Approved, ready to work on
- `015-complete-p1-sql-injection-fix.md` - Done

### Status Transitions

Todos flow through statuses:
```
pending → ready → complete
   ↓        ↓
deleted  deleted
(skipped)
```

- **pending** - Created by `/workflows:review`, needs triage
- **ready** - Approved in `/triage`, ready for `/workflows:work`
- **complete** - Fixed and verified
- **deleted** - Skipped in `/triage`

---

## How Commands Work Together

Commands integrate through shared file artifacts and data flows:

### Planning → Execution Flow

```
/workflows:plan
    ↓
.claude/plans/feature.md
    ↓
/deepen-plan (optional - adds 40+ agents of research)
    ↓
.claude/plans/feature.md (enhanced)
    ↓
/plan_review (optional - multi-agent validation)
    ↓
feedback + improvements
    ↓
/workflows:work
    ↓
implementation + tests + commits + PR
```

### Review → Triage → Work Flow

```
/workflows:review PR-123
    ↓
.claude/todos/*.md (status: pending)
    ↓
/triage (interactive approval)
    ↓
.claude/todos/*-ready-*.md (status: ready)
    ↓
/workflows:work .claude/todos/001-ready-p1-*.md
    ↓
fixes + tests + commits
    ↓
.claude/todos/*-complete-*.md (status: complete)
    ↓
/workflows:review PR-123 (verify fixes)
```

### Work → Documentation → Reuse Flow

```
/workflows:work
    ↓
implemented solution
    ↓
/workflows:compound
    ↓
.claude/solutions/category/problem-solution.md
    ↓
(future) /deepen-plan
    ↓
auto-discovers and injects past solutions into new plans
```

### Command Integration Table

| Command | Reads From | Writes To | Spawns Agents | Next Command |
|---------|------------|-----------|---------------|--------------|
| `/workflows:plan` | User description | `.claude/plans/*.md` | 3 research agents | `/deepen-plan` or `/plan_review` or `/workflows:work` |
| `/deepen-plan` | `.claude/plans/*.md`, `.claude/solutions/` | `.claude/plans/*.md` (enhanced) | 40+ research agents | `/plan_review` or `/workflows:work` |
| `/plan_review` | `.claude/plans/*.md` | Conversation feedback | 5-10 review agents | `/workflows:work` |
| `/workflows:work` | `.claude/plans/*.md` or `.claude/todos/*.md` | Code + tests + commits | 0-5 conditional agents | `/workflows:review` (after PR) |
| `/workflows:review` | PR changes | `.claude/todos/*.md` (pending) | 9-11 review agents | `/triage` |
| `/triage` | `.claude/todos/*-pending-*.md` | `.claude/todos/*-ready-*.md` | None (interactive) | `/workflows:work` (on ready todos) |
| `/workflows:compound` | Conversation | `.claude/solutions/**/*.md` | Compound-docs skill | (reused by `/deepen-plan`) |
| `/generate-tests` | Code files | Test files | None | Run tests |
| `/debug` | Error messages | Analysis + recommendations | Error-analysis skill | Fix code |

---

## Agents Reference

Agents run automatically in commands or can be invoked manually with the Task tool.

### Research Agents (4)

Automatically spawned by `/workflows:plan` and `/deepen-plan`.

| Agent | Description | When They Run |
|-------|-------------|---------------|
| `repo-research-analyst` | Analyzes repository structure, existing patterns, and conventions | Every `/workflows:plan`, `/deepen-plan` |
| `best-practices-researcher` | Gathers external best practices, industry standards, security guidelines | Every `/workflows:plan`, `/deepen-plan` |
| `framework-docs-researcher` | Researches framework-specific documentation and patterns (Rails/Django/React/etc.) | Every `/workflows:plan`, `/deepen-plan` |
| `git-history-analyzer` | Analyzes git history, code evolution, and related PRs | `/workflows:plan` when historical context needed |

**Manual invocation:**
```bash
# In Claude conversation:
Task repo-research-analyst: "Find similar authentication code in the repository"
Task best-practices-researcher: "Research OAuth 2.0 PKCE flow best practices"
```

---

### Review Agents (11)

Automatically spawned by `/workflows:review` (9 always, 2 conditional).

| Agent | Description | When They Run |
|-------|-------------|---------------|
| `senior-code-reviewer` | High-bar code quality review with strict standards | Every `/workflows:review` |
| `security-sentinel` | Security audits, vulnerability assessments, OWASP compliance | Every `/workflows:review` |
| `performance-oracle` | Performance analysis, N+1 queries, memory leaks, slow algorithms | Every `/workflows:review` |
| `architecture-strategist` | Architectural consistency, design patterns, module boundaries | Every `/workflows:review` |
| `pattern-recognition-specialist` | Code patterns, anti-patterns, duplication detection | Every `/workflows:review` |
| `data-integrity-guardian` | Database safety, migration validation, data consistency | Every `/workflows:review` |
| `framework-conventions-reviewer` | Framework-specific conventions (any framework) | Every `/workflows:review` |
| `kieran-typescript-reviewer` | TypeScript quality, type safety, strict conventions | `/workflows:review` when TypeScript changes detected |
| `code-simplicity-reviewer` | Simplicity and minimalism review, complexity reduction | Every `/workflows:review` (final pass) |
| `data-migration-expert` | Production data migration validation, ID mapping checks | `/workflows:review` when migrations detected |
| `deployment-verification-agent` | Go/No-Go deployment checklists for risky changes | `/workflows:review` when risky data changes detected |

**Manual invocation:**
```bash
# Review specific code
Task senior-code-reviewer: "Review changes in app/auth/oauth.rb"
Task security-sentinel: "Audit authentication code for vulnerabilities"
Task performance-oracle: "Check query performance in UserDashboard"

# Parallel review (recommended)
Task senior-code-reviewer: "Review PR #123"
Task security-sentinel: "Audit PR #123"
Task performance-oracle: "Check performance in PR #123"
```

---

### Testing Agents (1)

| Agent | Description | When They Run |
|-------|-------------|---------------|
| `test-coverage-analyzer` | Analyzes test coverage gaps and suggests missing tests | `/workflows:review` when test changes detected, or manual invocation |

**Manual invocation:**
```bash
Task test-coverage-analyzer: "Analyze coverage for auth module"
```

---

### Workflow Agents (1)

| Agent | Description | When They Run |
|-------|-------------|---------------|
| `spec-flow-analyzer` | Analyzes user flows, identifies specification gaps, validates acceptance criteria | `/workflows:plan` for flow-based features |

**Manual invocation:**
```bash
Task spec-flow-analyzer: "Analyze OAuth login user flow"
```

---

## Skills Reference

Skills provide reusable workflows and knowledge patterns.

### compound-docs

**Description:** Captures solved problems as categorized documentation in `.claude/solutions/` for future reuse and team knowledge building.

**When to use:** After solving any non-trivial problem (tricky debugging, complex implementation, non-obvious solution).

**Usage:**
```bash
claude /workflows:compound
```

**What it captures:**
- Exact error messages and symptoms
- Investigation attempts (what didn't work)
- Root cause analysis
- Solution with code examples
- Prevention guidance for future

**Output format:**
```yaml
---
title: Problem description
category: authentication-issues | performance-issues | patterns | etc.
tags: [tag1, tag2]
date: YYYY-MM-DD
---

# Problem Title

## Problem
What went wrong

## Investigation
What we tried

## Root Cause
Why it happened

## Solution
How we fixed it (with code)

## Prevention
How to avoid this in future
```

**Output location:** `.claude/solutions/[category]/[problem-description]-[YYYYMMDD].md`

**Why this matters:**
- Future `/deepen-plan` runs auto-discover these solutions
- Prevents repeating mistakes
- Builds permanent team knowledge
- Searchable: `grep -r "error message" .claude/solutions/`

---

### file-todos

**Description:** File-based todo tracking system with YAML frontmatter for structured, version-controlled task management.

**When to use:** Automatically used by `/workflows:review` and `/triage`. Can be used manually for any structured task tracking.

**File structure:**
```yaml
---
status: ready        # pending | ready | complete
priority: p1         # p1 (critical) | p2 (important) | p3 (nice-to-have)
issue_id: "042"
tags: [security, authentication]
category: bug
---

# [Issue Title]

## Problem Statement
Detailed description of the issue

## Location
file_path:line_number

## Proposed Solution
How to fix it

## Verification
How to test the fix
```

**Workflow:**
1. `/workflows:review` creates todos with `status: pending`
2. `/triage` presents each todo, user approves/skips
3. Approved todos renamed to `status: ready`
4. `/workflows:work` implements ready todos
5. After completion, renamed to `status: complete`

**File naming:** `{id}-{status}-{priority}-{description}.md`
- Example: `042-ready-p1-transaction-boundaries.md`

---

### error-analysis

**Description:** Systematic error analysis methodology with root cause identification and fix recommendations.

**When to use:** Used automatically by `/debug` command. Provides structured approach to debugging.

**What it provides:**
- 5-phase error analysis workflow:
  1. Parse error information
  2. Categorize error type
  3. Root cause analysis
  4. Generate fix recommendations
  5. Create action items

**Usage:** Invoked automatically by `/debug` command

```bash
claude /debug "TypeError: Cannot read property 'id' of undefined"
```

---

### framework-conventions-guide

**Description:** Framework-agnostic quality standards and conventions checker. Adapts to any framework (Rails, Django, React, Vue, etc.).

**When to use:** Used automatically by `/workflows:plan` and review agents. Ensures code follows framework best practices.

**What it checks:**
- Framework-specific naming conventions
- File organization patterns
- Testing conventions
- Security patterns
- Performance patterns

**Supported frameworks:** Detects and adapts to Rails, Django, Flask, React, Vue, Angular, Next.js, Nuxt, Laravel, and more.

---

### refactoring-patterns

**Description:** Safe, systematic refactoring methodology with validation steps.

**When to use:** When planning or executing refactors. Ensures changes preserve behavior while improving structure.

**What it provides:**
- Extract Method pattern
- Extract Class pattern
- Rename Method/Class pattern
- Move Method pattern
- Replace Conditional with Polymorphism
- Each pattern includes:
  - When to use
  - Step-by-step execution
  - Validation steps (tests must pass)

**Usage:** Referenced during `/workflows:work` when refactoring code.

---

### test-patterns

**Description:** Test patterns for unit, integration, and API testing following project conventions.

**When to use:** Used automatically by `/generate-tests`. Provides structured testing approach.

**What it provides:**
- Unit test patterns (AAA: Arrange-Act-Assert)
- Integration test patterns
- API test patterns
- Mocking strategies
- Edge case identification
- Test naming conventions

**Usage:** Invoked automatically by `/generate-tests`

```bash
claude /generate-tests src/auth/oauth.ts
```

---

## MCP Servers

MCP (Model Context Protocol) servers provide external integrations and tools.

| Server | Description | Used By | Auto-Start |
|--------|-------------|---------|------------|
| `playwright` | Browser automation for testing and screenshots | `/workflows:work` (UI PRs) | Yes |
| `context7` | Framework documentation lookup (100+ frameworks) | `/deepen-plan`, `/workflows:plan` | Yes |
| `tldr` | Semantic code search and architecture analysis | `/deepen-plan` (pattern discovery) | Yes |

### Playwright

**Tools provided:**
- `browser_navigate` - Navigate to URLs
- `browser_take_screenshot` - Capture screenshots
- `browser_click` - Click elements
- `browser_fill_form` - Fill form fields
- `browser_snapshot` - Get accessibility tree
- `browser_evaluate` - Execute JavaScript

**Used by:**
- `/workflows:work` automatically captures screenshots for UI changes
- Manual browser testing and automation

**Setup:** Auto-starts with plugin. Uses `npx @playwright/mcp@latest`

---

### Context7

**Tools provided:**
- `resolve-library-id` - Find library ID for a framework/package
- `get-library-docs` - Get documentation for a specific library

**Supported frameworks:** Rails, React, Next.js, Vue, Django, Laravel, Flask, Express, NestJS, and 90+ more

**Used by:**
- `/deepen-plan` fetches framework-specific patterns
- `/workflows:plan` researches framework conventions
- Review agents check framework compliance

**Setup:** Auto-starts with plugin. HTTP connection to `https://mcp.context7.com/mcp`

---

### tldr (llm-tldr)

**Capabilities:**
- **Semantic search** - Find code using natural language queries
- **Structure extraction** - AST, call graphs, control flow, data flow
- **Token efficiency** - 99% reduction for function context (21,000 → 175 tokens)
- **Architecture analysis** - Detect patterns (MVC, layered, hexagonal)
- **Impact analysis** - Find all code affected by changes

**Languages:** Python, TypeScript, JavaScript, Go, Rust, Java, C, C++, Ruby, PHP, C#, Kotlin, Scala, Swift, Lua, Elixir

**Used by:**
- `/deepen-plan` discovers similar code patterns via semantic search
- Helps find existing implementations for reference

**Requirements:**
- Python 3.7+
- `pip install llm-tldr`

**Setup:** MCP server auto-starts, but you must install llm-tldr first:
```bash
pip install llm-tldr
```

---

## Key Principles

### 1. Compounding Engineering

**Each unit of work makes subsequent work easier.**

How this works:
- **Documentation:** `/workflows:compound` captures solved problems in `.claude/solutions/`
- **Reuse:** `/deepen-plan` auto-discovers past solutions and injects them into new plans
- **Patterns:** Commands follow existing repo conventions discovered by research agents
- **Learning:** Team knowledge grows permanently, reducing time for similar future work

**Example:** After documenting an OAuth PKCE implementation, future OAuth features automatically benefit from that knowledge.

---

### 2. Separation of Concerns

**Each command has one clear job. Commands compose into workflows.**

- **Planning ≠ Execution ≠ Review**
  - `/workflows:plan` creates plans, doesn't implement
  - `/workflows:work` implements, doesn't review
  - `/workflows:review` reviews, doesn't fix

- **Plan todos ≠ Review todos**
  - `.claude/todos/plan/` - Implementation tasks from planning (not used in v3.0)
  - `.claude/todos/` - Issues found in code review
  - Never mix the two - they serve different purposes

- **Single Responsibility**
  - `/triage` only prioritizes, doesn't fix
  - `/workflows:compound` only documents, doesn't implement
  - Clear boundaries prevent confusion

---

### 3. Parallel Execution

**Multiple agents run simultaneously for speed.**

Parallelization examples:
- **Planning:** 3 agents run in parallel (repo-research, best-practices, framework-docs)
- **Deepening:** 40+ agents run in parallel (skills, learnings, research, review)
- **Review:** 9-11 agents run in parallel (code quality, security, performance, etc.)

**Result:** Minutes instead of hours
- Planning with 3 agents: ~30 seconds
- Deepening with 40+ agents: ~2-5 minutes
- Review with 11 agents: ~1-2 minutes

**Why this matters:** Sequential execution would take 10x-100x longer. Parallel execution is the core performance advantage.

---

### 4. Progressive Disclosure

**Start simple, add complexity only when needed.**

Progression:
1. **Simple:** `/workflows:plan` creates basic plan (200 lines, 30 seconds)
2. **Enhanced:** `/deepen-plan` adds comprehensive research (400 lines, 2 minutes)
3. **Validated:** `/plan_review` validates before coding (5-10 reviewers, 1 minute)
4. **Implemented:** `/workflows:work` executes plan (30-60 minutes)

**When to add depth:**
- Simple bug fix: Just `/workflows:plan` → `/workflows:work`
- Complex feature: `/workflows:plan` → `/deepen-plan` → `/plan_review` → `/workflows:work`

**Flexibility:** You control the complexity level based on feature complexity.

---

### 5. File-Based Artifacts

**Everything is a file: version controlled, searchable, greppable.**

Why files:
- **Version controlled:** Plans and solutions are part of your repo's history
- **Searchable:** `grep -r "OAuth PKCE" .claude/solutions/`
- **Greppable:** Find related problems quickly
- **Portable:** Share plans and solutions across teams
- **Permanent:** Knowledge persists beyond conversations

File locations:
- Plans: `.claude/plans/*.md`
- Solutions: `.claude/solutions/**/*.md`
- Todos: `.claude/todos/*.md`

**Tip:** Commit the `.claude/` directory. It's permanent team knowledge.

---

## Tips & Best Practices

### For Planning

**Deepen complex plans:**
- OAuth, payments, data migrations → Always use `/deepen-plan`
- Simple bug fixes → Skip `/deepen-plan`
- When unsure → Run `/deepen-plan`, it's fast (2-5 minutes)

**Reference similar code:**
- Instead of: "Add OAuth login"
- Say: "Add Google OAuth login like the GitHub OAuth in `app/auth/github_oauth.rb`"
- Helps research agents find relevant patterns

**Be specific:**
- ❌ "Add OAuth"
- ✅ "Add Google OAuth with PKCE flow and refresh tokens"
- ✅ "Add OAuth login using omniauth-google-oauth2 gem"

---

### For Execution

**Follow the plan:**
- `/workflows:work` reads plan references
- Plans contain links to similar code (e.g., `app/auth/github_oauth.rb:15`)
- Read those patterns - ensures consistency with codebase

**Test continuously:**
- Write tests as you implement (not after)
- Run tests after each file
- Don't accumulate test debt

**Commit incrementally:**
- Small, focused commits
- Each commit should pass tests
- Easier to review and debug

---

### For Reviews

**Triage immediately:**
- Run `/triage` right after `/workflows:review`
- Don't let `.claude/todos/` accumulate unreviewed findings
- Stale todos become irrelevant

**P1 blocks merge:**
- P1 (critical) findings must be fixed before merge
- P2 (important) findings should be addressed
- P3 (nice-to-have) findings are optional

**Skip P3 liberally:**
- P3 findings are suggestions, not requirements
- "Extract OAuth base class" might be P3
- Use judgment - not everything needs to be perfect

---

### For Documentation

**Document non-obvious solutions:**
- Typo fixes → Don't document
- Tricky OAuth token refresh logic → Document
- Complex database migration → Document
- Standard CRUD → Don't document

**Cross-reference aggressively:**
- Link related solutions in `.claude/solutions/`
- Reference original PRs and plans
- Build a web of knowledge

**Search before solving:**
```bash
grep -r "OAuth" .claude/solutions/
grep -r "token refresh" .claude/solutions/
```

---

### File Organization

**Commit .claude/:**
- Plans, solutions, todos are permanent repo knowledge
- Version control them
- Share across team

**Search with grep:**
- `.claude/solutions/` designed for text search
- `grep -r "error message" .claude/solutions/`
- Find related problems quickly

**Clean up completed todos:**
- Periodically delete old `*-complete-*.md` todos
- Keep recent completions for reference
- Archive to `.claude/archive/` if needed

---

### Performance Tips

**Parallel agents are fast:**
- 40 agents in `/deepen-plan` complete in ~2-5 minutes
- All agents run simultaneously
- Don't avoid deepening due to time concerns

**First run initializes:**
- First `/deepen-plan` scans plugins (~10 seconds for skill discovery)
- Subsequent runs use cache (instant)
- Normal behavior, not a bug

**MCP servers auto-start:**
- No manual configuration needed
- Playwright, Context7, tldr start with plugin
- Only exception: must `pip install llm-tldr` for tldr server

---

## Troubleshooting

### MCP Servers Not Loading

**Symptom:** Commands like `/deepen-plan` can't access Context7 or tldr. Error messages mention missing MCP tools.

**Solution:** Manually add to `.claude/settings.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "env": {}
    },
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp"
    },
    "tldr": {
      "type": "stdio",
      "command": "tldr-mcp",
      "args": ["--project", "."],
      "env": {}
    }
  }
}
```

**For tldr specifically:**
```bash
pip install llm-tldr
```

**Location options:**
- Project-specific: `.claude/settings.json` (in your project root)
- Global: `~/.claude/settings.json` (for all projects)

---

### /workflows:plan Not Finding Similar Code

**Symptom:** Plans lack references to existing patterns. No file paths like `app/auth/github_oauth.rb:15` in plan output.

**Solutions:**

1. **Mention similar features explicitly:**
   - ❌ "Add OAuth login"
   - ✅ "Add Google OAuth login similar to the GitHub OAuth flow"

2. **Run `/deepen-plan` for deeper search:**
   ```bash
   claude /deepen-plan .claude/plans/your-plan.md
   ```
   Spawns more research agents with better pattern discovery

3. **Check repo-research-analyst completed:**
   Look for "✓ repo-research-analyst" in output

---

### /deepen-plan Times Out

**Symptom:** Command spawns 40+ agents but times out before completion.

**Rare issue** - normally completes in 2-5 minutes.

**Solutions:**

1. **Check MCP servers running:**
   ```bash
   ps aux | grep mcp
   ```

2. **Verify network connectivity:**
   - Context7 requires `https://mcp.context7.com/mcp` access
   - Check firewall/proxy settings

3. **Try smaller plan first:**
   - `/workflows:plan` without `/deepen-plan` works fine
   - Use simpler plans for testing

---

### Todos Not Created After Review

**Symptom:** `/workflows:review` completes successfully but no `.claude/todos/` files created.

**Possible causes:**

1. **No issues found** (good!)
   - Review agents found no problems
   - Check output: "No critical issues found"

2. **Verify file-todos skill installed:**
   ```bash
   ls ~/.claude/plugins/cache/*/compound-engineering/*/skills/file-todos
   ```

3. **Check review agent output:**
   - Look for synthesis errors in output
   - Agents may have failed to create structured findings

**Solution:**
- Re-run review: `claude /workflows:review PR-123`
- Check for agent errors in output

---

### /workflows:work Not Following Plan References

**Symptom:** Implementation doesn't match similar code patterns mentioned in plan.

**Solution:**

1. **Explicitly mention patterns in plan:**
   Edit plan to add:
   ```markdown
   ## Implementation Notes
   Follow `app/auth/github_oauth.rb` pattern exactly
   ```

2. **Reference specific lines:**
   ```markdown
   See token refresh logic in `app/auth/github_oauth.rb:42-58`
   ```

3. **Provide example code in plan:**
   Include code snippets in plan for clarity

---

## Installation & Setup

### Plugin Installation

```bash
claude /plugin install compound-engineering
```

### MCP Server Configuration

MCP servers should auto-start, but if they don't, manually configure:

**.claude/settings.json** (project-specific) or **~/.claude/settings.json** (global):

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "env": {}
    },
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp"
    },
    "tldr": {
      "type": "stdio",
      "command": "tldr-mcp",
      "args": ["--project", "."],
      "env": {}
    }
  }
}
```

### tldr Requirements

The tldr MCP server requires llm-tldr:

```bash
pip install llm-tldr
```

After installation, the tldr server will auto-start when the plugin loads.

---

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

---

## License

MIT
