---
title: File Memory System Implementation Plan
date: 2026-01-10
status: pending
approach: hierarchical-memory-system
estimated_effort: 5-7 days
context_savings: 75%
token_overhead: 20k per session
roi: 4.5:1 initially, 10:1+ by session 4
---

# File Memory System Implementation Plan

## Executive Summary

Implement a two-tier hierarchical memory system to offload 75% of context from Claude Code's agent context window while maintaining full transparency and enabling cross-session learning.

**Current Problem:**
- Commands like `/deepen-plan` spawn 42+ parallel agents
- Generates 147,000 tokens that must fit in context window
- No cross-session learning (each session starts from scratch)
- Users can't easily inspect subagent reasoning chains

**Solution: Approach 2 - Hierarchical Memory System**
- **Tier 1 (Cache):** Ephemeral 7-day storage for recent session outputs
- **Tier 2 (Memory):** Persistent storage for promoted learnings
- **Context reduction:** 75% (147k → 36k tokens)
- **Token overhead:** ~20k per session (pays for itself through cross-session learning)
- **Implementation time:** 5-7 days

---

## Architecture Overview

### Storage Structure

```
.claude/
├── cache/                          # Tier 1: Ephemeral (7-day TTL)
│   ├── sessions/
│   │   └── {session-id}/
│   │       ├── metadata.json              # Session overview
│   │       ├── agents/
│   │       │   ├── {agent-name}-001.md    # Full output (numbered)
│   │       │   ├── {agent-name}-002.md    # Multiple invocations
│   │       │   └── {agent-name}-summary.md # Compressed (10% size)
│   │       ├── skills/
│   │       │   └── {skill-name}-output.md
│   │       ├── commands/
│   │       │   └── {command-name}-result.md
│   │       └── synthesis.md               # Session-level summary
│   └── INDEX.md                           # All sessions catalog
│
├── memory/                         # Tier 2: Persistent
│   ├── agents/
│   │   ├── review/
│   │   │   ├── code-quality-findings.md
│   │   │   ├── security-findings.md
│   │   │   └── performance-findings.md
│   │   ├── research/
│   │   │   └── best-practices.md
│   │   └── INDEX.md
│   ├── skills/
│   │   └── [skill-specific learnings]
│   ├── context.md                  # Accumulated agent knowledge
│   └── INDEX.md                    # Memory catalog
```

### Data Formats

**Session metadata (metadata.json):**
```json
{
  "session_id": "uuid-v4-here",
  "started_at": "2026-01-10T10:30:00Z",
  "completed_at": "2026-01-10T10:42:15Z",
  "command": "/deepen-plan",
  "status": "completed",
  "agent_count": 42,
  "cached_items": 58,
  "context_saved_tokens": 111000,
  "findings": {
    "security": 12,
    "performance": 8,
    "code_quality": 18,
    "architecture": 9
  }
}
```

**Agent output file ({agent-name}-001.md):**
```yaml
---
agent: senior-code-reviewer
invocation: 1
timestamp: 2026-01-10T10:32:15Z
input_hash: sha256-abc123def456
status: completed
tokens: 3500
parent_session: uuid-v4-here
tags: [review, code-quality, security]
priority: high
---

# senior-code-reviewer Output - Invocation 1

## Executive Summary
[Agent's high-level findings]

## Detailed Findings

### 1. Missing JWT Expiry Validation
**Location:** `src/middleware/auth.js:45-67`
**Severity:** High
**Description:** Authentication middleware does not validate JWT token expiry...

[Full detailed reasoning]

## Recommendations
1. Add token expiry validation in auth middleware
2. Implement token refresh flow
3. Add tests for expired token scenarios

## Cross-References
- Similar finding in session abc123 → `.claude/memory/agents/review/security-findings.md`
```

**Agent summary file ({agent-name}-summary.md):**
```yaml
---
agent: senior-code-reviewer
invocation: 1
findings: 3
priority: high
tokens: 350
---

# Summary: senior-code-reviewer

**Key Findings:**
1. JWT expiry validation missing → `src/middleware/auth.js:45-67`
2. N+1 query in dashboard → `src/controllers/users.js:127`
3. Unsafe input handling → `src/forms/comment.js:89`

**Recommendations:**
- Add token expiry validation (HIGH priority)
- Use `includes(:user)` in User.all query
- Sanitize comment form inputs

**Full details:** `.claude/cache/sessions/{session-id}/agents/senior-code-reviewer-001.md`
```

**Session synthesis (synthesis.md):**
```yaml
---
session: uuid-v4-here
date: 2026-01-10
command: /deepen-plan
agents_run: 42
findings_count: 58
critical_findings: 3
tokens_saved: 111000
---

# Session Synthesis - Plan Deepening

## Critical Findings (Immediate Action Required)

### Security (3 findings)
1. **JWT expiry not validated** → `src/middleware/auth.js`
   - Found by: security-sentinel, senior-code-reviewer
   - Priority: HIGH
   - Solution: See `.claude/solutions/security-issues/jwt-expiry-validation.md`

2. **SQL injection risk** → `src/models/search.js`
   - Found by: security-sentinel
   - Priority: CRITICAL
   - Action: Parameterize query immediately

### Performance (2 findings)
1. **N+1 query in dashboard** → `src/controllers/users.js:127`
   - Found by: performance-optimizer, senior-code-reviewer
   - Impact: 500ms page load time
   - Solution: Add `includes(:user)`

## Patterns Detected
- 3 similar JWT issues found across sessions (auto-promote candidate)
- 5 N+1 queries found in dashboard area (refactor needed)

## Recommended Next Steps
1. Fix critical security issues (SQL injection, JWT validation)
2. Optimize dashboard queries (N+1 pattern)
3. Update security documentation

## Cross-References
- Security patterns → `.claude/memory/agents/review/security-findings.md`
- Performance patterns → `.claude/memory/agents/review/performance-findings.md`
- Related todos → `.claude/todos/`
```

