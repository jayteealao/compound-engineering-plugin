# Changelog

All notable changes to the compound-engineering plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.31.0] - 2026-01-10

### Added

**New `/debug` command for unified error analysis**

Added comprehensive debugging workflow command that provides systematic error analysis, root cause identification, and automated fix recommendations:

**Features:**
- **Unified workflow**: Single command to analyze errors, stack traces, and log files
- **Multiple input modes**: Inline errors, pasted stack traces, or log file paths
- **Automatic agent invocation**: Launches `error-analyst` agent with full context
- **5-phase tracking**: TodoWrite integration for progress visibility
  1. Parse error information and extract key details
  2. Categorize error type and severity
  3. Perform root cause analysis
  4. Generate fix recommendations (hotfix + long-term)
  5. Create action items and todos
- **Structured analysis reports**: Comprehensive reports with error classification, RCA, timelines, and hypotheses
- **Auto-create todos**: Automatically generates todo files in `.claude/todos/` for all recommended fixes:
  - Immediate fixes → `{id}-ready-p1-*.md` (Priority 1)
  - Short-term fixes → `{id}-ready-p2-*.md` (Priority 2)
  - Long-term fixes → `{id}-pending-p3-*.md` (Priority 3)
- **Integration**: Works with `error-analyst` agent, `error-analysis` skill, and `file-todos` patterns

**Usage examples:**
```bash
/debug "TypeError: Cannot read property 'id' of undefined"
/debug logs/application.log
/debug  # Interactive mode
```

**New `debugging-workflow` skill**

Added comprehensive debugging methodology skill that provides structured approaches to systematic debugging:

**Content:**
- **Hypothesis-driven debugging**: Scientific method applied to bugs (observe, hypothesize, test, verify)
- **4-phase debugging process**: Gather information → Form hypotheses → Test hypotheses → Verify root cause
- **Reproduction strategies**: Minimal reproduction, isolate variables, consistent environments
- **Fix validation workflows**: Local → Staging → Production verification with monitoring
- **Binary search debugging**: Git bisect, code scope narrowing, data narrowing techniques
- **Error-type checklists**: Specific checklists for null references, network errors, performance, race conditions
- **Tool selection guide**: When to use logs vs debugger vs tests vs print statements
- **Best practices**: Documentation, avoiding common pitfalls, integration with error-analysis

**Properties:**
- Set as `user-invocable: false` (auto-discovered by Claude during debugging)
- Uses `context: fork` for isolated execution
- Complements existing `error-analysis` skill

**Component counts:**
- Commands: 32 → 33 (+1: `/debug`)
- Skills: 21 → 22 (+1: `debugging-workflow`)
- Agents: 38 (unchanged)

---

## [2.30.1] - 2026-01-10

### Fixed

**Documentation site updates**

Updated the documentation website to reflect the latest plugin changes from v2.30.0:
- Updated landing page (index.html) with current component counts
- Updated agents reference page with all 38 agents
- Updated commands reference page with all 32 commands
- Updated skills reference page with all 21 skills
- Updated MCP servers reference page
- Updated changelog page with v2.30.0 and v2.30.1 release notes

**Note:** These documentation files were inadvertently not included in the v2.30.0 commit and are now being added.

---

## [2.30.0] - 2026-01-10

### Added

**TodoWrite tracking for multi-step commands (15 commands enhanced)**

Commands with complex workflows now use TodoWrite tool for progress tracking, providing users with real-time visibility into multi-phase operations:

**High-priority commands:**
- **`/deepen-plan`** - Track 9-phase plan enhancement with parallel agents (skills, learnings, research, review)
- **`/release-docs`** - Track component inventory and 14 documentation/metadata updates
- **`/feature-video`** - Track 9-step video recording workflow (setup, record, upload, PR update)
- **`/triage`** - Track finding-by-finding progress through approval/skip decisions

**Testing/analysis commands:**
- **`/playwright-test`** - Track multi-step browser testing with dynamic route additions
- **`/xcode-test`** - Track 11-step iOS testing workflow (build, install, test, cleanup)
- **`/scan-debt`** - Track multi-category debt scanning (5 categories + scoring)
- **`/health-report`** - Track multi-metric collection (6 metrics + analysis)

