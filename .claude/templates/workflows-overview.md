# Workflows Overview

The Agentic Substrate provides structured workflows for common development patterns:

## Research → Plan → Implement Workflow

The core workflow enforced by the Agentic Substrate:

**Phase 1: Research** (< 2 min)
- Fetch authoritative, version-accurate documentation
- Prevent coding from stale memory
- Deliverable: ResearchPack (validated at 80+ score)

**Phase 2: Planning** (< 3 min)
- Transform research into minimal-change blueprint
- Identify surgical edits only
- Deliverable: Implementation Plan (validated at 85+ score)

**Phase 3: Implementation** (< 5 min)
- Execute plan with TDD (test-first mandatory)
- Self-correction with 3 intelligent retries
- Deliverable: Working code with tests passing + git commit

**Total**: ~10 minutes for production-ready features

### Usage

**Automated** (recommended):
```
/workflow Add Redis caching to ProductService with 5-minute TTL
```

**Manual Step-by-Step**:
```
/research Redis for Node.js v5.0
/plan Redis caching implementation for ProductService
/implement
```

**Direct Agent Control**:
```
@chief-architect orchestrate complete user authentication system
```

## Quality Gates

Automatic quality enforcement between phases:

**Gate 1: Research → Planning**
- ResearchPack must score 80+ (API research) or 70+ (philosophy research)
- Blocks planning if research incomplete
- Prevents garbage-in-garbage-out

**Gate 2: Planning → Implementation**
- Implementation Plan must score 85+
- Requires: rollback strategy, file list, step-by-step sequence
- Blocks coding if plan unsafe or incomplete

**Gate 3: Implementation → Completion**
- All tests must pass (TDD enforced)
- Self-correction attempts if failures (max 3)
- Circuit breaker prevents infinite loops

## TDD Workflow (Mandatory)

**RED-GREEN-REFACTOR Cycle**:

1. **RED**: Write failing test (2-3 min)
   - Create test file
   - Write test for new functionality
   - Run test - verify it fails

2. **GREEN**: Implement minimal code (3-5 min)
   - Write simplest code to pass test
   - Run test - verify it passes

3. **REFACTOR**: Improve quality (1-2 min)
   - DRY, SOLID, better naming
   - Run test - verify still passes

**Cycle time**: 6-10 minutes per feature unit

**Why mandatory**: "TDD becomes even more powerful with agentic coding" (Anthropic)

## Git Workflow

**Automatic Commits** (after successful implementation):

1. Check git status
2. Stage relevant files only
3. Create descriptive commit message:
   ```
   [type]: [summary]

   [why this change was made]

   Implemented from ImplementationPlan.md

   🤖 Generated with Claude Code

   Co-Authored-By: Claude <noreply@anthropic.com>
   ```
4. Commit locally (user must push)

**Commit types**: feat, fix, refactor, test, docs, perf, style, chore

**Safety**: Never commits .env, credentials, or large binaries

## Multi-Agent Workflow (Advanced)

**Parallel Multi-Agent Mode** (for complex tasks):

**When to use**:
- Task has 3+ independent sub-tasks
- Sub-tasks don't depend on each other
- Economic viability confirmed (15x cost acceptable)

**Performance**:
- 90.2% improvement over single-agent
- Up to 90% time reduction
- Cost: 15x more tokens

**Example**:
```
@chief-architect Build complete authentication system with OAuth, JWT, and session management

→ Spawns 3-5 parallel subagents:
  - @docs-researcher: OAuth 2.0 docs
  - @docs-researcher: JWT best practices
  - @docs-researcher: Session storage patterns
  - @brahma-scout: Existing auth patterns in codebase
  - @durga-security: Security requirements

→ Synthesizes results into unified plan
→ Proceeds with implementation
```

**Economic viability check**: Runs automatically before spawning (pre-agent-spawn hook)

## Context Management Workflow

**Active Context Curation**:

**Every 50 messages**:
```
/context analyze
```

**When switching tasks**:
```
/context optimize
```

**Fresh start for new project**:
```
/context reset
```

**Benefits**:
- 39% performance improvement
- 84% token reduction
- Clearer, more focused context
- Better decision-making

## Error Recovery Workflow

**Self-Correction Protocol** (automatic):

1. **Attempt 1**: Analyze error, categorize, apply first fix
2. **Attempt 2**: Try alternative approach
3. **Attempt 3**: Minimal working version

**Circuit Breaker**: Opens after 3 failed attempts

**Categories**:
- Syntax Error → Direct correction
- Logic Error → Review against ResearchPack
- API Usage Error → Re-check API signatures
- Type Error → Add type annotations
- Configuration Error → Check setup section
- Test Issue → Adjust test expectations

## Knowledge Preservation Workflow

**Automatic Pattern Capture**:

After every successful implementation:
1. Pattern-recognition skill identifies reusable patterns
2. Updates knowledge-core.md automatically
3. Patterns become available for future sessions

**Manual Knowledge Addition**:
```
# Quick add
# (prompts for location)

# Edit knowledge files
/memory

# Bootstrap new project
/init
```

## Performance Benchmarks

**Typical Feature Implementation**:
- **Before Agentic Substrate**: 55-120 minutes
- **With Agentic Substrate**: 10-25 minutes
- **Speedup**: 4.8-5.5x faster

**Quality Metrics**:
- API accuracy: 95%+ (prevents hallucination)
- Test coverage: 80%+ (TDD enforced)
- Code quality: Consistent (style/conventions enforced)

## Best Practices

**Always start with /workflow**: Automated orchestration is faster and safer

**Trust the quality gates**: If research scores < 80, fix it before planning

**Use think protocols**: Add "ultrathink" for critical architecture decisions

**Run /context optimize**: Every 50 messages or when switching tasks

**Review knowledge-core.md**: Periodically to see accumulated patterns

**Git commits locally only**: Review with `git show HEAD` before pushing
