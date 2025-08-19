# 🚀 Claude Code Orchestration System

Transform your Claude Code CLI into an intelligent multi-agent AI orchestration system with a single copy-paste installation.

## What is This?

An open-source enhancement for Claude Code that adds:
- **7 Specialized AI Agents** - Each expert in their domain
- **Intelligent Orchestration** - Automatic agent coordination
- **Workflow Automation** - Smart task decomposition
- **Knowledge Persistence** - Memory across sessions
- **Security First** - Protected sensitive file access

## Installation

### Quick Install (Recommended)

1. Open [ORCHESTRATION_INSTALLER.md](./ORCHESTRATION_INSTALLER.md)
2. Copy everything below the line
3. Paste into Claude Code
4. Let Claude install everything automatically

### Alternative Installers

- [NATIVE_ORCHESTRATION_INSTALLER.md](./NATIVE_ORCHESTRATION_INSTALLER.md) - Lightweight version with minimal setup
- [ULTIMATE_CLAUDE_CODE_ORCHESTRATION.md](./ULTIMATE_CLAUDE_CODE_ORCHESTRATION.md) - Full-featured version with extensive documentation

## Specialized Agents

| Agent | Role | Activation |
|-------|------|------------|
| 🎭 **orchestrator** | Manages complex multi-step workflows | "Build complete [system]" |
| 🔍 **researcher** | Gathers documentation and best practices | "Research [topic]" |
| 📋 **planner** | Creates detailed implementation plans | "Plan [project]" |
| ⚡ **implementer** | Writes production-ready code | "Implement [feature]" |
| 🧪 **tester** | Creates comprehensive test suites | "Write tests for [code]" |
| 🛡️ **reviewer** | Security and performance audits | "Review [code]" |
| 💾 **memory** | Preserves knowledge across sessions | "Document [decision]" |

## How It Works

The system automatically detects your intent and activates appropriate agents:

```
User: "Build a complete authentication system"
         ↓
📋 Planner: Creates development plan
         ↓
🔍 Researcher: Gathers best practices
         ↓
⚡ Implementer: Builds the system
         ↓
🧪 Tester: Creates test suite
         ↓
🛡️ Reviewer: Security audit
         ↓
💾 Memory: Documents decisions
```

## Example Commands

```bash
# Simple tasks - single agent
claude "Research React best practices"
claude "Write tests for user service"
claude "Review code for security issues"

# Complex tasks - automatic orchestration
claude "Build complete e-commerce platform"
claude "Create REST API with authentication and tests"
claude "Refactor codebase for performance"
```

## Features

### 🤖 Intelligent Agent Selection
Automatically chooses the right agents based on your request

### 🔄 Workflow Automation
Coordinates multiple agents for complex tasks

### 📚 Knowledge Persistence
Remembers decisions and patterns across sessions

### 🛡️ Security First
Protected access to sensitive files like .env

### ⚡ Parallel Execution
Runs independent tasks concurrently for speed

## Verification

After installation, verify with:

```bash
~/.claude/verify-orchestration.sh
```

Or check status in Claude Code:

```bash
claude /doctor
claude /status
```

## Project Structure

When you start a new project, the system automatically creates:

```
your-project/
├── .claude/
│   └── agents/          # Project-specific agents
├── docs/
│   ├── references/      # Gathered documentation
│   ├── ADR/            # Architecture decisions
│   └── patterns/       # Reusable patterns
├── tests/              # Test suites
└── CLAUDE.md           # Project memory
```

## Troubleshooting

### Agents not loading?
1. Run `~/.claude/verify-orchestration.sh`
2. Restart Claude Code session
3. Check `claude /doctor` for issues

### Hooks not working?
- Ensure settings.json uses `"type": "command"` not `"type": "script"`
- Check hook scripts are executable: `chmod +x ~/.claude/hooks/*.sh`

## Contributing

We welcome contributions! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT License - See [LICENSE](./LICENSE) file

## Support

- 🐛 [Report Issues](https://github.com/vamfi/claude-code-specialized-agents/issues)
- 💬 [Discussions](https://github.com/vamfi/claude-code-specialized-agents/discussions)
- 📖 [Documentation](https://github.com/vamfi/claude-code-specialized-agents/wiki)

---

*"From chaos, order emerges through intelligent orchestration"*

Made with ❤️ by the VAMFI team