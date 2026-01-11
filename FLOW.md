# Compound Engineering Plugin - Complete Workflow

**Philosophy:** Each unit of engineering work should make subsequent units of work easier—not harder.

**Core Cycle:** Plan → Delegate → Assess → Codify → Maintain

---

## 📋 Entry Points (Choose Your Starting Point)

```
┌─────────────────────┐     ┌─────────────────────┐     ┌─────────────────────┐
│ New Feature/Bug     │     │ Explore Codebase    │     │ Review Findings     │
│ Request             │     │ First               │     │ from Review         │
└──────────┬──────────┘     └──────────┬──────────┘     └──────────┬──────────┘
           │                           │                           │
           ▼                           ▼                           ▼
  ┌─────────────────┐        ┌─────────────────┐        ┌─────────────────┐
  │ /workflows:plan │        │ /code-map       │        │ /triage         │
  │                 │        │ /find-code      │        │                 │
  └─────────────────┘        └─────────────────┘        └─────────────────┘
```

---

## 🔄 Main Workflow Loop

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        PHASE 1: PLANNING (Parallel Agents)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                         /workflows:plan "Add OAuth login"
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
                    ▼                   ▼                   ▼
          ┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐
          │ agent            │ │ agent            │ │ agent            │
          │ repo-research-   │ │ best-practices-  │ │ framework-docs-  │
          │ analyst          │ │ researcher       │ │ researcher       │
          │                  │ │                  │ │                  │
          │ • Discovers      │ │ • Finds OAuth    │ │ • Rails/Django/  │
          │   existing auth  │ │   best practices │ │   Next.js auth   │
          │ • Similar code   │ │ • Industry       │ │   patterns       │
          │ • Conventions    │ │   standards      │ │ • Framework      │
          │                  │ │ • Security tips  │ │   conventions    │
          └──────────────────┘ └──────────────────┘ └──────────────────┘
                    │                   │                   │
                    └───────────────────┼───────────────────┘
                                        │
                    ┌───────────────────┴───────────────────┐
                    │                                       │
                    ▼                                       ▼
          ┌──────────────────┐                   ┌──────────────────┐
          │ agent            │                   │ skill            │
          │ spec-flow-       │                   │ compound-docs    │
          │ analyzer         │                   │ (searches        │
          │                  │                   │ .claude/         │
          │ • Validates user │                   │ solutions/)      │
          │   flows          │                   │                  │
          │ • Finds gaps     │                   │                  │
          └──────────────────┘                   └──────────────────┘
                    │                                       │
                    └───────────────────┬───────────────────┘
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
   parallel agents         to validate plan
   per section:            quality:
   • Per-section          • architecture-strategist
     research             • senior-code-reviewer
   • Review agents        • framework-conventions
   • Skill discovery      • pattern-recognition
   • Learning search
          │                            │
          └────────────────────────────┘
                       │
              Enhanced plan ready
                       │
                       ▼


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                    PHASE 2: IMPLEMENTATION (Tools + Agents + Skills)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                    /workflows:work .claude/plans/oauth-login.md
                                        │
                         Creates TodoWrite task list
                        (Phase 1, Step 3 - ONLY HERE)
                                        │
                            Setup environment:
                      git worktree or feature branch
                                        │
              ┌─────────────────────────┼─────────────────────────┐
              │                         │                         │
              ▼                         ▼                         ▼
    ┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
    │ Semantic Search  │     │ Impact Analysis  │     │ Pattern Discovery│
    │ /find-code       │     │ /trace-impact    │     │ skill:           │
    │ "oauth patterns" │     │ "auth_user"      │     │ framework-       │
    │                  │     │                  │     │ conventions      │
    │ Returns top 10   │     │ Shows all code   │     │                  │
    │ with context     │     │ that depends on  │     │ Discovers how    │
    │                  │     │ this function    │     │ team does auth   │
    └──────────────────┘     └──────────────────┘     └──────────────────┘
              │                         │                         │
              └─────────────────────────┼─────────────────────────┘
                                        │
              ┌─────────────────────────┼─────────────────────────┐
              │                         │                         │
              ▼                         ▼                         ▼
    ┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
    │ If stuck:        │     │ Need refactor:   │     │ Need tests:      │
    │ /debug [error]   │     │ /refactor        │     │ /generate-tests  │
    │                  │     │ /modernize       │     │                  │
    │ 5-phase analysis │     │                  │     │ Unit/Integration/│
    │ + fix            │     │ Safe with tests  │     │ E2E options      │
    └──────────────────┘     └──────────────────┘     └──────────────────┘
              │                         │                         │
              └─────────────────────────┼─────────────────────────┘
                                        │
                    Implements feature, writes tests, commits
                           TodoWrite tasks → completed
                                        │
                                        ▼
                              Create Pull Request
                                        │
                                        ▼


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                  PHASE 3: REVIEW (10-15 Parallel Agent Swarm)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                         /workflows:review PR-123
                                        │
                            Sets up git worktree
                                        │
          ┌─────────┬──────────┬────────┼────────┬──────────┬─────────┐
          │         │          │        │        │          │         │
          ▼         ▼          ▼        ▼        ▼          ▼         ▼
    ┌─────────┐ ┌─────────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
    │ agent   │ │ agent   │ │agent │ │agent │ │agent │ │agent │ │agent │
    │security-│ │perform- │ │senior│ │archi-│ │kieran│ │frame-│ │data- │
    │sentinel │ │ance-    │ │code- │ │tect- │ │python│ │work- │ │integ-│
    │         │ │oracle   │ │review│ │ure   │ │review│ │conven│ │rity  │
    │• SQL    │ │• N+1    │ │• Code│ │• SOLID│ │• Type│ │• Rails│ │• Migr│
    │• XSS    │ │• Memory │ │  qual│ │• Layer│ │  hints│ │ conven│ │ ation│
    │• CSRF   │ │• Slow   │ │• DRY │ │• Coupl│ │• PEP8│ │• REST │ │ valid│
    │• Auth   │ │  queries│ │• SOLID│ │  ing  │ │      │ │  API  │ │      │
    └─────────┘ └─────────┘ └──────┘ └──────┘ └──────┘ └──────┘ └──────┘
          │         │          │        │        │          │         │
          │         │          ▼        │        │          │         │
          │         │      ┌──────┐     │        │          │         │
          │         │      │agent │     │        │          │         │
          │         │      │pattern│    │        │          │         │
          │         │      │-recog│     │        │          │         │
          │         │      │      │     │        │          │         │
          │         │      │• Anti│     │        │          │         │
          │         │      │ -pat-│     │        │          │         │
          │         │      │ terns│     │        │          │         │
          │         │      └──────┘     │        │          │         │
          │         │          │        │        │          │         │
          └─────────┴──────────┼────────┴────────┴──────────┴─────────┘
                               │
            Uses skill: file-todos to create structured findings
                               │
              Writes to: .claude/todos/PR-123/
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
      ┌────────────┐   ┌────────────┐   ┌────────────┐
      │ p1-        │   │ p2-        │   │ p3-        │
      │ security-  │   │ performance│   │ style-     │
      │ sql-       │   │ -n-plus-   │   │ nits.md    │
      │ injection  │   │ 1.md       │   │            │
      │ .md        │   │            │   │ • Naming   │
      │            │   │ • 3 N+1    │   │ • Comments │
      │ • User     │   │   queries  │   │ • Format   │
      │   input    │   │ • Memory   │   │            │
      │   not      │   │   leak      │   │            │
      │   escaped  │   │            │   │            │
      └────────────┘   └────────────┘   └────────────┘
              │                │                │
              └────────────────┼────────────────┘
                               │
                               ▼


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                      PHASE 3.5: TRIAGE FINDINGS (Optional)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                              /triage
                                │
              Reads: .claude/todos/ (all pending findings)
                                │
              Uses skill: file-todos to manage todos
                                │
                    Present each finding to user:
                                │
        ┌───────────────────────┼───────────────────────┐
        │                       │                       │
        ▼                       ▼                       ▼
   User: "yes"            User: "next"           User: "custom"
   Add to CLI            Skip this              Modify priority/
   todo system           finding                description
        │                       │                       │
        └───────────────────────┼───────────────────────┘
                                │
              Creates TodoWrite tracking list:
              • Finding #1: SQL injection - approved
              • Finding #2: N+1 query - skipped
              • Finding #3: Style nit - custom P3
                                │
                                ▼
                    Prioritized action plan ready
                                │
                                ▼


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        PHASE 4: FIX ISSUES (Iterative)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                   /workflows:work .claude/todos/PR-123/p1-security-sql.md
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
                    ▼                   ▼                   ▼
          ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
          │ /debug       │    │ agent        │    │ skill:       │
          │ [error msg]  │    │ pr-comment-  │    │ refactoring- │
          │              │    │ resolver     │    │ patterns     │
          │ 5-phase:     │    │              │    │              │
          │ • Parse      │    │ Addresses    │    │ Safe         │
          │ • Categorize │    │ GitHub PR    │    │ refactoring  │
          │ • Root cause │    │ comments     │    │ techniques   │
          │ • Fix recs   │    │              │    │              │
          │ • Action plan│    │              │    │              │
          └──────────────┘    └──────────────┘    └──────────────┘
                    │                   │                   │
                    └───────────────────┼───────────────────┘
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
                    ▼                   ▼                   ▼
          ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
          │ /refactor    │    │ /generate-   │    │ /trace-      │
          │              │    │ tests        │    │ impact       │
          │ If code      │    │              │    │              │
          │ needs        │    │ Add tests    │    │ Verify fix   │
          │ restructure  │    │ for fix      │    │ doesn't break│
          │              │    │              │    │ other code   │
          └──────────────┘    └──────────────┘    └──────────────┘
                    │                   │                   │
                    └───────────────────┼───────────────────┘
                                        │
                    Push fixes, verify tests pass
                                        │
                                        ▼
                         Re-run: /workflows:review PR-123
                                        │
                      All P1s fixed? → MERGE PR
                                        │
                                        ▼


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                   PHASE 5: COMPOUND KNOWLEDGE (Parallel Docs)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                          /workflows:compound
                        "Fixed tricky SQL injection"
                                        │
          ┌─────────────┬───────────────┼───────────────┬─────────────┐
          │             │               │               │             │
          ▼             ▼               ▼               ▼             ▼
    ┌──────────┐  ┌──────────┐   ┌──────────┐   ┌──────────┐  ┌──────────┐
    │ Context  │  │ Solution │   │ Related  │   │ Prevent- │  │ Test     │
    │ Analyzer │  │ Extractor│   │ Docs     │   │ ion      │  │ Generator│
    │ (agent)  │  │ (agent)  │   │ Finder   │   │ Strategy │  │ (agent)  │
    │          │  │          │   │ (agent)  │   │ (agent)  │  │          │
    │ Extracts:│  │ Extracts:│   │ Searches:│   │ Creates: │  │ Suggests:│
    │ • Problem│  │ • Root   │   │ • .claude│   │ • How to │  │ • Test   │
    │   type   │  │   cause  │   │   /solut-│   │   prevent│  │   cases  │
    │ • Symp-  │  │ • Working│   │   ions/  │   │ • Best   │  │ • Regres-│
    │   toms   │  │   fix    │   │ • Similar│   │   pract- │  │   sion   │
    │ • CORA   │  │ • Code   │   │   issues │   │   ices   │  │   guards │
    │   schema │  │   changes│   │ • Links  │   │ • Checks │  │          │
    └──────────┘  └──────────┘   └──────────┘   └──────────┘  └──────────┘
          │             │               │               │             │
          └─────────────┴───────────────┼───────────────┴─────────────┘
                                        │
              Writes: .claude/solutions/2026-01-11-sql-injection-oauth.md
                                        │
                            With YAML frontmatter:
                              - problem_type
                              - component
                              - severity
                              - tags
                                        │
                      📚 KNOWLEDGE COMPOUNDS FOR NEXT TIME 📚
                                        │
              Next engineer searches: "SQL injection OAuth"
              Finds solution in 30 seconds instead of 3 hours
                                        │
                                        ▼


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                  PHASE 6: MAINTENANCE (Periodic, Parallel)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                       /workflows:maintain full
                      (Run weekly or monthly)
                                        │
          ┌─────────────┬───────────────┼───────────────┬─────────────┐
          │             │               │               │             │
          ▼             ▼               ▼               ▼             ▼
    ┌──────────┐  ┌──────────┐   ┌──────────┐   ┌──────────┐  ┌──────────┐
    │/update-  │  │/scan-    │   │/health-  │   │/analyze- │  │ agent    │
    │deps      │  │debt      │   │report    │   │coverage  │  │ debt-    │
    │          │  │          │   │          │   │          │  │ tracker  │
    │• Check   │  │• Tech    │   │• Overall │   │• Test    │  │          │
    │  outdated│  │  debt    │   │  health  │   │  gaps    │  │ Scores   │
    │• Security│  │  score   │   │• Metrics │   │• Missing │  │ and      │
    │  vulns   │  │• TODO    │   │• Trends  │   │  tests   │  │ priority │
    │• Breaking│  │  count   │   │• Issues  │   │• Branch  │  │          │
    │  changes │  │• Complex │   │• Warnings│   │  coverage│  │          │
    │• Auto PR │  │  files   │   │          │   │          │  │          │
    └──────────┘  └──────────┘   └──────────┘   └──────────┘  └──────────┘
          │             │               │               │             │
          └─────────────┴───────────────┼───────────────┴─────────────┘
                                        │
                     Generates comprehensive reports
                                        │
              If debt too high or coverage low:
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
                    ▼                   ▼                   ▼
          ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
          │ /refactor    │    │ /modernize   │    │ /generate-   │
          │              │    │              │    │ tests        │
          │ Fix complex  │    │ Update old   │    │              │
          │ code         │    │ patterns     │    │ Increase     │
          │              │    │              │    │ coverage     │
          └──────────────┘    └──────────────┘    └──────────────┘
                    │                   │                   │
                    └───────────────────┼───────────────────┘
                                        │
                              CODEBASE STAYS HEALTHY
                                        │
                                        ▼

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 🛠️ Specialized Workflows (Side Paths)

