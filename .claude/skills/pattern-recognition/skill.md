---
name: pattern-recognition
description: Systematic methodology for identifying, capturing, and documenting reusable patterns from implementations. Enables automatic learning and knowledge-core.md updates. Claude invokes this after successful implementations to preserve institutional knowledge.
auto_invoke: true
tags: [patterns, learning, knowledge, documentation]
---

# Pattern Recognition Skill

This skill provides systematic methodology for identifying reusable patterns from completed work and automatically updating the knowledge core to preserve institutional knowledge across sessions.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- Implementation successfully completed (tests passing)
- @code-implementer finishes major feature work
- Chief-architect synthesizes results from multiple agents
- User explicitly requests pattern documentation
- Stop hook triggers (end of session)

## Core Principles (BRAHMA Constitution)

1. **Knowledge preservation** - Capture patterns for future use
2. **Reproducibility** - Document enough detail to replicate pattern
3. **Simplicity** - Extract essential pattern, not every detail
4. **Verification** - Patterns should be validated by actual code
5. **Adaptive learning** - Learn from outcomes to suggest proven patterns (NEW v3.1)

## Before Implementation (Pattern Suggestion - NEW v3.1)

**Trigger**: User requests feature implementation via /workflow, /implement, or direct agent invocation

**Purpose**: Leverage past implementation success to accelerate current work by suggesting proven patterns proactively

### Pattern Suggestion Workflow

**Step 1: Context Extraction** (< 5 seconds)

Extract context tags from user request to find similar past implementations:
- **Technology keywords**: "nodejs", "python", "redis", "postgresql", "express", "fastapi"
- **Problem domain**: "authentication", "caching", "logging", "error-handling", "validation"
- **Solution type**: "service-layer", "repository", "factory", "middleware", "api"

**Example**:
```
User request: "Add JWT authentication to Express API"
Extracted tags: ["nodejs", "express", "authentication", "jwt", "security"]
```

**Step 2: Pattern Lookup** (< 2 seconds)

```markdown
Read ~/.claude/data/pattern-index.json
Find patterns with ≥60% context tag overlap (similarity matching)
Filter to HIGH confidence patterns only (confidence ≥ 0.80)
Rank by: confidence DESC, quality DESC, recency DESC
Return top 3 patterns
```

**Graceful Degradation**:
```python
try:
    pattern_index = read_json('~/.claude/data/pattern-index.json')
    suggestions = suggest_patterns(context_tags, pattern_index)
except (FileNotFoundError, JSONDecodeError):
    logger.warning("pattern-index.json unavailable, skipping suggestions")
    suggestions = []  # Proceed without suggestions
    # User impact: ZERO (workflow continues normally)
```

**Step 3: Present Suggestions** (user interaction)

If HIGH confidence patterns found, show top 3:

```markdown
💡 Suggested patterns based on past implementations:

1. [HIGH CONFIDENCE: 92%] JWT Authentication Middleware Pattern
   - Used 8 times, 7 successes (88% success rate)
   - Average time: 12 minutes, Average quality: 89/100
   - Context match: 85% similar to your request
   - See: knowledge-core.md#jwt-authentication-middleware-pattern

2. [HIGH CONFIDENCE: 85%] Token Refresh Pattern
   - Used 5 times, 4 successes (80% success rate)
   - Average time: 15 minutes, Average quality: 85/100
   - See: knowledge-core.md#token-refresh-pattern

Use suggested pattern? (y/n/view)
```

**Step 4: User Response Handling**