**Refactoring commands:**
- **`/refactor`** - Track incremental refactoring steps with test verification
- **`/modernize`** - Track multi-phase modernization (syntax, API, architecture, dependencies)
- **`/update-deps`** - Track 4-phase dependency updates with test runs after each phase

**Documentation/generation commands:**
- **`/generate-onboarding`** - Track multi-section documentation generation
- **`/analyze-coverage`** - Track coverage analysis and gap identification
- **`/generate-api-tests`** - Track endpoint-by-endpoint test generation
- **`/heal-skill`** - Track skill file correction workflow

**Command-skill bindings via `allowed-tools` (13 commands configured)**

Commands now declare their related skills for automatic invocation without permission requests:

**Workflow commands:**
- **`/triage`** → `Skill(file-todos)`
- **`/scan-debt`** → `Skill(technical-debt)`
- **`/health-report`** → `Skill(technical-debt)`

**Refactoring commands:**
- **`/refactor`** → `Skill(refactoring-patterns)`
- **`/modernize`** → `Skill(refactoring-patterns)`
- **`/update-deps`** → `Skill(dependency-management)`

**Testing commands:**
- **`/generate-tests`** → `Skill(test-patterns)`
- **`/generate-api-tests`** → `Skill(api-documentation), Skill(test-patterns)`
- **`/analyze-coverage`** → `Skill(test-patterns)`
- **`/playwright-test`** → `Skill(test-patterns)`
- **`/xcode-test`** → `Skill(test-patterns)`

**Documentation commands:**
- **`/document-api`** → `Skill(api-documentation)`
- **`/generate-onboarding`** → `Skill(onboarding-docs)`

### Summary

- 38 agents, 32 commands, 21 skills, 2 MCP servers
- **Improved UX:** 15 commands with TodoWrite progress tracking for complex workflows
- **Improved integration:** 13 commands with automatic skill invocation via `allowed-tools`
- Commands now provide real-time progress visibility and apply relevant skill patterns automatically

---

## [2.29.0] - 2026-01-10

### Changed

**Improved skill visibility: Hidden 6 pattern/guidance skills from slash command menu**

Skills that teach Claude how to perform tasks are now hidden from the user-facing slash command menu and instead auto-discovered based on context. This reduces menu clutter while maintaining full functionality through automatic skill discovery.

#### Additional Skills with `user-invocable: false` (6 new, 8 total)

Pattern and guidance skills now hidden from menu:
- **`create-agent-skills`** - Guides skill creation (auto-invoked when helping create skills)
- **`framework-conventions-guide`** - Framework-native code patterns (auto-applied when writing framework code)
- **`library-writer`** - Library development patterns (auto-applied when writing libraries)
- **`llm-application-patterns`** - LLM application patterns (auto-applied when building LLM apps)
- **`refactoring-patterns`** - Safe refactoring patterns (auto-applied when refactoring code)
- **`test-patterns`** - Test generation patterns (auto-applied when writing tests)

Previously hidden (unchanged):
- **`skill-creator`** - Used by /create-agent-skill command
- **`every-style-editor`** - Used by every-style-editor agent

### Summary

- 38 agents, 32 commands, 21 skills, 2 MCP servers
- Visibility: 8 skills hidden from menu (auto-discovered), 13 skills visible in menu (user-invocable)
- Improved UX: Cleaner slash command menu with only workflow/utility skills visible

---

## [2.28.0] - 2026-01-08

### Added

**Claude Code 2.1.0 feature adoption: hooks, context isolation, visibility control**

#### Skills with `context: fork` (4)

Heavy processing skills now run in isolated forked context:
- **`test-patterns`** - Test generation runs in isolated context
- **`refactoring-patterns`** - Refactoring operations run in isolated context
- **`technical-debt`** - Debt scanning runs in isolated context
- **`dependency-management`** - Dependency audits run in isolated context

#### Skills with `user-invocable: false` (2)

Reference-only skills hidden from slash command menu:
- **`skill-creator`** - Used by /create-agent-skill command
- **`every-style-editor`** - Used by every-style-editor agent

