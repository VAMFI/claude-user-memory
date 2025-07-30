# Claude Code Workflow Integration Guide

This guide provides comprehensive instructions for installing and using the research-plan-implement workflow agents with Claude Code CLI.

## 📋 Prerequisites

### System Requirements
- **Node.js** (v16 or higher)
- **Claude Code CLI** (latest version)
- **Git** (for cloning repository)
- **Unix-like system** (macOS, Linux, WSL on Windows)

### Claude Code Installation
If you haven't installed Claude Code CLI yet:

```bash
# Install via npm
npm install -g @anthropic/claude-code

# Verify installation
claude-code --version

# Set up configuration (first time only)
claude-code
# Follow the setup prompts to authenticate
```

## 🚀 Agent Installation

### Quick Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/irenicj/claude-code-workflow-agents.git
cd claude-code-workflow-agents

# Install all three workflow agents
cp agents/* ~/.claude/agents/

# Verify installation
claude-code
> /agents
```

You should see the three workflow agents listed:
- **docs-researcher** (purple) - Research phase
- **implementation-planner** (blue) - Planning phase
- **code-implementer** (cyan) - Implementation phase

### Project-Specific Installation

Install agents for a specific project only:

```bash
# Navigate to your project
cd /path/to/your/project

# Create project agents directory
mkdir -p .claude/agents

# Install workflow agents for this project
cp /path/to/claude-code-workflow-agents/agents/* .claude/agents/

# Verify installation
claude-code
> /agents
```

## 🔄 Understanding the Workflow

### The Three-Phase Approach

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│ 1. RESEARCH     │ --> │ 2. PLAN          │ --> │ 3. IMPLEMENT    │
├─────────────────┤     ├──────────────────┤     ├─────────────────┤
│ docs-researcher │     │ implementation-  │     │ code-           │
│                 │     │ planner          │     │ implementer     │
├─────────────────┤     ├──────────────────┤     ├─────────────────┤
│ Fetches current │     │ Creates detailed │     │ Executes        │
│ documentation   │     │ implementation   │     │ surgical edits  │
│                 │     │ blueprint        │     │ following plan  │
├─────────────────┤     ├──────────────────┤     ├─────────────────┤
│ Output:         │     │ Output:          │     │ Output:         │
│ ResearchPack    │     │ Implementation   │     │ Working code    │
│                 │     │ Plan             │     │ + test results  │
└─────────────────┘     └──────────────────┘     └─────────────────┘
```

### Key Concepts

#### ResearchPack
A structured document produced by docs-researcher containing:
- Library version information
- Official API documentation excerpts
- Code examples from authoritative sources
- Migration guides and breaking changes
- All sources properly linked

#### Implementation Plan
A detailed blueprint produced by implementation-planner containing:
- Specific files to modify or create
- Step-by-step implementation procedure
- Test scenarios and acceptance criteria
- Risk assessment and mitigation strategies
- Rollback procedures

#### Workflow Enforcement
- implementation-planner **requires** a ResearchPack
- code-implementer **requires** both ResearchPack and Plan
- This prevents coding from potentially outdated memory

## 🎯 Usage Patterns

### Automatic Workflow

Claude automatically orchestrates the workflow based on your request:

```bash
claude-code
> Add Stripe payment integration to our Node.js application

# Claude automatically:
# 1. Uses docs-researcher to fetch Stripe SDK documentation
# 2. Uses implementation-planner to create integration plan
# 3. Asks for approval, then uses code-implementer
```

### Manual Agent Selection

Control each phase explicitly:

```bash
# Phase 1: Research
> Use docs-researcher to research Stripe Node.js SDK v12

# Phase 2: Planning
> Use implementation-planner with the research to design payment flow

# Phase 3: Implementation
> Use code-implementer to execute the payment integration plan
```

### Keyword-Based Auto-Selection

#### Research Phase Keywords → docs-researcher
- `documentation`, `docs`, `API reference`
- `library`, `framework`, `package`, `version`
- `update to`, `migrate to`, `upgrade`
- `how to use`, `correct usage`

#### Planning Phase Keywords → implementation-planner
- `plan`, `design`, `architecture`
- `what files`, `where to implement`
- `implementation strategy`
- `based on research`

#### Implementation Phase Keywords → code-implementer
- `implement the plan`
- `execute changes`
- `make the changes`
- `apply the plan`

## 🚀 Common Workflows

### Adding a New Feature

```bash
# Scenario: Adding email notifications
claude-code

> I need to add email notifications using SendGrid

# Workflow execution:
# 1. docs-researcher fetches SendGrid Node.js SDK docs
# 2. implementation-planner creates notification system design
# 3. code-implementer implements the feature
```

### Updating Dependencies

```bash
# Scenario: Updating React Router
claude-code

> Update React Router from v5 to v6

# Workflow execution:
# 1. docs-researcher fetches migration guide
# 2. implementation-planner creates phased update plan
# 3. code-implementer executes migration steps
```

### Debugging Library Issues

```bash
# Scenario: MongoDB connection errors
claude-code

> mongoose.connect() is throwing authentication errors

# Workflow execution:
# 1. docs-researcher checks current Mongoose documentation
# 2. Provides solution based on official docs
```

## 🔧 Advanced Usage

### Task Tool Integration

For complex, multi-step operations:

```bash
# Research multiple technologies
> Use Task tool with docs-researcher to research OAuth2 providers

# Create comprehensive plans
> Use Task tool with implementation-planner for microservices design

# Execute large refactoring
> Use Task tool with code-implementer to modernize the codebase
```

### Workflow Customization

#### Skip Research (when you have documentation)
```bash
> I have the AWS SDK documentation ready. Create a plan for S3 integration
# Skips to implementation-planner
```

#### Skip to Implementation (when you have both)
```bash
> I have the ResearchPack and Plan ready. Implement the changes.
# Goes directly to code-implementer
```

## 🔍 Troubleshooting

### Agents Not Showing Up
```bash
# Check installation directory
ls -la ~/.claude/agents/

# Verify agent file format (should show YAML frontmatter)
head -10 ~/.claude/agents/docs-researcher.md
```

### Wrong Agent Selected
```bash
# Use explicit selection
> Use docs-researcher to find React hooks documentation

# Or use more specific keywords
> Research the official React hooks API documentation
```

### ResearchPack Not Found
```bash
# Ensure research phase completed first
> Use docs-researcher to research [topic] first
> Now use implementation-planner with the research
```

## 📊 Best Practices

### 1. Always Start with Research
```bash
# Good
> Research NextAuth.js v5 documentation
> Plan the authentication implementation
> Implement the auth system

# Avoid
> Implement NextAuth.js authentication  # May use outdated patterns
```

### 2. Review Plans Before Implementation
```bash
> Create a plan for database migration
# Review the plan output
> The plan looks good, implement it
```

### 3. Use Task Tool for Complex Operations
```bash
> Use Task tool to research, plan, and implement payment processing
```

### 4. Provide Context for Better Results
```bash
# Good
> Research Stripe SDK for Node.js v12, focusing on subscription APIs

# Less optimal
> Research Stripe
```

## 🔄 Workflow Examples

### Example 1: API Integration
```
Input: "Add weather API integration"

Process:
1. docs-researcher → Fetches OpenWeather API docs
2. implementation-planner → Designs integration architecture
3. code-implementer → Implements with error handling

Output: Working weather service with tests
```

### Example 2: Performance Optimization
```
Input: "Optimize database queries"

Process:
1. docs-researcher → Gathers optimization guides
2. implementation-planner → Identifies specific optimizations
3. code-implementer → Applies query improvements

Output: Optimized queries with benchmarks
```

### Example 3: Security Enhancement
```
Input: "Implement rate limiting"

Process:
1. docs-researcher → Researches rate limiting libraries
2. implementation-planner → Designs rate limit strategy
3. code-implementer → Implements across endpoints

Output: Protected API with rate limiting
```

## 📚 Additional Resources

### Workflow Documentation
- [Workflow Best Practices](workflow-best-practices.md)
- [Agent Reference Guide](agent-reference.md)
- [Example Scenarios](../examples/scenarios.md)

### Claude Code Resources
- [Official Claude Code Docs](https://docs.anthropic.com/claude-code)
- [Agent System Documentation](https://docs.anthropic.com/claude-code/agents)
- [Task Tool Guide](https://docs.anthropic.com/claude-code/task-tool)

### Support
- [GitHub Issues](https://github.com/irenicj/claude-code-workflow-agents/issues)
- [Discussions](https://github.com/irenicj/claude-code-workflow-agents/discussions)

---

**Transform your development with Research → Plan → Implement workflow!** 🚀