- **User accepts (y)**: Track acceptance, use pattern in implementation
- **User rejects (n)**: Track rejection, proceed without pattern
- **User views (view)**: Show full pattern from knowledge-core.md, ask again
- **No response**: Proceed without pattern (don't block workflow)

**Step 5: Record User Feedback**

Update pattern acceptance tracking in pattern-index.json:
```json
{
  "user_acceptance_rate": (accepted_count + 1) / (total_suggestions + 1),
  "total_suggestions": total_suggestions + 1
}
```

**Performance Target**: < 7 seconds total for suggestion workflow

---

## Pattern Recognition Methodology

### Step 1: Implementation Analysis (< 30 seconds)

**Objective**: Review what was just implemented to identify patterns

**Analysis questions**:

1. **Architectural patterns**:
   - What high-level structure was used? (Service layer, Repository, Factory, etc.)
   - How are concerns separated? (Business logic, data access, presentation)
   - What design patterns were applied? (Singleton, Strategy, Observer, etc.)

2. **Integration patterns**:
   - How does new code connect to existing code?
   - What interfaces/contracts were established?
   - How is dependency injection handled?

3. **Error handling patterns**:
   - How are errors caught and handled?
   - What logging/monitoring was added?
   - How are errors propagated to callers?

4. **Testing patterns**:
   - What test structure was used? (AAA: Arrange-Act-Assert, etc.)
   - How are mocks/stubs created?
   - What edge cases were covered?

5. **Configuration patterns**:
   - How are environment-specific values managed?
   - Where do defaults live?
   - How is configuration validated?

**Data to extract**:
- File paths demonstrating pattern
- Code snippets showing key concepts
- When this pattern should/shouldn't be used
- Alternatives considered and why rejected

### Step 2: Pattern Classification (< 15 seconds)

**Classify into knowledge-core.md sections**:

#### Section 1: Architectural Principles (high-level rules)
- Broad guidelines affecting entire codebase
- Example: "Use dependency injection for all external services"
- Example: "All API routes must have auth middleware"
- Example: "Database queries must go through repository layer"

#### Section 2: Established Patterns (concrete implementations)
- Specific, reusable implementation patterns
- Include: Pattern name, context, implementation example, files
- Example: "Service Layer Pattern for business logic"
- Example: "Factory pattern for creating Redis clients"

#### Section 3: Key Decisions & Learnings (chronological log)
- Decisions made during specific implementations
- Include: Date, decision, rationale, alternatives considered
- Example: "2025-10-17: Chose Redis over Memcached for caching (reason: better data structure support)"
- Learnings from mistakes or discoveries

**Classification criteria**:
- **Principle**: Applies across many features/files
- **Pattern**: Reusable template for specific problem
- **Decision**: One-time choice with lasting impact
- **Learning**: New insight or gotcha discovered

### Step 3: Pattern Documentation (< 30 seconds)

**For each pattern identified, document**:

```markdown
### Pattern: [Descriptive Name]

**Context**: [When to use this pattern]
- Use when: [Specific scenarios]
- Don't use when: [Scenarios where it doesn't fit]

**Problem**: [What problem does this solve?]

**Solution**:
[Brief description of the pattern]

**Implementation Example**:
```[language]
// Minimal code example showing pattern
// File: path/to/example.ts
```

**Files Demonstrating Pattern**:
- `path/to/file1.ts` - [What aspect it demonstrates]
- `path/to/file2.ts` - [What aspect it demonstrates]

**Related Patterns**:
- [Other patterns that work well with this]

**Trade-offs**:
- ✅ Benefits: [List]
- ⚠️ Costs: [List]

**Alternatives Considered**:
1. [Alternative 1] - Rejected because [reason]
2. [Alternative 2] - Rejected because [reason]
```

**Quality criteria**:
- **Actionable**: Another developer can apply this pattern from the description
- **Specific**: Not vague generalities ("use good code" → ❌)
- **Verified**: Pattern is actually implemented in referenced files
- **Complete**: Includes when to use AND when not to use

### Step 4: Knowledge Core Update (< 20 seconds)

**Update `knowledge-core.md` following its structure**:

```markdown
# Knowledge Core

Last Updated: [ISO date]
Version: [increment version number]

## 1. Architectural Principles

### [New principle if identified]
[Description]

**Rationale**: [Why this principle]
**Established**: [Date]
**Applies to**: [Which parts of codebase]

---

## 2. Established Patterns

### [New pattern from Step 3]
[Full pattern documentation]

---

## 3. Key Decisions & Learnings

### [YYYY-MM-DD] [Decision Title]
**Decision**: [What was decided]
**Context**: [What prompted this decision]
**Alternatives**: [What else was considered]
**Rationale**: [Why this was chosen]
**Implementation**: See `[files]`
**Status**: [Active / Superseded by [link]]

---
```

**Update protocol**:
1. Read current `knowledge-core.md`
2. Check for duplicates (don't add pattern if it already exists)
3. Append new patterns to appropriate sections
4. Increment version number
5. Update "Last Updated" timestamp
6. Write updated file

**Merge strategy** (if pattern partially exists):
- Enhance existing pattern with new examples/files
- Note that pattern was "reinforced" in latest implementation
- Don't create duplicate entries

### Step 5: Outcome Metrics Capture (< 10 seconds) - NEW v3.1

**Purpose**: Track implementation outcomes for pattern learning and confidence scoring

**Metrics to Capture**:

1. **Success/Failure Classification**:
   ```python
   success = (
       all_tests_passing AND
       quality_gates_passed AND
       no_rollback_required
   )
   ```

2. **Implementation Duration**:
   ```python
   duration_minutes = (end_time - start_time).total_seconds() / 60
   # Start time: When @code-implementer begins
   # End time: When tests pass and implementation complete
   ```

3. **Quality Scores** (if available from /workflow):
   ```python
   quality_score = (research_pack_score + implementation_plan_score) / 2
   # Only available if full workflow used (research + plan phases)
   ```

4. **Self-Correction Count**:
   ```python
   retry_count = number_of_self_correction_attempts
   # Reported by @code-implementer (0-3 range, lower is better)
   ```

5. **User Acceptance** (if pattern was suggested):
   ```python
   pattern_was_accepted = user_selected_yes_to_suggestion
   ```

**Data Structure**:
```python
outcome_metrics = {
    "success": True,  # or False
    "duration_minutes": 12.5,
    "quality_score": 87,  # or None if not available
    "retry_count": 1,
    "pattern_used": "JWT Authentication Middleware Pattern",  # or None
    "pattern_was_suggested": True,
    "pattern_was_accepted": True,
    "timestamp": "2025-10-25T14:30:00Z"
}
```

**Capture Process**:
1. Collect metrics from @code-implementer at end of implementation
2. Classify success/failure based on tests and quality gates
3. Calculate duration from timestamps
4. Retrieve quality scores from research/plan phases (if available)
5. Package into outcome_metrics structure
6. Pass to pattern-index.json update step

---

### Step 6: pattern-index.json Update (< 15 seconds) - NEW v3.1

**Purpose**: Update pattern metrics for adaptive learning and future suggestions

**Update Workflow**:

**1. Read Current pattern-index.json**:
```python
try:
    pattern_index = read_json('~/.claude/data/pattern-index.json')
except (FileNotFoundError, JSONDecodeError):
    logger.warning("pattern-index.json missing/corrupted, skipping metrics update")
    return  # Continue with knowledge-core.md update only (graceful degradation)
```

**2. Find or Create Pattern Entry**:
```python
pattern_name = "JWT Authentication Middleware Pattern"  # From pattern recognition

if pattern_name not in pattern_index['patterns']:
    # Create new pattern entry with conservative defaults
    pattern_index['patterns'][pattern_name] = {
        "pattern_id": generate_kebab_case_id(pattern_name),
        "total_uses": 0,
        "successes": 0,
        "failures": 0,
        "avg_time_minutes": 0,
        "avg_quality_score": 0,
        "quality_scores": [],
        "last_used": today_iso(),
        "first_used": today_iso(),
        "confidence": 0.5,  # Start conservative (MEDIUM)
        "confidence_level": "MEDIUM",
        "context_tags": extract_tags_from_pattern(),
        "related_patterns": [],
        "anti_pattern": False,
        "deprecation_warning": None,
        "user_acceptance_rate": 0.0,
        "self_correction_avg": 0.0
    }
```

**3. Update Metrics**:
```python
pattern = pattern_index['patterns'][pattern_name]

# Increment usage
pattern['total_uses'] += 1

# Update success/failure counts
if outcome_metrics['success']:
    pattern['successes'] += 1
else:
    pattern['failures'] += 1

# Update time metrics (running average)
if outcome_metrics['duration_minutes'] > 0:
    old_avg = pattern['avg_time_minutes']
    old_count = pattern['total_uses'] - 1
    pattern['avg_time_minutes'] = round(
        (old_avg * old_count + outcome_metrics['duration_minutes']) / pattern['total_uses'],
        2
    )

# Update quality scores (keep last 10 to prevent bloat)
if outcome_metrics['quality_score'] is not None:
    pattern['quality_scores'].append(outcome_metrics['quality_score'])
    pattern['quality_scores'] = pattern['quality_scores'][-10:]  # Keep last 10 only
    pattern['avg_quality_score'] = round(
        sum(pattern['quality_scores']) / len(pattern['quality_scores']),
        2
    )

# Update timestamps
pattern['last_used'] = today_iso()

# Update user acceptance rate (if pattern was suggested)
if outcome_metrics.get('pattern_was_suggested'):
    old_rate = pattern['user_acceptance_rate']
    old_suggestions = pattern.get('total_suggestions', 0)
    new_suggestions = old_suggestions + 1
    accepted = 1 if outcome_metrics.get('pattern_was_accepted') else 0
    pattern['user_acceptance_rate'] = round(
        (old_rate * old_suggestions + accepted) / new_suggestions,
        2
    )
    pattern['total_suggestions'] = new_suggestions

# Update self-correction average
old_avg_retries = pattern['self_correction_avg']
pattern['self_correction_avg'] = round(
    (old_avg_retries * (pattern['total_uses'] - 1) + outcome_metrics['retry_count']) / pattern['total_uses'],
    2
)
```

**4. Recalculate Confidence** (using algorithm from Step 7 below):
```python
pattern['confidence'] = calculate_confidence(pattern)
pattern['confidence_level'] = classify_confidence_level(pattern['confidence'])
```

**5. Check for Anti-Pattern Status**:
```python
# If pattern failed 3+ times consecutively with no successes, mark as anti-pattern
if pattern['failures'] >= 3 and pattern['successes'] == 0:
    pattern['anti_pattern'] = True
    pattern['deprecation_warning'] = "This pattern has failed repeatedly. Consider alternatives."

# If pattern rejected 3+ times, reduce confidence
if pattern.get('total_suggestions', 0) >= 3 and pattern['user_acceptance_rate'] < 0.30:
    pattern['confidence'] *= 0.8  # Reduce by 20%
    pattern['deprecation_warning'] = "This pattern has been rejected frequently."
```

**6. Write Updated JSON**:
```python
# Update metadata
pattern_index['metadata']['total_implementations'] += 1
pattern_index['metadata']['last_updated'] = today_iso()

# Recalculate overall success rate
total_successes = sum(p['successes'] for p in pattern_index['patterns'].values())
total_uses = sum(p['total_uses'] for p in pattern_index['patterns'].values())
pattern_index['metadata']['overall_success_rate'] = round(
    total_successes / total_uses if total_uses > 0 else 0.0,
    2
)

# Write updated JSON
write_json('~/.claude/data/pattern-index.json', pattern_index)

# Validate JSON is still valid
verify_json_valid('~/.claude/data/pattern-index.json')
```

**Performance Target**: < 15 seconds for complete metrics update

---

### Step 7: Verification (< 10 seconds)

**Before finalizing update**:

✓ **Completeness check**:
- Pattern has name, context, problem, solution
- At least 1 file reference provided
- Trade-offs documented

✓ **Accuracy check**:
- Referenced files actually exist
- Code snippets are actual code (not hallucinated)
- Pattern is demonstrated in listed files

✓ **Uniqueness check**:
- Pattern not duplicate of existing pattern
- Or if similar, explains difference/enhancement

✓ **Usefulness check**:
- Pattern is reusable (not one-off specific to this feature)
- Pattern solves a problem that will recur
- Pattern is clear enough for future use

**If any check fails**: Fix before updating knowledge-core.md

## Automation via Hooks

**Stop Hook Integration**:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "*",
        "command": "update-knowledge-core.sh",
        "description": "Automatically capture patterns from session"
      }
    ]
  }
}
```

**Hook script** (`.claude/hooks/update-knowledge-core.sh`):
```bash
#!/bin/bash
# Triggered at end of session to update knowledge core