### 1. Debugging Workflow

```
                              /debug [error or file]
                                        │
                      ┌─────────────────┼─────────────────┐
                      │                 │                 │
                      ▼                 ▼                 ▼
           ┌────────────────┐ ┌────────────────┐ ┌────────────────┐
           │ Phase 1:       │ │ Phase 2:       │ │ Phase 3:       │
           │ Parse & Info   │ │ Categorize     │ │ Root Cause     │
           │                │ │                │ │                │
           │ • Error msg    │ │ • Type         │ │ • Investigation│
           │ • Stack trace  │ │ • Severity     │ │ • Hypotheses   │
           │ • Frequency    │ │ • Impact       │ │ • Analysis     │
           │ • Environment  │ │ • Component    │ │                │
           └────────────────┘ └────────────────┘ └────────────────┘
                      │                 │                 │
                      └─────────────────┼─────────────────┘
                                        │
                      ┌─────────────────┼─────────────────┐
                      │                 │                 │
                      ▼                 ▼                 ▼
           ┌────────────────┐ ┌────────────────┐ ┌────────────────┐
           │ Phase 4:       │ │ Phase 5:       │ │ Uses:          │
           │ Fix Recs       │ │ Action Items   │ │ skill:         │
           │                │ │                │ │ error-analysis │
           │ • Hotfix       │ │ • Create todos │ │                │
           │ • Long-term    │ │ • Priority     │ │ Systematic     │
           │ • Prevention   │ │ • Track with   │ │ debugging      │
           │                │ │   TodoWrite    │ │ methodology    │
           └────────────────┘ └────────────────┘ └────────────────┘
                      │                 │                 │
                      └─────────────────┼─────────────────┘
                                        │
                      Implement fix → Document with
                                  /workflows:compound
                                        │
                                        ▼
```

