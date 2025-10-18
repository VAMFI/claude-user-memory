# ResearchPack: Anthropic Engineering Philosophy

## Quick Reference
- **Source**: Anthropic Engineering Blog (11 articles)
- **Date Range**: September 2024 - October 2025
- **Confidence**: HIGH (all official Anthropic sources)
- **Purpose**: Enhance claude-user-memory as system-wide Claude Code CLI enhancement

---

## THEMATIC ANALYSIS

### THEME 1: AGENT ARCHITECTURE & DESIGN

#### 1.1 Agent vs Workflow Distinction
**Source**: Building Effective Agents (Anthropic)
- **Workflows**: Systems where LLMs and tools are orchestrated through **predefined code paths**
- **Agents**: Systems where LLMs **dynamically direct their own processes** and tool usage, maintaining control over how they accomplish tasks
- **Decision criteria**: Use agents for open-ended problems where you can't predict required steps or hardcode a fixed path

#### 1.2 Agent Control Philosophy
**Source**: SWE-bench Engineering (Anthropic)
- **Minimal scaffolding**: Give as much control as possible to the language model itself
- **Simple tools**: Bash Tool for executing commands, Edit Tool for viewing/editing files
- **Agent autonomy**: Let the model decide the approach, don't force specific workflows

#### 1.3 Claude Agent SDK Architecture
**Source**: Building agents with the Claude Agent SDK (Sep 29, 2025)
- **Renamed from Claude Code SDK** to reflect broader capabilities beyond coding
- **Core infrastructure solved**:
  - Memory management across long-running tasks
  - Permission systems balancing autonomy with user control
  - Subagent coordination toward shared goals
- **Context as structure**: Folder and file structure becomes a form of context engineering
- **Tool access**: bash, file editing, file creation, file search → general-purpose agents with computer access

#### 1.4 Design Principles
**Source**: Multiple articles
- **Truth over speed** - but achieve both through systematic approach
- **Low-level and unopinionated** - Close to raw model access (Claude Code)
- **Flexible, customizable, scriptable, safe** - Power tool approach
- **Agent-centric perspective**: Rethink every detail from non-deterministic viewpoint

---

### THEME 2: ORCHESTRATION & COORDINATION

#### 2.1 Multi-Agent Research System
**Source**: How we built our multi-agent research system (Jun 13, 2025)

**Architecture**:
- **Lead agent**: Analyzes query, develops strategy, spawns subagents
- **Subagents**: Explore different aspects simultaneously (3-5 parallel)
- **Intelligent filtering**: Iteratively search, gather, return results to lead agent
- **Parallel execution**: Two levels - agent spawning AND tool calling within agents

**Performance**:
- Multi-agent (Opus 4 lead + Sonnet 4 subagents) outperformed single Opus 4 by **90.2%**
- Research time reduced by **up to 90%** for complex queries
- Cost consideration: Agents use **4x more tokens** than chat; multi-agent systems use **15x more tokens**

**Early failures & solutions**:
- Problem: Spawning 50 subagents for simple queries → Solution: Better prompt engineering for agent spawning logic
- Problem: Scouring web endlessly for nonexistent sources → Solution: Termination conditions in prompts
- Problem: Agents distracting each other → Solution: Controlled communication patterns

**Economic viability**: "Multi-agent systems require tasks where the value is high enough to pay for increased performance"

#### 2.2 Coordination Patterns
**Source**: Claude Agent SDK
- **Subagent coordination**: Multiple agents working toward shared goal
- **Memory sharing**: Long-running task context management
- **Permission delegation**: Balance between autonomy and user control

---

### THEME 3: TOOL USE & MCP INTEGRATION

#### 3.1 Writing Effective Tools for Agents
**Source**: Writing effective tools for agents — with agents (Sep 11, 2025)

**Core principle**: Shift from "engineers writing APIs for other engineers" to **agent-centric design** (non-deterministic)

**Best practices**:
1. **Prompt-engineer tool descriptions**: Most effective improvement method
   - Tool descriptions loaded into agent context
   - Collectively steer agents toward effective behaviors
   - Example: Claude appending "2025" to searches → Fixed by improving tool description

2. **Use agents to build tools**:
   - Let agents analyze evaluation transcripts
   - Paste transcripts into Claude Code
   - Claude refactors lots of tools at once

3. **Rethink from agent perspective**: Every detail needs reconsidering for non-deterministic use

#### 3.2 Desktop Extensions (.mcpb format)
**Source**: Desktop Extensions - One-click MCP server installation (Jun 26, 2025)

