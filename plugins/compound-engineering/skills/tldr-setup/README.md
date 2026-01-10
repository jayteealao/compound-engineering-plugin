# tldr-setup Skill

One-command setup for llm-tldr code analysis tool.

## What It Does

- Checks if llm-tldr is installed
- Installs llm-tldr if missing
- Creates `.tldrignore` file
- Indexes the codebase
- Starts the daemon for fast queries
- Validates the setup

## Installation

llm-tldr requires Python and pip:

```bash
pip install llm-tldr
```

## Usage

```bash
claude skill tldr-setup
```

## Scripts

- **install.sh** - Install llm-tldr and verify
- **warm.sh** - Index the codebase
- **daemon.sh** - Manage background daemon

## Requirements

- Python 3.7+
- pip
- 200-500MB disk space for indices

## See Also

- [tldr-context](../tldr-context/) - Extract function context
- [tldr-semantic-search](../tldr-semantic-search/) - Search code semantically
- [tldr-architecture](../tldr-architecture/) - Analyze architecture
