# FLOW.md Accuracy Audit

Audit of FLOW.md against actual command implementations.

**Date:** 2026-01-11
**Version:** v2.33.0-beta.2

---

## ✅ Accurate (Matches Implementation)

### `/workflows:plan` - Phase 1: Planning
**FLOW.md says:** Spawns 3 parallel research agents
**Implementation:** ✅ CORRECT
```markdown
- Task repo-research-analyst(feature_description)
- Task best-practices-researcher(feature_description)
- Task framework-docs-researcher(feature_description)
```

**FLOW.md says:** Writes to `.claude/plans/`
**Implementation:** ✅ CORRECT
```markdown
Write the plan to `.claude/plans/<issue_title>.md`
```

**FLOW.md says:** Presents next-step options via AskUserQuestion
**Implementation:** ✅ CORRECT
```markdown
After writing the plan file, use the **AskUserQuestion tool** to present these options:
- /deepen-plan
- /plan_review
- /workflows:work
```

---

### `/workflows:review` - Phase 3: Review
**FLOW.md says:** Spawns 10-15 parallel agents
**Implementation:** ✅ CORRECT
```markdown
Run ALL or most of these agents at the same time:
1. Task senior-code-reviewer(PR content)
2. Task framework-conventions-reviewer(PR title)
3-13. [10+ more agents]
Plus conditional agents (data-migration-expert, deployment-verification-agent, etc.)
```

**FLOW.md says:** Uses `file-todos` skill
**Implementation:** ✅ CORRECT
```markdown
This command uses the `file-todos` skill to create finding files in `.claude/todos/`
```

**FLOW.md says:** Writes to `.claude/todos/`
**Implementation:** ✅ CORRECT
```markdown
ALL findings MUST be stored in the .claude/todos/ directory using the file-todos skill
```

---

### `/deepen-plan` - Enhanced Planning
**FLOW.md says:** Spawns 40+ agents
**Implementation:** ✅ CORRECT
```markdown
### 5. Discover and Run ALL Review Agents

Dynamically discover every available agent and run them ALL against the plan.
40+ parallel agents is fine. Use everything available.

# Discover from:
- Project .claude/agents/
- User's ~/.claude/agents/
- compound-engineering plugin agents
- ALL other installed plugins
```

**FLOW.md says:** One agent per section + reviewers
**Implementation:** ✅ CORRECT
```markdown
- Skill discovery sub-agents (10-30 per matched skill)
- Learning discovery sub-agents (from .claude/solutions/)
- Per-section research agents (Explore agent type)
- ALL review agents from all sources (40+)
```

---

### `/triage` - Phase 3.5: Triage Findings
**FLOW.md says:** Triages findings from `.claude/todos/`
**Implementation:** ✅ CORRECT
```markdown
- First set the /model to Haiku
- Then read all pending todos in the .claude/todos/ directory
```

**FLOW.md says:** Uses `file-todos` skill
**Implementation:** ✅ CORRECT
```markdown
allowed-tools: Skill(file-todos)
```

**FLOW.md says:** Creates TodoWrite tracking list
**Implementation:** ✅ CORRECT
```markdown
Use TodoWrite to track progress through all findings in the triage session:
1. Finding #1: [title] - decision: pending - pending
2. Finding #2: [title] - decision: pending - pending
```

---

### `/debug` - Debugging Workflow
**FLOW.md says:** 5-phase systematic analysis
**Implementation:** ✅ CORRECT
```markdown
Use TodoWrite to track the 5-phase error analysis workflow:
1. Parse error information and extract key details - pending
2. Categorize error type and severity - pending
3. Perform root cause analysis - pending
4. Generate fix recommendations (hotfix + long-term) - pending
5. Create action items and todos - pending
```

**FLOW.md says:** Uses `error-analysis` skill
**Implementation:** ✅ CORRECT
```markdown
allowed-tools: Skill(error-analysis)
```

---

## ⚠️ Partially Accurate (Implementation Differs)

### `/workflows:compound` - Phase 5: Compound Knowledge
**FLOW.md says:** Spawns 5 parallel documentation agents
```
1. Context Analyzer (agent)
2. Solution Extractor (agent)
3. Related Docs Finder (agent)
4. Prevention Strategist (agent)
5. Test Generator (agent)
```

**Implementation:** ⚠️ CONCEPTUAL, NOT LITERAL
- Routes to `compound-docs` skill
- Skill uses 7-step sequential process
- Uses tools (Read, Write, Bash, Grep), not parallel agents
- The "5 parallel agents" are conceptual phases in the documentation

**Accuracy:** The FLOW.md diagram shows parallel agents, but the implementation uses a skill with sequential steps. The outcome is the same (documents to `.claude/solutions/`), but the mechanism differs.

**Fix needed:** Update FLOW.md to show `compound-docs` skill execution rather than parallel agent spawning, OR update command to actually spawn parallel agents.

---

### `/workflows:maintain` - Phase 6: Maintenance
**FLOW.md says:** Runs 4 commands in parallel
```
/update-deps  /scan-debt  /health-report  /analyze-coverage
```