**Problem solved**: Complex MCP server installation

**Solution**: Desktop Extensions (.mcpb files)
- **Format**: Zip archives with manifest.json (similar to Chrome .crx, VS Code .vsix)
- **Contents**: Entire MCP server + all dependencies
- **Installation**: Single click in Claude Desktop (Settings > Extensions)
- **Distribution**: Extension directory with Anthropic-reviewed tools + custom extensions
- **Open source**: Specification, toolchain, schemas at github.com/anthropics/mcpb

**Installation methods**:
1. Browse extension directory → Click Install
2. Install custom .mcpb file directly

#### 3.3 Tool Design Philosophy
**Source**: Multiple articles
- **Describe for new hires**: Write tool docs as if onboarding a team member
- **Make implicit explicit**: Don't assume context agents might bring
- **Agent analysis**: Tools should be analyzable and improvable by agents themselves

---

### THEME 4: CONTEXT ENGINEERING

#### 4.1 Context Engineering Definition
**Source**: Effective context engineering for AI agents (Sep 29, 2025)

**Definition**: The art and science of curating what goes into the limited context window from the constantly evolving universe of possible information

**Evolution**: Natural progression of prompt engineering
- **Old**: Finding the right words for prompts
- **New**: "What configuration of context is most likely to generate desired behavior?"

**Scope includes**:
- System instructions
- Tools
- Model Context Protocol (MCP)
- External data
- Message history

#### 4.2 Context Rot Problem
**Source**: Effective context engineering
- **Problem**: Degradation of model outputs as information overloads limited attention windows
- **Solution**: Active context curation and editing

#### 4.3 Performance Results
**Source**: Effective context engineering
- **Memory Tool + Context Editing**: 39% improvement in agent-based search performance
- **Token consumption**: 84% reduction in 100-round web search
- **LLM constraint**: Finite attention budget requires smallest possible set of high-signal tokens

#### 4.4 Context Engineering Best Practices
**Source**: Building Effective Agents
- **Few-shot prompting**: Strongly recommended, curate diverse canonical examples
- **Show expected behavior**: Examples portray the agent's desired behavior patterns
- **Minimize tokens**: Find smallest high-signal token set for desired outcome

#### 4.5 CLAUDE.md Pattern
**Source**: Claude Code best practices (Apr 18, 2025)
- **Purpose**: Special file automatically pulled into context at conversation start
- **Use cases**: Repository etiquette, developer environment setup, project-specific guidelines
- **Benefit**: Persistent context across all Claude Code sessions in that repository

---

### THEME 5: QUALITY & VALIDATION

#### 5.1 Development Approach
**Source**: Building Effective Agents
- **Extensive testing in sandboxed environments**
- **Appropriate guardrails** for autonomous agents
- **Trust level**: Must have some level of trust in agent decision-making

#### 5.2 Postmortem Culture - Engineering Excellence
**Source**: A postmortem of three recent issues (Sep 17, 2025)

**Transparency principle**: "We never reduce model quality due to demand, time of day, or server load"

**Three infrastructure bugs (Aug-Sep 2025)**:

1. **Context Window Routing Error** (Aug 31)
   - **Impact**: 16% of Sonnet 4 requests at worst hour
   - **Cause**: Short/long-context requests routed to wrong server pools
   - **"Sticky" routing**: Once wrong server selected, subsequent requests also wrong
   - **Fix**: Deployed Sep 4

2. **TPU Server Output Corruption** (Aug 25-Sep 2)
   - **Impact**: Opus 4.1, Opus 4, Sonnet 4
   - **Symptom**: Thai/Chinese characters in English prompts
   - **Cause**: Misconfiguration in token generation
   - **Fix**: Rollback Sep 2

3. **XLA Compiler Bug** (Sep 4-12)
   - **Impact**: Haiku 3.5, parts of Sonnet 4 and Opus 3
   - **Symptom**: Excluding most probable token during generation
   - **Cause**: ML compiler bug unintentionally triggered
   - **Fix**: Rollback Sep 4 (Haiku), Sep 12 (Opus)

**Lessons**: Infrastructure quality directly impacts model outputs; transparent postmortems build trust

#### 5.3 SWE-bench Quality Bar
**Source**: Raising the bar on SWE-bench Verified (Oct 2024)
- **Achievement**: Claude 3.5 Sonnet scored 49% (previous SOTA: 45%)
- **Improvement**: 33.4% → 49.0% on SWE-bench Verified
- **Verification**: 500-problem subset reviewed by humans for solvability
- **Real-world tasks**: Resolve actual GitHub issues from open-source Python repos

