# Agentic Substrate

**Research-driven development for Claude Code CLI**

> *Philia Sophia* (φιλία σοφία) - The Love of Wisdom
>
> Truth over speed. Research before coding. Knowledge that compounds.

The Agentic Substrate is a foundational enhancement layer for Claude Code CLI that enforces research-first development through specialized agents, quality gates, and persistent memory.

---

## Philosophy

AI coding assistants often hallucinate APIs, guess at best practices, or code from outdated training data. The Agentic Substrate takes a different approach:

**Research → Plan → Implement**

1. **Research**: Fetch authoritative, version-accurate documentation *before* coding
2. **Plan**: Transform research into minimal-change blueprints with rollback strategies
3. **Implement**: Execute with TDD, self-correction, and automatic knowledge capture

Every implementation teaches the system. Every pattern gets preserved. Every decision gets validated.

This isn't just faster development—it's *learning* development.

---

## What You Get

### 9 Specialized Agents (3 Tiers)

**Orchestration**
- `chief-architect` - Multi-agent coordination for complex projects

**Core Workflow**
- `docs-researcher` - Version-accurate documentation fetching
- `implementation-planner` - Minimal-change, reversible planning
- `brahma-analyzer` - Cross-artifact consistency validation
- `code-implementer` - TDD-enforced execution with self-correction
- `brahma-investigator` - Systematic root cause analysis

**Production**
- `brahma-deployer` - Safe deployments with canary rollouts
- `brahma-monitor` - Observability (metrics, logs, traces)
- `brahma-optimizer` - Performance optimization and auto-scaling

### 5 Auto-Invoked Skills

- `research-methodology` - Authoritative source retrieval
- `planning-methodology` - Surgical changes, not rewrites
- `quality-validation` - Objective scoring (80+ for research, 85+ for plans)
- `pattern-recognition` - Automatic knowledge capture
- `context-engineering` - Active context curation

### Quality Gates

- Research validates *before* planning (prevents garbage-in-garbage-out)
- Plans validate *before* implementation (ensures safety and reversibility)
- Tests validate *before* completion (TDD enforced, circuit breaker at 3 failures)

### Persistent Memory (V4.0)

Knowledge graph architecture (entities, relations, observations) for:
- Project-wise memory across sessions
- Pattern reuse across codebases
- Decision history and rationale
- Problem-solution mappings

---

## Quick Start

### Installation

```bash
# One-line installation
curl -sSL https://vamfi.org/install-claude | bash

# Or clone and install manually
git clone https://github.com/VAMFI/claude-user-memory.git
cd claude-user-memory
./install.sh
```

### Basic Usage

```bash
# Complete automation (recommended)
/workflow Add Redis caching to ProductService with 5-minute TTL

# Step-by-step control
/research Redis for Node.js v5.0
/plan Redis caching implementation
/implement

# Direct agent invocation
@chief-architect Build complete authentication system
```

### Configuration (V4.0)

```bash
# Interactive MCP configuration
./customize.sh

# Command-line configuration
./customize.sh --enable-mcp memory
./customize.sh --assign-mcp deepwiki docs-researcher
./customize.sh --list-mcps
```

### Uninstallation

```bash
# Preview what would be removed
./uninstall.sh --dry-run

# Safe removal (preserves user data)
./uninstall.sh
```

---

## Architecture

### Memory Hierarchy

Claude Code loads context in this order (they combine, not override):

1. **User-level** (`~/.claude/CLAUDE.md`) - System-wide capabilities (installed here)
2. **Project-level** (`./CLAUDE.md`) - Project-specific workflows and constitution
3. **Imports** (`@path/to/file.md`) - Modular organization

### Workflow Pattern

```
User Request
    ↓
Research Phase (< 2 min)
- Fetch official documentation
- Validate sources
- Create ResearchPack (score ≥ 80)
    ↓
Planning Phase (< 3 min)
- Transform research to blueprint
- Identify minimal changes
- Include rollback strategy (score ≥ 85)
    ↓
Analysis Phase (< 1 min)
- Cross-artifact consistency
- Conflict detection
- Coverage validation (score ≥ 80)
    ↓
Implementation Phase (< 10 min)
- TDD: RED → GREEN → REFACTOR
- Self-correction (max 3 attempts)
- Git commit with co-author attribution
    ↓
Pattern Capture
- Extract reusable patterns
- Update knowledge graph
- Available for future sessions
```

