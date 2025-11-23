# Agentic Substrate v4.1

**Research-first development system for Claude Code CLI**

> No API hallucinations. No coding from stale training data. Research → Plan → Implement.

---

## Quick Start

```bash
# Install
git clone https://github.com/VAMFI/claude-user-memory.git
cd claude-user-memory
./install.sh

# Use
/workflow Add Redis caching to ProductService
```

---

## What You Get

- **9 Agents** - Orchestration, research, planning, implementation, debugging, deployment
- **5 Skills** - Auto-invoked capabilities for research, planning, validation, patterns, context
- **5 Commands** - `/workflow`, `/research`, `/plan`, `/implement`, `/context`
- **Quality Gates** - Research ≥80, Plans ≥85, Tests passing, 3-retry circuit breaker
- **Memory** - Knowledge graph persists across sessions

---

## Usage

**Full automation:**
```bash
/workflow Add authentication with JWT tokens
```

**Step-by-step:**
```bash
/research Redis for Node.js v5.0
/plan Redis caching implementation
/implement
```

**Direct agents:**
```bash
@chief-architect Build payment system
@docs-researcher Research Stripe API
@brahma-deployer Deploy v2.5.0
```

---

## How It Works

1. **Research** (< 2 min) - Fetch version-accurate docs before coding
2. **Plan** (< 3 min) - Create minimal-change blueprint with rollback
3. **Implement** (< 10 min) - Execute with TDD + self-correction
4. **Learn** - Auto-capture patterns to knowledge graph

Quality gates block bad inputs. Circuit breaker stops infinite loops.

---

## Installation

**Installs to:** `~/.claude/`

**Preserves:**
- All data in `~/.claude/data/`
- Your `CLAUDE.md` customizations (smart-merged)
- Modified files (detected by checksum)
- Knowledge files and patterns

**Upgrade:**
```bash
./install.sh
```
Your data and customizations are automatically preserved.

---

## Configuration

```bash
./customize.sh                              # Interactive menu
./customize.sh --enable-mcp memory         # Enable MCP servers
./customize.sh --list-mcps                 # View configuration
```

---

## Uninstall

```bash
./uninstall.sh --dry-run    # Preview what will be removed
./uninstall.sh              # Remove (preserves data)
```

---

## Documentation

- [Agents Overview](.claude/templates/agents-overview.md) - All 9 agents
- [Skills Overview](.claude/templates/skills-overview.md) - Auto-invoked capabilities
- [Workflows Overview](.claude/templates/workflows-overview.md) - Development patterns
- [Installation Behavior](INSTALLATION-BEHAVIOR.md) - Data preservation details
- [Release Notes](RELEASE-NOTES-V4.md) - v4.0/4.1 features

---

## Research Foundation

Built on Anthropic research (2024-2025):
- Extended Thinking: 54% improvement on complex tasks
- Multi-Agent Orchestration: 90.2% performance improvement
- Contextual Retrieval: 49-67% better accuracy

---

## License

MIT License - See [LICENSE](LICENSE)

---

**Version:** 4.1.0
**Released:** November 22, 2025
**Status:** Production-Ready

*Research → Plan → Implement → Learn*
