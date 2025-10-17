---
name: quality-validation
description: Systematic validation methodology for ResearchPacks and Implementation Plans. Provides scoring rubrics and quality gates to ensure outputs meet standards before proceeding to next phase. Prevents garbage-in-garbage-out scenarios.
auto_invoke: true
tags: [validation, quality, verification, gates]
---

# Quality Validation Skill

This skill provides systematic validation methodology to ensure ResearchPacks and Implementation Plans meet quality standards before proceeding to implementation.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- ResearchPack completed and needs validation before planning
- Implementation Plan completed and needs validation before coding
- User explicitly requests quality check ("validate this", "is this complete?")
- About to proceed to next workflow phase (quality gate trigger)

## Core Principles (BRAHMA Constitution)

1. **Verification over speculation** - Validate with objective criteria
2. **Quality gates** - Don't proceed with bad inputs
3. **Reproducibility** - Same input quality = same score
4. **Explicit defects** - List specific problems, not vague "could be better"

## Validation Targets

### 1. ResearchPack Validation

**Purpose**: Ensure research is complete, accurate, and actionable before planning

**Validation Rubric** (100 points total):

#### Completeness (40 points)
- ✓ Library/API identified with version (10 pts)
- ✓ At least 3 key APIs documented (10 pts)
- ✓ Setup/configuration steps provided (10 pts)
- ✓ At least 1 complete code example (10 pts)

#### Accuracy (30 points)
- ✓ All API signatures match official docs exactly (15 pts)
  - Check: No paraphrasing, exact parameter types, correct returns
- ✓ Version numbers correct and consistent (5 pts)
- ✓ URLs all valid and point to official sources (10 pts)
  - Test: Each URL should be from official domain

#### Citation (20 points)
- ✓ Every API has source URL (10 pts)
- ✓ Sources include version and section references (5 pts)
- ✓ Confidence level stated and justified (5 pts)

#### Actionability (10 points)
- ✓ Implementation checklist provided (5 pts)
- ✓ Open questions identify real decisions (5 pts)

**Passing Score**: 80/100 or higher

**Validation Process**:

```python
# Pseudo-code for validation logic
def validate_research_pack(research_pack):
    score = 0
    defects = []

    # Completeness checks
    if has_library_with_version(research_pack):
        score += 10
    else:
        defects.append("CRITICAL: Library/version not identified")

    api_count = count_documented_apis(research_pack)
    if api_count >= 3:
        score += 10
    elif api_count > 0:
        score += (api_count / 3) * 10
        defects.append(f"MINOR: Only {api_count} APIs documented, need 3+")
    else:
        defects.append("CRITICAL: No APIs documented")

    # ... (continue for all criteria)

    return {
        "score": score,
        "grade": "PASS" if score >= 80 else "FAIL",
        "defects": defects,
        "recommendations": generate_recommendations(defects)
    }
```

**Output Format**:

```markdown
## 📊 ResearchPack Validation Report

**Overall Score**: [X]/100
**Grade**: [PASS ✅ / FAIL ❌]

### Breakdown
- Completeness: [X]/40
- Accuracy: [X]/30
- Citation: [X]/20
- Actionability: [X]/10

### Defects Found ([N])

#### CRITICAL (blocks implementation)
1. [Specific defect with example]
2. [Another defect]

#### MAJOR (should fix before proceeding)
1. [Defect]

#### MINOR (nice to have)
1. [Defect]

### Recommendations

**To reach passing score**:
1. [Specific action to take]
2. [Another action]

**If score >= 80**: ✅ **APPROVED** - Proceed to implementation-planner

**If score < 80**: ❌ **BLOCKED** - Fix critical/major defects and re-validate
```

### 2. Implementation Plan Validation

**Purpose**: Ensure plan is complete, safe, and executable before coding

**Validation Rubric** (100 points total):