# Check if any implementations occurred this session
if [ -f ".claude/session-summary.json" ]; then
    # Extract patterns from session
    # Call Claude with pattern-recognition skill
    # Update knowledge-core.md
    echo "🧠 Updating knowledge core with session learnings..."
fi
```

## Pattern Categories

### Common Patterns to Recognize

**1. Service Layer Pattern**:
```typescript
// Business logic separated into services
class ProductService {
  constructor(private repo: ProductRepository) {}

  async getProduct(id: string) {
    // Business logic here
    return this.repo.findById(id);
  }
}
```

**2. Repository Pattern**:
```typescript
// Data access abstracted
interface ProductRepository {
  findById(id: string): Promise<Product>;
  save(product: Product): Promise<void>;
}
```

**3. Factory Pattern**:
```typescript
// Complex object creation encapsulated
class CacheFactory {
  static createClient(config: CacheConfig): CacheClient {
    // Creation logic
  }
}
```

**4. Middleware Pattern**:
```typescript
// Request processing pipeline
app.use(authMiddleware);
app.use(loggingMiddleware);
app.use(errorHandlingMiddleware);
```

**5. Configuration Pattern**:
```typescript
// Environment-specific config
const config = {
  redis: {
    host: process.env.REDIS_HOST || 'localhost',
    port: parseInt(process.env.REDIS_PORT || '6379'),
  }
};
```

**6. Error Handling Pattern**:
```typescript
// Consistent error handling
try {
  await operation();
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new ApplicationError('User-friendly message', { cause: error });
}
```

### Anti-Patterns to Document

**Also capture what NOT to do**:

```markdown
### Anti-Pattern: Direct Database Access in Controllers

