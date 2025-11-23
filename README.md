# Agentic Substrate v4.1

**Research-driven development for Claude Code CLI**

> *Philia Sophia* (φιλία σοφία) - Truth over speed. Research before coding.

Multi-agent system enforcing research-first development through specialized agents, quality gates, and persistent memory. No API hallucinations. No coding from stale training data.

---

## ⚡ Quick Start

```bash
# Install
curl -sSL https://vamfi.org/install-claude | bash

# Use
/workflow Add Redis caching to ProductService
```

---

## 🎯 Philosophy

**Research → Plan → Implement**

1. **Research**: Fetch version-accurate docs *before* coding (< 2 min)
2. **Plan**: Create minimal-change blueprint with rollback (< 3 min)
3. **Implement**: Execute with TDD + self-correction (< 10 min)

Quality gates block bad inputs. Circuit breaker stops infinite loops. Knowledge compounds across sessions.

---

## 📦 What You Get

### 9 Specialized Agents

**Orchestration**
- `chief-architect` - Multi-agent coordination

**Core Workflow**
- `docs-researcher` - Version-accurate documentation
- `implementation-planner` - Minimal-change planning
- `brahma-analyzer` - Consistency validation
- `code-implementer` - TDD execution + self-correction
- `brahma-investigator` - Root cause analysis

**Production**
- `brahma-deployer` - Canary rollouts
- `brahma-monitor` - Metrics, logs, traces
- `brahma-optimizer` - Performance optimization

### 5 Auto-Invoked Skills

- `research-methodology` - Authoritative source retrieval
- `planning-methodology` - Surgical changes only
- `quality-validation` - Objective scoring (80+ research, 85+ plans)
- `pattern-recognition` - Automatic knowledge capture
- `context-engineering` - Active context curation

### Quality Gates

- **Research → Planning**: ResearchPack score ≥ 80
- **Planning → Implementation**: Plan score ≥ 85
- **Implementation → Completion**: All tests passing
- **Circuit Breaker**: Stops after 3 failed attempts

### Knowledge Graph Memory (V4.0)

Semantic graph (not key-value) for:
- Project memory across sessions
- Pattern reuse
- Decision history
- Problem-solution mappings

---

## 🚀 v4.1 Highlights

- ✅ **DeepWiki MCP**: Auto-installed, enforced across all agents
- ✅ **Zero API Hallucinations**: Repository-grounded code generation
- ✅ **20-30% Token Optimization**: Cleaner agent prompts
- ✅ **Data Preservation**: `~/.claude/data/` never touched during upgrades
- ✅ **Smart CLAUDE.md Merge**: Appends your customizations to template
- ✅ **MCP Config Protection**: install-if-missing behavior

---

## 📚 Usage

### Complete Automation

```bash
/workflow Add authentication with JWT tokens
```

### Step-by-Step Control

```bash
/research Redis for Node.js v5.0
/plan Redis caching implementation
/implement
```

### Direct Agent Invocation

```bash
@chief-architect Build payment processing system
@docs-researcher Research Stripe API
@brahma-deployer Deploy v2.5.0 to production
```

### Extended Thinking

Add keywords to your request:
- `think` (30-60s) - Routine planning
- `think hard` (1-2min) - Complex tradeoffs
- `think harder` (2-4min) - Novel problems
- `ultrathink` (5-10min) - Critical architecture

Research: 54% improvement on complex tasks (Anthropic, 2024)

---

## ⚙️ Configuration

```bash
# Interactive menu
./customize.sh

# Command-line
./customize.sh --enable-mcp memory
./customize.sh --assign-mcp deepwiki docs-researcher
./customize.sh --list-mcps
```

MCP configurations survive updates. Agents work without MCPs (graceful degradation).

---

## 🛠️ Installation Details

### What Gets Installed

- **Location**: `~/.claude/`
- **Agents**: 9 specialists
- **Skills**: 5 auto-invoked capabilities
- **Commands**: 5 slash commands
- **Hooks**: 7 automation hooks
- **Templates**: 6 documentation files
- **Data**: MCP config template

### What Gets Preserved

- ✅ `~/.claude/data/` - All user data and cache
- ✅ `~/.claude/CLAUDE.md` - Smart-merged with backups
- ✅ `~/.claude/data/mcp-config.json` - User's MCP configuration
- ✅ Modified files (detected via checksum)
- ✅ Knowledge files
- ✅ Pattern index

### Upgrade Behavior

```bash
# Backup created automatically
# Managed files updated
# User data preserved
# CLAUDE.md smart-merged (appends your content to template)
# MCP config preserved
# Rollback script generated
```

See [INSTALLATION-BEHAVIOR.md](INSTALLATION-BEHAVIOR.md) for details.

---

## 🗑️ Uninstallation

```bash
# Preview
./uninstall.sh --dry-run

# Remove (preserves data + modified files)
./uninstall.sh

# Keep everything (only remove manifest)
./uninstall.sh --preserve-all
```

---

## 📖 Documentation

- **[Agents Overview](.claude/templates/agents-overview.md)** - All 9 agents
- **[Skills Overview](.claude/templates/skills-overview.md)** - Auto-invoked capabilities
- **[Workflows Overview](.claude/templates/workflows-overview.md)** - Development patterns
- **[Installation Behavior](INSTALLATION-BEHAVIOR.md)** - Data preservation + smart-merge
- **[Release Notes](RELEASE-NOTES-V4.md)** - V4.0/4.1 features
- **[Memory MCP Guide](CLAUDE-MEMORY-ENHANCEMENT.md)** - Knowledge graph architecture

---

## 🔬 Research Foundation

Built on Anthropic research:
- **Extended Thinking** (2024) - 54% improvement on complex tasks
- **Multi-Agent Orchestration** (2024) - 90.2% performance improvement
- **Contextual Retrieval** (2024) - 49-67% better accuracy
- **Model Introspection** (2025) - Confidence levels + uncertainty markers

---

## 🤝 Contributing

1. Test locally before PRs
2. Update documentation
3. Follow research-first philosophy
4. Add workflow examples

```bash
# Test workflow system
/workflow [test scenario]

# Test installer suite
./install.sh --dry-run
./customize.sh --list-mcps
./uninstall.sh --dry-run
```

---

## 📝 License

MIT License - See [LICENSE](LICENSE)

---

## 🙏 Acknowledgments

- **Anthropic** - Extended thinking, multi-agent orchestration, contextual retrieval
- **VAMFI** - Philia Sophia philosophy, quality gates, knowledge preservation
- **Community** - Real-world usage, feedback, contributions

---

**Version**: 4.1.0
**Released**: November 22, 2025
**Status**: Production-Ready

*Research → Plan → Implement → Learn*
