# 🛠️ Claude Code Workflow Agents

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Compatible](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://docs.anthropic.com/claude-code)
[![Workflow: Research→Plan→Implement](https://img.shields.io/badge/Workflow-Research→Plan→Implement-green.svg)](docs/workflow-guide.md)

> Professional AI-powered development workflow for [Claude Code CLI](https://docs.anthropic.com/claude-code) that ensures every line of code is research-backed, well-planned, and precisely implemented.

## 📖 What is This?

Claude Code Workflow Agents transform how you develop software by enforcing a systematic three-phase approach:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   1. RESEARCH   │ --> │    2. PLAN      │ --> │  3. IMPLEMENT   │
│ docs-researcher │     │ implementation- │     │     code-       │
│                 │     │    planner      │     │  implementer    │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        ↓                        ↓                        ↓
  ResearchPack            Implementation            Working Code
  (Authoritative           Plan (Detailed         (Precise, Tested
   Documentation)           Blueprint)               Changes)
```

Instead of jumping straight into coding, this workflow ensures you:
1. **Research first** - Gather official, version-accurate documentation
2. **Plan thoroughly** - Create detailed implementation blueprints
3. **Implement precisely** - Execute minimal, reversible changes

## 🌟 Why This Workflow?

### The Problem with Traditional Development
- ❌ Coding from potentially outdated memory
- ❌ Making large, risky changes without planning
- ❌ Discovering breaking changes mid-implementation
- ❌ Difficult rollbacks when things go wrong

### The Workflow Solution
- ✅ **Always current**: Every implementation based on latest official docs
- ✅ **Risk mitigation**: Plans include rollback strategies before coding
- ✅ **Minimal changes**: Surgical edits reduce bug surface area
- ✅ **Full traceability**: Clear path from requirement to implementation

## ⚡ Quick Start

### Prerequisites
- Node.js v16 or higher
- npm or yarn package manager
- Claude Code CLI (see installation below)

### 1. Install Claude Code CLI
```bash
# Install Claude Code globally
npm install -g @anthropic/claude-code

# Verify installation
claude-code --version

# First-time setup (creates ~/.claude directory)
claude-code
```

### 2. Install Workflow Agents

#### Option A: Automated Setup (Recommended)
```bash
# Clone this repository
git clone https://github.com/irenicj/claude-code-workflow-agents.git
cd claude-code-workflow-agents

# Run the setup script
./setup.sh

# This will:
# ✓ Install all 3 workflow agents
# ✓ Create custom commands (/research, /plan, /implement, /workflow)
# ✓ Set up configuration templates
# ✓ Create directory structure
```

#### Option B: Manual Installation
```bash
# Install agents
cp agents/* ~/.claude/agents/

# Install commands (optional)
cp commands/* ~/.claude/commands/

# Verify installation
claude
> /agents
```

### 3. Your First Workflow
```bash
# Start Claude Code
claude-code

# Try a simple example
> I need to add Redis caching to my Node.js application

# Claude will automatically:
# 1. Research Redis documentation (docs-researcher)
# 2. Create an implementation plan (implementation-planner)
# 3. Execute the changes (code-implementer)
```

## 🎯 The Three Workflow Agents

### 1. 📚 docs-researcher
**Role**: Your documentation specialist who ensures you never code from outdated information.

**Triggers**:
- "documentation", "docs", "API reference"
- "library", "framework", "version"
- "how to use", "correct usage"

**Example**:
```bash
> Research the latest Next.js 14 App Router documentation
```

**Output**: ResearchPack containing:
- ✓ Official API documentation
- ✓ Version-specific details
- ✓ Migration guides
- ✓ Code examples with sources

### 2. 📋 implementation-planner
**Role**: Your architect who transforms research into actionable blueprints.

**Triggers**:
- "plan", "design", "architecture"
- "what files", "implementation strategy"

**Example**:
```bash
> Create a plan for migrating from Express to Fastify based on the research
```

**Output**: Implementation Plan containing:
- ✓ File-by-file changes
- ✓ Step-by-step procedures
- ✓ Test criteria
- ✓ Rollback strategies

### 3. 🚀 code-implementer
**Role**: Your precision developer who executes plans with surgical accuracy.

**Triggers**:
- "implement the plan"
- "execute changes"
- "apply the plan"

**Example**:
```bash
> Implement the Fastify migration plan
```

**Output**: 
- ✓ Implemented code
- ✓ Test results
- ✓ Execution report

## 📚 Detailed Guides

- **[Getting Started Tutorial](examples/getting-started.md)** - Step-by-step beginner guide
- **[Workflow Guide](docs/workflow-guide.md)** - Deep dive into each phase
- **[Configuration Guide](docs/claude-configuration-guide.md)** - Complete setup reference
- **[Troubleshooting Guide](docs/troubleshooting-agents.md)** - Fix common issues
- **[Quick Reference](docs/quick-reference.md)** - Commands and shortcuts
- **[Real-World Scenarios](examples/real-world-scenarios.md)** - Practical examples
- **[FAQ](docs/faq.md)** - Common questions answered

## 🔄 Common Workflows

### Adding a New Feature
```bash
# Automatic workflow
> Add Stripe payment processing to my SaaS application

# Manual control
> Use docs-researcher to find Stripe Node.js SDK documentation
> Use implementation-planner to design the payment flow
> Use code-implementer to add Stripe integration
```

### Updating Dependencies
```bash
> Update React from v17 to v18 in our application

# Claude automatically:
# 1. Researches React 18 migration guide
# 2. Plans phased migration approach
# 3. Implements changes with tests
```

### Debugging Library Issues
```bash
> The MongoDB connection keeps timing out in production

# Claude will:
# 1. Research MongoDB connection best practices
# 2. Analyze and provide solutions
```

## 🚀 Advanced Features

### Using Task Tool
For complex, multi-step operations:
```bash
# Research multiple technologies
> Use Task tool with docs-researcher to research both PostgreSQL and Redis

# Complex implementations
> Use Task tool with code-implementer to refactor the entire auth system
```

### Workflow Shortcuts
```bash
# Skip to planning (when you have research)
> I have the AWS SDK docs. Plan S3 integration.

# Skip to implementation (when you have both)
> I have the ResearchPack and Plan. Execute it.
```

## 🏗️ Real-World Examples

### E-commerce Payment Integration
```
1. Research: "Add Stripe checkout to our store"
   → Fetches latest Stripe API docs, security requirements
   
2. Plan: Creates integration blueprint
   → Payment flow, webhook handling, error states
   
3. Implement: Executes with tests
   → Secure payment processing with full test coverage
```

### Microservices Migration
```
1. Research: "Migrate monolith to microservices"
   → Best practices, service mesh options, patterns
   
2. Plan: Phased migration strategy
   → Service boundaries, data separation, rollback points
   
3. Implement: Incremental execution
   → One service at a time with verification
```

[See more examples →](examples/real-world-scenarios.md)

## 🚀 Recent Improvements (v2.0)

### Enhanced Agent Performance
- **Reduced token usage** - All agents now use < 2k tokens (60% reduction)
- **Progress reporting** - Real-time status updates every 30 seconds
- **Anti-stagnation** - Automatic timeout handling and recovery
- **Better logging** - Structured output with clear progress indicators

### New Features
- 🔍 Progress indicators (🔍, 📦, 🌐, ✅) for visibility
- ⏱️ Performance targets for each agent phase
- 🐛 Comprehensive debugging guide
- 💡 Verbose mode support for troubleshooting

## 🤝 Contributing

We welcome contributions that enhance the workflow! See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Agent enhancement guidelines
- Workflow improvement ideas
- Documentation contributions
- Testing and validation

## 📊 Project Status

- ✅ **Stable**: Core workflow agents are production-ready
- ✅ **Active**: Regular updates and improvements
- ✅ **Community**: Growing ecosystem of workflow patterns

## 🔗 Resources

### Documentation
- [Official Claude Code Docs](https://docs.anthropic.com/claude-code)
- [Workflow Best Practices](docs/workflow-guide.md)
- [Troubleshooting Guide](docs/troubleshooting-agents.md) **NEW!**
- [FAQ](docs/faq.md)

### Community
- [GitHub Issues](https://github.com/irenicj/claude-code-workflow-agents/issues) - Bug reports
- [Discussions](https://github.com/irenicj/claude-code-workflow-agents/discussions) - Q&A
- [Claude Code Community](https://docs.anthropic.com/claude-code/community) - Official community

## 📝 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

Built on the principles of:
- **Documentation-first development** - Never code from memory
- **Systematic planning** - Think before you type
- **Minimal changes** - Less code, fewer bugs
- **Quality over speed** - Do it right the first time

---

<p align="center">
  <strong>Research → Plan → Implement</strong><br>
  <em>The foundation of professional software development with Claude Code</em><br><br>
  <a href="examples/getting-started.md">Get Started</a> •
  <a href="docs/workflow-guide.md">Learn More</a> •
  <a href="https://github.com/irenicj/claude-code-workflow-agents/issues">Get Help</a>
</p>