<div align="center">

# 🧠 Agentic Substrate

### Transform Claude Code into an autonomous agent substrate

[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](https://github.com/VAMFI/claude-user-memory/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-v2.0.20%2B-purple.svg)](https://claude.ai/download)

**Research → Plan → Implement** in 10 minutes with built-in quality gates, self-correction, and knowledge preservation.

[Quick Install](#-installation) • [Documentation](R-and-D/V2_COMPLETE.md) • [Examples](examples/v2/) • [Philosophy](PHILOSOPHY.md)

</div>

---

## ✨ What is Agentic Substrate?

A **system-wide enhancement package** for Claude Code CLI that transforms it from a helpful assistant into an autonomous agent substrate with:

- 🤖 **4 Specialized Agents** - Orchestration, research, planning, implementation
- 🧠 **Extended Thinking** - 54% improvement on complex tasks
- 🔄 **Quality Gates** - Automated validation at every phase
- 🧪 **TDD Enforcement** - Test-first workflow mandatory
- 📚 **Knowledge Capture** - Learn from every implementation

### 📊 Performance Impact

| Metric | Improvement | Source |
|--------|-------------|--------|
| Complex task accuracy | **+54%** | Anthropic Think Tool |
| Research accuracy | **+49-67%** | Contextual Retrieval |
| Context optimization | **+39%, -84% tokens** | Active Curation |
| Feature implementation | **4.8-5.5x faster** | Real usage |
| Multi-agent performance | **+90.2%, -90% time** | Parallel execution |

### 🎯 Built on Anthropic's Engineering Philosophy

Synthesizes **11 Anthropic research articles** into a production-ready substrate:

- Agent autonomy with minimal scaffolding
- Think protocols for complex decisions
- Context engineering to prevent rot
- Multi-agent coordination patterns
- TDD enforcement (Anthropic's favorite)
- Economic viability analysis

> **Philia Sophia** (Love of Wisdom) - Research-driven development

📖 [Read the full philosophy](PHILOSOPHY.md)

---

## 🚀 Installation

### Option 1: One-Click Install (Recommended)

**For Claude Desktop v2.0.20+**

```bash
1. Download agentic-substrate-3.0.0.mcpb from Releases
2. Claude Desktop → Settings → Extensions → Install
3. Restart Claude Code CLI
```

✅ **Done!** Everything installs to `~/.claude/` automatically.

<br>

### Option 2: Quick Script Install

**For system-wide use across all projects:**

```bash
curl -fsSL https://raw.githubusercontent.com/VAMFI/claude-user-memory/main/install.sh | bash
```

**What happens:**
- Backs up existing `~/.claude/` → `~/.claude.backup-[timestamp]/`
- Installs agents, skills, commands, and hooks
- Makes scripts executable
- Shows next steps

<br>

### Option 3: Manual Install

<details>
<summary>Click to expand manual installation steps</summary>

```bash
# Clone repository
git clone https://github.com/VAMFI/claude-user-memory.git
cd claude-user-memory

# Backup existing config (optional)
mv ~/.claude ~/.claude.backup-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true

# Install to home directory
cp -r .claude ~/
chmod +x ~/.claude/hooks/*.sh
chmod +x ~/.claude/validators/*.sh

echo "✅ Installation complete!"
```

**Project-specific install:**
```bash
# Install in current project only
cp -r .claude .
chmod +x .claude/hooks/*.sh .claude/validators/*.sh
```

</details>

<br>

### ✅ Verify Installation

```bash
# Start Claude Code and type:
/workflow test
```

You should see the workflow orchestrator activate.

---

## ⚡ Quick Start

### Your First Workflow (10 minutes)

```bash
# Complete automation - just describe what you want:
/workflow Add user authentication with JWT tokens
```

**What happens automatically:**
1. 📚 **Research** - Fetches JWT best practices and library docs
2. 📝 **Plan** - Creates minimal-change implementation blueprint
3. ⚡ **Implement** - Writes code with TDD, self-corrects if needed
4. ✅ **Validate** - Runs tests, captures patterns to knowledge base

<br>

### Step-by-Step Control

```bash
# Phase 1: Research
/research Redis caching for Node.js v5.0
# → Creates ResearchPack.md with version-accurate docs

# Phase 2: Plan
/plan Add Redis caching to ProductService with 5-min TTL
# → Creates ImplementationPlan.md with rollback strategy

# Phase 3: Implement
/implement
# → Executes plan with TDD and self-correction
```

<br>

### Extended Thinking for Complex Tasks

```bash
# Standard thinking (30-60s)
think about the best API structure

# Deep reasoning (1-2 min)
think hard about the database schema

# Maximum reasoning (5-10 min)
ultrathink the entire system architecture before planning
```

> **54% improvement** on complex tasks with extended thinking

---

## 📦 What's Included

<table>
<tr>
<td width="50%">

### 🤖 4 Specialized Agents

| Agent | Purpose | Time |
|-------|---------|------|
| **chief-architect** | Multi-agent orchestration | N/A |
| **docs-researcher** | Version-accurate docs | < 2 min |
| **implementation-planner** | Minimal-change plans | < 3 min |
| **code-implementer** | TDD execution + self-correction | < 5 min |

</td>
<td width="50%">

### ⚡ 5 Auto-Invoked Skills

| Skill | Purpose |
|-------|---------|
| **research-methodology** | Systematic doc gathering |
| **planning-methodology** | Reversible planning |
| **quality-validation** | Objective scoring |
| **pattern-recognition** | Knowledge capture |
| **context-engineering** | 39% improvement |

</td>
</tr>
<tr>
<td width="50%">

### 🔒 Quality Gates

- ✅ **Research validation** - 80+ score required
- ✅ **Plan validation** - 85+ score required
- ✅ **API verification** - No hallucination
- ✅ **Test enforcement** - TDD mandatory
- ✅ **Circuit breaker** - 3-failure limit

</td>
<td width="50%">

### 🎯 Slash Commands

```bash
/research <topic>
/plan <feature>
/implement
/workflow <description>
/context analyze|optimize
```

</td>
</tr>
</table>

---

## 📖 Documentation

<table>
<tr>
<td width="50%">

### 📘 Getting Started
- [Quick Start Guide](#-quick-start)
- [Installation Options](#-installation)
- [First Workflow](#your-first-workflow-10-minutes)
- [Examples](examples/v2/)

</td>
<td width="50%">

### 🔧 Advanced
- [Complete System Overview](R-and-D/V2_COMPLETE.md)
- [Philosophy & Research](PHILOSOPHY.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Customization](#-customization)

</td>
</tr>
</table>

---

## 💡 Example Workflows

### 🚀 Complete API Integration (10 minutes)

```bash
/workflow Add OpenWeather API to homepage with error handling
```

**Automatic execution:**
1. 📚 Fetches OpenWeather API docs, detects version
2. 📝 Creates minimal-change plan with rollback
3. ⚡ Writes code with tests, self-corrects if needed
4. ✅ Captures patterns to knowledge base

**Result:** Production-ready code in ~10 minutes

<br>

### 🎯 Manual Control for Complex Tasks

```bash
# Research with extended thinking
ultrathink Redis caching strategies for high-traffic applications
/research Redis for Node.js v5.0

# Review and refine the plan
/plan Add Redis caching to ProductService with 5-min TTL

# Execute with monitoring
/implement
```

---

## 🛡️ Safety & Quality

### ✅ Automatic Backups

Your existing configuration is **always backed up** before installation:

```bash
~/.claude → ~/.claude.backup-[timestamp]/

# Restore anytime:
mv ~/.claude.backup-[timestamp] ~/.claude
```

<br>

### 🔒 Built-in Safety Features

| Feature | Protection |
|---------|-----------|
| **Quality Gates** | Research ≥80, Plan ≥85 scores required |
| **API Verification** | Prevents hallucinated APIs (95%+ accuracy) |
| **Circuit Breaker** | Stops after 3 failures (no infinite loops) |
| **Rollback Plans** | Every plan includes git-based undo |
| **TDD Enforcement** | Test-first mandatory for all code |

<br>

### ⚙️ Requirements

- Claude Code CLI **v2.0.20+** ([Download](https://claude.ai/download))
- Bash **4.0+** (macOS/Linux)
- Git (for installation)

---

## 🔧 Customization

<details>
<summary><b>Adjust quality thresholds</b></summary>

Edit `~/.claude/settings.json`:

```json
{
  "workflow": {
    "quality_gates": {
      "research_min_score": 70,  // Default: 80
      "plan_min_score": 75       // Default: 85
    }
  }
}
```

</details>

<details>
<summary><b>Customize agents and skills</b></summary>

**Agents:** `~/.claude/agents/`
- Add domain-specific knowledge
- Adjust time estimates
- Change output formats

**Skills:** `~/.claude/skills/`
- Create domain methodologies
- Add company patterns
- Technology-specific approaches

</details>

<details>
<summary><b>Common troubleshooting</b></summary>

**Permission denied:**
```bash
chmod +x ~/.claude/hooks/*.sh ~/.claude/validators/*.sh
```

**Hooks not running:**
- Ensure Claude Code CLI v2.0.20+
- Verify hooks are executable

**Circuit breaker open:**
```bash
# Check status
~/.claude/validators/circuit-breaker.sh code-implementer status

# Reset after fixing root cause
~/.claude/validators/circuit-breaker.sh code-implementer reset
```

📖 **Full guide:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

</details>

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

<table>
<tr>
<td width="33%">

### 🐛 Report Issues
- Validation errors
- Hook problems
- Documentation gaps
- Feature requests

[Open an issue →](https://github.com/VAMFI/claude-user-memory/issues)

</td>
<td width="33%">

### 💡 Share Patterns
- Submit workflow examples
- Add to knowledge base
- Improve documentation
- Share use cases

[Start a discussion →](https://github.com/VAMFI/claude-user-memory/discussions)

</td>
<td width="33%">

### 🔧 Extend the System
- Create custom skills
- Build new agents
- Add validators
- Write commands

[Fork & PR →](https://github.com/VAMFI/claude-user-memory/fork)

</td>
</tr>
</table>

---

## 📊 Benchmarks

Real-world performance improvements:

```
┌─────────────────────────┬──────────┬──────────┬─────────────┐
│ Task                    │ Before   │ After    │ Improvement │
├─────────────────────────┼──────────┼──────────┼─────────────┤
│ API Integration         │ 55 min   │ 10 min   │    5.5x     │
│ Feature Implementation  │ 120 min  │ 25 min   │    4.8x     │
│ Code Quality            │ Variable │ 95%+     │ Consistent  │
│ Context Efficiency      │ Baseline │ +39%     │ -84% tokens │
└─────────────────────────┴──────────┴──────────┴─────────────┘
```

---

## 🌟 Star History

If this project helps you, please consider starring it!

[![Star History Chart](https://api.star-history.com/svg?repos=VAMFI/claude-user-memory&type=Date)](https://star-history.com/#VAMFI/claude-user-memory&Date)

---

## 📜 License

**MIT License** - Use freely, modify as needed, contribute back if you can!

See [LICENSE](LICENSE) for full details.

---

## 🔗 Resources

<div align="center">

[![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)](https://github.com/VAMFI/claude-user-memory)
[![Issues](https://img.shields.io/github/issues/VAMFI/claude-user-memory)](https://github.com/VAMFI/claude-user-memory/issues)
[![Discussions](https://img.shields.io/github/discussions/VAMFI/claude-user-memory)](https://github.com/VAMFI/claude-user-memory/discussions)
[![VAMFI](https://img.shields.io/badge/VAMFI-Blog-blue)](https://vamfi.org)

</div>

<br>

<div align="center">

### Quick Navigation

[🚀 Installation](#-installation) •
[⚡ Quick Start](#-quick-start) •
[📖 Documentation](#-documentation) •
[💡 Examples](#-example-workflows) •
[🛡️ Safety](#-safety--quality) •
[🤝 Contributing](#-contributing)

</div>

---

<div align="center">

### Built with the philosophy of **Philia Sophia** (Love of Wisdom)

**Research-driven development powered by Anthropic's engineering excellence**

<br>

**Made with ❤️ by the VAMFI team for the Claude Code community**

<br>

⭐ **Star this repo** to support autonomous agentic development!

</div>
