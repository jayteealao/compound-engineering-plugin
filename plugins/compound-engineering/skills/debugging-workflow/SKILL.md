---
name: debugging-workflow
description: This skill should be used when systematically debugging issues using hypothesis-driven methodology and structured investigation techniques.
user-invocable: false
context: fork
---

# Debugging Workflow Skill

Systematic approach to debugging using hypothesis-driven methodology.

## When to Use

This skill is automatically applied when:
- Debugging errors or unexpected behavior
- Investigating production issues
- Reproducing reported bugs
- Analyzing root causes
- Narrowing down failure scenarios

## Core Debugging Process

### 1. Gather Information

**Collect all available data:**

```markdown
## Information Gathering Checklist

- [ ] Error message and type
- [ ] Stack trace (full trace, not truncated)
- [ ] Steps to reproduce
- [ ] Expected vs actual behavior
- [ ] Environment details (OS, runtime version, dependencies)
- [ ] Recent changes (code, config, data, infrastructure)
- [ ] Frequency (always, sometimes, once)
- [ ] Affected users/systems (all, specific subset, random)
- [ ] Related logs (application, system, database, network)
- [ ] Timing information (when did it start, pattern)
```

**Ask clarifying questions:**
- What changed recently?
- Can you reproduce it consistently?
- Does it happen in all environments?
- Are there any workarounds?
- What was the user trying to do?

### 2. Form Hypotheses

**Generate possible causes:**

```markdown
## Hypothesis Generation

### Hypothesis Template
**H1: [Hypothesis name]**
- **Cause:** What might be causing this
- **Evidence needed:** What would prove/disprove this
- **Test:** How to verify
- **Likelihood:** High/Medium/Low

### Common Hypothesis Categories

1. **Code bugs**
   - Logic errors
   - Off-by-one errors
   - Race conditions
   - Null/undefined references
   - Type mismatches

2. **Data issues**
   - Invalid data format
   - Missing data
   - Data corruption
   - Migration problems
   - Constraint violations

3. **Configuration**
   - Environment variables
   - Feature flags
   - Service configuration
   - Network settings
   - Permissions

4. **Infrastructure**
   - Service unavailable
   - Network issues
   - Resource exhaustion (memory, disk, CPU)
   - Timeout limits
   - Rate limiting

5. **External dependencies**
   - API changes
   - Third-party service issues
   - Database problems
   - Authentication failures
```

**Prioritize hypotheses:**
- Start with most likely based on evidence
- Consider recent changes first
- Check simple explanations before complex ones
- Rule out "impossible" scenarios early

### 3. Test Hypotheses

**Design experiments:**

```markdown
## Testing Strategy

### For Each Hypothesis

1. **Design minimal test**
   - Smallest change that would prove/disprove
   - Isolate one variable at a time
   - Use controlled environment

2. **Execute test**
   - Document exactly what you're testing
   - Record all results (even unexpected ones)
   - Note any side observations

3. **Analyze results**
   - Does it confirm or refute the hypothesis?
   - Are there alternative explanations?
   - What new questions does it raise?

### Testing Approaches

**Add logging:**
```python
logger.debug(f"Variable state: x={x}, y={y}, z={z}")
logger.debug(f"Entering function {func_name} with args={args}")
```

**Use debugger:**
- Set breakpoints at suspected locations
- Step through execution
- Inspect variable values
- Watch expressions

**Reproduce minimal case:**
- Strip away non-essential code
- Create isolated test case
- Reduce to simplest failing example

**Binary search:**
- If regression, bisect git history
- If large codebase, narrow down file/function
- If complex logic, divide & conquer

**Compare working vs broken:**
- What's different between environments?
- What changed between versions?
- What's different about failing cases?
```

### 4. Verify Root Cause

**Confirm your findings:**

```markdown
## Root Cause Verification

- [ ] Can reproduce the error consistently
- [ ] Can explain all observed symptoms
- [ ] Can predict behavior based on understanding
- [ ] Fix addresses the actual cause (not symptoms)
- [ ] No other simpler explanations exist

### Verification Techniques

1. **Make it fail on command**
   - Write test that reproduces bug
   - Verify test fails before fix
   - Verify test passes after fix

2. **Explain the timeline**
   - When did it start?
   - What triggered it?
   - Why now and not before?

3. **Account for all symptoms**
   - Every error message explained
   - Every unexpected behavior explained
   - No loose ends
```

## Hypothesis-Driven Debugging

### The Scientific Method for Bugs

