# Troubleshooting Guide - claude-user-memory v2.0

Common issues and solutions for the Research → Plan → Implement workflow.

---

## 🔍 Quick Diagnosis

### Symptom Checker

**Validation failing?** → [Validation Issues](#validation-issues)
**Implementation stuck?** → [Implementation Issues](#implementation-issues)
**Circuit breaker blocking?** → [Circuit Breaker Issues](#circuit-breaker-issues)
**Knowledge not saving?** → [Knowledge Core Issues](#knowledge-core-issues)
**Hooks not running?** → [Hook Issues](#hook-issues)

---

## ✅ Validation Issues

### ResearchPack Score < 80

**Symptom**: Hook reports "ResearchPack validation failed"

**Causes**:
1. Missing library/version identification
2. Too few APIs documented (need 3+)
3. No code examples
4. Missing source URLs

**Solution**:
```bash
# Check your ResearchPack against rubric:
./.claude/hooks/validate-research-pack.sh

# Common fixes:
# 1. Add library version explicitly
#    "Target Library: redis v4.6.0"

# 2. Document more APIs (minimum 3)
#    ### API: client.get(key)
#    ### API: client.set(key, value)
#    ### API: client.del(key)

# 3. Add working code example
#    ```javascript
#    const client = redis.createClient();
#    ```

# 4. Cite every API
#    Source: redis.io/docs/clients/nodejs#get
```

**Prevention**: Use @docs-researcher with clear instructions:
```
@docs-researcher "Redis client for Node.js - get versions, document at least 3 key APIs with examples"
```

### Implementation Plan Score < 85

**Symptom**: Hook reports "Implementation Plan validation failed"

**Causes**:
1. Missing rollback plan
2. No risk assessment
3. Steps lack verification methods
4. Too many files (not minimal)

**Solution**:
```bash
# Check your Plan:
./.claude/hooks/validate-implementation-plan.sh

# Common fixes:
# 1. Add rollback section
#    ## 🔄 Rollback Plan
#    ```bash
#    git reset --hard HEAD~1
#    ```

# 2. Add risk assessment (minimum 3 risks)
#    ⚠️ Risk: Rate limit → Mitigation: Cache results
#    ⚠️ Risk: API key leak → Mitigation: Use .env

# 3. Add verification to each step
#    Step 1: Create service
#    Verification: npm test passes

# 4. Minimize file changes
#    Review: Can you do this in fewer files?
```

**Prevention**: Use @implementation-planner with quality reminder:
```
@implementation-planner "Create plan with: rollback procedure, 3+ risks, verification per step"
```

### API Mismatch Detected

**Symptom**: "APIs in Plan don't match ResearchPack"

**Causes**:
- Hallucinated API (invented function not in research)
- Typo in API name
- Using outdated API from LLM memory

**Solution**:
```bash
# Run API matcher to see specific mismatches:
./.claude/validators/api-matcher.sh ResearchPack.md ImplementationPlan.md

# Fix:
# 1. Check exact API name in ResearchPack
# 2. Update Plan to use correct API
# 3. If genuinely new API needed, update ResearchPack first

# Example:
# ResearchPack shows: client.get(key)
# Plan was using: client.fetch(key)  ❌
# Fix Plan to: client.get(key)  ✅
```

**Prevention**: Explicitly remind planner:
```
@implementation-planner "Use ONLY APIs from ResearchPack. No hallucination."
```

---

## 🔧 Implementation Issues

### Tests Fail (No Self-Correction)

**Symptom**: Tests fail but @code-implementer doesn't auto-fix

**Causes**:
- Self-correction disabled
- Timeout too short
- Error not parseable

**Solution**:
```bash
# 1. Check self-correction is enabled
#    (It should be by default in v2.0)

# 2. Check error message is clear
#    Run tests manually to see full output:
npm test

# 3. If error is cryptic, help the implementer:
@code-implementer "Tests failed with error: [paste error]. Fix by [suggest approach]"

# 4. Check circuit breaker isn't blocking:
./.claude/validators/circuit-breaker.sh code-implementer status
```

**Prevention**: Write clearer test error messages

### Tests Fail After 3 Retries

**Symptom**: All 3 self-correction attempts fail

**Causes**:
- Fundamental issue with plan (not just code)
- Missing dependencies
- Environment problem (not code problem)

**Solution**:
```bash
# 1. Review what was attempted:
#    Implementer should report all 3 attempts

# 2. Check if problem is environment:
npm install  # Install missing deps
npm run build  # Check build works

# 3. Check if problem is plan:
#    - Is plan asking for something impossible?
#    - Are file paths correct?
#    - Are APIs actually available?

# 4. If plan is wrong, fix plan and retry:
@implementation-planner "Revise plan to fix [issue]"
@code-implementer "Execute revised plan"
```

**Prevention**: Validate environment before implementation:
```bash
npm install && npm run build && npm test
```

### Implementation Stuck/Slow

**Symptom**: Implementer runs for > 10 minutes

**Causes**:
- Too many files to change
- Large files to edit
- Complex dependencies

**Solution**:
```bash
# 1. Interrupt (Ctrl+C if needed)

# 2. Break into smaller tasks:
#    Instead of: "Implement entire feature"
#    Do: "Implement part 1: Create service"
#        "Implement part 2: Add tests"
#        "Implement part 3: Integrate"

# 3. Check anti-stagnation isn't triggered
#    Implementer should report progress every 30s
#    If silent > 2 min, likely stuck

# 4. Simplify plan:
@implementation-planner "Create simpler plan, fewer files"
```

**Prevention**: Start with minimal viable change

---

## 🚫 Circuit Breaker Issues

### Circuit Breaker Blocking Agent

**Symptom**: "CIRCUIT BREAKER OPEN - Agent blocked"

**Causes**:
- Agent failed 3+ times consecutively
- Previous session had repeated failures

**Solution**:
```bash
# 1. Check why it failed:
./.claude/validators/circuit-breaker.sh code-implementer status

# 2. Review failure history:
#    What was attempted?
#    What errors occurred?
#    Why did all attempts fail?

# 3. Fix root cause BEFORE resetting:
#    - Update ResearchPack with correct info
#    - Fix environment issues
#    - Simplify plan
#    - Install missing dependencies

# 4. Reset circuit:
./.claude/validators/circuit-breaker.sh code-implementer reset

# 5. Retry with fixes applied
```

**When NOT to reset**:
- You haven't fixed the underlying problem
- You're just hoping it works this time
- You haven't changed anything

**When TO reset**:
- You've fixed the root cause
- You've simplified the task
- You've updated research/plan with correct info

### Circuit Breaker Opening Too Early

**Symptom**: Opens after just 1-2 failures (should be 3)

**Causes**:
- Previous session didn't reset properly
- Manual editing of state file

**Solution**:
```bash
# Check current state:
cat .claude/.circuit-breaker-state

# Should show: {"code-implementer": 0}
# If higher, reset:
./.claude/validators/circuit-breaker.sh code-implementer reset

# If file corrupted, delete and recreate:
rm .claude/.circuit-breaker-state
echo "{}" > .claude/.circuit-breaker-state
```

---

## 🧠 Knowledge Core Issues

### knowledge-core.md Not Updating

**Symptom**: Patterns not captured after successful implementation

**Causes**:
- Stop hook didn't run
- Hook not executable
- No recent code changes detected

**Solution**:
```bash
# 1. Check hook is executable:
ls -la .claude/hooks/update-knowledge-core.sh
# Should show: -rwxr-xr-x

# If not executable:
chmod +x .claude/hooks/update-knowledge-core.sh

# 2. Run hook manually:
./.claude/hooks/update-knowledge-core.sh

# 3. Check for recent changes:
find . -type f -name "*.ts" -mmin -60  # Files changed in last hour

# 4. Manually capture patterns:
@pattern-recognition "Analyze recent implementation and update knowledge-core.md"
```

### Patterns Duplicated

**Symptom**: Same pattern appears multiple times in knowledge-core.md

**Causes**:
- Pattern recognition not checking for duplicates
- Manual edits created duplicates

**Solution**:
```bash
# 1. Review knowledge-core.md for duplicates

# 2. Consolidate manually:
#    - Keep most complete version
#    - Add note: "Reinforced in [date] implementation"

# 3. Update version number after manual edit:
#    Version: 1.4 → Version: 1.5
```

**Prevention**: Pattern recognition skill should check for duplicates (it's designed to, but LLM might miss it)

---

## 🔗 Hook Issues

### Hooks Not Running

**Symptom**: Validation should happen but doesn't

**Causes**:
- Hooks not executable
- settings.json misconfigured
- Claude Code version < 2.0.20

**Solution**:
```bash
# 1. Check Claude Code version:
claude --version  # Need 2.0.20+

# 2. Check hooks are executable:
ls -la .claude/hooks/
# All .sh files should have 'x' permission

# Fix if needed:
chmod +x .claude/hooks/*.sh

# 3. Verify settings.json is valid:
cat .claude/settings.json | jq .
# Should parse without errors

# 4. Check hook paths are correct:
cat .claude/settings.json | jq '.hooks'
# Paths should match actual files

# 5. Test hook manually:
./.claude/hooks/validate-research-pack.sh
```

### Hook Fails with Permission Error

**Symptom**: "Permission denied" when hook runs

**Causes**:
- Hook script not executable
- Running in restricted directory

**Solution**:
```bash
# Make executable:
chmod +x .claude/hooks/*.sh

# If still fails, check directory permissions:
ls -la .claude/
# Should be writable

# Check if hooks can write state files:
touch .claude/test
rm .claude/test
```

### Hook Produces Wrong Output

**Symptom**: Hook runs but gives unexpected result

**Causes**:
- Bash version incompatibility
- Missing command (grep, sed, etc.)

**Solution**:
```bash
# Check bash version:
bash --version  # Need 4.0+

# Check required commands:
which grep sed awk find

# Test hook logic:
bash -x ./.claude/hooks/validate-research-pack.sh
# Shows debug output

# If using macOS, might need:
brew install grep gnu-sed
```

---

## 🐛 Common Error Messages

### "Cannot find ResearchPack"

**Full Message**: "⚠️ No ResearchPack found"

**Meaning**: Validation hook can't find research output

**Solution**:
```bash
# Hook looks for files named *Research*.md modified in last 30 min

# Option 1: Name your file correctly
mv output.md ResearchPack-Redis.md

# Option 2: Create ResearchPack explicitly
@docs-researcher "..." > ResearchPack.md

# Option 3: If research is old, refresh:
@docs-researcher "[topic again]"
```

### "No APIs found in ResearchPack"

**Full Message**: "⚠️ No APIs found in ResearchPack"

**Meaning**: ResearchPack has no code/function examples

**Solution**:
```
Add code examples to ResearchPack:

### API: functionName(params)
```language
// Example usage
functionName(arg1, arg2);
```
Source: docs.com/api#function
```

### "APIs don't match ResearchPack"

**Full Message**: "❌ CRITICAL: N potentially hallucinated APIs"

**Meaning**: Plan uses APIs not mentioned in research

**Solution**:
```bash
# Run matcher to see which APIs:
./.claude/validators/api-matcher.sh ResearchPack.md Plan.md

# Fix by:
# 1. Adding missing APIs to ResearchPack, OR
# 2. Updating Plan to use correct APIs

# Then re-run:
@implementation-planner "Revise plan using only APIs from ResearchPack"
```

---

## 🔄 Reset Procedures

### Full Reset (Nuclear Option)

**Use when**: Everything is broken, start fresh

```bash
# 1. Backup current state
cp -r .claude .claude.backup

# 2. Reset circuit breakers
rm .claude/.circuit-breaker-state
echo "{}" > .claude/.circuit-breaker-state

# 3. Clear validation caches (if any)
rm -rf .claude/cache

# 4. Verify hooks work
./.claude/hooks/validate-research-pack.sh
./.claude/hooks/validate-implementation-plan.sh

# 5. Test basic workflow
@docs-researcher "test library"
```

### Soft Reset

**Use when**: Just need fresh start, keep patterns

```bash
# Reset only circuit breakers
./.claude/validators/circuit-breaker.sh code-implementer reset
./.claude/validators/circuit-breaker.sh implementation-planner reset

# Keep knowledge-core.md
# Keep settings.json
# Keep all agents/skills/hooks
```

---

## 📞 Getting Help

### Before Asking for Help

✅ Check this troubleshooting guide
✅ Run validation hooks manually
✅ Check Claude Code version (need 2.0.20+)
✅ Verify hooks are executable
✅ Try with a simple example first

### Information to Provide

When reporting issues, include:
- Claude Code version: `claude --version`
- Error message (full output)
- ResearchPack score (if validation issue)
- Plan score (if validation issue)
- What you were trying to do
- What you expected vs what happened

### Where to Get Help

- GitHub Issues: [repository URL]
- Documentation: `docs/` directory
- Examples: `examples/v2/` directory

---

## 💡 Best Practices (Prevention)

### Research Phase
✅ Use @docs-researcher with specific instructions
✅ Verify library version detected correctly
✅ Ensure at least 3 APIs documented
✅ Include working code example
✅ Cite all sources with URLs

### Planning Phase
✅ Use @implementation-planner with quality reminders
✅ Ensure rollback plan included
✅ Add at least 3 risks with mitigations
✅ Verify each step has verification method
✅ Keep file changes minimal

### Implementation Phase
✅ Run hooks before starting
✅ Monitor progress (should update every 30s)
✅ Let self-correction work (don't interrupt too early)
✅ Check tests pass before considering done
✅ Review captured patterns

### After Issues
✅ Document what went wrong
✅ Update knowledge-core.md with lessons
✅ Improve prompts for next time
✅ Reset circuit breakers after fixes

---

**Last Updated**: 2025-10-17
**Version**: 2.0
