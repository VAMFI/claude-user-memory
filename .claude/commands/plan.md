---
name: plan
description: Quick command to invoke implementation-planner to create surgical, reversible implementation plans with rollback procedures.
---

# /plan Command

Create detailed implementation plan using the implementation-planner agent.

## Usage

```
/plan <feature description>
```

## Prerequisites

⚠️ **Requires ResearchPack** from `/research` or `@docs-researcher`

## What This Does

1. Checks ResearchPack exists and passed validation (80+)
2. Invokes `@implementation-planner` with your feature
3. Applies `planning-methodology` skill automatically
4. Creates Implementation Plan with:
   - Minimal file changes
   - Step-by-step instructions
   - Verification methods
   - Test plan
   - Risk assessment
   - Rollback procedure
5. Validates Plan (must score 85+)
6. Runs API matcher (Plan APIs must match ResearchPack)
7. Returns ready for implementation

## Examples

```
/plan Add Redis caching with TTL configuration
/plan Implement JWT authentication middleware
/plan Create database migration for users table
/plan Integrate Stripe payment processing
```

## Output

You'll receive a complete Implementation Plan including:
- ✅ File changes (new and modified)
- ✅ Step-by-step implementation sequence
- ✅ Verification method for each step
- ✅ Comprehensive test plan
- ✅ Risk assessment with mitigations
- ✅ Complete rollback procedure
- ✅ Success criteria
- ✅ Time estimates

## Quality Gates

Plan will be automatically validated:
- Score must be ≥ 85/100
- APIs used must match ResearchPack (no hallucination)
- Must include rollback procedure
- Must include risk assessment (3+ risks)
- Each step must have verification method

If validation fails, you'll see:
- Specific defects found
- Required score vs actual score
- API mismatches (if any)
- Recommendations to fix

## Next Steps

After `/plan` completes:
1. Review the Implementation Plan
2. Verify it makes sense and is minimal
3. Run `/implement` to execute the plan
4. Or use `@code-implementer` directly

## Time

Typical completion: **< 3 minutes**

---

**Executing command...**

Please invoke: `@implementation-planner {args}`

The planning-methodology skill will be automatically applied to ensure minimal-change, reversible plans with complete safety procedures.

The plan will be validated for:
- Completeness (35 pts)
- Safety (30 pts)
- Clarity (20 pts)
- Alignment with ResearchPack (15 pts)