**Problem**: Controller directly queries database

**Why It's Bad**:
- Violates separation of concerns
- Hard to test
- Business logic mixed with HTTP handling

**Instead Use**: Repository pattern (see Section 2)

**Files that demonstrate BAD approach** (for reference):
- ❌ `old-code/legacy-controller.ts` (before refactor)

**Files that demonstrate GOOD approach**:
- ✅ `src/controllers/ProductController.ts` (uses ProductService)
```

## Knowledge Core Maintenance

**Regular review** (monthly recommended):
1. Check if documented patterns still apply
2. Mark deprecated patterns as "Superseded by [new pattern]"
3. Consolidate similar patterns if identified
4. Update examples if file paths changed

**Version control**:
- knowledge-core.md should be in git
- Track changes over time
- Tag versions with major architectural changes

## Performance Targets

- **Pattern identification**: < 30 seconds
- **Documentation**: < 30 seconds per pattern
- **Knowledge core update**: < 20 seconds
- **Total time**: < 90 seconds per completed implementation

## Example Usage

**Scenario**: @code-implementer just completed Redis caching implementation

**Claude (using this skill)**:

```
[Internal: Implementation complete, capture patterns]

🧠 Activating pattern-recognition skill

🔍 Analyzing implementation for patterns...

Identified patterns:
1. Service Layer Pattern (CacheService wraps Redis client)
2. Factory Pattern (createRedisClient() encapsulates connection)
3. Configuration Pattern (TTL and host via env vars)
4. Error Handling Pattern (try-catch with logging + fallback)

