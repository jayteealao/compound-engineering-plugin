# Compound Engineering Plugin - Complete Workflow

**Philosophy:** Each unit of engineering work should make subsequent units of work easier—not harder.

**Core Cycle:** Plan → Work → Review → Triage → Fix → Compound

---

## 📋 Quick Reference

| Phase | Command | Purpose | Output |
|-------|---------|---------|--------|
| **Planning** | `/workflows:plan` | Research & plan with 4 parallel agents | `.claude/plans/*.md` |
| **Depth** | `/deepen-plan` | Add 40+ research agents per section | Enhanced plan |
| **Validation** | `/plan_review` | Multi-agent plan quality check | Plan feedback |
| **Execution** | `/workflows:work` | Execute plan/todos systematically | Code + commits |
| **Review** | `/workflows:review` | Multi-agent code review (9-11 agents) | `.claude/todos/review/PR-*/*.md` |
| **Triage** | `/triage` | Prioritize todos interactively | Prioritized queue |
| **Debug** | `/debug` | 5-phase systematic debugging | Fix recommendations |
| **Testing** | `/generate-tests` | Generate comprehensive tests | Test files |
| **Compound** | `/workflows:compound` | Document solutions | `.claude/solutions/**/*.md` |

---

## 🔄 Main Workflow

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        PHASE 1: PLANNING (4 Parallel Agents)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                         /workflows:plan "Add OAuth login"
                                        │
                    ┌───────────────────┼───────────────────┬──────────────┐
                    │                   │                   │              │
                    ▼                   ▼                   ▼              ▼
          ┌──────────────────┐ ┌──────────────────┐ ┌──────────────┐ ┌────────────┐
          │ repo-research-   │ │ best-practices-  │ │ framework-   │ │ spec-flow- │
          │ analyst          │ │ researcher       │ │ docs-        │ │ analyzer   │
          │                  │ │                  │ │ researcher   │ │            │
          │ • Existing code  │ │ • Best practices │ │ • Framework  │ │ • User     │
          │ • Conventions    │ │ • Standards      │ │   patterns   │ │   flows    │
          │ • Patterns       │ │ • Security       │ │ • Docs       │ │ • Gaps     │
          └──────────────────┘ └──────────────────┘ └──────────────┘ └────────────┘
                    │                   │                   │              │
                    └───────────────────┴───────────────────┴──────────────┘
                                        │
                    Writes: .claude/plans/2026-01-11-oauth-login.md
                                        │
                                        ▼
                              ┌─────────────────────┐
                              │ AskUserQuestion:    │
                              │ Next steps?         │
                              │ • /deepen-plan      │
                              │ • /plan_review      │
                              │ • /workflows:work   │
                              └─────────┬───────────┘
                                        │
          ┌─────────────────────────────┼─────────────────────────────┐
          │                             │                             │
          ▼                             ▼                             ▼
   ┌──────────────┐           ┌──────────────────┐         ┌──────────────────┐
   │ /deepen-plan │           │ /plan_review     │         │ /workflows:work  │
   │              │           │                  │         │ (go to Phase 2)  │
   └──────┬───────┘           └────────┬─────────┘         └──────────────────┘
          │                            │
          ▼                            ▼
   Spawns 40+              Spawns review agents
   parallel agents         to validate plan:
   per section            • architecture-strategist
                          • senior-code-reviewer
                          • framework-conventions
                          • pattern-recognition


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                PHASE 2: WORK (Break Plan into Todos)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

              /workflows:work .claude/plans/oauth-login.md
                                    │
                                    ▼
                    Uses file-todos skill to:
                    • Parse plan sections
                    • Create todo files
                    • YAML frontmatter + markdown
                                    │
                                    ▼
                    Creates in .claude/todos/plan/:
                    • oauth-login-models.md
                    • oauth-login-routes.md
                    • oauth-login-views.md
                    • oauth-login-tests.md
                                    │
                                    ▼
              /workflows:work .claude/todos/plan/oauth-login-models.md
                                    │
                                    ▼
                    For each todo:
                    1. Read todo file
                    2. Implement changes
                    3. Run tests
                    4. Git commit incrementally
                    5. Mark todo completed


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                PHASE 3: REVIEW (9-11 Parallel Agents)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                        /workflows:review PR-123
                                    │
        ┌───────────┬───────────┬───┴───┬───────────┬───────────┬───────────┐
        │           │           │       │           │           │           │
        ▼           ▼           ▼       ▼           ▼           ▼           ▼
    ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
    │senior- │ │security│ │perform-│ │arch-   │ │pattern-│ │data-   │ │git-    │
    │code-   │ │sentinel│ │ance-   │ │stra-   │ │recog-  │ │integ-  │ │history-│
    │reviewer│ │        │ │oracle  │ │tegist  │ │nition  │ │rity    │ │analyzer│
    └────────┘ └────────┘ └────────┘ └────────┘ └────────┘ └────────┘ └────────┘
        │           │           │       │           │           │           │
        └───────────┴───────────┴───┬───┴───────────┴───────────┴───────────┘
                                    │
        ┌───────────────────────────┴────────────────────────────┐
        │                                                         │
        ▼                                                         ▼
    ┌────────────────┐                                    ┌────────────────┐
    │framework-      │                                    │kieran-         │
    │conventions-    │                                    │typescript-     │
    │reviewer        │                                    │reviewer        │
    └────────────────┘                                    └────────────────┘
        │                                                         │
        └───────────────────────────┬─────────────────────────────┘
                                    │
                    Conditional agents (if needed):
                    • data-migration-expert
                    • deployment-verification-agent
                    • test-coverage-analyzer
                                    │
                                    ▼
                    Uses file-todos skill to write:
                    .claude/todos/review/PR-123/
                    • p1-security-sql.md
                    • p2-performance-n+1.md
                    • p3-style-nits.md


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        PHASE 4: TRIAGE (Interactive)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                            /triage
                                │
                                ▼
                    Reads: .claude/todos/review/PR-123/
                                │
                                ▼
                    For each finding:
                    1. Present to user
                    2. AskUserQuestion: yes/next/custom
                    3. Update priority
                    4. Track with TodoWrite
                                │
                                ▼
                    Creates prioritized work queue


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        PHASE 5: FIX (Work on Review Todos)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

        /workflows:work .claude/todos/review/PR-123/p1-security-sql.md
                                │
                                ▼
                    1. Read todo file
                    2. Fix issue
                    3. Run tests
                    4. Git commit
                    5. Mark completed
                                │
                                ▼
              Re-run /workflows:review to verify fix


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        PHASE 6: COMPOUND (Document Solutions)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

            /workflows:compound "Fixed SQL injection in OAuth"
                                │
                                ▼
                    Uses compound-docs skill:
                    1. Analyze conversation
                    2. Extract solution
                    3. Find related docs
                    4. Create prevention strategy
                                │
                                ▼
        Writes: .claude/solutions/security-issues/oauth-sql-injection.md
