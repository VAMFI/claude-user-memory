---
name: context-engineering
description: Active context curation to fight context rot. Curates what goes into limited context window from constantly evolving information universe. 39% improvement, 84% token reduction.
auto_invoke: true
tags: [context, curation, optimization, memory]
---

# Context Engineering Skill

This skill provides a systematic methodology for active context curation - the art and science of optimizing what goes into the limited context window from the constantly evolving universe of possible information.

## Definition

**Context Engineering**: The art and science of curating what goes into the limited context window from the constantly evolving universe of possible information.

**Evolution**: Natural progression of prompt engineering
- **Old paradigm**: Finding the right words for prompts
- **New paradigm**: "What configuration of context is most likely to generate desired behavior?"

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- Conversation starts (optimize CLAUDE.md and knowledge-core.md relevance)
- During long sessions exceeding 50 messages (context rot likely)
- Before complex operations (ensure high-signal, minimal-token context)
- After tool use (update context with learnings, remove obsolete info)
- Task switching (archive old task context, load new task context)

## Core Principles

1. **Context Rot is Real**: Information degrades as conversation lengthens
   - Stale information accumulates
   - Relevance decreases over time
   - Attention budget gets wasted on low-signal content

2. **Finite Attention Budget**: Models have limited attention; optimize for signal
   - Every token in context competes for attention
   - High-signal tokens improve performance
   - Low-signal tokens degrade outputs

3. **Active Curation**: Editing context is not cheating, it's engineering
   - Context should be dynamically managed
   - Archive what's no longer needed
   - Load what's currently relevant

4. **CLAUDE.md as Structure**: Folder/file structure is context engineering
   - Naming conventions encode information
   - Directory patterns signal architecture
   - Organization reduces cognitive load

## Performance Results (Anthropic Research)

**With Context Engineering**:
- **39% improvement** in agent-based search performance
- **84% reduction** in token consumption (100-round web search)
- **Higher signal-to-noise** ratio in context window
- **Better decision-making** due to clearer, focused context

**Example**:
- Without context editing: 100-round search uses 50,000 tokens
- With context editing: 100-round search uses 8,000 tokens
- **Improvement: 84% fewer tokens, 39% better quality**

## Context Curation Protocol

### Curation Triggers

**Automatic Triggers**:
1. **Conversation exceeds 50 messages** → Review and prune context
2. **Switching tasks** → Archive old task context, load new task context
3. **Before complex operations** → Ensure context is optimized for upcoming task
4. **After major learnings** → Update knowledge-core.md, remove superseded info
5. **Tool use with large outputs** → Consider archiving immediately

**Manual Triggers** (user-initiated):
- `/context analyze` - Analyze current context configuration
- `/context optimize` - Actively prune and reorganize
- `/context reset` - Fresh start for new projects

### Curation Actions

**Step 1: Identify Stale Information**
- Information no longer relevant to current task
- Outdated context from previous tasks
- Redundant or repetitive content
- Generic advice not specific to this project

**Step 2: Archive to knowledge-core.md**
- Preserve learnings for future sessions
- Maintain institutional knowledge
- Enable retrieval when needed again

**Step 3: Remove from Active Context**
- Reduce token count
- Improve signal-to-noise ratio
- Free up attention budget

**Step 4: Verify Context Quality**
- All information is high-signal for current task
- No redundancy or duplication
- Proper organization and structure

## CLAUDE.md Optimization

### What Belongs in CLAUDE.md

✅ **Include**:
- **Project-specific guidelines**: "Use 2-space indentation for JavaScript"
- **Repository etiquette**: "Never commit to main directly; use feature branches"
- **Environment setup**: "Run `npm install && npm run db:migrate` before testing"
- **Architecture patterns**: "We use hexagonal architecture; see /docs/architecture.md"
- **Conventions**: "API routes go in /src/routes/, business logic in /src/services/"

❌ **Avoid**:
- Generic programming advice
- Universal best practices (Claude already knows these)
- Outdated information about the project
- Redundant content already in code comments
- Information that changes frequently (belongs in knowledge-core.md)

### CLAUDE.md Structure Best Practices