#### Completeness (35 points)
- ✓ All file changes listed with purposes (10 pts)
- ✓ Step-by-step implementation sequence (10 pts)
- ✓ Each step has verification method (10 pts)
- ✓ Test plan included (5 pts)

#### Safety (30 points)
- ✓ Rollback plan complete and specific (15 pts)
  - Must include: exact commands, verification steps, triggers
- ✓ Risk assessment done (10 pts)
  - At least 3 risks identified with mitigations
- ✓ Changes are minimal (fewest files possible) (5 pts)

#### Clarity (20 points)
- ✓ Steps are actionable (no ambiguity) (10 pts)
- ✓ Success criteria defined (5 pts)
- ✓ Time estimates provided (5 pts)

#### Alignment (15 points)
- ✓ Plan matches ResearchPack APIs (10 pts)
- ✓ Plan addresses all requirements from user (5 pts)

**Passing Score**: 85/100 or higher (higher bar than research)

**Validation Process**:

```python
def validate_implementation_plan(plan, research_pack):
    score = 0
    defects = []

    # Completeness checks
    if has_file_changes_list(plan):
        score += 10
    else:
        defects.append("CRITICAL: No file changes specified")

    steps = extract_steps(plan)
    if all(step_has_verification(s) for s in steps):
        score += 10
    else:
        missing = [s for s in steps if not step_has_verification(s)]
        score += (len(steps) - len(missing)) / len(steps) * 10
        defects.append(f"MAJOR: Steps {missing} lack verification")

    # Safety checks
    rollback = extract_rollback_plan(plan)
    if has_exact_commands(rollback) and has_triggers(rollback):
        score += 15
    elif has_rollback_section(plan):
        score += 8
        defects.append("MAJOR: Rollback plan incomplete (missing commands or triggers)")
    else:
        defects.append("CRITICAL: No rollback plan")

    # Alignment checks
    apis_used = extract_apis_from_plan(plan)
    research_apis = extract_apis_from_research(research_pack)
    if all(api_matches_research(a, research_apis) for a in apis_used):
        score += 10
    else:
        mismatches = find_api_mismatches(apis_used, research_apis)
        defects.append(f"CRITICAL: APIs don't match ResearchPack: {mismatches}")

    # ... (continue for all criteria)

    return {
        "score": score,
        "grade": "PASS" if score >= 85 else "FAIL",
        "defects": defects,
        "recommendations": generate_recommendations(defects)
    }
```

**Output Format**:

```markdown
## 📊 Implementation Plan Validation Report

**Overall Score**: [X]/100
**Grade**: [PASS ✅ / FAIL ❌]

### Breakdown
- Completeness: [X]/35
- Safety: [X]/30
- Clarity: [X]/20
- Alignment: [X]/15

### Defects Found ([N])

#### CRITICAL (blocks implementation)
1. [Specific defect]

#### MAJOR (should fix)
1. [Defect]

#### MINOR (nice to have)
1. [Defect]

### API Alignment Check
✅ All APIs match ResearchPack
OR
❌ Mismatches found:
- Plan uses `foo(x, y)` but ResearchPack shows `foo(x: string, y?: number)`

### Recommendations

**To reach passing score**:
1. [Action]

**If score >= 85**: ✅ **APPROVED** - Proceed to code-implementer

**If score < 85**: ❌ **BLOCKED** - Fix defects and re-validate
```

## Quality Gate Protocol

**Gates are MANDATORY checkpoints** - cannot proceed to next phase without passing validation.

### Gate 1: Research → Planning

```
Trigger: @docs-researcher completes ResearchPack
Action: Validate ResearchPack
Decision:
  - Score >= 80: ✅ Allow @implementation-planner to proceed
  - Score < 80: ❌ Block, return to @docs-researcher with defect list
```

### Gate 2: Planning → Implementation