```

---

## 🐛 Debug Workflow

```
                            /debug "Error message"
                                        │
                                        ▼
                            5-Phase Analysis:
                                        │
            ┌───────────────────────────┼────────────────────────────┐
            │                           │                            │
            ▼                           ▼                            ▼
    ┌──────────────┐          ┌──────────────┐           ┌──────────────┐
    │ Phase 1      │          │ Phase 2      │           │ Phase 3      │
    │ Parse Error  │  ───>    │ Categorize   │  ───>     │ Root Cause   │
    │ Information  │          │ Error Type   │           │ Analysis     │
    └──────────────┘          └──────────────┘           └──────────────┘
            │                           │                            │
            └───────────────────────────┼────────────────────────────┘
                                        │
            ┌───────────────────────────┼────────────────────────────┐
            │                           │                            │
            ▼                           ▼                            ▼
    ┌──────────────┐          ┌──────────────┐           ┌──────────────┐
    │ Phase 4      │          │ Phase 5      │           │ Output       │
    │ Generate Fix │  ───>    │ Create       │  ───>     │ Fix + Todos  │
    │ Recommen-    │          │ Action Items │           │              │
    │ dations      │          │              │           │              │
    └──────────────┘          └──────────────┘           └──────────────┘

                    Uses error-analysis skill for methodology
