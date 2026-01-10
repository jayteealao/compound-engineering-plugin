#!/bin/bash
# Index codebase with tldr

set -e

PROJECT_DIR="${1:-.}"

echo "Indexing codebase with llm-tldr..."
echo "This may take 30-60 seconds for typical projects"
echo ""

cd "$PROJECT_DIR"

# Create .tldrignore if it doesn't exist
if [[ ! -f .tldrignore ]]; then
    cat > .tldrignore <<EOF
# Build outputs
node_modules/
dist/
build/
.next/
.nuxt/

# Python
__pycache__/
.venv/
venv/
*.pyc

# Tests
coverage/
.coverage
test_fixtures/
fixtures/

# Security
.env
.env.*
*.pem
*.key
credentials.json
EOF
    echo "✓ Created .tldrignore"
fi

# Run indexing
tldr warm .

echo ""
echo "✓ Indexing complete"
echo ""
echo "Index stored in: .tldr/cache/"
echo ""

# Show stats
echo "Repository structure:"
tldr tree . | head -20
echo ""

# Count files by language
echo "Detected languages:"
tldr structure . 2>/dev/null | grep -E "^\w+:" | head -10