```
Trigger: @implementation-planner completes Implementation Plan
Action: Validate Implementation Plan + check alignment with ResearchPack
Decision:
  - Score >= 85 AND APIs match: ✅ Allow @code-implementer to proceed
  - Score < 85 OR APIs mismatch: ❌ Block, return to @implementation-planner with defect list
```

### Gate 3: Implementation → Completion

```
Trigger: @code-implementer reports completion
Action: Validate tests passed, build succeeded, no regressions
Decision:
  - All checks pass: ✅ Mark complete
  - Any check fails: ❌ Trigger self-correction loop (up to 3 attempts)
```

## Validation Automation

**These validations should be automated via hooks** (see hooks implementation):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "implementation-planner",
        "command": "validate-research-pack.sh",
        "action": "block_if_fails"
      },
      {
        "matcher": "code-implementer",
        "command": "validate-implementation-plan.sh",
        "action": "block_if_fails"
      }
    ]
  }
}
```

**Validation scripts return**:
- Exit code 0: Validation passed, proceed
- Exit code 1: Validation failed, defects printed to stdout, block

## Common Validation Failures

### ResearchPack Failures

**Hallucinated APIs**:
```
❌ CRITICAL: API `redis.client.fetch()` not found in official docs
   ResearchPack cites: redis.io/docs/clients/nodejs
   Actual API: `client.get()` (verified at redis.io/docs/clients/nodejs#get)
   FIX: Replace all instances of `fetch` with correct `get` API
```

**Version mismatch**:
```
❌ MAJOR: ResearchPack uses v3.x docs but project has v4.6.0
   Example: v3 uses callbacks, v4 uses promises
   FIX: Re-fetch docs for v4.6.0 specifically
```

**Missing citations**:
```
❌ MAJOR: 5 APIs listed without source URLs
   APIs: set(), del(), ttl(), exists(), keys()
   FIX: Add source URL for each (format: docs.com/path#section)
```

### Implementation Plan Failures

**No rollback plan**:
```
❌ CRITICAL: Rollback plan missing
   FIX: Add section "## 🔄 Rollback Plan" with:
   - Exact git commands to revert
   - Configuration restoration steps
   - Verification after rollback
   - Triggers for when to rollback
```

**Ambiguous steps**:
```
❌ MAJOR: Step 3 says "Update the service" (too vague)
   FIX: Specify:
   - Which service? (path/to/ServiceName.ts)
   - What update? (Add method X, modify method Y)
   - How to verify? (run `npm test path/to/test.ts`)
```

**API misalignment**:
```
❌ CRITICAL: Plan uses `client.fetch(key)` but ResearchPack shows `client.get(key)`
   FIX: Update plan to use correct API signature from ResearchPack
```

## Performance Targets

- **Validation time**: < 15 seconds per validation
- **Defect detection rate**: 95%+ of major issues caught
- **False positive rate**: < 5% (don't block good work)

## Integration with Hooks

Hooks provide deterministic enforcement (always run, not LLM-dependent):

**Research validation hook**:
```bash
#!/bin/bash
# .claude/hooks/validate-research-pack.sh

RESEARCH_FILE="$1" # Path to ResearchPack file

# Check completeness
if ! grep -q "Target Library:" "$RESEARCH_FILE"; then
    echo "❌ CRITICAL: Library not identified"
    exit 1
fi

# Check API count
API_COUNT=$(grep -c "^###.*API" "$RESEARCH_FILE" || echo 0)
if [ "$API_COUNT" -lt 3 ]; then
    echo "❌ MINOR: Only $API_COUNT APIs documented, need 3+"
    # Don't block for this, just warn
fi

# Check citations
if ! grep -q "Source:" "$RESEARCH_FILE"; then
    echo "❌ CRITICAL: No source citations found"
    exit 1
fi

echo "✅ ResearchPack validation passed (score: [calculated]/100)"
exit 0
```

**Plan validation hook** (similar structure).

---

**This skill ensures quality gates are objective, automated, and enforce the Research → Plan → Implement workflow deterministically.**