```markdown
## Debugging as Science

1. **Observe** - Gather symptoms and evidence
2. **Question** - What could cause these symptoms?
3. **Hypothesize** - Form testable explanations
4. **Predict** - What should happen if hypothesis is true?
5. **Test** - Design and run experiments
6. **Analyze** - Do results match predictions?
7. **Conclude** - Confirm root cause or form new hypothesis

### Example: Null Reference Error

**Observation:**
- Error: `TypeError: Cannot read property 'id' of undefined`
- Location: `user.profile.id`
- Frequency: 5% of requests

**Hypotheses:**
1. H1: User object is null
2. H2: Profile property doesn't exist
3. H3: Profile is null for some users

**Tests:**
1. Add logging: `console.log('user:', user)`
   - Result: User exists, not null → H1 rejected

2. Add logging: `console.log('has profile:', 'profile' in user)`
   - Result: Profile property exists → H2 rejected

3. Add logging: `console.log('profile value:', user.profile)`
   - Result: Profile is null for legacy users → H3 confirmed

**Root Cause:** Legacy users (pre-2023) don't have profiles
```

## Reproduction Strategies

### Minimal Reproduction

```markdown
## Creating Minimal Reproductions

### Why Minimal Reproductions Matter
- Easier to understand
- Faster to debug
- Clearer root cause
- Better bug reports
- Simpler fixes

### How to Create Minimal Reproduction

1. **Start with failing case**
2. **Remove one piece at a time**
   - Remove a dependency
   - Remove a function call
   - Remove a configuration
   - Simplify input data
3. **Verify still fails after each removal**
4. **Stop when can't remove anything else**

### Example: API Request Failure

**Full Case (Complex):**
```javascript
const response = await fetch('/api/users', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`,
    'X-Custom-Header': 'value'
  },
  body: JSON.stringify({
    name: 'John Doe',
    email: 'john@example.com',
    age: 30,
    preferences: { theme: 'dark', lang: 'en' }
  })
});
```

**Minimal Reproduction:**
```javascript
// Remove auth → still fails
// Remove custom header → still fails
// Remove preferences → still fails
// Remove age → still fails
// Remove name → still works!

// Minimal failing case:
fetch('/api/users', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ name: 'John Doe', email: 'john@example.com' })
});

// Root cause: Name validation is broken
```

### Isolate Variables

**One variable at a time:**
- Change environment → Production vs Staging vs Dev
- Change user → Admin vs Regular vs Guest
- Change data → Large dataset vs Small vs Empty
- Change timing → Morning vs Evening vs Peak hours
- Change version → Latest vs Previous vs Specific commit

### Consistent Environments

**Eliminate environmental differences:**

```markdown
## Environment Checklist

- [ ] Same runtime version (Node.js, Python, Ruby, etc.)
- [ ] Same dependency versions
- [ ] Same configuration
- [ ] Same environment variables
- [ ] Same database state
- [ ] Same file permissions
- [ ] Same timezone/locale
- [ ] Same network conditions
```

## Fix Validation Workflows

### Verify Your Fix Works

```markdown
## Fix Validation Steps

### 1. Local Verification
- [ ] Write failing test before fix
- [ ] Apply fix
- [ ] Verify test now passes
- [ ] Verify no regressions (run full test suite)
- [ ] Test edge cases
- [ ] Verify in dev environment

### 2. Staging Verification
- [ ] Deploy to staging
- [ ] Run smoke tests
- [ ] Test reproduction steps
- [ ] Monitor for errors
- [ ] Verify metrics (latency, error rate)

### 3. Production Verification
- [ ] Deploy to production (canary/gradual rollout)
- [ ] Monitor error rates
- [ ] Check logs for new errors
- [ ] Verify user impact metrics
- [ ] Confirm fix with affected users

### 4. Long-term Monitoring
- [ ] Set up alerts for similar errors
- [ ] Track related metrics
- [ ] Document the fix in runbooks
- [ ] Add monitoring dashboards

### Rollback Plan

Always have a rollback strategy:
- Know how to revert the change quickly
- Monitor deployment closely
- Set rollback criteria (error rate threshold)
- Communicate rollback plan to team
```

## Binary Search Debugging

### Divide and Conquer

```markdown
## Binary Search Techniques

### 1. Git Bisect for Regressions

**When:** Bug exists now but worked before

```bash
# Start bisect
git bisect start
git bisect bad HEAD           # Current version is broken
git bisect good v2.0.0        # This version worked

# Git will checkout a commit in the middle
# Test if bug exists
git bisect good   # If bug doesn't exist
git bisect bad    # If bug exists

# Repeat until git finds the breaking commit
git bisect reset  # When done
```

### 2. Narrow Down Code Scope

**When:** Bug is in large codebase

Strategy:
1. Identify large section where bug must be (e.g., module)
2. Comment out half
3. Test if bug still exists
4. If yes, bug is in remaining half
5. If no, bug is in commented half
6. Repeat until you find the exact line

### 3. Narrow Down Data

**When:** Bug only happens with certain data

Strategy:
1. Start with dataset that causes bug
2. Remove half the data
3. Test if bug still happens
4. Keep half that causes bug
5. Repeat until minimal failing dataset

### Example: Performance Issue

```markdown
# Initial: Slow with 10,000 records
Test with 5,000 records → Still slow
Test with 2,500 records → Still slow
Test with 1,250 records → Fast!
Test with 1,875 records → Slow!
Test with 1,562 records → Fast!

# Conclusion: Slowdown happens around 1,600-1,700 records
# Hypothesis: Hitting some threshold or pagination limit
# Next: Check code for hardcoded limits near this range
```

## Debugging Checklists by Error Type

### Null/Undefined References

```markdown
- [ ] Does the variable exist?
- [ ] Is it initialized before use?
- [ ] Could it be null/undefined in some cases?
- [ ] Is there a race condition?
- [ ] Did an async operation fail?
- [ ] Was the API response different than expected?
- [ ] Is there a typo in the property name?
```

### Connection/Network Errors

```markdown
- [ ] Is the service running?
- [ ] Is the URL/endpoint correct?
- [ ] Are network ports open?
- [ ] Is DNS resolving correctly?
- [ ] Are credentials valid?
- [ ] Is there a firewall blocking?
- [ ] Is TLS/SSL configured correctly?
- [ ] Are there rate limits or throttling?
- [ ] Is the connection timing out?
```

### Performance Issues

```markdown
- [ ] Is there an N+1 query problem?
- [ ] Are there missing database indexes?
- [ ] Is data volume larger than expected?
- [ ] Is there a memory leak?
- [ ] Are resources exhausted (CPU, memory, disk)?
- [ ] Is caching working?
- [ ] Are there unnecessary computations?
- [ ] Is blocking I/O slowing things down?
```

### Race Conditions

```markdown
- [ ] Does the bug happen inconsistently?
- [ ] Does adding delays change behavior?
- [ ] Are multiple threads/processes involved?
- [ ] Are shared resources properly locked?
- [ ] Is async code awaited properly?
- [ ] Are events firing in unexpected order?
- [ ] Is there non-atomic read-modify-write?
```

## Debugging Tools by Scenario

### When to Use Each Approach

```markdown
## Tool Selection Guide

### Use Logs When:
- Debugging production issues
- Understanding execution flow
- Tracking value changes over time
- Post-mortem analysis
- Can't attach debugger

### Use Debugger When:
- Stepping through complex logic
- Inspecting deep object structures
- Understanding call stack
- Local development
- Need to modify values on the fly

### Use Tests When:
- Verifying fix works
- Preventing regressions
- Documenting expected behavior
- Reproducing edge cases
- Testing hypotheses

### Use Print Statements When:
- Quick and dirty debugging
- Simple value inspection
- No debugger available
- Minimal setup needed
- Temporary investigation
```

## Best Practices

### Documentation While Debugging

```markdown
## Document Your Process

### Why Document?
- Share findings with team
- Remember what you tried
- Avoid repeating failed attempts
- Create post-mortem reports
- Help future debuggers

### What to Document

**Investigation Log:**
- Timestamp
- Hypothesis tested
- Test performed
- Results observed
- Conclusions drawn
- Next steps

**Example:**
```
2024-01-10 14:30 - H1: Database connection issue
Test: Checked pg_stat_activity
Result: Only 5 connections, max is 100
Conclusion: Not a connection limit issue
Next: Check query performance
```
```

### Common Debugging Pitfalls

```markdown
## Avoid These Mistakes

1. **Changing multiple things at once**
   - Change one variable at a time
   - You won't know what fixed it

2. **Not documenting what you tried**
   - You'll repeat failed attempts
   - You'll forget important findings

3. **Confirmation bias**
   - Don't just look for evidence supporting your theory
   - Actively try to disprove hypotheses

4. **Going too deep too fast**
   - Start with simple explanations
   - Check the obvious things first

5. **Not writing reproduction steps**
   - If you can't reproduce it, you can't fix it
   - If you can't verify the fix, you don't know it works

6. **Assuming others are wrong**
   - "The framework must have a bug"
   - Usually it's your code
   - Check your assumptions first

7. **Debugging without understanding**
   - Don't just try random fixes
   - Understand why something works
```

## Integration with Error Analysis

This debugging workflow complements the `error-analysis` skill:

- **error-analysis**: Analyzes errors after they occur (post-mortem)
- **debugging-workflow**: Guides systematic investigation (active debugging)

Use together for complete debugging methodology:
1. Use `error-analysis` to categorize and understand error patterns
2. Use `debugging-workflow` to systematically investigate root cause
3. Apply hypothesis-driven methodology from this skill
4. Use error patterns from `error-analysis` to form better hypotheses