---

### 2. Semantic Code Exploration (llm-tldr)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    llm-tldr Integration Workflow                         │
│                    (95-99% token reduction)                              │
└─────────────────────────────────────────────────────────────────────────┘

                    First time? Run: skill tldr-setup
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
              ▼                 ▼                 ▼
    ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
    │ Check if     │  │ Install      │  │ Index        │
    │ installed    │  │ llm-tldr     │  │ codebase     │
    │              │  │ (pip)        │  │              │
    │ Python 3.7+? │  │ .tldrignore  │  │ Start daemon │
    └──────────────┘  └──────────────┘  └──────────────┘
              │                 │                 │
              └─────────────────┼─────────────────┘
                                │
                        Ready to use!
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
              ▼                 ▼                 ▼
    ┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐
    │ /code-map        │ │ /find-code       │ │ /trace-impact    │
    │                  │ │ [query]          │ │ [function]       │
    │ Architecture     │ │                  │ │                  │
    │ overview:        │ │ Semantic search: │ │ Impact analysis: │
    │ • Patterns (MVC, │ │ • Natural lang   │ │ • All callers    │
    │   layered, etc)  │ │ • "JWT token     │ │ • Direct +       │
    │ • Call graph     │ │   validation"    │ │   transitive     │
    │ • Dead code      │ │ • Top 10 matches │ │ • Dependency tree│
    │ • Module         │ │ • Similarity     │ │ • Test coverage  │
    │   coupling       │ │   scores         │ │ • Risk level     │
    │ • Layer          │ │ • Context        │ │                  │
    │   violations     │ │   extraction     │ │                  │
    │                  │ │                  │ │                  │
    │ Writes to:       │ │ Writes to:       │ │ Writes to:       │
    │ .claude/         │ │ .claude/         │ │ .claude/         │
    │ architecture/    │ │ research/        │ │ research/        │
    └──────────────────┘ └──────────────────┘ └──────────────────┘
              │                 │                 │
              └─────────────────┼─────────────────┘
                                │
                      ┌─────────┼─────────┐
                      │         │         │
                      ▼         ▼         ▼
            ┌──────────────────────────────────┐
            │ Skills (used by agents):         │
            │                                  │
            │ • skill: tldr-context            │
            │   99% token reduction            │
            │   Function → summary + deps      │
            │                                  │
            │ • skill: tldr-semantic-search    │
            │   Natural language queries       │
            │   100ms with daemon              │
            │                                  │
            │ • skill: tldr-architecture       │
            │   Pattern detection              │
            │   Coupling analysis              │
            └──────────────────────────────────┘
                                │
                    Used by 9 enhanced agents:
                    • security-sentinel
                    • performance-oracle
                    • senior-code-reviewer
                    • framework-conventions-reviewer
                    • architecture-strategist
                    • repo-research-analyst
                    • git-history-analyzer
                    • framework-docs-researcher
                    • library-readme-writer
                                │
                                ▼