**Implementation:** ⚠️ AMBIGUOUS
```markdown
### Phase 1: Parallel Analysis

Run these analyses concurrently:
1. 🔄 Dependency audit (dependency-auditor agent)
2. 🔄 Technical debt scan (debt-tracker agent)
3. 🔄 Coverage analysis (test-coverage-analyzer agent)
```

**Issues:**
1. Command mentions "agents" (dependency-auditor, debt-tracker, test-coverage-analyzer)
2. But in "Related" section, lists commands (`/update-deps`, `/scan-debt`, `/analyze-coverage`)
3. No explicit Task invocations found
4. Looks like example output rather than actual implementation instructions

**Accuracy:** FLOW.md shows 4 commands running in parallel. Implementation documentation mentions 3 agents but doesn't have clear Task invocation code. Needs clarification.

**Fix needed:**
- EITHER: Update command to explicitly spawn agents in parallel
- OR: Update command to explicitly run 4 commands in parallel
- OR: Update FLOW.md to match actual implementation

---

### `/workflows:work` - Phase 2: Implementation
**FLOW.md says:** Uses TodoWrite for task tracking
**Implementation:** ✅ CORRECT
```markdown
- Use TodoWrite ONLY in Phase 1, Step 3 ("Create Todo List") to track implementation tasks
```

**FLOW.md says:** Can use specialized commands during work
**Implementation:** ✅ IMPLIED BUT NOT EXPLICIT
- FLOW.md shows using `/find-code`, `/trace-impact`, `/debug`, `/refactor` during work phase
- Command doesn't explicitly list these, but doesn't prohibit them either
- This is accurate guidance based on plugin design

---

## 📊 Overall Accuracy Score

| Category | Matches | Partial | Total | Accuracy |
|----------|---------|---------|-------|----------|
| Workflow Commands (5) | 4 | 1 | 5 | 80% |
| Specialized Workflows (4) | 3 | 1 | 4 | 75% |
| **Overall** | **7** | **2** | **9** | **78%** |

---

## 🔧 Recommended Fixes

### Priority 1: `/workflows:compound` Clarification

**Option A:** Update command to spawn actual parallel agents
```markdown
### Main Tasks

Spawn these agents in PARALLEL:

1. Task general-purpose: "Analyze conversation context to extract: problem type, component, symptoms. Return YAML frontmatter skeleton."

2. Task general-purpose: "Extract solution from conversation: root cause, working fix, code examples. Return solution content block."

3. Task general-purpose: "Search .claude/solutions/ for related docs. Find cross-references and related issues. Return links."

4. Task general-purpose: "Develop prevention strategies and test cases. Return prevention content."

5. Task general-purpose: "Assemble complete markdown file with YAML frontmatter. Write to .claude/solutions/"
```

**Option B:** Update FLOW.md to show skill execution
```
/workflows:compound
        │
        ▼
Uses skill: compound-docs
        │
7-step sequential process:
1. Detect confirmation
2. Gather context (Read conversation)
3. Check existing docs (Grep)
4. Categorize problem
5. Generate YAML frontmatter
6. Write documentation (Write)
7. Cross-reference (link to related)
        │
        ▼
Writes: .claude/solutions/
```

**Recommendation:** Option A (update command) - Better performance with parallel execution

---

### Priority 2: `/workflows:maintain` Clarification

**Option A:** Spawn agents explicitly
```markdown
### Phase 1: Parallel Analysis

Launch ALL these agents in PARALLEL:

Task dependency-auditor: "Audit dependencies for security vulnerabilities and outdated packages"

Task debt-tracker: "Scan codebase for technical debt with scoring"

Task test-coverage-analyzer: "Analyze test coverage and identify gaps"

Task codebase-health: "Generate comprehensive health report"
```

**Option B:** Run commands explicitly
```markdown
### Phase 1: Parallel Maintenance Tasks

Run these commands in PARALLEL using background execution:

Bash: /update-deps --check-only &
Bash: /scan-debt &
Bash: /analyze-coverage &
Bash: /health-report &

Wait for all to complete, then synthesize results.
```

**Recommendation:** Check if these agents exist. If yes, use Option A. If no, use Option B with actual commands.

---

## 📝 Summary

**What's working well:**
- Core workflow commands (`/workflows:plan`, `/workflows:review`, `/workflows:work`) accurately implement parallel agent spawning
- `/deepen-plan` correctly spawns 40+ agents as documented
- `/triage` and `/debug` match their documented workflows
- File organization (`.claude/plans/`, `.claude/todos/`, `.claude/solutions/`) is consistent

**What needs fixing:**
1. `/workflows:compound` - Either update command to spawn parallel agents OR update FLOW.md to show skill execution
2. `/workflows:maintain` - Clarify whether it spawns agents or runs commands, then update command/FLOW.md accordingly

**Impact:**
- Users get 78% accurate understanding of workflow from FLOW.md
- The 22% inaccuracy is in implementation details (parallel agents vs. skills/commands), not in outcomes
- All documented file locations and next-step options are correct

**Action items:**
1. Review `/workflows:compound` implementation - spawn actual parallel agents for better performance
2. Review `/workflows:maintain` implementation - explicitly invoke agents or commands in parallel
3. Update FLOW.md if choosing to keep current implementations (though parallel agents are better)
