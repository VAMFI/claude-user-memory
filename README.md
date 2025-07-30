# 🛠️ Claude Code Workflow Agents

A streamlined collection of 3 specialized AI agents designed to implement a research-backed, plan-driven development workflow with [Claude Code CLI](https://docs.anthropic.com/claude-code).

**📚 Research First | 📋 Plan Thoroughly | 🚀 Implement Precisely**

![Claude Code Workflow](photo.jpeg)
*Research → Plan → Implement: A systematic approach to software development with Claude Code*

## 🌟 The Philosophy

Transform your development process with a systematic three-phase workflow:

1. **Research Phase**: Gather authoritative, version-accurate documentation
2. **Planning Phase**: Create detailed, actionable implementation plans  
3. **Implementation Phase**: Execute precise, minimal code changes

This approach ensures:
- **🎯 Accuracy**: All code based on current, official documentation
- **🔄 Reversibility**: Every change is planned with rollback strategies
- **✅ Verifiability**: All implementations include test criteria
- **📊 Traceability**: Clear path from research to implementation

## 🤖 The Three Agents

### 1. 📚 **docs-researcher**
**Purpose**: Fetches current, version-accurate documentation from official sources

**When to use**:
- Before implementing any new library or framework feature
- When updating dependencies to new versions
- When debugging library-specific issues
- To verify correct API usage

**Output**: ResearchPack containing:
- Authoritative API references
- Version-specific information
- Usage examples from official docs
- Migration guides and breaking changes

### 2. 📋 **implementation-planner**
**Purpose**: Creates detailed, actionable implementation plans based on research

**When to use**:
- After completing research phase
- When you need to map requirements to actual code changes
- To design safe, minimal change sets
- Before starting any complex implementation

**Output**: Implementation Plan containing:
- File-by-file change specifications
- Step-by-step procedures
- Test criteria and acceptance tests
- Risk assessment and mitigation strategies
- Rollback procedures

### 3. 🚀 **code-implementer**
**Purpose**: Executes surgical code edits following the plan

**When to use**:
- Only after you have both ResearchPack and Implementation Plan
- When ready to make actual code changes
- For precise, minimal edits that follow specifications

**Output**: 
- Implemented code changes
- Verification test results
- Execution report with any issues encountered

## ⚡ Quick Start

### 1. Install Claude Code CLI
```bash
# Install Claude Code if you haven't already
npm install -g @anthropic/claude-code
```

### 2. Install Workflow Agents
```bash
# Clone this repository
git clone https://github.com/irenicj/claude-code-workflow-agents.git
cd claude-code-workflow-agents

# Install agents to your Claude Code configuration
cp agents/* ~/.claude/agents/

# Verify installation
claude-code
> /agents
```

### 3. Start Using the Workflow
```bash
# Launch Claude Code
claude-code

# Example: Add a new feature
> I need to add Stripe payment integration

# Claude will automatically:
# 1. Use docs-researcher to fetch Stripe API documentation
# 2. Suggest using implementation-planner to create a plan
# 3. Wait for approval before using code-implementer
```

## 🔄 The Workflow in Action

### Complete Feature Implementation
```bash
# Step 1: Research
> Use docs-researcher to find the latest Stripe Node.js SDK documentation

# Step 2: Plan
> Use implementation-planner with this research to design payment integration

# Step 3: Implement
> Use code-implementer to execute the payment integration plan
```

### Dependency Updates
```bash
# Updating a library (e.g., React Router v5 to v6)
> Update our React Router from v5 to v6

# Claude automatically orchestrates:
# 1. docs-researcher → fetches migration guide and API changes
# 2. implementation-planner → creates phased migration plan
# 3. code-implementer → executes changes with verification
```

### Quick Bug Fixes
```bash
# When you encounter library-specific errors
> mongoose.connect() is throwing errors

# Claude uses docs-researcher to verify correct usage
# Then provides solution based on official documentation
```

## 🎯 Automatic Agent Selection

Claude Code automatically selects the right agent based on keywords:

### Research Keywords → `docs-researcher`
- "documentation", "docs", "API reference"
- "library", "framework", "package", "version"
- "update to", "migrate to", "upgrade"
- "how to use", "correct usage", "official docs"

### Planning Keywords → `implementation-planner`
- "plan", "design", "architecture"
- "what files", "where to implement"
- "implementation strategy", "approach"
- "based on research", "create a plan"

### Implementation Keywords → `code-implementer`
- "implement the plan", "execute changes"
- "make the changes", "apply the plan"
- "code it", "build it" (when plan exists)

## 🚀 Advanced Usage

### Using Task Tool
For complex, multi-step operations:

```bash
# Research multiple libraries
> Use Task tool with docs-researcher to research both Stripe and SendGrid APIs

# Create comprehensive plans
> Use Task tool with implementation-planner to design microservices architecture

# Execute large implementations
> Use Task tool with code-implementer to refactor the entire authentication system
```

### Workflow Shortcuts
```bash
# Let Claude handle the entire workflow
> Add Redis caching to our application
# Claude will automatically sequence: research → plan → implement

# Skip to implementation if you have research and plan
> I have the AWS S3 research and plan ready. Implement it.
# Claude recognizes existing artifacts and jumps to code-implementer
```

## 📋 Important Concepts

### ResearchPack
A structured document containing:
- Verified library versions
- Official API documentation
- Code examples from authoritative sources
- Migration guides and breaking changes
- All sources linked and cited

### Implementation Plan
A detailed blueprint containing:
- Specific files to modify or create
- Step-by-step implementation procedure
- Test scenarios and acceptance criteria
- Risk assessment and mitigation
- Rollback strategy

### Workflow Enforcement
- **implementation-planner** requires a ResearchPack
- **code-implementer** requires both ResearchPack and Plan
- This ensures quality and prevents coding from memory

## 🏗️ Example Workflows

### API Integration
```
User: "Add SendGrid email integration to our Node.js app"

1. docs-researcher automatically runs
   → Produces: SendGrid Node.js SDK ResearchPack

2. implementation-planner creates integration plan
   → Produces: Step-by-step implementation guide

3. code-implementer executes the plan
   → Result: Working email integration with tests
```

### Framework Migration
```
User: "Migrate from Express to Fastify"

1. docs-researcher fetches both framework docs
   → Produces: Comparative analysis and migration guide

2. implementation-planner designs phased migration
   → Produces: Risk-minimized migration strategy

3. code-implementer executes incrementally
   → Result: Successful migration with rollback points
```

### Performance Optimization
```
User: "Optimize database queries for better performance"

1. docs-researcher gathers optimization guides
   → Produces: Database-specific optimization techniques

2. implementation-planner identifies bottlenecks
   → Produces: Targeted optimization plan

3. code-implementer applies optimizations
   → Result: Measurable performance improvements
```

## 📚 Documentation

- **[Installation Guide](docs/claude-code-integration.md)** - Detailed setup instructions
- **[Workflow Best Practices](docs/workflow-best-practices.md)** - Tips for effective workflow usage
- **[Agent Reference](docs/agent-reference.md)** - Detailed agent capabilities
- **[Example Scenarios](examples/scenarios.md)** - Real-world workflow examples

## 🤝 Contributing

We welcome contributions to improve the workflow agents!

### Areas for Contribution
- Enhance agent prompts for better accuracy
- Add workflow examples and patterns
- Improve documentation and guides
- Share success stories and use cases

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 🔗 Resources

### Claude Code Documentation
- [Official Claude Code Docs](https://docs.anthropic.com/claude-code)
- [Agent System Guide](https://docs.anthropic.com/claude-code/agents)
- [Task Tool Documentation](https://docs.anthropic.com/claude-code/task-tool)

### Support
- [GitHub Issues](https://github.com/irenicj/claude-code-workflow-agents/issues)
- [Discussions](https://github.com/irenicj/claude-code-workflow-agents/discussions)

## ⚖️ License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

Built for developers who value:
- Documentation-driven development
- Systematic planning before implementation
- Minimal, reversible changes
- Quality over speed

---

**Research → Plan → Implement: Professional software development with Claude Code** 🚀