---

### THEME 6: ERROR HANDLING & RESILIENCE

#### 6.1 Think Tool for Complex Decision-Making
**Source**: The "think" tool (Mar 20, 2025)

**Purpose**: Create dedicated space for structured thinking during complex tasks

**Difference from Extended Thinking**:
- **Extended thinking**: More detailed reasoning **before** generating response
- **Think tool**: Stop and think **during** response generation

**Best use cases**:
- Calling complex tools
- Analyzing tool outputs in long chains
- Navigating policy-heavy environments
- Sequential decisions where mistakes are costly

**Performance**:
- **Airline domain**: 54% relative improvement over baseline
- **SWE-bench contribution**: 1.6% improvement on average just from think tool
- **TAU-bench retail**: 62.6% → 69.2%
- **TAU-bench airline**: 36.0% → 46.0%

**Implementation**: Minimal overhead, integrated into Claude 3.7 Sonnet (state-of-the-art 0.623 on SWE-Bench)

#### 6.2 Multi-Agent Error Patterns
**Source**: Multi-agent research system
- **Agent excess**: Spawning too many agents for simple tasks
- **Endless search**: Not recognizing when information doesn't exist
- **Agent interference**: Subagents distracting each other
- **Solution approach**: Prompt engineering is primary lever for fixing behaviors

---

### THEME 7: WORKFLOWS & BEST PRACTICES

#### 7.1 Claude Code Best Practices
**Source**: Claude Code best practices (Apr 18, 2025)

**1. Research and Plan First**
- **Problem**: Jumping straight to coding
- **Solution**: Ask Claude to research and plan before coding
- **Result**: Significant performance improvement for problems requiring deeper thinking

**2. Test-Driven Development (TDD)**
- **Anthropic favorite**: For changes verifiable with unit/integration/e2e tests
- **Power**: TDD becomes even more powerful with agentic coding

**3. Extended Thinking Mode**
- **Trigger word**: "think"
- **Levels**: "think" < "think hard" < "think harder" < "ultrathink"
- **Mechanism**: Additional computation time for complex problems

**4. CLAUDE.md Configuration**
- **Purpose**: Repository etiquette and environment setup
- **Behavior**: Automatically pulled into every conversation
- **Best for**: Project-specific guidelines, conventions, setup instructions

**5. Codebase Exploration**
- **Anthropic usage**: Core onboarding workflow
- **Benefits**: Faster ramp-up, reduced load on other engineers
- **Application**: Learning and exploration at scale

**6. Git Operations**
- **Anthropic engineers**: Use Claude for 90%+ of git interactions
- **Implication**: Agent-assisted version control is production-ready

#### 7.2 Contextual Retrieval for RAG
**Source**: Introducing Contextual Retrieval (Sep 2024)

**Problem**: Lost context in chunked documents for retrieval

**Solution**: Two sub-techniques
1. **Contextual Embeddings**: Prepend chunk-specific explanatory context before embedding
2. **Contextual BM25**: Add context before creating BM25 index

**Performance**:
- **Standalone**: 49% reduction in failed retrievals
- **With reranking**: 67% reduction in failed retrievals

**Example transformation**:
```
Original: "The company's revenue grew by 3% over the previous quarter."

Contextualized: "This chunk is from an SEC filing on ACME corp's
performance in Q2 2023; the previous quarter's revenue was $314 million.
The company's revenue grew by 3% over the previous quarter."
```

**Resources**: Implementation details in Anthropic's cookbook

---

## KEY PATTERNS EXTRACTED FOR SYSTEM-WIDE ENHANCEMENT

### Pattern 1: Minimal Scaffolding, Maximum Agent Control
- Give language model as much decision-making power as possible
- Keep infrastructure minimal and unopinionated
- Let agents direct their own processes

### Pattern 2: Context as First-Class Citizen
- Context engineering > prompt engineering for agent systems
- CLAUDE.md pattern for persistent project context
- Folder/file structure as context engineering mechanism
- Active context curation to fight "context rot"

### Pattern 3: Multi-Agent Economic Model
- Lead agent + subagents architecture (90.2% performance gain)
- Parallel execution at multiple levels (agent spawning + tool calling)
- Cost awareness: 15x token usage requires high-value tasks
- Prompt engineering as primary control lever

