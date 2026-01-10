# Compounding Engineering Plugin Development

## Versioning Requirements

**IMPORTANT**: Every change to this plugin MUST include updates to all three files:

1. **`.claude-plugin/plugin.json`** - Bump version using semver
2. **`CHANGELOG.md`** - Document changes using Keep a Changelog format
3. **`README.md`** - Verify/update component counts and tables

### Version Bumping Rules

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes, major reorganization
- **MINOR** (1.0.0 → 1.1.0): New agents, commands, or skills
- **PATCH** (1.0.0 → 1.0.1): Bug fixes, doc updates, minor improvements

### Pre-Commit Checklist

Before committing ANY changes:

- [ ] Version bumped in `.claude-plugin/plugin.json`
- [ ] CHANGELOG.md updated with changes
- [ ] README.md component counts verified
- [ ] README.md tables accurate (agents, commands, skills)
- [ ] plugin.json description matches current counts

### Directory Structure

```
agents/
├── review/     # Code review agents
├── research/   # Research and analysis agents
├── design/     # Design and UI agents
├── workflow/   # Workflow automation agents
└── docs/       # Documentation agents

commands/
├── workflows/  # Core workflow commands (workflows:plan, workflows:review, etc.)
└── *.md        # Utility commands

skills/
└── *.md        # All skills at root level
```

## Command Naming Convention

**Workflow commands** use `workflows:` prefix to avoid collisions with built-in commands:
- `/workflows:plan` - Create implementation plans
- `/workflows:review` - Run comprehensive code reviews
- `/workflows:work` - Execute work items systematically
- `/workflows:compound` - Document solved problems

**Why `workflows:`?** Claude Code has built-in `/plan` and `/review` commands. Using `name: workflows:plan` in frontmatter creates a unique `/workflows:plan` command with no collision.

## Workflow Command Protection

**CRITICAL:** Workflow commands require explicit guards to prevent Claude Code's built-in planning tools from hijacking execution.

**Problem:** Claude Code's system prompts detect "planning" keywords in commands and automatically trigger `EnterPlanMode` or `TodoWrite`, overriding custom command logic.

**Solution:** All workflow commands in `commands/workflows/` must include a "CRITICAL: Command Execution Instructions" section at the top that:
1. Explicitly forbids using `EnterPlanMode` and/or `TodoWrite` (depending on command)
2. States what the command's custom mechanism is (e.g., `.claude/plans/`, `.claude/solutions/`)
3. Directs Claude to follow the command instructions EXACTLY

**Example:**
```markdown
## CRITICAL: Command Execution Instructions

**DO NOT use Claude Code's EnterPlanMode tool or TodoWrite tool for this command.**

This is a custom workflow command with its own planning mechanism that:
- Spawns specialized research agents
- Writes plans to `.claude/plans/`
- Presents next-step options via AskUserQuestion

Follow the instructions in this command EXACTLY. Do not delegate to other planning tools.
```

**When to add guards:**
- All commands in `commands/workflows/` (these use custom mechanisms)
- Commands that might be confused as "planning" tasks by Claude Code's heuristics

**When NOT to add guards:**
- Utility commands that legitimately use TodoWrite for progress tracking (`/deepen-plan`, `/refactor`, etc.)
- Simple commands that won't trigger planning heuristics

## Skill Compliance Checklist

When adding or modifying skills, verify compliance with skill-creator spec:

### YAML Frontmatter (Required)

- [ ] `name:` present and matches directory name (lowercase-with-hyphens)
- [ ] `description:` present and uses **third person** ("This skill should be used when..." NOT "Use this skill when...")

### Reference Links (Required if references/ exists)

- [ ] All files in `references/` are linked as `[filename.md](./references/filename.md)`
- [ ] All files in `assets/` are linked as `[filename](./assets/filename)`
- [ ] All files in `scripts/` are linked as `[filename](./scripts/filename)`
- [ ] No bare backtick references like `` `references/file.md` `` - use proper markdown links

### Writing Style

- [ ] Use imperative/infinitive form (verb-first instructions)
- [ ] Avoid second person ("you should") - use objective language ("To accomplish X, do Y")

### Quick Validation Command

```bash
# Check for unlinked references in a skill
grep -E '`(references|assets|scripts)/[^`]+`' skills/*/SKILL.md
# Should return nothing if all refs are properly linked

# Check description format
grep -E '^description:' skills/*/SKILL.md | grep -v 'This skill'
# Should return nothing if all use third person
```

## Documentation

See `.claude/solutions/plugin-versioning-requirements.md` for detailed versioning workflow.