```

---

### 3. Refactoring Workflows

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Refactoring Workflows                             │
└─────────────────────────────────────────────────────────────────────────┘

          ┌─────────────────────┐            ┌─────────────────────┐
          │ /refactor           │            │ /modernize          │
          │                     │            │                     │
          │ Safe refactoring    │            │ Update to modern    │
          │ with test verify    │            │ patterns/APIs       │
          └──────────┬──────────┘            └──────────┬──────────┘
                     │                                  │
          AskUserQuestion:                   AskUserQuestion:
          Strategy?                          Aggressiveness?
          • Incremental (recommended)        • Conservative (recommended)
          • Comprehensive                    • Balanced
          • Interactive                      • Aggressive
                     │                                  │
                     ▼                                  ▼
          ┌─────────────────────┐            ┌─────────────────────┐
          │ Uses:               │            │ Uses:               │
          │ • skill:            │            │ • skill:            │
          │   refactoring-      │            │   refactoring-      │
          │   patterns          │            │   patterns          │
          │                     │            │                     │
          │ • /trace-impact     │            │ • /trace-impact     │
          │   (verify safe)     │            │   (check breaking)  │
          │                     │            │                     │
          │ • /generate-tests   │            │ • /generate-tests   │
          │   (regression)      │            │   (new patterns)    │
          └──────────┬──────────┘            └──────────┬──────────┘
                     │                                  │
                     └──────────────┬───────────────────┘
                                    │
                          Run tests after each
                          refactoring step
                                    │
                                    ▼
```

