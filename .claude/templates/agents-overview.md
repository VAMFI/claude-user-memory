# Agents Overview

The Agentic Substrate provides 4 specialized agents that work together:

## 1. chief-architect
**Purpose**: Master orchestrator for complex, multi-faceted projects

**Use when**: Project requires 3+ distinct capabilities or spans multiple domains

**Example**: "Build complete user authentication system with email verification and password reset"

**What it does**:
- Analyzes requirements and decomposes into specialized tasks
- Selects optimal team of specialist agents
- Manages dependencies and handoffs
- Synthesizes results into cohesive deliverables

**Think Protocol**: Uses "ultrathink" for critical architecture decomposition

## 2. docs-researcher
**Purpose**: High-speed documentation specialist

**Use when**: Implementing features with external libraries or APIs

**Example**: "Research Redis caching best practices for Node.js"

**What it does**:
- Fetches version-accurate docs from official sources
- Prevents coding from potentially stale memory
- Delivers ResearchPack in < 2 minutes
- Uses contextual retrieval for 49-67% better accuracy

**Think Protocol**: Uses "ultrathink" for complex API landscape analysis

## 3. implementation-planner
**Purpose**: Strategic architect for minimal-change, reversible plans

**Use when**: ResearchPack ready and implementation needs planning

**Example**: "Create implementation plan for Redis caching integration"

**What it does**:
- Transforms ResearchPacks into executable blueprints
- Identifies minimal changes required
- Creates step-by-step plans with rollback procedures
- Ensures surgical edits only

**Think Protocol**: Uses "ultrathink" for critical architecture decisions

## 4. code-implementer
**Purpose**: Precision execution specialist

**Use when**: Both ResearchPack AND Implementation Plan are ready

**Example**: "Implement the caching plan"

**What it does**:
- Executes plans with surgical precision
- Enforces TDD (test-first mandatory)
- Self-corrects with 3 intelligent retries
- Creates git commits with co-author attribution

**Think Protocol**: Uses "ultrathink" for critical self-correction decisions

## Workflow

**Complete Automation**:
```
/workflow Add Redis caching to ProductService
```

**Step-by-Step**:
```
/research Redis for Node.js v5.0
/plan Redis caching for ProductService
/implement
```

**Direct Agent Invocation**:
```
@chief-architect Build complete payment processing system
@docs-researcher Research Stripe API v2023-10-16
@implementation-planner Plan integration of Stripe webhooks
@code-implementer Execute payment integration plan
```

## Performance

- **Research**: < 2 min (49-67% better with contextual retrieval)
- **Planning**: < 3 min (think tool for complex decisions)
- **Implementation**: < 5 min (TDD enforced, self-correction enabled)
- **Total**: ~10 minutes for production-ready features

## Think Protocol Keywords

All agents support extended thinking modes:
- **"think"**: Standard (30-60s) - Routine decisions
- **"think hard"**: Deep (1-2min) - Multi-option choices
- **"think harder"**: Very deep (2-4min) - Novel problems
- **"ultrathink"**: Maximum (5-10min) - Critical architecture

54% improvement on complex tasks (Anthropic research)
