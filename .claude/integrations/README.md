# OSS Framework Integrations for Agentic Substrate

This directory contains integration templates, examples, and guides for enhancing the Agentic Substrate with leading open-source agentic AI frameworks.

## Overview

Based on comprehensive research across 50+ authoritative sources (2024-2025), these integrations provide:

- **LangGraph**: State machine orchestration with best-in-class performance
- **Deep Agents**: Long-running task capabilities with file system management
- **DSPy**: Systematic prompt optimization for 20-40% accuracy improvement
- **CrewAI**: Rapid prototyping with 40+ pre-built tools

## Research Foundation

**Source**: `SELF-ENHANCEMENT-BLUEPRINT.md` (comprehensive meta-research)
**Agents Used**: 4 parallel researchers + 1 gap analyzer
**Thinking Mode**: Ultrathink (5-10 min extended reasoning per domain)
**Sources**: 50+ (official docs, research papers, benchmarks)
**Confidence**: HIGH (corroborated by multiple official sources)

### Key Findings

**Multi-Agent Orchestration** (Anthropic Research 2024):
- 90.2% performance improvement on complex tasks
- Lead orchestrator (Claude Opus 4) + parallel workers (Claude Sonnet 4)
- Swarm pattern > Supervisor pattern (flat token usage vs. growing overhead)

**State Management** (LangGraph Production Patterns):
- Explicit state definition (TypedDict/Pydantic)
- PostgreSQL checkpointing for fault tolerance
- Human-in-the-loop interrupts
- Best latency and token efficiency in benchmarks

**Long-Running Tasks** (Deep Agents Architecture):
- Task decomposition with `write_todos`
- Subagent spawning for context isolation
- File system prevents context overflow
- Built for 10-60 minute implementations

**Prompt Optimization** (DSPy Stanford NLP):
- Systematic optimization vs. trial-and-error
- Model portability (swap Claude ↔ GPT-4 ↔ Gemini)
- 20-40% accuracy improvement empirically

## Framework Comparison

| Framework | Best For | Integration Difficulty | Production Ready | Fit Score |
|-----------|----------|----------------------|------------------|-----------|
| **LangGraph** | Multi-agent orchestration, state management | Medium-High | ✅ Yes | **95/100** |
| **Deep Agents** | Long-running coding tasks, file systems | Medium | ✅ Yes | **92/100** |
| **DSPy** | Prompt optimization, individual agents | High | ✅ Yes | **88/100** |
| **CrewAI** | Role-based teams, rapid prototyping | Low | ✅ Yes | **85/100** |

See `FRAMEWORK-COMPARISON.md` for detailed analysis.

## Directory Structure

```
.claude/integrations/
├── README.md (this file)
├── langgraph/
│   ├── README.md (setup guide)
│   ├── brahma_state.py.template (state definition)
│   ├── brahma_graph.py.template (graph workflows)
│   ├── quality_gates.py.template (conditional routing)
│   └── examples/ (working examples)
├── deepagents/
│   ├── README.md (setup guide)
│   ├── code_implementer.py.template (enhanced implementer)
│   └── subagents/ (test_runner, linter, security)
├── dspy/
│   ├── README.md (setup guide)
│   ├── optimizers/ (compiled modules)
│   └── training/ (training datasets)
└── crewai/
    ├── README.md (setup guide)
    ├── prototype_crew.py.template (crew template)
    └── crews/ (example crews)
```

## Quick Start

### Prerequisites

```bash
# Python 3.9+ required
python --version

# Create virtual environment (recommended)
python -m venv ~/.claude/venv
source ~/.claude/venv/bin/activate  # On Windows: venv\Scripts\activate

# PostgreSQL (for LangGraph checkpointing)
brew install postgresql  # macOS
# or apt-get install postgresql  # Linux
```

### Installation

```bash
# Install all frameworks
pip install langgraph langgraph-checkpoint-postgres langchain-anthropic
pip install deepagents
pip install dspy-ai
pip install crewai crewai-tools

# Verify installations
python -c "import langgraph; print('LangGraph:', langgraph.__version__)"
python -c "import deepagents; print('Deep Agents:', deepagents.__version__)"
python -c "import dspy; print('DSPy:', dspy.__version__)"
python -c "import crewai; print('CrewAI:', crewai.__version__)"
```

### Configuration

```bash
# PostgreSQL for LangGraph (production)
createdb brahma_checkpoints

# Set environment variables
export POSTGRES_CHECKPOINT_URI="postgresql://user:pass@localhost/brahma_checkpoints"
export CREWAI_STORAGE_DIR="$HOME/.claude/.crewai_memory"

# Verify configuration
psql brahma_checkpoints -c "SELECT version();"
```

## Integration Guides

Each framework subdirectory contains:
- **README.md**: Detailed setup, usage, and examples
- **Templates**: Copy-paste ready code with comments
- **Examples**: Working demonstrations of key patterns

### 1. LangGraph (Recommended for Phase 1)

**When to use**: Complex multi-step workflows, state persistence needed, production deployment

**Setup time**: 2-4 hours
**Complexity**: Medium-High
**ROI**: Very High (best performance, fault tolerance)

See `langgraph/README.md` for complete guide.

### 2. Deep Agents (Recommended for Phase 2)

