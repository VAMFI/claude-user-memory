---
name: context
description: Analyze and optimize context configuration. Reviews CLAUDE.md, knowledge-core.md, and active context for optimization opportunities. Helps prevent context rot (39% improvement, 84% token reduction).
---

# /context - Context Analysis & Optimization

Analyze and optimize your Claude Code context configuration using Anthropic's context engineering principles.

## Usage

```bash
/context                # Analyze mode (default)
/context analyze        # Same as default
/context optimize       # Actively optimize context
/context reset          # Reset to templates
```

## What This Does

### Analyze Mode (Default)

When you run `/context` or `/context analyze`:

1. **Read context files**
   - CLAUDE.md (project configuration)
   - knowledge-core.md (accumulated learnings)
   - Imported files (via `@` syntax)

2. **Analyze token count and relevance**
   - Count total tokens in context
   - Identify stale/redundant information
   - Check for context rot indicators

3. **Identify optimization opportunities**
   - Sections that should be archived
   - Redundant content that can be consolidated
   - Missing imports that could improve modularity

4. **Report findings**
   - Current token usage
   - Stale information detected
   - Potential token savings
   - Recommended actions

### Optimize Mode

When you run `/context optimize`:

1. **Run analysis** (as above)

2. **Archive stale information**
   - Move outdated patterns to knowledge-core.md historical section
   - Add timestamps to archived content
   - Preserve information for future retrieval

3. **Prune redundant context**
   - Remove duplicate information
   - Consolidate similar sections
   - Replace verbose explanations with concise bullet points

4. **Update CLAUDE.md**
   - Keep only high-signal, project-specific content
   - Use imports for modular organization
   - Ensure clear structure with markdown headings

5. **Report token savings**
   - Before/after token counts
   - Percentage reduction
   - Expected performance improvement

### Reset Mode

When you run `/context reset`:

1. **Confirmation prompt**
   - Warns that this will discard current context
   - Asks for explicit confirmation

2. **Restore templates** (if confirmed)
   - CLAUDE.md → `.claude/templates/CLAUDE.md.template`
   - knowledge-core.md → Fresh template
   - Clear project-specific customizations

3. **Fresh start**
   - Ideal for switching to new project
   - Removes accumulated context rot
   - Begins with clean slate

## Output Examples

### Analyze Mode Output

```markdown
📊 Context Analysis

## Current Configuration

**Memory Hierarchy**:
- Enterprise: Not configured
- Project: ./CLAUDE.md (450 tokens)
- User: ~/.claude/CLAUDE.md (120 tokens)
- Imports: 3 files (280 tokens)

**Total Context**: 850 tokens

**Files Analyzed**:
- ✓ CLAUDE.md (450 tokens)
- ✓ knowledge-core.md (320 tokens)
- ✓ @.claude/templates/agents-overview.md (100 tokens)
- ✓ @.claude/templates/skills-overview.md (90 tokens)
- ✓ @.claude/templates/workflows-overview.md (90 tokens)

## Optimization Opportunities

### 1. Stale Information in CLAUDE.md (120 tokens)

**Section: "Python Development"**
- Last used: 30 days ago
- Recommendation: Archive to knowledge-core.md (project now uses TypeScript)

**Section: "Deployment to Heroku"**
- Last used: 45 days ago
- Recommendation: Archive to knowledge-core.md (now using Vercel)

**Section: "Generic Testing Tips"**
- Recommendation: Remove (not project-specific, Claude already knows this)

### 2. Redundant Content (80 tokens)

**Duplicated Information**:
- Git workflow mentioned in 3 places (CLAUDE.md, workflows-overview.md, agents-overview.md)
- Recommendation: Keep in workflows-overview.md only, import elsewhere

### 3. Missing Modularity

**Large CLAUDE.md File**:
- Could be split into modular imports
- Recommendation: Create `project-architecture.md`, import with `@.claude/project-architecture.md`

## Potential Savings

**If all recommendations applied**:
- Stale information removal: 120 tokens (14% reduction)
- Redundancy elimination: 80 tokens (9% reduction)
- Modularity improvements: 50 tokens (6% reduction)

**Total Potential Savings**: 250 tokens (29% reduction)

**Expected Impact**:
- Performance improvement: ~39% (Anthropic research on context engineering)
- Token reduction in long sessions: ~84%
- Clearer, more focused context
- Better agent decision-making

## Recommendations

**Immediate Actions**:
1. Run `/context optimize` to automatically apply changes
2. Review knowledge-core.md after optimization to ensure important information preserved

**Periodic Maintenance**:
- Run `/context analyze` every 50 messages or major task switch
- Archive completed work to knowledge-core.md
- Keep CLAUDE.md project-specific (remove generic advice)

**Best Practices**:
- Be specific: "Use 2-space indentation for JS" not "Format code properly"
- Use structure: Organize with clear markdown headings
- Review periodically: Update as project evolves
```

### Optimize Mode Output

```markdown
✅ Context Optimized

## Changes Applied

### 1. Archived Stale Information

**To knowledge-core.md**:
- "Python Development" section → `## Historical: Python Setup (archived 2025-10-18)`
- "Deployment to Heroku" section → `## Historical: Heroku Deployment (archived 2025-10-18)`

### 2. Removed Redundant Content

**From CLAUDE.md**:
- Removed generic testing tips (not project-specific)
- Removed duplicate git workflow (kept import from workflows-overview.md)

### 3. Improved Modularity

