# Work Progress Summaries

This directory contains high-level progress summaries for `/workflows:work` execution.

## File Pattern

- `{plan-name}-work-progress.md` - Summary of work todo progress

## Purpose

While individual work todos live in `.claude/todos/work/`, this directory provides at-a-glance summaries showing:
- Total tasks and completion status
- Current task being worked on
- Completed tasks with timestamps
- Overall progress percentage

## Structure

```yaml
---
command: workflows:work
plan: .claude/plans/{plan-name}.md
started: ISO-8601-timestamp
status: in_progress | completed
---

# Work Progress: {plan-name}

## Tasks
- [x] 001: Task description (completed HH:MM)
- [ ] 002: Task description (in progress)
- [ ] 003: Task description (pending)

## Current Task: 002
## Completed: 1/3 (33%)
```

## Cleanup

Progress files can be deleted after work completion or kept for historical reference.