#### Commands with PreToolUse Hooks (3)

- **`/refactor`** - Verifies git status before edits
- **`/update-deps`** - Creates lockfile backups before dependency changes (npm, pip, bundle)
- **`/modernize`** - Verifies git status before edits

#### Agents with PostToolUse Hooks (2)

- **`refactoring-assistant`** - Notifies after edits complete
- **`code-modernizer`** - Notifies after modernization edits

### Summary

- 38 agents, 32 commands, 21 skills, 2 MCP servers
- New features: 4 skills with forked context, 2 hidden skills, 3 commands with hooks, 2 agents with hooks

---

## [2.27.0] - 2026-01-08

### Added

**Major expansion: 7 new skills, 11 new agents, 12 new commands, 1 new workflow**

#### New Skills (7)

- **`test-patterns` skill** - Generate and organize tests following project conventions. References: unit-test-patterns, integration-test-patterns, test-data-factories, coverage-strategies.
- **`api-documentation` skill** - Generate and maintain API documentation with OpenAPI patterns. References: openapi-patterns, endpoint-documentation, example-generation, versioning-docs.
- **`technical-debt` skill** - Track and categorize technical debt with scoring. References: debt-categories, debt-scoring, debt-frontmatter, debt-resolution. Output: `.claude/debt/` directory.
- **`onboarding-docs` skill** - Generate developer onboarding documentation. References: architecture-overview, setup-guide, code-tour, decision-log.
- **`dependency-management` skill** - Manage project dependencies safely. References: update-strategies, security-audit, compatibility-matrix, changelog-analysis.
- **`error-analysis` skill** - Analyze errors and logs systematically. References: log-patterns, root-cause-analysis, error-categorization, fix-patterns.
- **`refactoring-patterns` skill** - Safe, systematic refactoring patterns. References: extract-patterns, rename-patterns, move-patterns, simplify-patterns.

#### New Agents (11)

**Testing Agents (agents/testing/)**
- **`test-generator` agent** - Generate comprehensive tests following project conventions
- **`test-coverage-analyzer` agent** - Analyze coverage gaps and suggest tests
- **`api-test-generator` agent** - Generate API/integration tests from endpoints

**Documentation Agents (agents/docs/)**
- **`api-docs-generator` agent** - Generate OpenAPI/Swagger documentation
- **`onboarding-generator` agent** - Create onboarding docs for new developers

**Analysis Agents (agents/analysis/)**
- **`debt-tracker` agent** - Scan codebase for technical debt with scoring
- **`codebase-health` agent** - Generate comprehensive health reports
- **`dependency-auditor` agent** - Audit dependencies for updates/vulnerabilities
- **`error-analyst` agent** - Analyze error logs and stack traces

**Refactoring Agents (agents/refactoring/)**
- **`refactoring-assistant` agent** - Plan and execute safe refactorings
- **`code-modernizer` agent** - Update code to modern patterns/APIs

#### New Commands (12)

**Testing Commands**
- **`/generate-tests`** - Generate tests for specified files or features
- **`/analyze-coverage`** - Analyze test coverage and identify gaps
- **`/generate-api-tests`** - Generate API tests from endpoints

**Documentation Commands**
- **`/document-api`** - Generate or update API documentation
- **`/generate-onboarding`** - Generate onboarding documentation

**Analysis Commands**
- **`/scan-debt`** - Scan codebase for technical debt
- **`/health-report`** - Generate comprehensive health report
- **`/update-deps`** - Safely update dependencies

**Refactoring Commands**
- **`/refactor`** - Plan and execute safe refactorings (extract/rename/move/simplify)
- **`/modernize`** - Update code to modern patterns

#### New Workflow

- **`/workflows:maintain`** - Systematic maintenance workflow combining dependency audit, debt scan, coverage analysis, and health reporting. Modes: full, quick, deps, debt, tests.

### Summary

- 38 agents, 32 commands, 21 skills, 2 MCP servers

---

## [2.26.0] - 2026-01-08

### Changed