**When to use**: Long-running coding tasks (10-60 min), large codebases, need subagents

**Setup time**: 1-2 hours
**Complexity**: Medium
**ROI**: High (perfect fit for code-implementer enhancement)

See `deepagents/README.md` for complete guide.

### 3. DSPy (Recommended for Phase 3)

**When to use**: Optimizing individual agent prompts, need model portability

**Setup time**: 3-5 hours (including training data collection)
**Complexity**: High (paradigm shift)
**ROI**: Medium-High (20-40% accuracy improvement)

See `dspy/README.md` for complete guide.

### 4. CrewAI (Recommended for ongoing use)

**When to use**: Rapid prototyping, tool-heavy workflows, domain-specific teams

**Setup time**: 30 min - 1 hour
**Complexity**: Low
**ROI**: Medium (3-5x faster prototyping)

See `crewai/README.md` for complete guide.

## Phased Implementation Plan

### Phase 1: LangGraph Foundation (Weeks 1-3)
- Implement BUILD workflow as StateGraph
- Add PostgreSQL checkpointing
- Quality gates as conditional edges
- Test with real features

**Expected outcome**: State persistence, fault tolerance, visual debugging

### Phase 2: Deep Agents Enhancement (Weeks 4-5)
- Enhance code-implementer with Deep Agents
- Add subagents (test_runner, linter, security)
- Enable file system for large codebases

**Expected outcome**: Better handling of complex 10-60 min implementations

### Phase 3: DSPy Optimization (Weeks 6-8)
- Optimize top 5 agents (docs-researcher, brahma-clarifier, implementation-planner, brahma-analyzer, brahma-investigator)
- Collect training data
- Compile and measure improvement

**Expected outcome**: 20-40% accuracy improvement, model portability

### Phase 4: CrewAI Prototyping (Weeks 9-10)
- Build 3 example crews (documentation, security, performance)
- Use for rapid iteration on new capabilities

**Expected outcome**: 3-5x faster development of new agents

See `V4-IMPLEMENTATION-PLAN.md` for complete roadmap.

## Testing

Each integration includes test procedures:

```bash
# Test LangGraph
python .claude/integrations/langgraph/examples/test_brahma_graph.py

# Test Deep Agents
python .claude/integrations/deepagents/examples/test_code_implementer.py

# Test DSPy
python .claude/integrations/dspy/examples/test_optimizers.py

# Test CrewAI
python .claude/integrations/crewai/examples/test_documentation_crew.py
```

## Troubleshooting

### Common Issues

**Import Error: No module named 'langgraph'**
- Ensure virtual environment activated: `source ~/.claude/venv/bin/activate`
- Reinstall: `pip install langgraph`

**PostgreSQL Connection Failed**
- Check database exists: `psql -l | grep brahma_checkpoints`
- Verify connection string: `echo $POSTGRES_CHECKPOINT_URI`
- Create database: `createdb brahma_checkpoints`

**Deep Agents File Not Found**
- Check installation: `pip list | grep deepagents`
- Reinstall: `pip install deepagents --upgrade`

**DSPy Compilation Error**
- Verify training data format (JSON list of examples)
- Check metric function returns float 0-1
- Increase max_bootstrapped_demos if too few examples

**CrewAI Memory Error**
- Check storage directory exists: `ls $CREWAI_STORAGE_DIR`
- Create if missing: `mkdir -p $CREWAI_STORAGE_DIR`
- Clear old memory: `rm -rf $CREWAI_STORAGE_DIR/*` (careful!)

## Resources

**Official Documentation**:
- [LangGraph Docs](https://docs.langchain.com/oss/python/langgraph)
- [Deep Agents GitHub](https://github.com/langchain-ai/deepagents)
- [DSPy Docs](https://dspy.ai/)
- [CrewAI Docs](https://docs.crewai.com/)

**Research Papers**:
- [Anthropic Multi-Agent Research](https://www.anthropic.com/engineering/multi-agent-research-system)
- [Extended Thinking Protocol](https://www.anthropic.com/engineering/claude-think-tool)
- [DSPy: Compiling Declarative Language Model Calls](https://arxiv.org/abs/2310.03714)

**Benchmarks**:
- [LangGraph vs Others](https://blog.langchain.com/benchmarking-multi-agent-architectures/)
- [Agentic AI Design Patterns](https://machinelearningmastery.com/7-must-know-agentic-ai-design-patterns/)

## Support

**Issues**: Open an issue in the `claude-user-memory` repository
**Questions**: See `docs/faq.md` or `TROUBLESHOOTING.md`
**Contributions**: See `CONTRIBUTING.md`

## Version History

- **v4.0** (2025-11-06): Initial integration architecture
  - LangGraph templates and examples
  - Deep Agents code-implementer enhancement
  - DSPy optimization framework
  - CrewAI rapid prototyping templates
  - Comprehensive documentation and guides

---

**Next Steps**:
1. Review framework comparison: `FRAMEWORK-COMPARISON.md`
2. Read integration guide: `OSS-INTEGRATION-GUIDE.md`
3. Choose starting framework (recommend LangGraph)
4. Follow framework-specific README
5. Test with simple examples
6. Integrate into Agentic Substrate

**Happy integrating!**