### Pattern 4: Tool-Agent Symbiosis
- Tools designed from agent perspective (non-deterministic use)
- Agents building/improving their own tools
- Prompt-engineered tool descriptions as steering mechanism
- MCP packaging (.mcpb) for one-click distribution

### Pattern 5: Think Before Act
- Research → Plan → Implement workflow
- "Think" tool for complex decision points
- Extended thinking modes (think, think hard, ultrathink)
- TDD as forcing function for quality

### Pattern 6: Transparency & Quality Culture
- Public postmortems for infrastructure issues
- Never sacrifice quality for performance/demand
- SWE-bench as quality bar (49% = state-of-the-art)
- Real-world task validation (not synthetic benchmarks)

### Pattern 7: Agent Skills & Specialization
- Agent Skills: Specialized capabilities (Claude Code, Research, etc.)
- Subagent coordination for complex goals
- Memory management for long-running tasks
- Permission systems balancing autonomy & control

---

## ANTHROPIC'S ENGINEERING PSYCHOLOGY

### Core Beliefs
1. **Agent autonomy is the goal** - Minimal human intervention for complex tasks
2. **Context is everything** - What goes into context matters more than prompt wording
3. **Transparency builds trust** - Public postmortems, honest about failures
4. **Economics drive adoption** - 15x cost needs 15x+ value
5. **Real-world validation** - SWE-bench, GitHub issues, not toy problems
6. **Agents building agents** - Meta-capability for continuous improvement

### System Design Philosophy
- **Low-level primitives** over high-level frameworks
- **Flexibility** over convenience
- **Agent-centric** over engineer-centric
- **Non-deterministic** design patterns
- **Minimal scaffolding**, maximal model control

### Quality Standards
- Infrastructure bugs are transparent (postmortem culture)
- Never reduce quality for demand/load
- State-of-the-art benchmarks as bar (SWE-bench 49%)
- Human verification (SWE-bench Verified: 500 reviewed problems)

---

## REVOLUTIONARY TERM CANDIDATES

Based on Anthropic's philosophy, what should we call our system-wide Claude Code CLI enhancement?

### Option 1: "Agentic Runtime"
- **Pros**: Captures execution environment, aligns with "runtime" terminology
- **Cons**: Generic, doesn't capture orchestration aspect

### Option 2: "Cognitive Mesh"
- **Pros**: Suggests interconnected intelligence, multi-agent coordination
- **Cons**: May sound too abstract

### Option 3: "Context Fabric"
- **Pros**: Honors Anthropic's context engineering emphasis, "fabric" suggests foundational layer
- **Cons**: Might emphasize context over agents

### Option 4: "Orchestration Substrate"
- **Pros**: Technical, captures foundational layer + coordination
- **Cons**: Less approachable for users

### Option 5: "Agent Nexus"
- **Pros**: "Nexus" = connection point, suggests hub for agent coordination
- **Cons**: Might sound too futuristic

### Option 6: "Brahma Engine"
- **Pros**: Honors existing VAMFI naming, "engine" suggests power
- **Cons**: Less universal appeal (Sanskrit-specific)

### Option 7: "Agentic Substrate"
- **Pros**: "Substrate" = foundational layer agents build upon
- **Anthropic alignment**: Matches their low-level primitives philosophy
- **Cons**: Technical term, may need explanation

### Option 8: "Context Engine"
- **Pros**: Direct alignment with Anthropic's context engineering focus
- **Cons**: Doesn't capture multi-agent aspect

### RECOMMENDED: "Agentic Substrate"
**Reasoning**:
- Captures foundational layer concept (substrate)
- Emphasizes agent-centric design (agentic)
- Aligns with Anthropic's minimal scaffolding philosophy
- Suggests something agents build upon, not something that constrains them
- Technical but accessible

**Tagline**: "The foundational layer for Claude Code superintelligence"

---

## IMPLEMENTATION CHECKLIST FOR ENHANCEMENT

### 1. Skills to Enhance
- ✅ research-methodology: Add contextual retrieval patterns
- ✅ planning-methodology: Add "think before act" protocol, multi-agent planning
- ✅ quality-validation: Add SWE-bench-inspired quality gates
- ✅ pattern-recognition: Add agent skill recognition patterns
- 🆕 context-engineering: NEW SKILL - Active context curation, CLAUDE.md patterns

### 2. Commands to Enhance
- ✅ /workflow: Add multi-agent orchestration option (lead + subagents)
- ✅ /research: Integrate contextual retrieval
- ✅ /plan: Add think tool protocol
- ✅ /implement: Add TDD enforcement, self-correction loops
- 🆕 /context: NEW COMMAND - Analyze and optimize context configuration