```markdown
# Project Name

## Quick Context
[2-3 sentences about what this project does]

## Development Environment
[Specific setup steps for THIS project]

## Architecture Patterns
[High-level patterns used in THIS codebase]

## Conventions
[Project-specific conventions that differ from defaults]

## Common Tasks
[Frequently performed workflows specific to THIS project]

## Import User Preferences
@~/.claude/agentic-substrate-personal.md
```

## Context Engineering Best Practices

### 1. Few-Shot Prompting
- Curate 3-5 diverse canonical examples
- Show expected behavior patterns
- Choose examples that generalize well
- Include examples in CLAUDE.md or knowledge-core.md

**Example**:
```markdown
## API Implementation Pattern

Example 1: GET /users/:id
[Show complete example]

Example 2: POST /orders
[Show complete example]

Example 3: PATCH /products/:id
[Show complete example]
```

### 2. Minimize Tokens
- Find smallest set of high-signal tokens
- Remove redundant information
- Archive historical context to knowledge-core.md
- Use references instead of duplication

**Before**:
```markdown
Our authentication system uses JWT tokens. JWT tokens are JSON Web Tokens
that encode user information. We use JWT tokens for API authentication.
JWT tokens expire after 1 hour. JWT tokens are signed with HS256.
```

**After** (75% token reduction):
```markdown
Authentication: JWT (HS256, 1hr expiry)
```

### 3. Structure as Context
- Use folder/file structure meaningfully
- Naming conventions encode information
- Directory patterns signal architecture

**Example**:
```
/src/
  /api/        → API layer (REST endpoints)
  /services/   → Business logic
  /models/     → Data models
  /utils/      → Shared utilities
  /config/     → Configuration
```

This structure tells Claude the architecture without verbose explanation.

### 4. Dynamic Context Management

**Load**: Bring relevant context for current task
```markdown
# Working on authentication now
@docs/authentication-architecture.md
```

**Edit**: Remove stale/irrelevant information
```bash
# Remove old API patterns that are no longer used
```

**Archive**: Preserve learnings to knowledge-core.md
```markdown
# knowledge-core.md

## Authentication Implementation (2025-10-15)
Implemented JWT auth with refresh tokens.
Pattern: See /src/services/auth-service.js
Learnings: [what we learned]
```

**Reload**: Fetch archived context when needed again
```markdown
# Switching back to authentication work
@knowledge-core.md#authentication-implementation
```

## Tools for Context Engineering

Claude has these tools available for context management:

1. **Read**: Load context from CLAUDE.md, knowledge-core.md
   - Use to understand current project context
   - Check what's already documented

2. **Edit**: Update context files to remove stale info
   - Remove outdated sections
   - Update with new learnings

3. **Write**: Archive learnings to knowledge-core.md
   - Preserve institutional knowledge
   - Document patterns for future sessions

4. **Grep**: Find relevant context across codebase
   - Locate existing patterns
   - Find similar implementations

## Anti-Pattern: Context Hoarding

❌ **Don't**: Keep all information in context "just in case"
- Results in context rot
- Wastes attention budget
- Degrades model performance
- Increases token costs

✅ **Do**: Archive to knowledge-core.md, reload when needed
- Maintains clean, focused context
- Preserves information for future
- Enables retrieval on demand
- Optimizes performance

## Context Editing Mid-Session Example

### Scenario
After completing API integration task, switching to UI work

### Actions

**Step 1: Archive API learnings**
```markdown
# knowledge-core.md

## API Integration Pattern (2025-10-18)
Integrated Stripe API v2023-10-16.
Pattern: See /src/services/payment-service.js
Learnings:
- Use idempotency keys for all payment requests
- Webhook signature verification is mandatory
- Test mode uses sk_test_, live uses sk_live_
```

**Step 2: Remove API-specific context from active memory**
- Edit CLAUDE.md to remove Stripe-specific guidelines
- Clear conversation history of API implementation details
- Archive API ResearchPack to knowledge-core.md

**Step 3: Load UI patterns and conventions**
```markdown
# CLAUDE.md

## UI Development (Active Task)
Framework: React 18
Styling: Tailwind CSS
Component library: shadcn/ui
Pattern: Atomic design (atoms → molecules → organisms)
```

