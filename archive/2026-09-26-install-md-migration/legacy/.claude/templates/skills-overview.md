# Skills Overview

The Agentic Substrate provides 5 auto-invoked skills that enhance agent capabilities:

## 1. research-methodology
**Purpose**: Systematic approach for gathering authoritative documentation

**Auto-invokes when**: User mentions implementing/using a specific library or API

**What it does**:
- Rapid assessment (< 30s): Identify what needs research
- Documentation fetching (< 1 min): Retrieve from official sources
- ResearchPack assembly (< 30s): Organize findings with citations

**Key principle**: Truth over speed (but achieve both)

## 2. planning-methodology
**Purpose**: Minimal-change, reversible planning approach

**Auto-invokes when**: Transforming research into implementation plans

**What it does**:
- Simplicity enforcement (KISS, YAGNI)
- Minimal changes only (surgical edits)
- Reversibility mandatory (rollback plans always)
- Verification at each step

**Key principle**: Surgical changes, not rewrites

## 3. quality-validation
**Purpose**: Objective scoring for ResearchPacks and Implementation Plans

**Auto-invokes when**: ResearchPack or Plan completed and needs validation

**What it does**:
- **API Research**: 80+ pass threshold (objective criteria)
- **Philosophy Research**: 70+ pass threshold (thematic analysis)
- **Implementation Plans**: 85+ pass threshold (safety + completeness)

**Quality gates**: Don't proceed with bad inputs

**Research Types**:
- Type 1: API/Library (API endpoints, function signatures, code examples)
- Type 2: Philosophy (themes, principles, patterns, methodologies)
- Type 3: Pattern (code patterns, design patterns, anti-patterns)

## 4. pattern-recognition
**Purpose**: Automatic learning and knowledge capture

**Auto-invokes when**: After successful implementations to preserve knowledge

**What it does**:
- Identifies reusable patterns from implementations
- Captures institutional knowledge
- Updates knowledge-core.md automatically
- Enables pattern reuse across sessions

**Key principle**: Learn from every implementation

## 5. context-engineering
**Purpose**: Active context curation to fight context rot

**Auto-invokes when**:
- Conversation starts (optimize context relevance)
- Long sessions (> 50 messages)
- Before complex operations
- After tool use (large outputs)

**What it does**:
- Context rot detection and prevention
- Archives stale info to knowledge-core.md
- Loads relevant context for current task
- Optimizes token usage

**Performance**: 39% improvement, 84% token reduction (Anthropic research)

**Commands**:
- `/context analyze` - Show current context configuration
- `/context optimize` - Automatically prune stale context
- `/context reset` - Fresh start for new projects

## Integration

All skills work together automatically:

```
1. User: "Add Redis caching"

2. research-methodology → Fetches Redis docs (< 2 min)
   quality-validation → Validates ResearchPack (80+ score)

3. planning-methodology → Creates minimal-change plan (< 3 min)
   quality-validation → Validates Implementation Plan (85+ score)

4. [code-implementer executes with TDD]

5. pattern-recognition → Captures caching pattern to knowledge-core.md
   context-engineering → Archives completed work, loads next task context
```

Result: High-quality, reproducible outcomes with continuous learning

## Best Practices

**Research**: Always use context7 when available for latest docs

**Planning**: Favor surgical changes over rewrites

**Validation**: Trust the quality gates - fix defects before proceeding

**Pattern Recognition**: Review knowledge-core.md periodically to see what you've learned

**Context Engineering**: Run `/context optimize` every 50 messages or when switching tasks