---

### 4. Testing & Documentation Workflows

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    Testing & Documentation Workflows                     │
└─────────────────────────────────────────────────────────────────────────┘

    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
    │ /generate-   │    │ /generate-   │    │ /analyze-    │
    │ tests        │    │ api-tests    │    │ coverage     │
    └──────┬───────┘    └──────┬───────┘    └──────┬───────┘
           │                   │                   │
    AskUserQuestion:    Uses:              Analyzes:
    Testing approach?   • skill:           • Coverage gaps
    • Unit (recom.)       api-            • Untested paths
    • Integration         documentation   • Critical missing
    • E2E               • skill:           • Suggests tests
    • Balanced pyramid    test-patterns
           │                   │                   │
           └───────────────────┼───────────────────┘
                               │
                     Uses skill: test-patterns
                               │
                               ▼
          Generates comprehensive test suites
                               │
                               ▼

    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
    │ /document-   │    │ /generate-   │    │ agent:       │
    │ api          │    │ onboarding   │    │ library-     │
    │              │    │              │    │ readme-writer│
    └──────┬───────┘    └──────┬───────┘    └──────┬───────┘
           │                   │                   │
    AskUserQuestion:    AskUserQuestion:    Uses:
    Format? (multi)     Sections? (multi)   • skill:
    • OpenAPI           • Architecture         library-writer
    • Swagger           • Setup             • Best practices
    • Markdown          • Codebase tour     • Examples
    • Postman           • Key decisions
           │                   │                   │
           └───────────────────┼───────────────────┘
                               │
                Uses skill: api-documentation
                Uses skill: onboarding-docs
                               │
                               ▼