**Memory file (persistent finding):**
```yaml
---
title: Security Findings - Authentication Patterns
category: agents/review
created: 2026-01-10
updated: 2026-01-10
agent: security-sentinel
sessions: [uuid-1, uuid-2, uuid-3]
tags: [security, authentication, jwt, session, token]
priority: high
occurrences: 3
status: active
---

# Security Findings - Authentication Patterns

## Pattern: JWT Token Expiry Not Validated

**First seen:** 2025-12-15 (Session uuid-1)
**Occurrences:** 3 sessions
**Status:** Active (still being found)

### Common Issue
Authentication middleware across multiple codebases is missing JWT token expiry validation. This allows expired tokens to authenticate users.

### Technical Details
**Typical vulnerable code:**
```javascript
// Missing expiry check!
function verifyToken(token) {
  const decoded = jwt.decode(token);
  if (decoded.userId) {
    return User.find(decoded.userId);
  }
}
```

**Secure implementation:**
```javascript
function verifyToken(token) {
  const decoded = jwt.verify(token, SECRET); // verify checks expiry
  const now = Date.now() / 1000;
  if (decoded.exp < now) {
    throw new Error('Token expired');
  }
  return User.find(decoded.userId);
}
```

### Evidence Trail
Session evidence (full agent outputs):
- Session uuid-1: `.claude/cache/sessions/uuid-1/agents/security-sentinel-001.md`
- Session uuid-2: `.claude/cache/sessions/uuid-2/agents/senior-code-reviewer-003.md`
- Session uuid-3: `.claude/cache/sessions/uuid-3/agents/security-sentinel-002.md`

### Solution Reference
Comprehensive solution documented in:
- `.claude/solutions/security-issues/jwt-expiry-validation.md`

### Prevention
**Checklist for auth middleware:**
- [ ] Use `jwt.verify()` not `jwt.decode()`
- [ ] Check `exp` claim explicitly
- [ ] Implement token refresh flow
- [ ] Add tests for expired tokens
- [ ] Monitor auth failures for expired token patterns

### Related Patterns
- Session management → `.claude/memory/agents/review/session-security.md`
- Token refresh flows → `.claude/memory/agents/review/auth-refresh-patterns.md`
```

---

## Implementation Phases

### Phase 1: Cache Tier (Days 1-3)

**Objective:** Implement ephemeral session caching with automatic summary generation.

#### Step 1.1: Create Cache Infrastructure (Day 1, 3 hours)

**Create skill: `session-cache`**

Location: `plugins/compound-engineering/skills/session-cache/`

```
session-cache/
├── SKILL.md
├── scripts/
│   ├── write_cache.sh          # Write agent output to cache
│   ├── generate_summary.sh     # Create summary from full output
│   ├── generate_synthesis.sh   # Create session synthesis
│   └── cleanup.sh              # Remove expired cache
├── assets/
│   ├── cache-template.md       # Template for agent output
│   ├── summary-template.md     # Template for summaries
│   └── synthesis-template.md   # Template for synthesis
└── README.md
```

**SKILL.md content:**
```yaml
---
name: session-cache
description: Cache subagent outputs for context window optimization
version: 1.0.0
---

# Session Cache Skill

Automatically caches subagent outputs to `.claude/cache/` with:
- Full agent outputs for user inspection
- Compressed summaries for main agent consumption
- Session-level synthesis for quick overview
- 7-day auto-expiry

## Usage

**Automatic (in commands):**
Commands that spawn parallel agents automatically cache outputs.

**Manual:**
```bash
claude skill session-cache write \
  --agent senior-code-reviewer \
  --output "$OUTPUT" \
  --session $SESSION_ID
```

## Directory Structure

See main plan document.

## Lifecycle

- **Created:** Automatically after subagent execution
- **Expires:** 7 days (configurable in `.claude/settings.local.json`)
- **Cleanup:** Weekly automatic cleanup via cron

## Scripts

### write_cache.sh
Writes agent output to cache with metadata.

### generate_summary.sh
Extracts key findings from full output (90% compression).

### generate_synthesis.sh
Creates session-level summary from all agent summaries.

### cleanup.sh
Removes cache sessions older than TTL.
```

**write_cache.sh:**
```bash
#!/bin/bash
# Usage: write_cache.sh --agent NAME --output CONTENT --session SESSION_ID

set -e

AGENT=""
OUTPUT=""
SESSION=""
INVOCATION=1

while [[ $# -gt 0 ]]; do
  case $1 in
    --agent) AGENT="$2"; shift 2 ;;
    --output) OUTPUT="$2"; shift 2 ;;
    --session) SESSION="$2"; shift 2 ;;
    --invocation) INVOCATION="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Create cache directory
CACHE_DIR=".claude/cache/sessions/$SESSION/agents"
mkdir -p "$CACHE_DIR"

# Count existing invocations
EXISTING=$(ls "$CACHE_DIR/$AGENT"-*.md 2>/dev/null | grep -v summary | wc -l || echo 0)
INVOCATION=$((EXISTING + 1))

# Write full output
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
INPUT_HASH=$(echo "$OUTPUT" | sha256sum | cut -d' ' -f1)

cat > "$CACHE_DIR/$AGENT-$(printf '%03d' $INVOCATION).md" <<EOF
---
agent: $AGENT
invocation: $INVOCATION
timestamp: $TIMESTAMP
input_hash: $INPUT_HASH
status: completed
tokens: $(echo "$OUTPUT" | wc -w)
parent_session: $SESSION
tags: []
---

$OUTPUT
EOF

echo "Cached: $CACHE_DIR/$AGENT-$(printf '%03d' $INVOCATION).md"
```

