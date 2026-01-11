---
name: tldr-architecture
description: This skill should be used when analyzing codebase architecture and detecting structural patterns like MVC, layering, and coupling
user-invocable: true
---

# tldr-architecture Skill

Analyzes codebase structure to detect architectural patterns and layering.

## When to Use

Use this skill when you need to:
- Understand overall codebase structure
- Detect layered architecture (MVC, hexagonal, clean architecture)
- Find circular dependencies
- Identify dead code
- Map module boundaries
- Assess code coupling

## Usage

**Full architecture analysis:**
```bash
claude skill tldr-architecture
```

**Specific directory:**
```bash
claude skill tldr-architecture --path src/
```

**Focus on specific pattern:**
```bash
claude skill tldr-architecture --pattern mvc
```

## Analysis Types

### 1. Layered Architecture Detection

Detects common patterns:
- **MVC** (Model-View-Controller)
- **Hexagonal** (Ports and Adapters)
- **Clean Architecture** (Entities, Use Cases, Interface Adapters, Frameworks)
- **Layered** (Presentation, Business, Data)

### 2. Call Graph Analysis

- Identifies central modules (high in-degree)
- Finds leaf modules (no dependencies)
- Detects circular dependencies
- Maps dependency flow

### 3. Dead Code Detection

- Finds unreachable functions
- Identifies unused exports
- Detects orphaned files

### 4. Module Coupling

- Measures coupling between modules
- Identifies tight coupling hotspots
- Suggests decoupling opportunities

## Output Format

```yaml
---
analysis_type: architecture
codebase: my-project
languages: [python, typescript, bash]
total_functions: 487
total_files: 156
---

# Architecture Analysis

## Detected Pattern: Layered Architecture

### Layer 1: Controllers (Entry Points)
- 32 controller files in `controllers/`
- Expose HTTP endpoints
- Call services and models

### Layer 2: Services (Business Logic)
- 21 service modules in `services/`
- Reusable business logic
- Called by controllers

### Layer 3: Models (Data Access)
- 18 model files in `models/`
- Database interactions
- Called by services

### Layer 4: Utils (Shared Utilities)
- 12 utility modules in `utils/`
- Helper functions
- Called by all layers

## Module Coupling Analysis

### High Coupling (>10 dependencies):
- `controllers/user.py` → 15 services, 8 models
- `services/auth.py` → 12 models, 6 utils

### Low Coupling (<3 dependencies):
- `utils/crypto.py` → 0 dependencies
- `models/user.py` → 1 util

## Circular Dependencies

None detected ✓

## Dead Code

### Unreachable Functions: 3
- `helpers/old_format.py::format_date` (not called)
- `utils/deprecated.py::process_legacy` (not called)
- `services/abandoned.py::handle_old_flow` (not called)

### Orphaned Files: 1
- `controllers/test_controller.py` (no imports)

## Recommendations

1. **Maintain clear layering** - Controllers → Services → Models pattern is clean
2. **Reduce user controller coupling** - 15 service dependencies is high
3. **Remove dead code** - 3 unreachable functions, 1 orphaned file
4. **Consider facade pattern** - For high-coupling modules
```

## Integration Patterns

**In planning agents:**
```
Before creating new architecture:
1. Run tldr-architecture to understand current patterns
2. Align new design with detected patterns
3. Avoid introducing circular dependencies
```

**In review agents:**
```
When reviewing PRs:
1. Check if changes affect module coupling
2. Verify no new circular dependencies introduced
3. Flag if dead code is being added
```

## Use Cases

### 1. Onboarding New Developers
Generate architecture overview for newcomers to quickly understand codebase structure.

### 2. Refactoring Planning
Identify tightly coupled modules before major refactoring.

### 3. Technical Debt Assessment
Find dead code and circular dependencies to prioritize cleanup.

### 4. Architecture Decision Records (ADRs)
Document current architecture patterns for future reference.

### 5. Code Review
Verify PR doesn't violate architectural patterns.

## Metrics Provided

| Metric | Description |
|--------|-------------|
| **Layers** | Detected architectural layers |
| **Coupling** | Dependencies per module |
| **Circular deps** | Cycles in dependency graph |
| **Dead code** | Unreachable functions/files |
| **Complexity** | Cyclomatic complexity scores |
| **Centrality** | Most connected modules |

## Requirements

- llm-tldr installed (`pip install llm-tldr`)
- Codebase indexed (`tldr warm .`)
- Analysis time: 2-3 seconds for typical project

## Languages Supported

Python, TypeScript, JavaScript, Go, Rust, Java, C, C++, Ruby, PHP, C#, Kotlin, Scala, Swift, Lua, Elixir