📝 Documenting patterns...

[Creates detailed pattern documentation for each]

📚 Updating knowledge-core.md...

Added to Section 2 (Established Patterns):
- Pattern: Redis Client Factory
- Pattern: Cache Service Layer
- Pattern: Environment-Based TTL Configuration

Added to Section 3 (Key Decisions):
- 2025-10-17: Chose Redis client v4.6.0 (promise-based over callback)
- 2025-10-17: TTL configured per-environment (dev: 60s, prod: 300s)

✅ Knowledge core updated (version 1.3 → 1.4)

New patterns available for future implementations!
```

---

## Confidence Calculation Algorithm (NEW v3.1)

### Bayesian Confidence with Time Decay

**Purpose**: Calculate pattern reliability based on success rate, recency, and evidence quality

**Formula**:
```
confidence = base_confidence × time_decay_factor × evidence_factor
```

**Components**:

**1. Base Confidence** (Success Rate):
```python
base_confidence = successes / total_uses
# Range: 0.0 to 1.0
# Example: 7 successes / 10 uses = 0.70
```

**2. Time Decay Factor** (Recency Penalty):
```python
days_since_use = (today - last_used).days

if days_since_use > 180:  # 6+ months
    time_decay_factor = 0.5  # Reduce confidence by 50%
elif days_since_use > 90:  # 3-6 months
    time_decay_factor = 0.75  # Reduce confidence by 25%