**generate_summary.sh:**
```bash
#!/bin/bash
# Usage: generate_summary.sh --session SESSION_ID --agent AGENT_NAME

set -e

SESSION=""
AGENT=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --session) SESSION="$2"; shift 2 ;;
    --agent) AGENT="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

CACHE_DIR=".claude/cache/sessions/$SESSION/agents"

# Find latest invocation
LATEST=$(ls "$CACHE_DIR/$AGENT"-*.md 2>/dev/null | grep -v summary | sort -r | head -1)

if [[ -z "$LATEST" ]]; then
  echo "No cache file found for agent: $AGENT"
  exit 1
fi

# Extract key findings (using Claude Code agent)
# This is a simplified version - real implementation would use Claude to compress
claude agent summarizer "Compress this agent output to key findings only (bullets, no verbose explanations). Keep code references and priority levels." < "$LATEST" > "$CACHE_DIR/$AGENT-summary.md"

echo "Generated: $CACHE_DIR/$AGENT-summary.md"
```

#### Step 1.2: Integrate with `/deepen-plan` (Day 1, 4 hours)

**File:** `plugins/compound-engineering/commands/deepen-plan.md`

**Current lines 383-415 (Wait for ALL Agents and Synthesize):**

Add caching step:

```markdown
### Step 9: Wait for ALL Agents and Cache Outputs

**CRITICAL:** DO NOT proceed until ALL 42 agents have completed.

1. **Generate unique session ID:**
   ```bash
   SESSION_ID=$(uuidgen)
   ```

2. **For each completed agent:**
   ```bash
   .claude/skills/session-cache/scripts/write_cache.sh \
     --agent $AGENT_NAME \
     --output "$AGENT_OUTPUT" \
     --session $SESSION_ID
   ```

3. **Generate summaries:**
   ```bash
   for agent in $(ls .claude/cache/sessions/$SESSION_ID/agents/*.md | grep -v summary); do
     AGENT_NAME=$(basename "$agent" | sed 's/-[0-9]*.md//')
     .claude/skills/session-cache/scripts/generate_summary.sh \
       --session $SESSION_ID \
       --agent $AGENT_NAME
   done
   ```

4. **Read summaries (not full outputs) for synthesis:**
   ```bash
   cat .claude/cache/sessions/$SESSION_ID/agents/*-summary.md
   ```

5. **Create session synthesis:**
   - Group findings by domain (security, performance, code-quality, architecture)
   - Identify critical issues (HIGH/CRITICAL priority)
   - Detect patterns (3+ similar findings)
   - Generate cross-references to cache files

6. **Write synthesis:**
   ```bash
   .claude/skills/session-cache/scripts/generate_synthesis.sh \
     --session $SESSION_ID
   ```

7. **Present to user:**
   - Show synthesis (not all 42 agent outputs!)
   - Offer: "View full details in `.claude/cache/sessions/$SESSION_ID/`"
   - Ask: "Promote findings to memory?" (Phase 2 feature)
```

**Expected outcome:**
- Main agent context: 36k tokens (summaries) instead of 147k tokens (full outputs)
- User can inspect full details in `.claude/cache/sessions/{id}/`
- 75% context reduction

#### Step 1.3: Integrate with `/review` (Day 2, 3 hours)

**File:** `plugins/compound-engineering/commands/workflows/review.md`

**Current lines 51-95 (parallel_tasks):**

Enhance to cache review outputs:

```markdown
### Phase 3: Execute Review Agents in Parallel

SESSION_ID=$(uuidgen)

parallel_tasks = [
  task("kieran-rails-reviewer", cache_to=".claude/cache/sessions/$SESSION_ID"),
  task("security-sentinel", cache_to=".claude/cache/sessions/$SESSION_ID"),
  task("performance-optimizer", cache_to=".claude/cache/sessions/$SESSION_ID"),
  # ... all 14 review agents
]

**After all agents complete:**

1. Generate summaries for all agents
2. Check memory for duplicate findings:
   ```bash
   grep -r "JWT expiry" .claude/memory/agents/review/
   ```
3. Flag duplicates in synthesis
4. Present consolidated report (read summaries, not full outputs)
```

#### Step 1.4: Create Cleanup Command (Day 2, 2 hours)

**File:** `plugins/compound-engineering/commands/cache.md` (NEW)

```yaml
---
name: cache
description: Manage session cache (cleanup, status, export)
argument-hint: "cleanup|status|export"
---

# Cache Management Command

Manage the `.claude/cache/` session storage.

## Usage

**Cleanup old sessions:**
```bash
claude /cache cleanup --older-than 7d
```

**View cache status:**
```bash
claude /cache status
```

**Export session:**
```bash
claude /cache export {session-id}
```

## Implementation

### /cache cleanup

1. Find sessions older than TTL:
   ```bash
   find .claude/cache/sessions -name "metadata.json" -mtime +7
   ```

2. Delete session directories:
   ```bash
   for session in $OLD_SESSIONS; do
     rm -rf ".claude/cache/sessions/$(dirname $session)"
   done
   ```

3. Update INDEX.md

### /cache status

Display:
- Session count
- Disk usage
- Oldest/newest sessions
- Next cleanup date

### /cache export

Package session into single markdown file for sharing.
```

#### Step 1.5: Testing Phase 1 (Day 3, Full day)

**Test suite:**

1. **Test basic caching:**
   ```bash
   claude /deepen-plan
   ls .claude/cache/sessions/
   cat .claude/cache/sessions/{latest}/metadata.json
   ```

2. **Verify summary compression:**
   ```bash
   FULL=$(wc -w .claude/cache/sessions/{id}/agents/senior-code-reviewer-001.md | awk '{print $1}')
   SUMMARY=$(wc -w .claude/cache/sessions/{id}/agents/senior-code-reviewer-summary.md | awk '{print $1}')
   echo "Compression: $((100 - SUMMARY * 100 / FULL))%"
   # Expected: 90% compression
   ```

3. **Test cleanup:**
   ```bash
   # Manually set old date on test session
   touch -d "8 days ago" .claude/cache/sessions/test-session/metadata.json
   claude /cache cleanup --older-than 7d
   ls .claude/cache/sessions/test-session
   # Should not exist
   ```

4. **Context measurement:**
   ```bash
   # Before: Read all agent outputs
   TOKEN_COUNT_BEFORE=147000

   # After: Read all summaries
   TOKEN_COUNT_AFTER=$(cat .claude/cache/sessions/{id}/agents/*-summary.md | wc -w)

   echo "Context savings: $((100 - TOKEN_COUNT_AFTER * 100 / TOKEN_COUNT_BEFORE))%"
   # Expected: 75%
   ```

---

### Phase 2: Memory Tier (Days 4-7)

**Objective:** Add persistent memory with promotion workflow and cross-session learning.

#### Step 2.1: Create Memory Infrastructure (Day 4, 3 hours)

**Create skill: `cache-to-memory`**

Location: `plugins/compound-engineering/skills/cache-to-memory/`

```
cache-to-memory/
├── SKILL.md
├── scripts/
│   ├── promote.sh              # Promote session to memory
│   ├── detect_patterns.sh      # Find recurring findings
│   ├── deduplicate.sh          # Check if finding already exists
│   └── update_context.sh       # Update context.md
├── assets/
│   └── memory-template.md
└── README.md
```

**SKILL.md content:**
```yaml
---
name: cache-to-memory
description: Promote session findings to persistent memory
version: 1.0.0
---

# Cache to Memory Skill

Promotes important findings from ephemeral cache to persistent memory.

## Promotion Workflow

After session completes:

1. **Analyze session** for promotion candidates
2. **Present decision menu** to user
3. **Extract patterns** from session
4. **Check for duplicates** against existing memory
5. **Write to memory** with cross-references
6. **Update context.md** with learnings

## Automatic Promotion Triggers

- Critical security findings (CRITICAL priority)
- Patterns appearing 3+ times across sessions
- User manual selection

## Usage

**Automatic (after command completes):**
```bash
Session complete. What would you like to do?
1. Continue (keep in cache, expire in 7 days)
2. Promote findings to memory
3. Review findings first
```

**Manual:**
```bash
claude skill cache-to-memory promote --session {session-id}
```
```

**promote.sh:**
```bash
#!/bin/bash
# Usage: promote.sh --session SESSION_ID [--auto]

set -e

SESSION=""
AUTO=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --session) SESSION="$2"; shift 2 ;;
    --auto) AUTO=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Read session synthesis
SYNTHESIS=".claude/cache/sessions/$SESSION/synthesis.md"
if [[ ! -f "$SYNTHESIS" ]]; then
  echo "No synthesis found for session: $SESSION"
  exit 1
fi

# Extract findings by category
SECURITY=$(grep -A 10 "### Security" "$SYNTHESIS" || echo "")
PERFORMANCE=$(grep -A 10 "### Performance" "$SYNTHESIS" || echo "")
QUALITY=$(grep -A 10 "### Code Quality" "$SYNTHESIS" || echo "")

# Check for duplicates
.claude/skills/cache-to-memory/scripts/deduplicate.sh --session "$SESSION"

# Promote non-duplicates
if [[ ! "$AUTO" = true ]]; then
  echo "Ready to promote findings from session $SESSION"
  echo "Review synthesis: $SYNTHESIS"
  read -p "Proceed? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Promotion cancelled"
    exit 0
  fi
fi

# Write to memory
mkdir -p .claude/memory/agents/review

# Promote security findings
if [[ -n "$SECURITY" ]]; then
  cat >> .claude/memory/agents/review/security-findings.md <<EOF
## Finding from Session $SESSION ($(date +%Y-%m-%d))

$SECURITY

**Evidence:** \`.claude/cache/sessions/$SESSION/synthesis.md\`
EOF
fi

# Update context.md
.claude/skills/cache-to-memory/scripts/update_context.sh --session "$SESSION"

echo "Promotion complete: .claude/memory/agents/review/"
```

**detect_patterns.sh:**
```bash
#!/bin/bash
# Detect recurring patterns across sessions

set -e

# Search all session syntheses for similar findings
PATTERN="$1"

if [[ -z "$PATTERN" ]]; then
  echo "Usage: detect_patterns.sh <pattern>"
  exit 1
fi

# Count occurrences
OCCURRENCES=$(grep -r "$PATTERN" .claude/cache/sessions/*/synthesis.md 2>/dev/null | wc -l)

