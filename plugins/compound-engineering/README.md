# Compounding Engineering Plugin

AI-powered development tools that get smarter with every use. Make each unit of engineering work easier than the last.

**📖 [Read the Complete Workflow Guide](../../FLOW.md)** - Comprehensive visual guide showing how all commands, agents, and skills work together.

## Components

| Component | Count |
|-----------|-------|
| Agents | 17 |
| Commands | 9 |
| Skills | 6 |
| MCP Servers | 3 |

## Agents

Agents are organized into categories for easier discovery.

### Research (4)

| Agent | Description |
|-------|-------------|
| `best-practices-researcher` | Gather external best practices and examples |
| `framework-docs-researcher` | Research framework documentation and best practices |
| `git-history-analyzer` | Analyze git history and code evolution |
| `repo-research-analyst` | Research repository structure and conventions |

### Review (11)

| Agent | Description |
|-------|-------------|
| `architecture-strategist` | Analyze architectural decisions and compliance |
| `code-simplicity-reviewer` | Final pass for simplicity and minimalism |
| `data-integrity-guardian` | Database migrations and data integrity |
| `data-migration-expert` | Validate ID mappings match production, check for swapped values |
| `deployment-verification-agent` | Create Go/No-Go deployment checklists for risky data changes |
| `framework-conventions-reviewer` | Review code against framework conventions (any framework) |
| `kieran-typescript-reviewer` | TypeScript code review with strict conventions |
| `pattern-recognition-specialist` | Analyze code for patterns and anti-patterns |
| `performance-oracle` | Performance analysis and optimization |
| `security-sentinel` | Security audits and vulnerability assessments |
| `senior-code-reviewer` | High-bar code review with strict quality standards |

### Testing (1)

| Agent | Description |
|-------|-------------|
| `test-coverage-analyzer` | Analyze coverage gaps and suggest tests |

### Workflow (1)

| Agent | Description |
|-------|-------------|
| `spec-flow-analyzer` | Analyze user flows and identify gaps in specifications |

## Commands

### Workflow Commands

Core workflow commands use `workflows:` prefix to avoid collisions with built-in commands:

| Command | Description |
|---------|-------------|
| `/workflows:plan` | Create implementation plans with parallel research agents |
| `/workflows:review` | Run comprehensive code reviews with parallel review agents |
| `/workflows:work` | Execute work items systematically using plan or review todos |
| `/workflows:compound` | Document solved problems to compound team knowledge |

### Utility Commands

| Command | Description |
|---------|-------------|
| `/debug` | 5-phase systematic debugging with automated fix recommendations |
| `/deepen-plan` | Enhance plans with 40+ parallel research agents for each section |
| `/generate-tests` | Generate comprehensive tests following project conventions |
| `/plan_review` | Multi-agent plan validation in parallel |
| `/triage` | Triage and prioritize todos interactively |

## Skills

### Knowledge Management

| Skill | Description |
|-------|-------------|
| `compound-docs` | Capture solved problems as categorized documentation in .claude/solutions/ |
| `file-todos` | File-based todo tracking system with YAML frontmatter |

### Code Quality

| Skill | Description |
|-------|-------------|
| `error-analysis` | Analyze errors and logs systematically with root cause analysis |
| `framework-conventions-guide` | Write code following framework conventions (any framework) |
| `refactoring-patterns` | Safe, systematic refactoring patterns |
| `test-patterns` | Test patterns for unit, integration, and API testing |

## MCP Servers

| Server | Description |
|--------|-------------|
| `playwright` | Browser automation via `@playwright/mcp` |
| `context7` | Framework documentation lookup via Context7 |
| `tldr` | Code analysis and semantic search via `llm-tldr` |

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

### tldr (llm-tldr)

**Capabilities:**
- **Semantic search** - Find code using natural language queries
- **Structure extraction** - AST, call graphs, control flow, data flow
- **Token efficiency** - 99% reduction for function context (21,000 → 175 tokens)
- **Architecture analysis** - Detect patterns and layered structures
- **Impact analysis** - Find all code affected by changes

**Languages:** Python, TypeScript, JavaScript, Go, Rust, Java, C, C++, Ruby, PHP, C#, Kotlin, Scala, Swift, Lua, Elixir

**Requirements:**
- Python 3.7+
- `pip install llm-tldr`

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

**Note:** For the `tldr` MCP server, you must first install llm-tldr:
```bash
pip install llm-tldr
```

Or add them globally in `~/.claude/settings.json` for all projects.

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## License

MIT