**Created**:
- `.claude/project-architecture.md` (150 tokens)
  - Moved architecture details from CLAUDE.md
  - Imported in CLAUDE.md with `@.claude/project-architecture.md`

**Updated CLAUDE.md**:
- Replaced verbose architecture section with import
- Clearer structure with focused sections

## Results

**Before Optimization**:
- Total tokens: 850
- Stale information: 120 tokens (14%)
- Redundant content: 80 tokens (9%)

**After Optimization**:
- Total tokens: 600
- Stale information: 0 tokens (0%)
- Redundant content: 0 tokens (0%)

**Savings**: 250 tokens (29% reduction)

## Performance Impact

**Expected Improvements** (based on Anthropic research):
- Context-focused tasks: 39% improvement
- Long conversations (100+ messages): 84% token reduction
- Agent decision accuracy: Higher signal-to-noise ratio
- Faster response times: Less context to process

## Next Steps

1. ✅ Context optimized successfully
2. Review `knowledge-core.md` to verify archived content
3. Test context with new tasks to verify improvements
4. Run `/context analyze` again in 50 messages or at next major task switch

**Maintenance Reminder**: Set up periodic context optimization (every 50 messages or weekly)
```

### Reset Mode Output

```markdown
⚠️  Context Reset Confirmation

This will:
- ❌ Discard current CLAUDE.md customizations
- ❌ Reset knowledge-core.md to fresh template
- ❌ Remove project-specific context
- ✅ Restore template files for fresh start

**Current context will be backed up to**:
- `.claude/backups/CLAUDE.md.backup-2025-10-18`
- `.claude/backups/knowledge-core.md.backup-2025-10-18`

**Are you sure?** (yes/no): _

[If user confirms with "yes"]

✅ Context Reset Complete

**Changes Made**:
- Backed up current CLAUDE.md → `.claude/backups/CLAUDE.md.backup-2025-10-18`
- Backed up current knowledge-core.md → `.claude/backups/knowledge-core.md.backup-2025-10-18`
- Restored CLAUDE.md from template
- Restored knowledge-core.md from template

**Fresh Start**:
- CLAUDE.md: 150 tokens (template)
- knowledge-core.md: 50 tokens (template)
- Total: 200 tokens

**Next Steps**:
1. Customize CLAUDE.md for current project
2. Use `#` quick command to add project-specific context
3. Import personal preferences with `@~/.claude/agentic-substrate-personal.md`
```

## When to Use

### Run `/context analyze` when:
- ✅ Conversation feels sluggish (context rot suspected)
- ✅ Starting new project in same repo
- ✅ After major refactoring (old patterns obsolete)
- ✅ Monthly maintenance (context hygiene)
- ✅ Every 50 messages in long conversations

### Run `/context optimize` when:
- ✅ Analysis shows 15%+ potential savings
- ✅ Switching major tasks (e.g., API work → UI work)
- ✅ Context rot indicators detected
- ✅ Performance feels degraded

### Run `/context reset` when:
- ✅ Starting completely new project
- ✅ Context is severely corrupted or misaligned
- ✅ Want fresh start after major project pivot

## Integration with Context Engineering

This command implements Anthropic's context engineering principles:

**Context Engineering Definition**:
> "The art and science of curating what goes into the limited context window from
> the constantly evolving universe of possible information."

**Key Principles**:
1. **Context Rot is Real**: Information degrades over time
2. **Finite Attention Budget**: Optimize for signal-to-noise ratio
3. **Active Curation**: Editing context improves performance
4. **Structure as Context**: Organization encodes information

**Performance Results** (Anthropic Research):
- 39% improvement in agent-based search
- 84% token reduction in 100-round web search
- Higher quality decisions due to focused context

## Advanced Usage

### Combine with Memory Commands

```bash
# Add new context quickly
#

# Edit context files directly
/memory

# Analyze context
/context analyze

# Optimize based on analysis
/context optimize
```

### Periodic Maintenance Schedule

**Recommended Schedule**:
- **Every 50 messages**: Run `/context analyze`
- **Task switches**: Run `/context optimize`
- **Weekly**: Review knowledge-core.md growth
- **Monthly**: Full context audit and cleanup

### Context Hierarchy Management

The `/context` command respects the memory hierarchy:

1. **Enterprise** (`/Library/Application Support/ClaudeCode/CLAUDE.md`)
   - Not modified by `/context` (managed by organization)

2. **Project** (`./CLAUDE.md`)
   - Analyzed and optimized by `/context`
   - Reset by `/context reset`

3. **User** (`~/.claude/CLAUDE.md`)
   - Analyzed but not modified (personal preferences)

4. **Imports** (`@path/to/file.md`)
   - Analyzed for size/relevance
   - Not directly modified (source files managed separately)

## Best Practices

1. **Regular Analysis**: Don't wait for problems - proactive context hygiene
2. **Archive, Don't Delete**: Move to knowledge-core.md for future retrieval
3. **Project-Specific Only**: Remove generic advice Claude already knows
4. **Use Imports**: Modular organization beats monolithic CLAUDE.md
5. **Clear Structure**: Headings and sections improve navigability

## Performance Monitoring

Track these metrics over time:
- **Tokens per session**: Should decrease after optimization
- **Context utilization**: Aim for < 70% of max window
- **Stale content ratio**: Should stay < 10%
- **Optimization frequency**: Optimal is every 50-100 messages

---

**Context engineering is not optional - it's the foundation of sustainable, high-performance agent interactions.**