if [[ $OCCURRENCES -ge 3 ]]; then
  echo "Pattern detected: $PATTERN ($OCCURRENCES occurrences)"
  echo "Auto-promoting to memory..."
  # Trigger automatic promotion
fi
```

#### Step 2.2: Integrate Promotion Workflow (Day 4, 4 hours)

**Enhance `/deepen-plan` to offer promotion:**

After synthesis generation, add:

```markdown
### Step 10: Promotion Decision

**Present to user:**

"Session complete. 42 agents generated outputs.
Found: 58 findings across security, performance, code-quality

Detected patterns:
- JWT expiry validation missing (3 occurrences across sessions)
- N+1 queries in dashboard (5 occurrences)

What would you like to do?
1. Continue (keep in cache, expire in 7 days)
2. Promote findings to memory (extract key learnings)
3. Review findings first

[User selects option]"

**If option 2 selected:**
```bash
.claude/skills/cache-to-memory/scripts/promote.sh --session $SESSION_ID
```

**If option 3 selected:**
- Show full synthesis
- Offer drill-down into specific agents
- Then re-offer options 1-2
```

**Decision menu implementation:**

Follow the pattern from `compound-docs` skill (lines 259-342: decision_gate section).

#### Step 2.3: Update Agent System Prompts (Day 5, 4 hours)

**Enhance agents to read memory before starting:**

**Example: `senior-code-reviewer.md`**

Add to system prompt:

```markdown
## Your Memory System

