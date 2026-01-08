# Compounding Engineering Plugin

AI-powered development tools that get smarter with every use. Make each unit of engineering work easier than the last.

## Components

| Component | Count |
|-----------|-------|
| Agents | 38 |
| Commands | 32 |
| Skills | 21 |
| MCP Servers | 2 |

## Agents

Agents are organized into categories for easier discovery.

### Review (14)

| Agent | Description |
|-------|-------------|
| `agent-native-reviewer` | Verify features are agent-native (action + context parity) |
| `architecture-strategist` | Analyze architectural decisions and compliance |
| `code-simplicity-reviewer` | Final pass for simplicity and minimalism |
| `data-integrity-guardian` | Database migrations and data integrity |
| `data-migration-expert` | Validate ID mappings match production, check for swapped values |
| `deployment-verification-agent` | Create Go/No-Go deployment checklists for risky data changes |
| `framework-conventions-reviewer` | Review code against framework conventions (any framework) |
| `senior-code-reviewer` | High-bar code review with strict quality standards |
| `kieran-python-reviewer` | Python code review with strict conventions |
| `kieran-typescript-reviewer` | TypeScript code review with strict conventions |
| `pattern-recognition-specialist` | Analyze code for patterns and anti-patterns |
| `performance-oracle` | Performance analysis and optimization |
| `security-sentinel` | Security audits and vulnerability assessments |
| `julik-frontend-races-reviewer` | Review JavaScript/Stimulus code for race conditions |

### Research (4)

| Agent | Description |
|-------|-------------|
| `best-practices-researcher` | Gather external best practices and examples |
| `framework-docs-researcher` | Research framework documentation and best practices |
| `git-history-analyzer` | Analyze git history and code evolution |
| `repo-research-analyst` | Research repository structure and conventions |

### Design (3)

| Agent | Description |
|-------|-------------|
| `design-implementation-reviewer` | Verify UI implementations match Figma designs |
| `design-iterator` | Iteratively refine UI through systematic design iterations |
| `figma-design-sync` | Synchronize web implementations with Figma designs |

### Workflow (5)

| Agent | Description |
|-------|-------------|
| `bug-reproduction-validator` | Systematically reproduce and validate bug reports |
| `every-style-editor` | Edit content to conform to Every's style guide |
| `lint` | Run linting and code quality checks on Ruby and ERB files |
| `pr-comment-resolver` | Address PR comments and implement fixes |
| `spec-flow-analyzer` | Analyze user flows and identify gaps in specifications |

### Docs (3)

| Agent | Description |
|-------|-------------|
| `library-readme-writer` | Create READMEs for any library/package with proven best practices |
| `api-docs-generator` | Generate OpenAPI/Swagger documentation from code |
| `onboarding-generator` | Create onboarding docs for new developers |

### Testing (3)

| Agent | Description |
|-------|-------------|
| `test-generator` | Generate comprehensive tests following project conventions |
| `test-coverage-analyzer` | Analyze coverage gaps and suggest tests |
| `api-test-generator` | Generate API/integration tests from endpoints |

### Analysis (4)

| Agent | Description |
|-------|-------------|
| `debt-tracker` | Scan codebase for technical debt with scoring |
| `codebase-health` | Generate comprehensive health reports |
| `dependency-auditor` | Audit dependencies for updates/vulnerabilities |
| `error-analyst` | Analyze error logs and stack traces |

### Refactoring (2)

| Agent | Description |
|-------|-------------|
| `refactoring-assistant` | Plan and execute safe refactorings |
| `code-modernizer` | Update code to modern patterns/APIs |

## Commands

### Workflow Commands

Core workflow commands use `workflows:` prefix to avoid collisions with built-in commands:

| Command | Description |
|---------|-------------|
| `/workflows:plan` | Create implementation plans |
| `/workflows:review` | Run comprehensive code reviews |
| `/workflows:work` | Execute work items systematically |
| `/workflows:compound` | Document solved problems to compound team knowledge |
| `/workflows:maintain` | Run maintenance tasks (deps, debt, coverage, health) |

### Testing Commands

| Command | Description |
|---------|-------------|
| `/generate-tests` | Generate tests for specified files or features |
| `/analyze-coverage` | Analyze test coverage and identify gaps |
| `/generate-api-tests` | Generate API tests from endpoints |

### Documentation Commands

| Command | Description |
|---------|-------------|
| `/document-api` | Generate or update API documentation |
| `/generate-onboarding` | Generate onboarding documentation |

### Analysis Commands

| Command | Description |
|---------|-------------|
| `/scan-debt` | Scan codebase for technical debt |
| `/health-report` | Generate comprehensive health report |
| `/update-deps` | Safely update dependencies |