- **Generalized Ruby-specific components** - Replaced all Ruby/Rails-specific agents and skills with language-agnostic equivalents that work for any framework or language.
- **Standardized file output paths to `.claude/`** - All commands and skills now write non-code files to `.claude/` directory instead of top-level directories:
  - `.claude/plans/` - Implementation plans (from `plans/`)
  - `.claude/todos/` - Todo tracking (from `todos/`)
  - `.claude/solutions/` - Solved problem documentation (from `docs/solutions/`)
  - Updated: `workflows:plan`, `workflows:review`, `workflows:compound`, `deepen-plan`, `triage`, `resolve_todo_parallel`, `playwright-test`, `xcode-test`, `file-todos` skill, `compound-docs` skill (including references)
- **Updated agent references in commands** - Replaced all references to removed Ruby-specific agents with their generic equivalents in `plan_review`, `workflows:review`, `workflows:work`, `workflows:compound`, and `deepen-plan`

### Added

- **`framework-conventions-reviewer` agent** - Review code against framework conventions (Django, Laravel, Next.js, Spring Boot, Phoenix, etc.). Fights complexity, enforces conventions, mocks over-engineering.
- **`senior-code-reviewer` agent** - High-bar code review with strict quality standards. Strict on modifications, pragmatic on new code, obsessive about testability and naming.
- **`library-readme-writer` agent** - Create READMEs for any library/package with proven best practices. 15-word sentences, imperative voice, proper section ordering.
- **`framework-conventions-guide` skill** - Write code following framework conventions for any opinionated framework. Includes universal patterns (REST mapping, state as data, naming) and anti-patterns to avoid.
- **`llm-application-patterns` skill** - Build production LLM applications with structured, testable patterns. Covers signatures, modules, providers, testing, and optimization.
- **`library-writer` skill** - Write libraries with minimal dependencies, clean APIs, and framework integration without coupling.

### Removed

- **`dhh-rails-reviewer` agent** - Replaced by `framework-conventions-reviewer`
- **`kieran-rails-reviewer` agent** - Replaced by `senior-code-reviewer`
- **`ankane-readme-writer` agent** - Replaced by `library-readme-writer`
- **`dhh-rails-style` skill** - Replaced by `framework-conventions-guide`
- **`dspy-ruby` skill** - Replaced by `llm-application-patterns`
- **`andrew-kane-gem-writer` skill** - Replaced by `library-writer`

### Summary

- 27 agents, 20 commands, 14 skills, 2 MCP servers

---

## [2.23.0] - 2025-01-07

### Added

- **`claude-workspace` skill** - Organize working files in `.claude/` directory with enforced structure, naming conventions, and required cross-references. Features:
  - **5 categories**: plans/, architecture/, examples/, research/, analysis/
  - **Category indexes**: Each category has auto-generated INDEX.md
  - **Required cross-references**: Every file must link to codebase files and related .claude/ docs
  - **Date-prefixed naming**: `YYYY-MM-DD-description.md` convention
  - **YAML frontmatter**: Category-specific schemas with validation
  - **4 workflows**: create-file, update-index, validate-workspace, migrate-existing

### Summary

- 27 agents, 20 commands, 14 skills, 2 MCP servers

---

## [2.22.0] - 2026-01-05

### Added

- **`rclone` skill** - Upload files to S3, Cloudflare R2, Backblaze B2, and other cloud storage providers

### Changed

- **`/feature-video` command** - Enhanced with:
  - Better ffmpeg commands for video/GIF creation (proper scaling, framerate control)
  - rclone integration for cloud uploads
  - Screenshot copying to project folder
  - Improved upload options workflow

### Summary

- 27 agents, 20 commands, 13 skills, 2 MCP servers

---

## [2.21.0] - 2026-01-05

### Fixed

- Version history cleanup after merge conflict resolution

### Summary

This release consolidates all recent work:
- `/feature-video` command for recording PR demos
- `/deepen-plan` command for enhanced planning
- `create-agent-skills` skill rewrite (official spec compliance)
- `agent-native-architecture` skill major expansion
- `dhh-rails-style` skill consolidation (merged dhh-ruby-style)
- 27 agents, 20 commands, 12 skills, 2 MCP servers

---

## [2.20.0] - 2026-01-05

### Added