### 3. Hooks to Create/Enhance
- 🆕 pre-tool-use: Think tool protocol for complex decisions
- 🆕 post-tool-use: Context editing to prevent context rot
- 🆕 pre-agent-spawn: Economic viability check (is multi-agent worth 15x cost?)
- 🆕 quality-gate: SWE-bench-inspired validation

### 4. Plugins/MCP Integration
- 🆕 .mcpb packaging: Create installer for our agentic substrate
- 🆕 Desktop extension: One-click install for users
- 🆕 Agent Skills registry: Catalog of available specialized agents

### 5. Agents to Enhance
- ✅ chief-architect: Add lead agent + subagent coordination pattern (90% improvement potential)
- ✅ docs-researcher: Add contextual retrieval (49-67% better retrieval)
- ✅ implementation-planner: Add think tool for complex planning
- ✅ code-implementer: Add TDD enforcement, git operations, extended thinking modes

### 6. Sub-agents (Brahma System)
- ✅ All 18 agents: Add think tool capability
- ✅ brahma-navigator: Lead agent pattern with subagent spawning
- ✅ brahma-clarifier: Context engineering for requirements
- ✅ brahma-analyzer: Quality gates inspired by SWE-bench

### 7. Installation & Setup
- 🆕 install.sh: Copy to ~/.claude/ with .mcpb packaging option
- 🆕 CLAUDE.md templates: Auto-setup for new projects
- 🆕 Constitution templates: Project governance from day one
- 🆕 Extension manifest: Desktop extension for one-click install

### 8. Documentation
- 🆕 README: "Agentic Substrate" positioning
- 🆕 Quick Start: One-click installation guide
- 🆕 Philosophy: Explain Anthropic alignment
- 🆕 Architecture: Lead agent + subagent patterns
- 🆕 Best Practices: Research→Plan→Implement, TDD, think tool

---

## SOURCES

1. **Building agents with the Claude Agent SDK** (Sep 29, 2025)
   https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk

2. **Building effective agents** (2025)
   https://www.anthropic.com/engineering/building-effective-agents

3. **Effective context engineering for AI agents** (Sep 29, 2025)
   https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents

4. **A postmortem of three recent issues** (Sep 17, 2025)
   https://www.anthropic.com/engineering/a-postmortem-of-three-recent-issues

5. **Writing effective tools for agents — with agents** (Sep 11, 2025)
   https://www.anthropic.com/engineering/writing-tools-for-agents

6. **Desktop Extensions: One-click MCP server installation** (Jun 26, 2025)
   https://www.anthropic.com/engineering/desktop-extensions

7. **How we built our multi-agent research system** (Jun 13, 2025)
   https://www.anthropic.com/engineering/multi-agent-research-system

8. **Claude Code: Best practices for agentic coding** (Apr 18, 2025)
   https://www.anthropic.com/engineering/claude-code-best-practices

9. **The "think" tool: Enabling Claude to stop and think** (Mar 20, 2025)
   https://www.anthropic.com/engineering/claude-think-tool

10. **Raising the bar on SWE-bench Verified with Claude 3.5 Sonnet** (Oct 2024)
    https://www.anthropic.com/engineering/swe-bench-sonnet

11. **Introducing Contextual Retrieval** (Sep 2024)
    https://www.anthropic.com/news/contextual-retrieval
    https://www.anthropic.com/engineering/contextual-retrieval

---

## OPEN QUESTIONS FOR PLANNING PHASE

1. **Revolutionary term**: Approve "Agentic Substrate" or propose alternative?

2. **Multi-agent economics**: When should chief-architect spawn subagents? (15x cost threshold)

3. **Think tool integration**: Which agents need think tool capability? All or subset?

4. **MCP packaging**: Should we create .mcpb installer for one-click distribution?

5. **Context engineering skill**: Create as new skill or integrate into existing?

6. **Quality bar**: Use SWE-bench patterns for validation? Create our own benchmark?

7. **CLAUDE.md defaults**: What should default project CLAUDE.md contain?

8. **Backward compatibility**: How to migrate existing users to enhanced system?

---

**ResearchPack Complete - Ready for Planning Phase**

**Confidence: HIGH** - All information from official Anthropic engineering sources
**Coverage: COMPREHENSIVE** - All 11 articles analyzed and synthesized
**Thematic Organization: COMPLETE** - 7 major themes + patterns + implementation checklist
