---
name: implement
description: Quick command to invoke code-implementer to execute implementation with self-correction (up to 3 intelligent retries).
---

# /implement Command

Execute implementation plan using the code-implementer agent with automatic self-correction.

## Usage

```
/implement
```

## Prerequisites

⚠️ **Requires**:
1. ResearchPack (from `/research`) - passed validation (80+)
2. Implementation Plan (from `/plan`) - passed validation (85+)

## What This Does

1. Checks circuit breaker status (must be closed)
2. Validates ResearchPack exists (80+ score)
3. Validates Implementation Plan exists (85+ score)
4. Invokes `@code-implementer` to execute plan
5. Creates/modifies files as specified in plan
6. Runs tests automatically
7. **Self-corrects on failure** (up to 3 attempts):
   - Attempt 1: Analyze error, targeted fix
   - Attempt 2: Alternative approach
   - Attempt 3: Minimal working version
8. Records success/failure in circuit breaker
9. Captures patterns in knowledge-core.md (on success)

## Examples

```
# After /research and /plan:
/implement

# That's it! The agent knows what to do from the artifacts.
```

## Output

You'll receive:
- ✅ Complete implementation report
- ✅ Files created/modified with line counts
- ✅ Test results (all passing or errors shown)
- ✅ Self-correction summary (if errors occurred)
- ✅ Verification results
- ✅ Pattern suggestions for knowledge-core.md

## Self-Correction Protocol

If tests fail, implementer will:

**Attempt 1** (targeted fix):
- Analyze error message
- Categorize error type (syntax, logic, API, config, test issue)
- Apply specific fix for that error type
- Re-run tests

**Attempt 2** (alternative approach):
- If attempt 1 failed
- Try different solution strategy
- Review ResearchPack for alternative APIs
- Check for version-specific gotchas
- Re-run tests

**Attempt 3** (minimal working version):
- If attempt 2 failed
- Strip down to bare minimum functionality
- Use simplest API usage from ResearchPack
- Focus on core happy path only
- Re-run tests

**After 3 failures**:
- Circuit breaker opens (blocks further attempts)
- Full error report with all 3 attempts documented
- Recommendations for manual intervention
- Requires manual circuit breaker reset after fixing root cause

## Circuit Breaker Protection

The circuit breaker prevents infinite retry loops:

**States**:
- **CLOSED** (0-2 failures): Operational
- **OPEN** (3+ failures): Blocked until manual reset

**If blocked**:
```bash
# Check status
./.claude/validators/circuit-breaker.sh code-implementer status

# Review why it failed
# Fix root cause (update ResearchPack/Plan, fix environment, etc.)

# Reset after fixing
./.claude/validators/circuit-breaker.sh code-implementer reset
```

## Quality Gate

Before implementation starts:
- ✅ Circuit breaker must be closed
- ✅ ResearchPack must exist with 80+ score
- ✅ Implementation Plan must exist with 85+ score
- ✅ Plan APIs must match ResearchPack

## Time

Typical completion:
- **Success on first try**: 5 minutes
- **With 1 self-correction**: 6-7 minutes
- **With 2 self-corrections**: 8-9 minutes
- **With 3 failures**: 10+ minutes (then blocked)

## Next Steps

After `/implement` completes:

**On Success**:
1. ✅ Review implementation report
2. ✅ Verify tests passing
3. ✅ Check patterns captured in knowledge-core.md
4. ✅ Commit changes
5. ✅ Deploy (if appropriate)

**On Failure**:
1. ❌ Review all 3 attempts made
2. ❌ Check error messages
3. ❌ Identify root cause
4. ❌ Fix ResearchPack/Plan/environment
5. ❌ Reset circuit breaker
6. ❌ Retry with fixes

## Troubleshooting

**Tests fail all 3 times**:
- See `TROUBLESHOOTING.md` → "Implementation Issues"
- Check if plan was correct (might need revision)
- Check if environment is set up (deps installed, etc.)
- Check if APIs in ResearchPack are accurate

**Circuit breaker blocking**:
- See `TROUBLESHOOTING.md` → "Circuit Breaker Issues"
- Don't reset until root cause fixed
- Review failure history before retrying

**Implementation seems stuck**:
- Should report progress every 30 seconds
- If silent > 2 minutes, likely blocked
- Interrupt and simplify task

---

**Executing command...**

Please invoke: `@code-implementer`

The code-implementer will:
1. Execute plan precisely (no improvisation)
2. Run tests continuously
3. Self-correct intelligently (up to 3 tries)
4. Record circuit breaker state
5. Capture patterns on success

**Protection**: Circuit breaker prevents infinite loops (blocks after 3 failures)
