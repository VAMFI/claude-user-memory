# Claude Code Workflow Agents - Project Configuration

This repository contains the official workflow agents for Claude Code CLI, implementing a systematic Research → Plan → Implement methodology.

## 🎯 Agent Philosophy

Our agents follow a strict three-phase workflow designed to ensure:
- **Accuracy**: All code is based on current, official documentation
- **Safety**: Changes are minimal, reversible, and well-planned
- **Quality**: Every implementation is tested and verified

## 🤖 Available Agents

### 1. docs-researcher
- **Purpose**: Fetches current, version-accurate documentation
- **Trigger keywords**: documentation, API, library, version, migrate
- **Output**: ResearchPack with authoritative sources

### 2. implementation-planner  
- **Purpose**: Creates detailed implementation blueprints
- **Trigger keywords**: plan, design, architecture, strategy
- **Requires**: ResearchPack from docs-researcher
- **Output**: Step-by-step Implementation Plan

### 3. code-implementer
- **Purpose**: Executes precise code changes
- **Trigger keywords**: implement, execute, apply the plan
- **Requires**: Both ResearchPack and Implementation Plan
- **Output**: Working code with test results

## 🔄 Workflow Enforcement

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

## 🧠 Memory Integration

This configuration works with your global `~/.claude/CLAUDE.md` settings:
- Respects the `context7` directive for latest documentation
- Follows the "never code from memory" principle
- Maintains minimal, reversible change philosophy

## 📚 Project Context

When working in this repository:
1. All development follows the three-phase workflow
2. Documentation must come from authoritative sources
3. Plans must include rollback strategies
4. Implementations must be minimal and tested

## 🚀 Contributing

When contributing to this project:
1. Enhance agent prompts while maintaining the workflow
2. Add examples that demonstrate the three-phase approach
3. Ensure all changes support the research-first philosophy

---

*Research → Plan → Implement: The foundation of quality software development*