```

---

## 🧪 Testing Workflow

```
                    /generate-tests src/auth/oauth.ts
                                │
                                ▼
                    Uses test-patterns skill:
                    • Unit test patterns
                    • Integration test patterns
                    • Mocking strategies
                    • Edge cases
                                │
                                ▼
                    Generates:
                    • Unit tests
                    • Integration tests
                    • Fixture data
                                │
                                ▼
                    Runs tests to verify
```

---

## 📁 File Organization

All workflow outputs are organized in `.claude/`:

```
.claude/
├── plans/                    # From /workflows:plan
│   └── YYYY-MM-DD-feature.md
│
├── todos/
│   ├── plan/                # From /workflows:work (plan breakdown)
│   │   └── feature-section-1.md
│   │
│   └── review/              # From /workflows:review (PR findings)
│       └── PR-123/
│           ├── p1-security.md
│           ├── p2-performance.md
│           └── p3-style.md
│
└── solutions/               # From /workflows:compound
    └── category/
        └── problem-solution.md
```

**Critical Separation:**
- **Plan todos** (`.claude/todos/plan/`) - Implementation tasks from planning phase
- **Review todos** (`.claude/todos/review/PR-*/`) - Issues found during code review
- These are NEVER mixed - they serve different purposes in the workflow

---

## 🎯 Complete Example: OAuth Feature

### Step 1: Planning
```bash
claude /workflows:plan "Add OAuth login with Google and GitHub"
# Spawns 4 parallel research agents
# Writes: .claude/plans/2026-01-11-oauth-login.md
# Asks: Next steps? /deepen-plan, /plan_review, or /workflows:work?
```

### Step 2: Optional Depth
```bash
claude /deepen-plan .claude/plans/2026-01-11-oauth-login.md
# Spawns 40+ agents for deeper research per section
# Updates plan with comprehensive details
```

### Step 3: Optional Validation
```bash
claude /plan_review .claude/plans/2026-01-11-oauth-login.md
# Spawns review agents to validate plan quality
# Provides feedback on completeness, feasibility
```

### Step 4: Execute Plan
```bash
claude /workflows:work .claude/plans/2026-01-11-oauth-login.md
# Uses file-todos skill to break plan into todos:
#   .claude/todos/plan/oauth-models.md
#   .claude/todos/plan/oauth-routes.md
#   .claude/todos/plan/oauth-views.md
#   .claude/todos/plan/oauth-tests.md
```

### Step 5: Work on Todos
```bash
claude /workflows:work .claude/todos/plan/oauth-models.md
# Implements OAuth models
# Runs tests
# Commits incrementally
# Marks todo completed
```

### Step 6: Create PR and Review
```bash
# After pushing branch and creating PR
claude /workflows:review PR-123
# Spawns 9-11 parallel review agents
# Creates review todos in .claude/todos/review/PR-123/
```

### Step 7: Triage Findings
```bash
claude /triage
# Presents each finding interactively
# User decides: yes/next/custom
# Creates prioritized work queue
```

### Step 8: Fix Issues
```bash
claude /workflows:work .claude/todos/review/PR-123/p1-security-sql.md
# Fixes SQL injection issue
# Runs tests
# Commits
# Re-review to verify
```

### Step 9: Debug (if stuck)
```bash
claude /debug "OAuth callback failing with 401"
# 5-phase analysis
# Root cause identification
# Fix recommendations
```

### Step 10: Generate Tests
```bash
claude /generate-tests src/auth/oauth.ts
# Creates comprehensive test suite
# Runs tests to verify
```

### Step 11: Document Solution
```bash
claude /workflows:compound "OAuth implementation with security best practices"
# Analyzes conversation
# Extracts key learnings
# Creates: .claude/solutions/auth/oauth-implementation.md
```

---

## 🔑 Key Principles

### 1. Separation of Concerns
- **Plan todos** - Implementation tasks from planning
- **Review todos** - Issues found in code review
- Never mix the two types

### 2. File-Based Todos
- All todos use `file-todos` skill
- YAML frontmatter for metadata
- Markdown content for details
- Version controlled with codebase

### 3. Parallel Agent Execution
- Planning: 4 agents in parallel
- Deepen: 40+ agents in parallel
- Review: 9-11 agents in parallel (9 core + up to 2 conditional)
- Maximum efficiency

### 4. Progressive Disclosure
- Start simple: `/workflows:plan`
- Add depth when needed: `/deepen-plan`
- Validate if uncertain: `/plan_review`
- Review before merge: `/workflows:review`
- Document learnings: `/workflows:compound`

### 5. Knowledge Compounding
- Each solution documented in `.claude/solutions/`
- Future planning searches past solutions
- Learning compounds over time
- Team knowledge grows automatically

---

## 📊 Agent Inventory

### Research Agents (4)
- **repo-research-analyst** - Repository structure, existing patterns, conventions
- **best-practices-researcher** - Industry best practices, standards, security
- **framework-docs-researcher** - Framework-specific documentation and patterns
- **spec-flow-analyzer** - User flow analysis, specification gap detection

### Review Agents (11)
- **senior-code-reviewer** - High-bar code quality standards
- **security-sentinel** - Security audits, vulnerability detection
- **performance-oracle** - Performance analysis and optimization
- **architecture-strategist** - Architectural decisions and compliance
- **pattern-recognition-specialist** - Code patterns and anti-patterns
- **data-integrity-guardian** - Database safety, migration validation
- **framework-conventions-reviewer** - Framework-specific conventions
- **kieran-typescript-reviewer** - TypeScript quality and conventions
- **data-migration-expert** - Production data migration validation
- **deployment-verification-agent** - Deployment risk assessment
- **code-simplicity-reviewer** - Simplicity and minimalism review

### Testing Agents (1)
- **test-coverage-analyzer** - Coverage gap analysis

### Workflow Agents (1)
- **spec-flow-analyzer** - Specification and flow analysis

---

## 📚 Skill Inventory

### Knowledge Management
- **compound-docs** - Document solved problems in `.claude/solutions/`
- **file-todos** - File-based todo system with YAML frontmatter

### Code Quality
- **error-analysis** - Systematic error analysis with root cause identification
- **framework-conventions-guide** - Framework-agnostic quality standards
- **refactoring-patterns** - Safe, systematic refactoring methodology
- **test-patterns** - Unit, integration, and API testing patterns

---

## 🚀 Getting Started

1. **Start with planning:**
   ```bash
   claude /workflows:plan "Your feature description"
   ```

2. **Execute the plan:**
   ```bash
   claude /workflows:work .claude/plans/your-plan.md
   ```

3. **Review your work:**
   ```bash
   claude /workflows:review PR-123
   ```

4. **Triage findings:**
   ```bash
   claude /triage
   ```

5. **Document learnings:**
   ```bash
   claude /workflows:compound "What you learned"
   ```

---

## 💡 Tips

- **Use `/deepen-plan`** when you need comprehensive research (spawns 40+ agents)
- **Use `/plan_review`** before starting work to catch issues early
- **Use `/triage`** to efficiently prioritize review findings
- **Use `/debug`** for systematic error analysis with 5-phase methodology
- **Use `/workflows:compound`** after solving hard problems to build team knowledge
- **Separate plan and review todos** - they serve different purposes
- **Run `/workflows:review`** after fixes to verify resolution

---

## 📖 Version History

See [CHANGELOG.md](plugins/compound-engineering/CHANGELOG.md) for detailed version history.