### Extended Thinking

Trigger with keywords in your request:
- `think` (30-60s) - Routine planning
- `think hard` (1-2min) - Complex tradeoffs
- `think harder` (2-4min) - Novel problems
- `ultrathink` (5-10min) - Critical architecture

Research foundation: 54% improvement on complex tasks (Anthropic, 2024)

---

## V4.0 Features

### Knowledge Graph Memory

Not key-value storage—a semantic graph:

```python
# Create project memory
mcp__memory__create_entities(entities=[{
  "name": "/Users/you/project",
  "entityType": "project",
  "observations": ["Next.js app with PostgreSQL"]
}])

# Create relationships
mcp__memory__create_relations(relations=[{
  "from": "/Users/you/project",
  "to": "feature:authentication",
  "relationType": "contains"
}])

# Semantic queries
mcp__memory__search_nodes(query="authentication patterns jwt")
```

**Entity Types**: Projects, Features, Patterns, Decisions, Problems, Research

**Relations**: contains, implements, solved, led_to, influenced

**Observations**: Timestamped notes, metrics, lessons learned

### MCP Configuration System

User-configurable MCP-to-agent mappings that survive updates:

- Interactive configuration menu (`./customize.sh`)
- Per-agent MCP assignments
- Workflow-based configurations
- Graceful degradation (agents work without MCPs)

Addresses [GitHub Issue #2](https://github.com/VAMFI/claude-user-memory/issues/2)

### Latest Anthropic Research Integration

**Extended Thinking Protocols** (2024)
- 54% improvement on complex tasks
- Automatic triggers for irreversible operations

**Multi-Agent Orchestration** (2024)
- 90.2% performance improvement with parallel execution
- Swarm pattern (lower token overhead than supervisor)

**Model Introspection** (2025)
- Confidence levels in decisions
- Uncertainty markers in outputs
- Self-assessment of performance

### Complete Installer Suite

**install.sh**
- Manifest-driven tracking
- Preserves user customizations
- Automatic backups

**uninstall.sh**
- Safe removal with data preservation
- Detects modified files
- --dry-run preview mode

**customize.sh**
- Interactive configuration menu
- Enable/disable MCP servers
- Assign MCPs to agents
- Reset to defaults option

---

## Documentation

- **[Agents Overview](.claude/templates/agents-overview.md)** - All 9 agents detailed
- **[Skills Overview](.claude/templates/skills-overview.md)** - Auto-invoked capabilities
- **[Workflows Overview](.claude/templates/workflows-overview.md)** - Development patterns
- **[Release Notes](RELEASE-NOTES-V4.md)** - V4.0 features and migration guide
- **[Memory MCP Guide](CLAUDE-MEMORY-ENHANCEMENT.md)** - Knowledge graph architecture

---

## Integration

Works standalone or alongside:

- **LangGraph** - State machine workflows with PostgreSQL checkpointing
- **Deep Agents** - Long-running tasks with file systems
- **DSPy** - Prompt optimization for accuracy improvement
- **CrewAI** - Rapid agent prototyping

See `.claude/integrations/` for templates and patterns.

---

## Contributing

Contributions welcome! Please:

1. Test locally before submitting PRs
2. Update documentation for new features
3. Follow the research-first philosophy
4. Add examples demonstrating workflows

### Testing Your Changes

```bash
# Test complete workflow
/workflow [your test scenario]

# Test individual agents
@docs-researcher [research task]
@implementation-planner [planning task]
@code-implementer [implementation task]

# Test installer suite
./install.sh
./customize.sh --list-mcps
./uninstall.sh --dry-run
```

---

## Community

- **GitHub**: [VAMFI/claude-user-memory](https://github.com/VAMFI/claude-user-memory)
- **Issues**: Bug reports and feature requests
- **Discussions**: Questions and community support

---

## License

MIT License - See [LICENSE](LICENSE) file for details

---

## Acknowledgments

Built on foundational research from:
- **Anthropic** - Extended thinking, multi-agent orchestration, contextual retrieval
- **VAMFI** - Philia Sophia philosophy, quality gates, knowledge preservation
- **Community** - Real-world usage, feedback, and contributions

---

**Version**: 4.0.0
**Codename**: "Knowledge Graph"
**Released**: November 22, 2025

*Research → Plan → Implement → Learn*
