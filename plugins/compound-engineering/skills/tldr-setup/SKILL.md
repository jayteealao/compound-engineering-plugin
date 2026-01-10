---
name: tldr-setup
description: This skill should be used when setting up llm-tldr code analysis for the first time in a project
user-invocable: true
---

# llm-tldr Setup Skill

Sets up llm-tldr code analysis tool for structural understanding and semantic search.

## What is llm-tldr?

llm-tldr extracts structure from codebases (AST, call graphs, control flow, data flow) and enables:
- 99% token reduction for function context (21,000 → 175 tokens)
- Semantic code search using natural language queries
- Architectural pattern detection
- Call graph and impact analysis

## Quick Start

**Automatic setup:**
```bash
claude skill tldr-setup
```

This will:
1. Check if llm-tldr is installed (install if missing)
2. Index the current codebase
3. Start the daemon for fast queries
4. Validate the setup

**Manual setup:**
```bash
# Install
pip install llm-tldr

# Index codebase (30-60 seconds)
tldr warm .

# Start daemon (optional but recommended)
tldr daemon start --project .

# Verify
tldr structure . --lang python | head
```

## Configuration

**Create `.tldrignore` (optional):**
```
# Exclude from indexing
node_modules/
.venv/
dist/
build/
*.min.js
test_fixtures/
```

**Daemon settings (`.tldr/config.json`):**
```json
{
  "semantic": {
    "enabled": true,
    "auto_reindex_threshold": 20
  }
}
```

## Usage After Setup

**Via MCP server (automatic in agents):**
```
mcp__tldr__context({ function: "login", project: "." })
mcp__tldr__semantic_search({ query: "JWT validation", project: "." })
mcp__tldr__call_graph({ path: "src/", project: "." })
```

**Via CLI (manual):**
```bash
# Semantic search
tldr semantic "authentication logic" .

# Function context (LLM-optimized)
tldr context login --project .

# Architecture analysis
tldr arch .

# Impact analysis
tldr impact validate_token .
```

## Supported Languages

Python, TypeScript, JavaScript, Go, Rust, Java, C, C++, Ruby, PHP, C#, Kotlin, Scala, Swift, Lua, Elixir

## Maintenance

**Re-index after major changes:**
```bash
tldr warm .
```

**Daemon management:**
```bash
tldr daemon status
tldr daemon stop
tldr daemon start --project .
```

**Update to latest version:**
```bash
pip install --upgrade llm-tldr
```

## Scripts

See [scripts/](./scripts/) directory for implementation details:
- [install.sh](./scripts/install.sh) - Installation script
- [warm.sh](./scripts/warm.sh) - Indexing script
- [daemon.sh](./scripts/daemon.sh) - Daemon management