**Step 4: Verify context optimization**
- Context now focused on UI work
- API knowledge preserved in knowledge-core.md
- Can reload API context if needed later

### Result
- **84% token reduction** (removed API context)
- **Clearer focus** on current UI task
- **Better performance** due to optimized context
- **Knowledge preserved** for future API work

## Context Scope Management

### Scope Levels

**1. Conversation Scope** (current session)
- Immediate task context
- Recent tool outputs
- Active file contents
- Current problem being solved

**2. Project Scope** (CLAUDE.md)
- Project conventions
- Architecture patterns
- Environment setup
- Team guidelines

**3. Knowledge Scope** (knowledge-core.md)
- Accumulated learnings
- Historical patterns
- Solved problems
- Lessons learned

**4. User Scope** (~/.claude/agentic-substrate-personal.md)
- Personal preferences
- Coding style
- Common workflows
- Individual shortcuts

### Managing Across Scopes

**Promote** (Conversation → Project):
- New pattern used multiple times → Add to CLAUDE.md

**Archive** (Conversation → Knowledge):
- Solved problem → Document in knowledge-core.md

**Demote** (Project → Knowledge):
- Outdated convention → Move to knowledge-core.md historical section

**Reload** (Knowledge → Conversation):
- Similar problem encountered → Load relevant knowledge

## Integration with Memory Hierarchy

Context engineering integrates with Claude Code's memory system:

**Memory Hierarchy** (4 levels):
1. **Enterprise** (`/Library/Application Support/ClaudeCode/CLAUDE.md`) - Organization-wide
2. **Project** (`./CLAUDE.md`) - Team-shared
3. **User** (`~/.claude/CLAUDE.md`) - Personal preferences
4. **Imports** (`@path/to/file.md`) - Modular organization

**Import Syntax**:
```markdown
# Load user preferences
@~/.claude/agentic-substrate-personal.md

# Load project-specific patterns
@.claude/templates/agents-overview.md
@.claude/templates/skills-overview.md
```

**Benefits**:
- Modular context organization
- User customization without changing project files
- Team conventions shared via project CLAUDE.md
- Enterprise policies enforced at org level

## Common Context Problems & Solutions

### Problem 1: Context Rot
**Symptom**: Model performance degrades over long conversations
**Solution**: Regular pruning at 50-message intervals

### Problem 2: Information Overload
**Symptom**: Too much context, model misses key details
**Solution**: Archive historical content to knowledge-core.md

### Problem 3: Redundant Information
**Symptom**: Same information repeated in multiple places
**Solution**: Use references/imports instead of duplication

### Problem 4: Stale Context
**Symptom**: Outdated patterns or deprecated approaches in context
**Solution**: Regular CLAUDE.md review and updates

### Problem 5: Missing Context
**Symptom**: Model lacks necessary project-specific information
**Solution**: Document critical patterns in CLAUDE.md

## Quality Checklist

Before considering context optimized:

- [ ] All information in CLAUDE.md is project-specific (not generic)
- [ ] No redundant or duplicate content
- [ ] Stale information archived to knowledge-core.md
- [ ] Current task has all necessary context loaded
- [ ] Token count is minimal for desired outcome
- [ ] Examples are canonical and representative
- [ ] Structure clearly signals architecture
- [ ] User preferences imported (not hardcoded)

## Performance Monitoring

Track these metrics to measure context engineering effectiveness:

**Token Efficiency**:
- Tokens per conversation round (should decrease over time)
- Context window utilization (should stay < 70%)
- Redundancy ratio (duplicate info / total info)

**Quality Metrics**:
- Successful task completion rate (should increase)
- Self-correction frequency (should decrease)
- Clarification questions needed (should decrease)

**Knowledge Preservation**:
- knowledge-core.md growth rate (steady accumulation)
- Pattern reuse frequency (documented patterns applied)
- Historical context retrieval success rate

---

**Context engineering is not optional - it's the foundation of sustainable, high-performance agent interactions.**

**Remember**: Every token in context either helps or hurts. Make each one count.
