# Claude Code Specialized Agents 🤖

A curated collection of **12 professional AI specialist agents** for [Claude Code CLI](https://docs.anthropic.com/claude-code), crafted from industry-leading AI code generation tool system prompts. These agents provide role-based expertise across all major software development disciplines.

## 🚀 Quick Start

### For Personal Use (Recommended)
Copy agents to your global Claude Code directory:
```bash
# Clone the repository
git clone https://github.com/irenicj/claude-code-specialized-agents.git
cd claude-code-specialized-agents

# Copy agents to your personal Claude Code directory
cp agents/* ~/.claude/agents/
```

### For Project-Specific Use
Copy agents to your project's Claude Code directory:
```bash
# In your project root
mkdir -p .claude/agents
cp agents/* .claude/agents/
```

## 📋 Available Agents

| Agent | Specialization | Color | Use Cases |
|-------|---------------|-------|-----------|
| **backend-specialist** | API development, database design, server architecture | Yellow | REST APIs, microservices, database optimization |
| **devops-engineer** | CI/CD, infrastructure, deployment automation | Purple | Docker, Kubernetes, cloud platforms |
| **engineering-manager** | Team leadership, process optimization, performance | Blue | Team velocity, sprint planning, career development |
| **enterprise-cto** | Technology strategy, executive decisions | Red | Architecture decisions, technology roadmaps |
| **frontend-specialist** | UI/UX, React, responsive design | Cyan | Component libraries, performance optimization |
| **product-owner** | Requirements, feature prioritization | Green | User stories, stakeholder alignment |
| **project-manager** | Planning, coordination, risk management | Orange | Timeline management, resource coordination |
| **qa-engineer** | Testing strategy, quality assurance | Magenta | Test automation, quality gates |
| **security-engineer** | Security architecture, vulnerability assessment | Red | Authentication, compliance, security audits |
| **senior-fullstack-developer** | Full-stack development, mentoring | White | Complex features, cross-stack integration |
| **software-architect** | System design, technical standards | Yellow | Distributed systems, architectural patterns |
| **technical-writer** | Documentation, API specs, user guides | Gray | Developer onboarding, API documentation |

## 💡 Usage Examples

### Access Agents in Claude Code
Once installed, access agents via the `/agents` command:
```
/agents
```

### Example Scenarios

**Building a REST API:**
```
I need to design a high-performance REST API for 10k+ requests/minute.
```
*Claude Code will automatically suggest the `backend-specialist` agent*

**React Performance Issues:**
```
My React app is slow with large lists and frequent re-renders. How can I optimize?
```
*Claude Code will automatically suggest the `frontend-specialist` agent*

**Setting up CI/CD Pipeline:**
```
I want to automate deployment from GitHub to AWS with proper testing.
```
*Claude Code will automatically suggest the `devops-engineer` agent*

## 🛠 Installation Methods

### Method 1: Global Installation (Recommended)
Agents are available across all your projects:
```bash
# Clone and install globally
git clone https://github.com/irenicj/claude-code-specialized-agents.git
cd claude-code-specialized-agents
cp agents/* ~/.claude/agents/
```

### Method 2: Project-Specific Installation
Agents are only available in the specific project:
```bash
# In your project directory
git clone https://github.com/irenicj/claude-code-specialized-agents.git
mkdir -p .claude/agents
cp claude-code-specialized-agents/agents/* .claude/agents/
```

### Method 3: Direct Download
Download individual agents:
```bash
# Download a specific agent
curl -o ~/.claude/agents/backend-specialist.md \
  https://raw.githubusercontent.com/irenicj/claude-code-specialized-agents/main/agents/backend-specialist.md
```

## 🔧 Verification

Verify installation:
```bash
# Check agents are installed
ls ~/.claude/agents/

# Start Claude Code and test
claude-code
```

In Claude Code session:
```
/agents
```

You should see all 12 specialized agents available for selection.

## 📖 Agent Architecture

Each agent follows a comprehensive structure:
- **Role Definition**: Clear identity and responsibilities
- **Philosophy**: Core principles and approach
- **Technical Expertise**: Specific technology areas
- **Communication Style**: How the agent interacts
- **Enterprise Context**: Adaptation for different company sizes
- **Success Metrics**: Measurable outcomes
- **Technology Stack**: Preferred tools and frameworks

## 🌟 Features

- **Professional-Grade Prompts**: Curated from industry-leading AI tools
- **Role-Based Specialization**: 12 distinct software development roles
- **Context-Aware**: Adapts to startup, growth, and enterprise contexts
- **Plug-and-Play**: Works immediately with Claude Code CLI
- **Comprehensive Coverage**: From frontend to infrastructure to management
- **Consistent Quality**: All agents follow the same high-quality structure

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Adding New Agents
1. Follow the established agent structure
2. Include comprehensive examples and use cases
3. Test with Claude Code CLI
4. Update this README with agent details

### Improving Existing Agents
1. Maintain backward compatibility
2. Enhance technical expertise areas
3. Add more practical examples
4. Update technology stack references

## 📚 Examples and Tutorials

See [examples/usage-examples.md](examples/usage-examples.md) for detailed usage scenarios and best practices.

## 🙏 Credits

These agents are curated and optimized from the excellent work at:
- **[system-prompts-and-models-of-ai-tools](https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools)** by [@x1xhlol](https://github.com/x1xhlol)

Special thanks to the AI development community for sharing these high-quality system prompts.

## ⚖️ License

MIT License - see [LICENSE](LICENSE) for details.

## 🔗 Related Links

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Original System Prompts Repository](https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)

---

**Built for the Claude Code Community** 🚀

*These agents are specifically crafted for Claude Code CLI but can be adapted for other AI development tools as needed.*