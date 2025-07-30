# Claude Code Workflow Agents - Project Configuration

This repository contains the official workflow agents for Claude Code CLI, implementing a systematic Research → Plan → Implement methodology.

## 🎯 Agent Philosophy

Our agents follow a strict three-phase workflow designed to ensure:
- **Accuracy**: All code is based on current, official documentation
- **Safety**: Changes are minimal, reversible, and well-planned
- **Quality**: Every implementation is tested and verified

## 🤖 The Agent Team

This project uses a multi-agent system, led by a Chief Architect that orchestrates a team of specialists.

### 1. chief-architect (Orchestrator)
- **Purpose**: Decomposes complex goals and manages the workflow across specialist agents.
- **Trigger keywords**: For broad or multi-faceted goals like "add user authentication" or "refactor the billing system."
- **Output**: A completed project with a full report synthesizing the work of all involved agents.

### Specialist Agents (Managed by Chief Architect)

#### a. docs-researcher
- **Purpose**: Fetches current, version-accurate documentation.
- **Output**: ResearchPack with authoritative sources.

#### b. implementation-planner
- **Purpose**: Creates detailed implementation blueprints from research.
- **Output**: Step-by-step Implementation Plan.

#### c. code-implementer
- **Purpose**: Executes precise code changes based on a plan and now features a **self-correction loop** to attempt to fix its own errors if tests fail.
- **Output**: Working, tested code with test results.



## ✨ Enhanced Capabilities

This agent system has been upgraded with two key mechanisms:

1.  **Project Knowledge Core (`knowledge-core.md`)**: A central file that acts as the project's long-term memory. All agents read this file before acting and suggest updates after making key architectural decisions, ensuring consistency and learning over time.
2.  **Self-Correction Loop**: The `code-implementer` can now automatically run tests and, if they fail, analyze the error and attempt to fix its own code once before reporting failure. This increases autonomy and resilience.

## 🔄 The Orchestration Workflow

The agents follow a coordinated workflow managed by the `chief-architect`:
```
User Goal → chief-architect → Decomposes & Delegates → (docs-researcher → implementation-planner → code-implementer) → Synthesized Result
```
- For complex tasks, the `chief-architect` manages the entire lifecycle.
- For simple, focused tasks, you can still invoke specialist agents directly.

The agents enforce dependencies:
```
docs-researcher → ResearchPack → implementation-planner → Plan → code-implementer → Code
```

- You cannot plan without research
- You cannot implement without a plan
- This prevents coding from potentially outdated memory

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