# ⭐ Claude Code Specialized Agents

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Compatible](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://docs.anthropic.com/claude-code)
[![Philosophy: Orchestrate→Specialize→Learn](https://img.shields.io/badge/Philosophy-Orchestrate→Specialize→Learn-purple.svg)](docs/01_philosophy.md)

> An advanced, multi-agent framework for the [Claude Code CLI](https://docs.anthropic.com/claude-code) that uses an orchestrator to manage a team of specialist agents, enabling them to tackle complex software development tasks with persistent memory and self-correction capabilities.

## 📖 Core Philosophy

This framework evolves beyond a simple linear workflow into a sophisticated, hierarchical system built on three core principles:

1.  **Orchestration**: A high-level `chief-architect` agent analyzes complex goals, creates a strategic plan, and delegates tasks to a team of specialists.
2.  **Specialization**: Each specialist agent (e.g., for research, coding, security) is an expert in its domain, ensuring high-quality work on each sub-task.
3.  **Knowledge**: A shared `knowledge-core.md` file acts as a persistent memory, allowing the system to learn from past decisions and maintain consistency.

## ✨ The New Workflow: Orchestration in Action

```mermaid
graph TD
    A[User Goal] --> B{Chief Architect};
    B -- 1. Decomposes & Plans --> B;
    B -- 2. Reads/Writes --> C[📚 Knowledge Core];
    C -- 2. Informs --> B;
    B -- 3. Delegates Tasks --> D[Specialist Team];
    D -- 4. Reads --> C;
    D -- 5. Executes Tasks --> E[Code, Tests, Research];
    E -- 6. Reports Results --> D;
    D -- 7. Synthesizes & Reports --> B;
    B -- 8. Delivers Final Output --> F[Completed Work];

    subgraph D [Specialist Team]
        direction LR
        D1[Docs Researcher]
        D2[Impl. Planner]
        D3[Code Implementer]
    end

    style B fill:#8E44AD,stroke:#fff,stroke-width:2px,color:#fff
    style C fill:#F1C40F,stroke:#fff,stroke-width:2px,color:#333
    style D fill:#3498DB,stroke:#fff,stroke-width:2px,color:#fff
    style F fill:#2ECC71,stroke:#fff,stroke-width:2px,color:#fff
```

## 🚀 Enhanced Capabilities

-   **Handles Complexity**: The orchestration model allows the system to tackle large, multi-faceted projects that would overwhelm a single agent.
-   **Persistent Memory**: The `knowledge-core.md` ensures that architectural decisions and patterns are remembered and adhered to across all tasks.
-   **Self-Correction**: The `code-implementer` can now automatically run tests and attempt to fix its own errors, increasing autonomy.

## ⚡ Quick Start

### Prerequisites
-   Node.js v16 or higher
-   Claude Code CLI

### 1. Installation
```bash
# Clone this repository
git clone https://github.com/irenicj/claude-code-specialized-agents.git
cd claude-code-specialized-agents

# Run the setup script (copies agents to ~/.claude)
./setup.sh
```

### 2. Your First Orchestrated Workflow
```bash
# Start Claude Code in your project directory
claude-code

# Give the system a complex task
> Refactor our authentication system to use JWT instead of sessions.

# The chief-architect will now take the lead, create a plan,
# and delegate to its specialist team.
```

## 🤖 The Agent Team

### The Orchestrator
-   **`chief-architect`**: The project leader. It analyzes high-level goals, creates plans, and coordinates the specialist team. All complex tasks start here.

### The Specialist Team (`agents/specialists`)
-   **`docs-researcher`**: Fetches current, authoritative documentation from the web.
-   **`implementation-planner`**: Creates detailed, step-by-step implementation plans.
-   **`code-implementer`**: Executes the plan with precision and attempts to self-correct if tests fail.
-   *... and 10+ other specialists for security, DevOps, QA, and more.*

## 📚 Detailed Documentation

-   **[Core Philosophy](docs/01_philosophy.md)**: Understand the 'why' behind this framework.
-   **[Orchestration Workflow](docs/02_orchestration_workflow.md)**: See how the `chief-architect` works.
-   **[The Knowledge Core](docs/03_knowledge_core.md)**: Learn how persistent memory is used.
-   **[Complex Task Example](examples/complex_task_orchestration.md)**: A full, end-to-end example.
-   **[Direct Specialist Usage](examples/direct_specialist_usage.md)**: How to bypass orchestration for simple tasks.

## 🔍 Tags for Discovery

This project provides a powerful **AI agent framework** for the **Claude Code CLI**, implementing a **hierarchical agent system** for advanced **software development automation**. Key features include a sophisticated **agentic workflow** with a chief **orchestrator** managing **autonomous agents**. This **multi-agent system** leverages **persistent memory AI** and **self-correcting code** mechanisms to deliver robust and intelligent development capabilities.

## 🔄 Contributing

Contributions are welcome! Please focus on enhancing specialist agents or improving the orchestration logic. See `CONTRIBUTING.md` for more details.

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