### Refactoring Commands

| Command | Description |
|---------|-------------|
| `/refactor` | Plan and execute safe refactorings |
| `/modernize` | Update code to modern patterns |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/deepen-plan` | Enhance plans with parallel research agents for each section |
| `/changelog` | Create engaging changelogs for recent merges |
| `/create-agent-skill` | Create or edit Claude Code skills |
| `/generate_command` | Generate new slash commands |
| `/heal-skill` | Fix skill documentation issues |
| `/plan_review` | Multi-agent plan review in parallel |
| `/report-bug` | Report a bug in the plugin |
| `/reproduce-bug` | Reproduce bugs using logs and console |
| `/resolve_parallel` | Resolve TODO comments in parallel |
| `/resolve_pr_parallel` | Resolve PR comments in parallel |
| `/resolve_todo_parallel` | Resolve todos in parallel |
| `/triage` | Triage and prioritize issues |
| `/playwright-test` | Run browser tests on PR-affected pages |
| `/xcode-test` | Build and test iOS apps on simulator |
| `/feature-video` | Record video walkthroughs and add to PR description |

## Skills

### Architecture & Design

| Skill | Description |
|-------|-------------|
| `agent-native-architecture` | Build AI agents using prompt-native architecture |

### Development Tools

| Skill | Description |
|-------|-------------|
| `compound-docs` | Capture solved problems as categorized documentation |
| `create-agent-skills` | Expert guidance for creating Claude Code skills |
| `framework-conventions-guide` | Write code following framework conventions (any framework) |
| `frontend-design` | Create production-grade frontend interfaces |
| `library-writer` | Write libraries with minimal dependencies and clean APIs |
| `llm-application-patterns` | Build production LLM apps with structured patterns |
| `skill-creator` | Guide for creating effective Claude Code skills |

### Testing & Quality

| Skill | Description |
|-------|-------------|
| `test-patterns` | Test patterns for unit, integration, and API testing |
| `technical-debt` | Track and categorize technical debt with scoring |
| `refactoring-patterns` | Safe, systematic refactoring patterns |

### Documentation

| Skill | Description |
|-------|-------------|
| `api-documentation` | Generate and maintain API documentation |
| `onboarding-docs` | Generate developer onboarding documentation |

### Maintenance

| Skill | Description |
|-------|-------------|
| `dependency-management` | Manage project dependencies safely |
| `error-analysis` | Analyze errors and logs systematically |

### Content & Workflow

| Skill | Description |
|-------|-------------|
| `claude-workspace` | Organize working files in .claude/ with required cross-references |
| `every-style-editor` | Review copy for Every's style guide compliance |
| `file-todos` | File-based todo tracking system |
| `git-worktree` | Manage Git worktrees for parallel development |

### File Transfer

| Skill | Description |
|-------|-------------|
| `rclone` | Upload files to S3, Cloudflare R2, Backblaze B2, and cloud storage |

### Image Generation

| Skill | Description |
|-------|-------------|
| `gemini-imagegen` | Generate and edit images using Google's Gemini API |

**gemini-imagegen features:**
- Text-to-image generation
- Image editing and manipulation
- Multi-turn refinement
- Multiple reference image composition (up to 14 images)

**Requirements:**
- `GEMINI_API_KEY` environment variable
- Python packages: `google-genai`, `pillow`

## MCP Servers

| Server | Description |
|--------|-------------|
| `playwright` | Browser automation via `@playwright/mcp` |
| `context7` | Framework documentation lookup via Context7 |

### Playwright

**Tools provided:**
- `browser_navigate` - Navigate to URLs
- `browser_take_screenshot` - Take screenshots
- `browser_click` - Click elements
- `browser_fill_form` - Fill form fields
- `browser_snapshot` - Get accessibility snapshot
- `browser_evaluate` - Execute JavaScript

### Context7

**Tools provided:**
- `resolve-library-id` - Find library ID for a framework/package
- `get-library-docs` - Get documentation for a specific library

Supports 100+ frameworks including Rails, React, Next.js, Vue, Django, Laravel, and more.

MCP servers start automatically when the plugin is enabled.

## Installation

```bash
claude /plugin install compound-engineering
```

## Known Issues

### MCP Servers Not Auto-Loading

**Issue:** The bundled MCP servers (Playwright and Context7) may not load automatically when the plugin is installed.

**Workaround:** Manually add them to your project's `.claude/settings.json`:

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
    }
  }
}
```

Or add them globally in `~/.claude/settings.json` for all projects.

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## License

MIT