- **`/feature-video` command** - Record video walkthroughs of features using Playwright

### Changed

- **`create-agent-skills` skill** - Complete rewrite to match Anthropic's official skill specification

### Removed

- **`dhh-ruby-style` skill** - Merged into `dhh-rails-style` skill

---

## [2.19.0] - 2025-12-31

### Added

- **`/deepen-plan` command** - Power enhancement for plans. Takes an existing plan and runs parallel research sub-agents for each major section to add:
  - Best practices and industry patterns
  - Performance optimizations
  - UI/UX improvements (if applicable)
  - Quality enhancements and edge cases
  - Real-world implementation examples

  The result is a deeply grounded, production-ready plan with concrete implementation details.

### Changed

- **`/workflows:plan` command** - Added `/deepen-plan` as option 2 in post-generation menu. Added note: if running with ultrathink enabled, automatically run deepen-plan for maximum depth.

## [2.18.0] - 2025-12-25

### Added

- **`agent-native-architecture` skill** - Added **Dynamic Capability Discovery** pattern and **Architecture Review Checklist**:

  **New Patterns in mcp-tool-design.md:**
  - **Dynamic Capability Discovery** - For external APIs (HealthKit, HomeKit, GraphQL), build a discovery tool (`list_*`) that returns available capabilities at runtime, plus a generic access tool that takes strings (not enums). The API validates, not your code. This means agents can use new API capabilities without code changes.
  - **CRUD Completeness** - Every entity the agent can create must also be readable, updatable, and deletable. Incomplete CRUD = broken action parity.

  **New in SKILL.md:**
  - **Architecture Review Checklist** - Pushes reviewer findings earlier into the design phase. Covers tool design (dynamic vs static, CRUD completeness), action parity (capability map, edit/delete), UI integration (agent → UI communication), and context injection.
  - **Option 11: API Integration** - New intake option for connecting to external APIs like HealthKit, HomeKit, GraphQL
  - **New anti-patterns:** Static Tool Mapping (building individual tools for each API endpoint), Incomplete CRUD (create-only tools)
  - **Tool Design Criteria** section added to success criteria checklist

  **New in shared-workspace-architecture.md:**
  - **iCloud File Storage for Multi-Device Sync** - Use iCloud Documents for your shared workspace to get free, automatic multi-device sync without building a sync layer. Includes implementation pattern, conflict handling, entitlements, and when NOT to use it.

### Philosophy

This update codifies a key insight for **agent-native apps**: when integrating with external APIs where the agent should have the same access as the user, use **Dynamic Capability Discovery** instead of static tool mapping. Instead of building `read_steps`, `read_heart_rate`, `read_sleep`... build `list_health_types` + `read_health_data(dataType: string)`. The agent discovers what's available, the API validates the type.

Note: This pattern is specifically for agent-native apps following the "whatever the user can do, the agent can do" philosophy. For constrained agents with intentionally limited capabilities, static tool mapping may be appropriate.

---

## [2.17.0] - 2025-12-25

### Enhanced

- **`agent-native-architecture` skill** - Major expansion based on real-world learnings from building the Every Reader iOS app. Added 5 new reference documents and expanded existing ones:

  **New References:**
  - **dynamic-context-injection.md** - How to inject runtime app state into agent system prompts. Covers context injection patterns, what context to inject (resources, activity, capabilities, vocabulary), implementation patterns for Swift/iOS and TypeScript, and context freshness.
  - **action-parity-discipline.md** - Workflow for ensuring agents can do everything users can do. Includes capability mapping templates, parity audit process, PR checklists, tool design for parity, and context parity guidelines.
  - **shared-workspace-architecture.md** - Patterns for agents and users working in the same data space. Covers directory structure, file tools, UI integration (file watching, shared stores), agent-user collaboration patterns, and security considerations.
  - **agent-native-testing.md** - Testing patterns for agent-native apps. Includes "Can Agent Do It?" tests, the Surprise Test, automated parity testing, integration testing, and CI/CD integration.
  - **mobile-patterns.md** - Mobile-specific patterns for iOS/Android. Covers background execution (checkpoint/resume), permission handling, cost-aware design (model tiers, token budgets, network awareness), offline handling, and battery awareness.

  **Updated References:**
  - **architecture-patterns.md** - Added 3 new patterns: Unified Agent Architecture (one orchestrator, many agent types), Agent-to-UI Communication (shared data store, file watching, event bus), and Model Tier Selection (fast/balanced/powerful).

  **Updated Skill Root:**
  - **SKILL.md** - Expanded intake menu (now 10 options including context injection, action parity, shared workspace, testing, mobile patterns). Added 5 new agent-native anti-patterns (Context Starvation, Orphan Features, Sandbox Isolation, Silent Actions, Capability Hiding). Expanded success criteria with agent-native and mobile-specific checklists.

