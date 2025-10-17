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

### Step 5: Verification (< 10 seconds)

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

**This skill ensures institutional knowledge is captured automatically, making future implementations faster and more consistent.**
