# Agentic Substrate - Advanced Claude Code Enhancement

This repository contains the **Agentic Substrate** - the foundational layer for Claude Code superintelligence.

## System Version
**Agentic Substrate v3.0** (Project Brahma Demo8)

## Core Components

### Agents (4 specialists)
@.claude/templates/agents-overview.md

### Skills (5 auto-invoked capabilities)
@.claude/templates/skills-overview.md

### Workflows (Research → Plan → Implement + Advanced Patterns)
@.claude/templates/workflows-overview.md

## Memory Management

### Quick Commands
- `#` - Add memory quickly (prompts for location)
- `/memory` - Edit memory files in system editor
- `/init` - Bootstrap CLAUDE.md for new projects
- `/context` - Analyze and optimize context configuration

### Memory Hierarchy (4 levels)
1. **Enterprise** (`/Library/Application Support/ClaudeCode/CLAUDE.md`) - Organization-wide
2. **Project** (this file) - Team-shared instructions
3. **User** (`~/.claude/CLAUDE.md`) - Personal preferences (all projects)
4. **Imports** - Modular organization via `@path/to/file.md` (max 5 hops)

### Import Syntax
```markdown
@.claude/templates/agents-overview.md     # Relative path
@~/.claude/my-preferences.md              # User home directory
@/absolute/path/to/file.md                # Absolute path
```

**Not evaluated in code spans/blocks** (avoids collisions)

## 💡 Usage in Claude Code

When you use Claude Code in this project:

```bash
# Automatic workflow
> Add Redis caching to the application
# Claude will sequence: research → plan → implement

# Manual control
> Use docs-researcher to find Redis documentation
> Use implementation-planner to design caching strategy  
> Use code-implementer to add Redis caching

# Skip phases when you have artifacts
> I have the research ready, create a plan
> I have both research and plan, implement it
```

## 🧠 Extended Thinking Modes

Claude Code supports extended thinking for complex problems. Trigger by including keywords in your request:

### Thinking Levels

**"think"** - Standard extended reasoning (30-60 seconds):
```bash
> Think about the best way to structure this API
```
- **Use for**: Routine planning, standard decisions
- **Time**: 30-60 seconds additional computation
- **Best for**: Clear problems with known patterns

**"think hard"** - Deep reasoning (1-2 minutes):
```bash
> Think hard about the architecture for multi-tenant auth
```
- **Use for**: Multiple valid approaches, unclear tradeoffs
- **Time**: 1-2 minutes additional computation
- **Best for**: Complex design decisions

**"think harder"** - Very deep reasoning (2-4 minutes):
```bash
> Think harder about scaling this to 1M users
```
- **Use for**: Novel problems, high-stakes decisions
- **Time**: 2-4 minutes additional computation
- **Best for**: Performance optimization, security-critical design

**"ultrathink"** - Maximum reasoning (5-10 minutes):
```bash
> Ultrathink the entire system architecture before planning
```
- **Use for**: Multi-agent coordination, critical architecture, ResearchPack analysis
- **Time**: 5-10 minutes additional computation
- **Best for**: Highest-stakes decisions, complex multi-domain problems

### Performance Impact

From Anthropic research:
- **54% improvement** on complex tasks
- **1.6% SWE-bench improvement** just from think tool
- **TAU-bench retail**: 62.6% → 69.2%
- **TAU-bench airline**: 36.0% → 46.0%

### When Agents Auto-Trigger Thinking

All agents automatically use extended thinking for:
- Complex tool operations (irreversible effects)
- Long chains of tool outputs
- Sequential decisions where mistakes are costly
- Multiple valid approaches with unclear tradeoffs

### Combine with Workflows

```bash
> /workflow add payment processing - ultrathink the architecture first
```

Agents will apply maximum reasoning before decomposing into research/plan/implement phases.

## 🧠 Integration with Global Settings

This project configuration integrates with your global `~/.claude/CLAUDE.md`:

### Global Settings Respected
- **context7 directive**: Uses context7 for latest documentation when available
- **Never code from memory**: All implementations require research first
- **Minimal changes**: Every change is surgical and reversible
- **Test everything**: All implementations include verification

### How Settings Work Together
1. **Global CLAUDE.md** (`~/.claude/CLAUDE.md`): Defines system-wide preferences
2. **Project CLAUDE.md** (this file): Adds project-specific workflow requirements
3. **Agent files** (`agents/*.md`): Implement the workflow phases

The three-agent workflow in this project enforces stricter requirements than typical Claude Code usage, ensuring enterprise-grade quality.

## 📚 Project Context

When working in this repository:
1. All development follows the three-phase workflow
2. Documentation must come from authoritative sources
3. Plans must include rollback strategies
4. Implementations must be minimal and tested

### Common Workflows

#### Adding a Feature
```bash
> Add user authentication to the API
# Automatically triggers:
# 1. Research auth best practices
# 2. Plan implementation approach
# 3. Implement with tests
```

#### Updating Dependencies
```bash
> Update all dependencies to latest versions
# Triggers:
# 1. Research breaking changes
# 2. Plan phased update
# 3. Implement with verification
```

#### Fixing Bugs
```bash
> Fix the database connection timeout issue
# Triggers:
# 1. Research correct patterns
# 2. Plan minimal fix
# 3. Implement with tests
```

## 🔍 Troubleshooting

### Agents Not Triggering
- Use keywords from trigger list above
- Be explicit: "Use docs-researcher to..."
- Check agents are installed: `/agents`

### Workflow Seems Slow
The workflow trades initial speed for:
- Fewer bugs and rework
- Better documentation
- Safer deployments
- Knowledge preservation

### Integration Issues
If global and project settings conflict:
1. Project settings take precedence
2. Workflow requirements cannot be bypassed
3. Global shortcuts are disabled in this project

## 🚀 Contributing

When contributing to this project:
1. Enhance agent prompts while maintaining the workflow
2. Add examples that demonstrate the three-phase approach
3. Ensure all changes support the research-first philosophy
4. Test the complete workflow before submitting

### Testing Your Changes
```bash
# Test research phase
> Use docs-researcher to research [your topic]

# Test planning phase  
> Use implementation-planner with the research

# Test implementation
> Use code-implementer with the plan

# Verify workflow enforcement
> Try to implement without research (should fail)
```

## 📖 Additional Resources

- [Getting Started Tutorial](examples/getting-started.md)
- [Workflow Guide](docs/workflow-guide.md)
- [Quick Reference](docs/quick-reference.md)
- [Real-World Examples](examples/real-world-scenarios.md)
- [FAQ](docs/faq.md)

---

*Research → Plan → Implement: The foundation of quality software development*
- so we have this repo claude-user-memory is a main repo where we are developing a claude code cli user memory which anyone can copy paste in their installation of claude code cli's home dir so it will work system wide remember that please in