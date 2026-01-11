---
name: code-map
description: Generate architectural overview and code structure map using llm-tldr
argument-hint: "[optional: path]"
allowed-tools: Skill(tldr-architecture), Skill(tldr-context)
---

# Code Map Command

Generates a comprehensive architectural overview of the codebase using llm-tldr.

## Usage

**Full codebase map:**
```bash
claude /code-map
```

**Specific directory:**
```bash
claude /code-map src/auth/
```

**Focus on specific language:**
```bash
claude /code-map --lang python
```

## What It Generates

1. **Architecture Overview**
   - Detected patterns (MVC, hexagonal, layered, etc.)
   - Layer structure and boundaries
   - Module organization

2. **Key Modules**
   - Entry points (high-level interfaces)
   - Central modules (highly connected)
   - Leaf modules (minimal dependencies)

3. **Dependency Analysis**
   - Call graph visualization
   - Coupling metrics (dependencies per module)
   - Circular dependency detection

4. **Code Statistics**
   - Function count by module
   - Complexity metrics
   - Dead code detection

5. **Language Breakdown**
   - Files by language
   - Function count by language
   - Patterns per language

## Output Location

The command generates:
- `.claude/architecture/code-map-YYYY-MM-DD.md` - Full analysis report
- Console summary with key insights

## Implementation Steps

### Step 1: Check Prerequisites

Verify llm-tldr is installed and codebase is indexed:

```bash
# Check installation
command -v tldr || echo "Run: pip install llm-tldr"

# Check index
[[ -d .tldr/cache ]] || tldr warm .
```

### Step 2: Architecture Analysis

Run tldr architecture analysis:

```bash
mcp__tldr__arch({ path: ".", project: "." })
```

### Step 3: Structure Extraction

Get complete structure for statistics:

```bash
mcp__tldr__structure({ path: ".", project: "." })
```

### Step 4: Call Graph Generation

Build call graph for dependency analysis:

```bash
mcp__tldr__calls({ path: ".", project: "." })
```

### Step 5: Synthesize Report

Create comprehensive report combining:
- Architecture patterns from Step 2
- Module structure from Step 3
- Dependency graph from Step 4
- Statistics and metrics
- Actionable recommendations

### Step 6: Save Report

Write to `.claude/architecture/`:

```bash
mkdir -p .claude/architecture
cat > .claude/architecture/code-map-$(date +%Y-%m-%d).md <<EOF
# Code Map - [Project Name]
**Generated:** $(date +%Y-%m-%d)

[Full report content]
EOF
```

### Step 7: Present Summary

Display console summary with:
- Top 3 insights
- Architecture pattern detected
- Coupling metrics (high/medium/low)
- Recommendations (top 3 actions)
- Link to full report

## Example Output

```markdown
# Code Map - my-project
**Generated:** 2026-01-10

## Executive Summary

**Architecture Pattern:** Layered (3 layers)
**Total Functions:** 287
**Total Files:** 89
**Languages:** Python (65%), JavaScript (25%), Bash (10%)
**Coupling:** Low (average 2.4 dependencies per module)
**Dead Code:** 3 functions
**Circular Dependencies:** 0

## Layer Structure

### Layer 1: API (Entry Points)
Controllers expose HTTP endpoints. 12 controller files.

**Key Modules:**
- `controllers/user.py` - User management endpoints
- `controllers/auth.py` - Authentication endpoints
- `controllers/admin.py` - Admin panel endpoints

### Layer 2: Services (Business Logic)
Services contain business logic. 18 service modules.

**Key Services:**
- `services/auth.py` - Authentication logic (called by 3 controllers)
- `services/user.py` - User operations (called by 4 controllers)
- `services/email.py` - Email notifications (called by 6 services)

### Layer 3: Models (Data Access)
Models handle database interactions. 15 model files.

**Key Models:**
- `models/user.py` - User data model (used by 8 services)
- `models/session.py` - Session storage (used by 2 services)

## Module Coupling

**Highest Coupling (>8 dependencies):**
1. `controllers/user.py` → 9 dependencies (services + models)
2. `services/auth.py` → 8 dependencies (models + utils)

**Recommendations:**
- Consider facade pattern for `controllers/user.py`
- Extract shared auth logic to separate service

**Lowest Coupling (<2 dependencies):**
- Most utility modules
- Leaf models

## Circular Dependencies

None detected ✓

## Dead Code

**Unreachable Functions:** 3
- `helpers/deprecated.py::old_format` (not called)
- `utils/legacy.py::process_v1` (not called)
- `services/experimental.py::test_flow` (not called)

**Recommendation:** Remove dead code to improve maintainability

## Code Statistics

**By Module:**
| Module | Functions | Avg Complexity | Lines |
|--------|-----------|----------------|-------|
| controllers/ | 45 | 6.2 | 1,850 |
| services/ | 89 | 8.4 | 3,200 |
| models/ | 67 | 4.1 | 2,100 |
| utils/ | 86 | 2.8 | 1,400 |

**By Language:**
| Language | Files | Functions | Lines |
|----------|-------|-----------|-------|
| Python | 58 | 234 | 7,200 |
| JavaScript | 22 | 43 | 1,100 |
| Bash | 9 | 10 | 250 |

## Recommendations

1. ✓ **Clean architecture** - Clear 3-layer separation
2. ⚠ **Reduce user controller coupling** - 9 dependencies is high
3. → **Remove dead code** - 3 unreachable functions identified
4. ✓ **No circular dependencies** - Healthy dependency graph
5. → **Document central modules** - `services/auth.py` and `services/email.py` heavily used

## Full Report

See: `.claude/architecture/code-map-2026-01-10.md`
```

## Use Cases

### 1. Onboarding
Generate map for new developers to understand codebase quickly.

### 2. Refactoring
Identify coupling hotspots before major refactoring.

### 3. Technical Debt
Find dead code and areas needing cleanup.

### 4. Architecture Reviews
Document current state for architecture decision records.

### 5. Planning
Understand impact of proposed changes on architecture.

## Requirements

- llm-tldr installed (`pip install llm-tldr`)
- Codebase indexed (`tldr warm .`)
- ~200MB disk space for indices

## See Also

- [tldr-architecture skill](../skills/tldr-architecture/) - Architecture analysis
- [/find-code](./find-code.md) - Semantic code search
- [/trace-impact](./trace-impact.md) - Impact analysis