- **`agent-native-reviewer` agent** - Significantly enhanced with comprehensive review process covering all new patterns. Now checks for action parity, context parity, shared workspace, tool design (primitives vs workflows), dynamic context injection, and mobile-specific concerns. Includes detailed anti-patterns, output format template, quick checks ("Write to Location" test, Surprise test), and mobile-specific verification.

### Philosophy

These updates operationalize a key insight from building agent-native mobile apps: **"The agent should be able to do anything the user can do, through tools that mirror UI capabilities, with full context about the app state."** The failure case that prompted these changes: an agent asked "what reading feed?" when a user said "write something in my reading feed"—because it had no `publish_to_feed` tool and no context about what "feed" meant.

## [2.16.0] - 2025-12-21

### Enhanced

- **`dhh-rails-style` skill** - Massively expanded reference documentation incorporating patterns from Marc Köhlbrugge's Unofficial 37signals Coding Style Guide:
  - **controllers.md** - Added authorization patterns, rate limiting, Sec-Fetch-Site CSRF protection, request context concerns
  - **models.md** - Added validation philosophy, let it crash philosophy (bang methods), default values with lambdas, Rails 7.1+ patterns (normalizes, delegated types, store accessor), concern guidelines with touch chains
  - **frontend.md** - Added Turbo morphing best practices, Turbo frames patterns, 6 new Stimulus controllers (auto-submit, dialog, local-time, etc.), Stimulus best practices, view helpers, caching with personalization, broadcasting patterns
  - **architecture.md** - Added path-based multi-tenancy, database patterns (UUIDs, state as records, hard deletes, counter caches), background job patterns (transaction safety, error handling, batch processing), email patterns, security patterns (XSS, SSRF, CSP), Active Storage patterns
  - **gems.md** - Added expanded what-they-avoid section (service objects, form objects, decorators, CSS preprocessors, React/Vue), testing philosophy with Minitest/fixtures patterns

### Credits

- Reference patterns derived from [Marc Köhlbrugge's Unofficial 37signals Coding Style Guide](https://github.com/marckohlbrugge/unofficial-37signals-coding-style-guide)

## [2.15.2] - 2025-12-21

### Fixed

- **All skills** - Fixed spec compliance issues across 12 skills:
  - Reference files now use proper markdown links (`[file.md](./references/file.md)`) instead of backtick text
  - Descriptions now use third person ("This skill should be used when...") per skill-creator spec
  - Affected skills: agent-native-architecture, andrew-kane-gem-writer, compound-docs, create-agent-skills, dhh-rails-style, dspy-ruby, every-style-editor, file-todos, frontend-design, gemini-imagegen

### Added

- **CLAUDE.md** - Added Skill Compliance Checklist with validation commands for ensuring new skills meet spec requirements

## [2.15.1] - 2025-12-18

### Changed

- **`/workflows:review` command** - Section 7 now detects project type (Web, iOS, or Hybrid) and offers appropriate testing. Web projects get `/playwright-test`, iOS projects get `/xcode-test`, hybrid projects can run both.

## [2.15.0] - 2025-12-18

### Added

- **`/xcode-test` command** - Build and test iOS apps on simulator using XcodeBuildMCP. Automatically detects Xcode project, builds app, launches simulator, and runs test suite. Includes retries for flaky tests.

- **`/playwright-test` command** - Run Playwright browser tests on pages affected by current PR or branch. Detects changed files, maps to affected routes, generates/runs targeted tests, and reports results with screenshots.
