---
name: workflow
description: Complete Research → Plan → Implement workflow in one command. Invokes chief-architect to orchestrate all phases with quality gates and self-correction.
---

# /workflow Command

Execute complete Research → Plan → Implement workflow using chief-architect orchestration.

## Usage

```
/workflow <feature description>
```

## What This Does

**Complete automation of all three phases**:

1. **Research Phase**
   - Invokes `@docs-researcher`
   - Applies `research-methodology` skill
   - Creates ResearchPack
   - Validates score ≥ 80

2. **Planning Phase**
   - Invokes `@implementation-planner`
   - Applies `planning-methodology` skill
   - Creates Implementation Plan
   - Validates score ≥ 85
   - Runs API matcher (no hallucination)

3. **Implementation Phase**
   - Checks circuit breaker (must be closed)
   - Invokes `@code-implementer`
   - Executes plan with self-correction
   - Validates tests pass
   - Records circuit breaker state

4. **Knowledge Capture**
   - Applies `pattern-recognition` skill
   - Updates knowledge-core.md
   - Records decisions and learnings

## Examples

```
/workflow Add Redis caching to product service with TTL
/workflow Implement JWT authentication middleware
/workflow Create user profile page with avatar upload
/workflow Add Stripe payment integration with webhooks
/workflow Migrate database from SQLite to PostgreSQL
```

## Output

You'll receive a **complete project report**:

### 📈 Project Summary
- Goal: [Your request]
- Outcome: [What was delivered]
- Duration: [Actual time]
- Agents Used: researcher, planner, implementer

### 🛠️ Phase Results

**Research**:
- Library/API researched
- Version detected
- APIs documented (count)
- ResearchPack score

**Planning**:
- Files to change (count)
- Implementation steps (count)
- Risks identified (count)
- Plan score

**Implementation**:
- Files created/modified
- Tests passing/failing
- Self-corrections made (if any)
- Circuit breaker state

### 📚 Artifacts Created
- ResearchPack.md
- ImplementationPlan.md
- Code files (list)
- Test files (list)

### 🧠 Knowledge Captured
- Patterns identified
- Decisions recorded
- Suggestions for knowledge-core.md

## Quality Gates (Automatic)

At each phase transition:

**Research → Planning**:
- ✅ ResearchPack score ≥ 80
- ✅ Library version identified
- ✅ Minimum 3 APIs documented
- ✅ Code examples present
- ⛔ If fail: Blocks planning, requests fixes

**Planning → Implementation**:
- ✅ Plan score ≥ 85
- ✅ APIs match ResearchPack exactly
- ✅ Rollback plan present
- ✅ Risk assessment complete
- ⛔ If fail: Blocks implementation, requests fixes

**Implementation → Completion**:
- ✅ Circuit breaker closed
- ✅ All tests passing
- ✅ Build successful
- ⛔ If fail: Up to 3 self-corrections, then block

## Advantages Over Manual Steps

**Manual** (3 commands):
```
/research [topic]
# wait, review
/plan [feature]
# wait, review
/implement
# wait, review
```

**Automatic** (1 command):
```
/workflow [feature]
# orchestrator handles everything
```

**Benefits**:
- ✅ No waiting between phases
- ✅ Automatic quality gate enforcement
- ✅ Context preserved throughout
- ✅ Single comprehensive report
- ✅ Automatic knowledge capture

## When to Use `/workflow` vs Manual Commands

**Use `/workflow` when**:
- ✅ Clear, well-defined feature
- ✅ Trust orchestrator to handle details
- ✅ Want complete automation
- ✅ Standard feature (not experimental)

**Use manual commands when**:
- ⚠️ Need to review research before planning
- ⚠️ Want to modify plan before implementing
- ⚠️ Uncertain about approach
- ⚠️ Learning the system

## Time

Typical completion by feature complexity:

| Complexity | Time | Example |
|------------|------|---------|
| Simple | 10-15 min | API integration |
| Medium | 15-25 min | Caching layer, Auth middleware |
| Complex | 25-40 min | Database migration, Payment flow |
| Very Complex | 40-60 min | Multi-service integration |

## Error Handling

**If research fails**:
- Chief-architect reports research issues
- Suggests fixes or retry
- Does not proceed to planning

**If planning fails**:
- Chief-architect reports planning issues
- May suggest research update
- Does not proceed to implementation

**If implementation fails** (after 3 self-corrections):
- Circuit breaker opens
- Chief-architect provides complete failure analysis
- Lists all attempts made
- Recommends manual intervention
- Requires circuit breaker reset before retry

## Progress Tracking

Chief-architect reports progress throughout:

```
🏛️ Starting analysis for [feature]
🗺️ Designing multi-agent execution plan...
🤝 Delegating task 'research' to @docs-researcher
   📊 Research phase progress: 50%...
   ✅ ResearchPack complete (score: 85/100)
🤝 Delegating task 'planning' to @implementation-planner
   📊 Planning phase progress: 60%...
   ✅ Implementation Plan complete (score: 88/100)
   ✅ API matching passed
🤝 Delegating task 'implementation' to @code-implementer
   📊 Implementation phase: 3/5 files complete...
   🧪 Running tests...
   ✅ All tests passing
🔄 Synthesizing results...
✅ Project complete: [summary]
```

## Rollback

If you need to undo the entire workflow:

```bash
# Use rollback procedure from ImplementationPlan.md
git reset --hard HEAD~[N commits]

# Or if not yet committed:
git checkout -- [files modified]

# Or reset completely:
git clean -fd
```

Each Implementation Plan includes specific rollback instructions.

## Tips for Best Results

**Be specific in request**:
- ❌ "Add caching" (too vague)
- ✅ "Add Redis caching to ProductService with 5-minute TTL"

**Include constraints**:
- "Add auth using JWT tokens, not sessions"
- "Use PostgreSQL, not MongoDB"
- "Must work with existing API structure"

**Specify non-functional requirements**:
- "Must handle 1000 req/sec"
- "Must roll back on error"
- "Must log all operations"

## Next Steps

After `/workflow` completes:

1. **Review all artifacts**
   - ResearchPack.md
   - ImplementationPlan.md
   - Code changes

2. **Verify implementation**
   - Run tests manually: `npm test`
   - Check build: `npm run build`
   - Review changes: `git diff`

3. **Update knowledge**
   - Review knowledge-core.md updates
   - Add any additional lessons learned

4. **Commit changes**
   - Use meaningful commit message
   - Reference implementation plan
   - Include co-author attribution

5. **Deploy**
   - Follow your deployment procedure
   - Monitor for issues
   - Keep rollback plan handy

---

**Executing command...**

Please invoke: `@chief-architect {args}`

The chief-architect will:
1. Orchestrate all three phases sequentially
2. Enforce quality gates at each transition
3. Handle errors and retries automatically
4. Synthesize comprehensive final report
5. Capture knowledge for future use

**Expected duration**: 10-60 minutes depending on complexity

**Protection**: Multiple quality gates and circuit breaker prevent bad outcomes