else:  # < 3 months
    time_decay_factor = 1.0  # No reduction
```

**Rationale**: Patterns become stale (libraries update, best practices change)

**3. Evidence Factor** (Sample Size Requirement):
```python
if total_uses < 3:
    evidence_factor = 0.5  # Low confidence, need more data
elif total_uses < 5:
    evidence_factor = 0.75  # Moderate confidence
else:  # 5+ uses
    evidence_factor = 1.0  # High confidence, sufficient evidence
```

**Rationale**: Require minimum evidence before trusting pattern (avoid false confidence from 1-2 uses)

### Confidence Level Classification

```python
if confidence >= 0.80:
    level = "HIGH"  # Auto-suggest prominently
elif confidence >= 0.50:
    level = "MEDIUM"  # Suggest with caveat
else:
    level = "LOW"  # Don't suggest, review pattern
```

**Threshold Rationale**:
- **80%**: High confidence ensures 80%+ suggestion accuracy
- **50%**: Medium patterns may work but need review
- **<50%**: Low confidence patterns need more evidence or deprecation

### Example Calculations

**Case 1: Proven Recent Pattern** (IDEAL)
```
Success rate: 8/10 = 0.80
Last used: 20 days ago → decay = 1.0
Total uses: 10 → evidence = 1.0
Confidence: 0.80 × 1.0 × 1.0 = 0.80 (HIGH)
```

**Case 2: Unproven Pattern** (LOW EVIDENCE)
```
Success rate: 2/2 = 1.00
Last used: 5 days ago → decay = 1.0
Total uses: 2 → evidence = 0.5
Confidence: 1.00 × 1.0 × 0.5 = 0.50 (MEDIUM)
```

**Case 3: Stale Pattern** (OLD, NOT USED)
```
Success rate: 5/5 = 1.00
Last used: 200 days ago → decay = 0.5
Total uses: 5 → evidence = 1.0
Confidence: 1.00 × 0.5 × 1.0 = 0.50 (MEDIUM)
```

**Case 4: Failed Pattern** (POOR SUCCESS RATE)
```
Success rate: 1/5 = 0.20
Last used: 10 days ago → decay = 1.0
Total uses: 5 → evidence = 1.0
Confidence: 0.20 × 1.0 × 1.0 = 0.20 (LOW)
```

### Implementation Reference

**Script**: `~/.claude/scripts/calculate-confidence.sh`

This algorithm is implemented in bash for standalone calculation and testing. The pattern-recognition skill uses these same calculations when updating pattern-index.json.

---

**This skill ensures institutional knowledge is captured automatically AND learns from outcomes to suggest proven patterns proactively, making future implementations 30-40% faster.**