Before starting review, check your accumulated knowledge:

1. **Read memory index:**
   ```bash
   cat .claude/memory/INDEX.md
   ```

2. **Search relevant findings:**
   ```bash
   grep -r "tag: security" .claude/memory/agents/review/
   grep -r "tag: performance" .claude/memory/agents/review/
   ```

3. **Read context.md:**
   ```bash
   cat .claude/memory/context.md
   ```

4. **Apply past learnings:**
   - If JWT expiry pattern exists in memory, check for it in current code
   - If N+1 patterns documented, scan for similar issues
   - Reference past solutions for similar problems

## During Review

**When you find an issue:**
1. Check if it's already documented in memory
2. If duplicate, flag it: "This is a known pattern, see `.claude/memory/...`"
3. If new, document it fully for potential promotion

**Cross-reference your findings:**
- Link to similar issues in memory
- Reference solutions in `.claude/solutions/`
- Suggest prevention patterns from context.md
```

**Apply to all 38 agents** (prioritize review agents first):
- senior-code-reviewer
- security-sentinel
- performance-optimizer
- framework-conventions-reviewer
- etc.

#### Step 2.4: Implement Pattern Detection (Day 6, 4 hours)

**Create automatic promotion logic:**

**In `detect_patterns.sh`:**

```bash
#!/bin/bash
# Automatic pattern detection and promotion

set -e

SESSION="$1"

if [[ -z "$SESSION" ]]; then
  echo "Usage: detect_patterns.sh <session-id>"
  exit 1
fi

SYNTHESIS=".claude/cache/sessions/$SESSION/synthesis.md"

# Extract all findings
FINDINGS=$(grep -E "^\d+\." "$SYNTHESIS" | sed 's/^[0-9]*\. //')

# For each finding, search past sessions
while IFS= read -r finding; do
  # Extract key terms (simplified - real implementation would use Claude)
  KEY_TERMS=$(echo "$finding" | awk '{print $1, $2, $3}')

  # Search all past syntheses
  MATCHES=$(grep -r "$KEY_TERMS" .claude/cache/sessions/*/synthesis.md 2>/dev/null | wc -l)

  if [[ $MATCHES -ge 3 ]]; then
    echo "Pattern detected: $finding ($MATCHES occurrences)"
    echo "Auto-promoting..."

    # Promote to memory
    # (call promote.sh with specific finding)
  fi
done <<< "$FINDINGS"
```

**Trigger pattern detection:**
- After every session synthesis
- Weekly batch analysis of all sessions

#### Step 2.5: Update claude-workspace Skill (Day 6, 2 hours)

**File:** `plugins/compound-engineering/skills/claude-workspace/SKILL.md`

**Lines 25-156: Directory structure**

Add cache and memory to workspace structure:

```markdown
## Directory Structure

```
.claude/
├── plans/              # Implementation plans
├── architecture/       # ADRs and design decisions
├── examples/           # Reference implementations
├── research/           # Research findings
├── analysis/           # Code analysis
├── cache/             # Session cache (NEW)
│   ├── sessions/
│   └── INDEX.md
├── memory/            # Persistent learnings (NEW)
│   ├── agents/
│   ├── skills/
│   ├── context.md
│   └── INDEX.md
├── solutions/         # Problem solutions (compound-docs)
└── todos/             # Work tracking (file-todos)
```

## INDEX.md Generation

**For .claude/cache/:**
```bash
# Auto-generate cache index
cat > .claude/cache/INDEX.md <<EOF
# Session Cache Index

$(for session in .claude/cache/sessions/*/; do
  SESSION_ID=$(basename "$session")
  DATE=$(jq -r '.started_at' "$session/metadata.json")
  COMMAND=$(jq -r '.command' "$session/metadata.json")
  echo "- [$SESSION_ID]($session) - $COMMAND ($DATE)"
done)
EOF
```

**For .claude/memory/:**
```bash
# Auto-generate memory index
cat > .claude/memory/INDEX.md <<EOF
# Memory Index

## By Agent Category