```

---

## 📂 File Organization (Where Everything Lives)

```
.claude/
├── plans/               # From: /workflows:plan
│   └── YYYY-MM-DD-feature-name.md
│
├── solutions/           # From: /workflows:compound
│   └── YYYY-MM-DD-problem-solution.md
│       (YAML frontmatter for search)
│
├── todos/               # From: /workflows:review
│   └── PR-123/
│       ├── p1-security-sql.md
│       ├── p2-performance-n+1.md
│       └── p3-style-nits.md
│
├── architecture/        # From: /code-map
│   └── YYYY-MM-DD-architecture-report.md
│
└── research/            # From: /find-code, /trace-impact
    └── YYYY-MM-DD-semantic-search-results.md
```

---

## 🎯 Quick Reference: When to Use What

| Scenario | Command | What It Does |
|----------|---------|--------------|
| **Starting new feature** | `/workflows:plan` | 3 parallel research agents → plan file |
| **Deepening a plan** | `/deepen-plan` | 40+ agents research each section |
| **Reviewing a plan** | `/plan_review` | Review agents validate plan quality |
| **Implementing feature** | `/workflows:work` | Execute plan with quality |
| **Code review PR** | `/workflows:review` | 10-15 parallel agents → findings |
| **Triage findings** | `/triage` | Categorize/prioritize todos |
| **Debugging error** | `/debug` | 5-phase systematic analysis |
| **Finding similar code** | `/find-code` | Semantic search (not keywords) |
| **Understanding architecture** | `/code-map` | Architecture patterns + call graph |
| **Checking impact** | `/trace-impact` | All code affected by change |
| **Refactoring code** | `/refactor` | Safe refactoring with tests |
| **Modernizing code** | `/modernize` | Update to modern patterns |
| **Generating tests** | `/generate-tests` | Unit/integration/E2E tests |
| **Documenting solution** | `/workflows:compound` | 5 parallel agents → knowledge base |
| **Maintaining health** | `/workflows:maintain` | 4 parallel maintenance tasks |

---

## 🔑 Key Principles

1. **Massive Parallelism** - Commands spawn 3-40+ agents simultaneously
2. **Structured Knowledge** - Everything written to `.claude/` with consistent naming
3. **Compounding Returns** - Each solution documented makes next occurrence instant
4. **Quality Gates** - Review before merge, test as you code
5. **Follow Patterns** - Discover and use existing conventions
6. **Skills as Libraries** - Reusable expertise (26 skills)
7. **MCP Integration** - External tools (playwright, context7, tldr)

---

## 🚀 First Time Using the Plugin?

```bash
# 1. Plan your first feature
/workflows:plan "Add user profile page"

# 2. Deepen it (optional but recommended)
/deepen-plan .claude/plans/2026-01-11-user-profile.md

# 3. Implement it
/workflows:work .claude/plans/2026-01-11-user-profile.md

# 4. Review it
/workflows:review PR-456

# 5. Triage findings (if many)
/triage

# 6. Fix P1 issues
/workflows:work .claude/todos/PR-456/p1-security.md

# 7. Document what you learned
/workflows:compound

# 8. Maintain codebase health
/workflows:maintain quick
```

**Each cycle makes the next one easier. That's compounding engineering.** 🎯

---

## 📊 Component Inventory

- **38 Agents** - Specialized experts (review, research, docs, testing, etc.)
- **36 Commands** - Workflow automation + utilities
- **26 Skills** - Reusable knowledge libraries
- **3 MCP Servers** - External integrations (playwright, context7, tldr)

---

## 💡 Philosophy in Practice

```
First time solving a problem:  3 hours of research
Document with /workflows:compound
Next time same problem:        30 seconds to find solution

First PR review:               Manual, slow, might miss issues
Use /workflows:review:         10+ agents, comprehensive, fast
Next PR review:                Same quality, repeatable

Understanding new codebase:    Days of exploration
Use /code-map + /find-code:   30 minutes to architecture map
Every search after:            Instant semantic search
```

**This is compounding engineering. Each unit of work makes the next unit easier.** ✨
