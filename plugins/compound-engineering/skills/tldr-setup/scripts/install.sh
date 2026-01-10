#!/bin/bash
# Install llm-tldr if not present

set -e

echo "Checking llm-tldr installation..."

if command -v tldr &> /dev/null; then
    VERSION=$(tldr --version 2>&1 | head -1)
    echo "✓ llm-tldr already installed: $VERSION"
else
    echo "Installing llm-tldr..."
    pip install llm-tldr
    echo "✓ llm-tldr installed successfully"
fi

# Verify installation
if command -v tldr-mcp &> /dev/null; then
    echo "✓ tldr-mcp (MCP server) available"
else
    echo "⚠ tldr-mcp not found in PATH"
    echo "  Make sure pip install directory is in PATH"
    exit 1
fi

echo ""
echo "Installation complete!"