### Review
$(ls .claude/memory/agents/review/*.md | while read f; do
  TITLE=$(grep "^title:" "$f" | cut -d: -f2-)
  echo "- [$TITLE]($f)"
done)

### Research
$(ls .claude/memory/agents/research/*.md 2>/dev/null | while read f; do
  TITLE=$(grep "^title:" "$f" | cut -d: -f2-)
  echo "- [$TITLE]($f)"
done)
EOF
```
```

#### Step 2.6: Testing Phase 2 (Day 7, Full day)

**Test suite:**

1. **Test promotion workflow:**
   ```bash
   claude /deepen-plan
   # Select "Promote to memory"
   ls .claude/memory/agents/review/
   cat .claude/memory/agents/review/security-findings.md
   # Verify cross-references to cache
   ```

2. **Test pattern detection:**
   ```bash
   # Run same command 3 times
   claude /review
   # [Ensure JWT expiry finding appears]

   # After 3rd occurrence
   cat .claude/memory/agents/review/security-findings.md
   # Verify "occurrences: 3" in frontmatter
   ```

3. **Test cross-session learning:**
   ```bash
   # Create memory finding
   cat > .claude/memory/agents/review/test-finding.md <<EOF
   ---
   title: Test Pattern
   tags: [test, n-plus-one]
   ---
   # Test Pattern
   N+1 queries are common in dashboard controllers.
   EOF

   # Run review
   claude /review

   # Check agent output references memory
   grep -r "Found in memory" .claude/cache/sessions/{latest}/agents/
   ```

4. **Test deduplication:**
   ```bash
   # Promote session with JWT finding
   # Promote another session with same finding
   # Verify only one entry exists (with occurrences: 2)
   ```

5. **Test context.md integration:**
   ```bash
   cat .claude/memory/context.md
   # Verify accumulated learnings present

   # Run agent
   # Verify agent reads context.md (check agent output for references)
   ```

---

### Phase 3: Optional Enhancements (Future)

**Not required for initial implementation. Consider after Phase 2 proves valuable.**

#### Enhancement 3.1: Memory Dashboard Command

**File:** `plugins/compound-engineering/commands/memory.md` (NEW)

```bash
claude /memory status
```

Displays:
- Cache stats (session count, disk usage, oldest/newest)
- Memory stats (pattern count by category, recent promotions)
- Recommendations (sessions ready for promotion, old cache to clean up)

#### Enhancement 3.2: Automatic Compression

If memory grows beyond 100 files:
- Monthly compression pipeline
- Group findings by domain
- Create domain summary documents
- Archive raw findings

#### Enhancement 3.3: Semantic Search (Optional)

If embedding API available:
- Generate embeddings for all findings
- Enable similarity search
- Find related patterns across sessions

#### Enhancement 3.4: MCP Server

**Location:** `plugins/compound-engineering/mcp-servers/memory-server/`

Provides:
- Memory CRUD operations via MCP protocol
- External tools can query cache/memory
- Enables integration with other Claude Code plugins

---

## Context Savings Analysis

### Token Flow Comparison

**Without memory system (current):**
```
/deepen-plan spawns 42 agents
→ Each agent: 3,500 tokens
→ Main agent context: 42 × 3,500 = 147,000 tokens
→ User sees: Nothing (all in agent context)
```

**With Phase 1 (cache tier):**
```
/deepen-plan spawns 42 agents
→ Each agent: 3,500 tokens → cached to .claude/cache/
→ Summary generated: 350 tokens (10% compression)
→ Main agent context: 42 × 350 = 14,700 tokens
→ Session synthesis: 1,500 tokens
→ Total context: 16,200 tokens (89% savings)
→ User sees: Synthesis + can drill into cache
```

**With Phase 2 (cache + memory):**
```
Session 1:
→ Main agent reads memory: 2,000 tokens (relevant patterns)
→ Main agent reads summaries: 14,700 tokens
→ Total context: 16,700 tokens (89% savings)

Session 2 (same findings):
→ Main agent reads memory: 2,000 tokens
→ Main agent reads summaries: 14,700 tokens
→ Deduplication flags: 10 findings already documented
→ Agent skips redundant analysis (saves 10 × 3,500 = 35,000 tokens)
→ Total context: 16,700 tokens
→ Total processing: 112,000 tokens vs 147,000 tokens (24% savings)

Session 4+:
→ Memory provides learned patterns upfront
→ Agents focus on new findings only
→ Context: 16,700 tokens
→ Processing: ~80,000 tokens (45% savings)
→ **ROI: 10:1 savings ratio**
```

### ROI Trajectory

```
Session 1:
- Context saved: 130,300 tokens
- Processing cost: 20,000 tokens
- Net savings: 110,300 tokens (5.5:1 ROI)

Session 2:
- Context saved: 130,300 tokens
- Processing cost: 20,000 tokens
- Deduplication savings: 35,000 tokens
- Net savings: 145,300 tokens (7.3:1 ROI)

Session 3:
- Context saved: 130,300 tokens
- Processing cost: 15,000 tokens (less promotion needed)
- Deduplication savings: 50,000 tokens
- Net savings: 165,300 tokens (11:1 ROI)

Session 4:
- Context saved: 130,300 tokens
- Processing cost: 10,000 tokens (mostly duplicates)
- Deduplication savings: 70,000 tokens
- Net savings: 190,300 tokens (19:1 ROI)
```

**Conclusion:** System pays for itself by session 1, and ROI improves with each subsequent session.

---

## Risk Mitigation

### Risk 1: Summary Quality

**Risk:** Summaries lose important details, degrading main agent effectiveness.

**Mitigation:**
- Validate summaries against full outputs (spot check)
- Include "drill-down" references in summaries
- Main agent can request full output if synthesis is unclear
- User feedback loop: "Was synthesis helpful?"

### Risk 2: Disk Space Growth

**Risk:** Cache grows unbounded, consuming excessive disk space.

**Mitigation:**
- 7-day TTL on cache (automatic cleanup)
- Weekly cleanup cron job
- Monitor disk usage in `/memory status`
- Alert if cache exceeds 1GB

### Risk 3: Stale Memory

**Risk:** Memory findings become outdated as codebase evolves.

**Mitigation:**
- Date-stamp all memory findings
- Periodic review prompt: "Review memory older than 90 days?"
- Archive mechanism for outdated patterns
- Version tracking in frontmatter

### Risk 4: Promotion Workflow Friction

**Risk:** Users find decision gates annoying, skip promotion.

**Mitigation:**
- Smart defaults (auto-promote critical/recurring)
- One-click promotion (minimal friction)
- "Remind me later" option
- Background promotion (no blocking)

### Risk 5: Deduplication False Positives

**Risk:** Different findings incorrectly flagged as duplicates.

**Mitigation:**
- Conservative similarity threshold (85%)
- Show comparison to user before deduplication
- Allow manual override ("This is different")
- Track false positives, adjust threshold

---

## Success Metrics

### Quantitative Metrics

1. **Context savings:**
   - Target: 75% reduction (147k → 36k tokens)
   - Measure: Token count before/after per session

2. **Token consumption:**
   - Target: <20k tokens overhead per session
   - Measure: Total processing tokens for promotion workflow

3. **ROI trajectory:**
   - Target: 10:1 by session 4
   - Measure: (Context saved + Dedup saved) / Processing cost

4. **Disk usage:**
   - Target: <500MB after 30 days
   - Measure: du -sh .claude/cache .claude/memory

5. **Deduplication rate:**
   - Target: >30% by session 3
   - Measure: (Duplicate findings / Total findings) × 100

### Qualitative Metrics

1. **User satisfaction:**
   - Can users find agent reasoning within 30 seconds?
   - Do decision gates feel natural or intrusive?
   - Is directory structure intuitive?

2. **Cross-session learning:**
   - Are agents referencing memory in outputs?
   - Do repeat issues decrease over time?
   - Is context.md accumulating useful patterns?

3. **Transparency:**
   - Can users follow chains of reasoning?
   - Are cross-references discoverable?
   - Is synthesis accurately representing agent work?

---

## Critical Files to Modify

### Phase 1 Files

| File | Lines | Purpose |
|------|-------|---------|
| `commands/deepen-plan.md` | 383-415 | Add cache writing, summary generation |
| `commands/workflows/review.md` | 51-95 | Cache review outputs, duplicate detection |
| `commands/resolve_parallel.md` | 19-29 | Cache PR resolution reasoning |
| `skills/session-cache/` | NEW | Cache infrastructure (write, summary, cleanup) |
| `commands/cache.md` | NEW | Cache management (cleanup, status, export) |

### Phase 2 Files

| File | Lines | Purpose |
|------|-------|---------|
| `skills/cache-to-memory/` | NEW | Promotion workflow, pattern detection |
| `skills/claude-workspace/SKILL.md` | 25-156 | Add cache/memory to structure |
| `skills/file-todos/SKILL.md` | - | Cross-reference to cache |
| `agents/*.md` | All | Update system prompts to read memory |

### Phase 3 Files (Optional)

| File | Lines | Purpose |
|------|-------|---------|
| `commands/memory.md` | NEW | Dashboard, search, analytics |
| `mcp-servers/memory-server/` | NEW | MCP protocol for external access |

---

## Implementation Checklist

### Phase 1: Cache Tier (Days 1-3)

**Day 1:**
- [ ] Create `skills/session-cache/` directory structure
- [ ] Write `write_cache.sh` script
- [ ] Write `generate_summary.sh` script
- [ ] Write `generate_synthesis.sh` script
- [ ] Create cache templates (assets/)
- [ ] Write `SKILL.md` documentation
- [ ] Test cache writing manually

**Day 2:**
- [ ] Integrate caching into `/deepen-plan` (lines 383-415)
- [ ] Integrate caching into `/review` (lines 51-95)
- [ ] Integrate caching into `/resolve_parallel` (lines 19-29)
- [ ] Create `/cache` command
- [ ] Write cleanup script
- [ ] Test integration end-to-end

**Day 3:**
- [ ] Run full test suite (4 tests)
- [ ] Measure context savings (target: 75%)
- [ ] Measure summary compression (target: 90%)
- [ ] Test cleanup mechanism
- [ ] User acceptance testing
- [ ] Document Phase 1 completion

### Phase 2: Memory Tier (Days 4-7)

**Day 4:**
- [ ] Create `skills/cache-to-memory/` directory structure
- [ ] Write `promote.sh` script
- [ ] Write `detect_patterns.sh` script
- [ ] Write `deduplicate.sh` script
- [ ] Write `update_context.sh` script
- [ ] Create memory templates
- [ ] Write `SKILL.md` documentation

**Day 5:**
- [ ] Add promotion workflow to `/deepen-plan`
- [ ] Implement decision menu (following compound-docs pattern)
- [ ] Update 10 agent system prompts to read memory
- [ ] Test promotion manually

**Day 6:**
- [ ] Implement automatic pattern detection (3+ occurrences)
- [ ] Update remaining 28 agent system prompts
- [ ] Update `claude-workspace` skill with cache/memory structure
- [ ] Generate INDEX.md for both tiers
- [ ] Test cross-session learning

**Day 7:**
- [ ] Run full Phase 2 test suite (5 tests)
- [ ] Test promotion workflow end-to-end
- [ ] Test pattern detection (3 runs)
- [ ] Test deduplication
- [ ] Verify context.md integration
- [ ] User acceptance testing
- [ ] Document Phase 2 completion

### Phase 3: Optional Enhancements (Future)

- [ ] Create `/memory` dashboard command
- [ ] Implement automatic compression
- [ ] Add semantic search (if API available)
- [ ] Build memory MCP server

---

## Documentation Updates Required

### 1. Plugin README

**File:** `plugins/compound-engineering/README.md`

Add section:

```markdown
## File Memory System

The plugin includes a two-tier file memory system for context optimization:

### Cache Tier (.claude/cache/)
- Ephemeral 7-day storage for recent session outputs
- Automatically caches subagent outputs from parallel commands
- Enables session resume and quick reference
- 75% context window reduction

### Memory Tier (.claude/memory/)
- Persistent storage for promoted learnings
- Cross-session pattern detection and deduplication
- Accumulated agent knowledge via context.md
- Enables compounding engineering

### Commands
- `/cache cleanup` - Remove expired sessions
- `/cache status` - View cache statistics
- `/memory status` - View memory analytics (Phase 3)

See `.claude/plans/2026-01-10-file-memory-system-implementation.md` for full details.
```

### 2. Plugin Metadata

**File:** `plugins/compound-engineering/.claude-plugin/plugin.json`

Update description:
```json
{
  "description": "Includes 38 agents, 33 commands, 24 skills, 2 MCP servers. Features file memory system for 75% context reduction."
}
```

Increment version:
```json
{
  "version": "2.33.0"
}
```

### 3. Marketplace Metadata

**File:** `.claude-plugin/marketplace.json`

Update plugin description and version to match plugin.json.

### 4. Changelog

**File:** `plugins/compound-engineering/CHANGELOG.md`

Add entry:
```markdown
## [2.33.0] - 2026-01-XX

### Added
- **File Memory System** - Two-tier hierarchical memory (cache + memory) for context optimization
  - Cache tier: Ephemeral 7-day storage for session outputs (75% context reduction)
  - Memory tier: Persistent storage for promoted learnings with cross-session pattern detection
  - New skill: `session-cache` - Automatic caching of subagent outputs
  - New skill: `cache-to-memory` - Promotion workflow with decision gates
  - New command: `/cache` - Manage session cache (cleanup, status, export)
  - Integration: `/deepen-plan`, `/review`, `/resolve_parallel` now cache outputs
  - Context savings: 75% reduction (147k → 36k tokens)
  - ROI: 10:1 savings ratio by session 4

### Changed
- Updated 38 agent system prompts to read memory before starting
- Enhanced `claude-workspace` skill with cache/memory structure
- Enhanced parallel execution commands with automatic caching
```

### 5. Documentation Site

Run:
```bash
claude /release-docs
```

This will update:
- `docs/index.html` - Stats (24 skills now)
- `docs/pages/skills.html` - Add session-cache, cache-to-memory
- `docs/pages/commands.html` - Add /cache command
- `docs/pages/changelog.html` - Mirror CHANGELOG.md

---

## Next Steps After Implementation

1. **User testing** - Run with 5-10 real `/deepen-plan` sessions
2. **Metrics collection** - Measure actual context savings and ROI
3. **Iteration** - Adjust compression, promotion triggers based on data
4. **Documentation** - Create tutorial video/guide for users
5. **Phase 3 evaluation** - Decide if enhancements are needed

---

## Questions for User

None - this plan is ready for implementation pending your approval.

---

## Appendix: Example Flows

### Example Flow 1: First Session with Cache

```bash
# User runs command
$ claude /deepen-plan

# Claude generates session ID
SESSION_ID=550e8400-e29b-41d4-a716-446655440000

# Spawns 42 agents in parallel
[Running 42 agents...]

# Each agent output cached automatically
Cached: .claude/cache/sessions/550e8400.../agents/senior-code-reviewer-001.md
Cached: .claude/cache/sessions/550e8400.../agents/security-sentinel-001.md
...

# Summaries generated (90% compression)
Generated: .claude/cache/sessions/550e8400.../agents/senior-code-reviewer-summary.md
...

# Main agent reads summaries (not full outputs)
Context: 14,700 tokens (summaries) + 1,500 tokens (synthesis) = 16,200 tokens
Savings: 147,000 - 16,200 = 130,800 tokens (89% reduction)

# Synthesis generated
Generated: .claude/cache/sessions/550e8400.../synthesis.md

# Presented to user
===================
Session Complete
===================

Found 58 findings:
- Security: 12 findings (3 CRITICAL)
- Performance: 8 findings
- Code Quality: 18 findings
- Architecture: 9 findings

Critical findings:
1. SQL injection risk in search.js
2. JWT expiry not validated in auth.js
3. Missing error boundaries in dashboard

View full details: .claude/cache/sessions/550e8400.../

What would you like to do?
1. Continue (cache expires in 7 days)
2. Promote findings to memory
3. Review findings

[User selects: 1]

Done! Cache will expire on 2026-01-17.
```

### Example Flow 2: Promotion to Memory

```bash
# User selects option 2
[User selects: 2]

# Promotion analysis
Analyzing session for promotion...

Checking for duplicates against memory...
- JWT expiry: NEW (first occurrence)
- SQL injection: NEW
- Missing error boundaries: NEW

Patterns detected:
- None yet (need 3+ occurrences for pattern)

Promoting to memory:
- 3 critical security findings
- 2 performance patterns

Writing to:
- .claude/memory/agents/review/security-findings.md
- .claude/memory/agents/review/performance-findings.md

Updating context.md...

Cross-references created:
- .claude/cache/sessions/550e8400... → .claude/memory/...
- .claude/memory/... → .claude/solutions/...

Done! Memory updated.
```

### Example Flow 3: Cross-Session Learning (Session 3)

```bash
# User runs command (3rd time)
$ claude /review

# Agent starts, reads memory first
[senior-code-reviewer starting...]

Reading accumulated knowledge:
- .claude/memory/INDEX.md (12 patterns documented)
- .claude/memory/agents/review/security-findings.md (JWT expiry pattern - seen 2 times)

Checking current codebase against known patterns...

# Agent finds JWT issue (3rd occurrence)
Found: JWT expiry not validated in new-auth.js

This matches known pattern (2 previous occurrences):
- Session 550e8400: src/middleware/auth.js
- Session 7789af12: src/api/auth.js
- Current: src/new-auth.js

Recommendation: See .claude/memory/agents/review/security-findings.md

# Pattern detection triggers
Pattern detected: JWT expiry validation (3 occurrences)
Auto-promoting to memory...

Updated: .claude/memory/agents/review/security-findings.md
- occurrences: 2 → 3
- sessions: [550e8400, 7789af12, 9923bbc4]
- status: active (still being found)

# Deduplication saves work
Skipping detailed analysis (already documented)
Savings: 3,500 tokens

# Final output
Review complete.

Found 15 findings:
- 1 duplicate (JWT expiry - known pattern)
- 14 new findings

Net new work: 14 findings (vs 15 without memory)
Tokens saved: 3,500 (deduplication)

Session cached: .claude/cache/sessions/9923bbc4.../
```

---

**End of Implementation Plan**
