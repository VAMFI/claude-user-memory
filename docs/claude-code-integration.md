# Claude Code Integration Guide

This guide provides comprehensive instructions for installing and using specialized agents with Claude Code CLI.

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

### Method 1: Quick Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/irenicj/claude-code-agents.git
cd claude-code-agents

# Install all agents to Claude Code
cp agents/* ~/.claude/agents/

# Verify installation
claude-code
> /agents
```

You should see all 12 specialized agents listed with their descriptions and colors.

### Method 2: Selective Installation

Install only specific agents you need:

```bash
# Install specific agents
cp agents/backend-specialist.md ~/.claude/agents/
cp agents/frontend-specialist.md ~/.claude/agents/
cp agents/devops-engineer.md ~/.claude/agents/

# Verify installation
claude-code
> /agents
```

### Method 3: Project-Specific Installation

Install agents for a specific project only:

```bash
# Navigate to your project
cd /path/to/your/project

# Create project agents directory
mkdir -p .claude/agents

# Install agents for this project only
cp /path/to/claude-code-specialized-agents/agents/* .claude/agents/

# Verify installation
claude-code
> /agents
```

## 🎯 Usage Patterns

### Basic Agent Usage

#### Auto-Selection
Claude Code automatically suggests the most relevant agent based on your query:

```bash
claude-code
> I need help creating a REST API for user authentication
# Claude automatically suggests: backend-specialist

> Help me optimize this React component for better performance  
# Claude automatically suggests: frontend-specialist

> Set up CI/CD pipeline for Node.js application
# Claude automatically suggests: devops-engineer
```

#### Explicit Agent Selection
Request a specific agent directly:

```bash
claude-code
> Use backend-specialist to design database schema for e-commerce

> Use frontend-specialist to create responsive navigation component

> Use security-engineer to review authentication implementation
```

### Advanced Usage with Task Tool

#### Complex Single-Agent Tasks
```bash
claude-code
> Use Task tool with backend-specialist to analyze this codebase and identify performance bottlenecks

> Use Task tool with devops-engineer to investigate production issues and provide detailed analysis

> Use Task tool with security-engineer to conduct comprehensive security audit
```

#### Multi-Agent Coordination
```bash
claude-code
> Use Task tool to coordinate:
  1. product-owner for requirements analysis
  2. software-architect for system design  
  3. backend-specialist for API implementation
  4. frontend-specialist for UI development
  5. qa-engineer for testing strategy
```

## 🔧 Configuration and Customization

### Agent Directory Structure
```
~/.claude/
├── agents/                    # User-level agents (global)
│   ├── backend-specialist.md
│   ├── frontend-specialist.md
│   └── ...
└── config.json              # Claude Code configuration

your-project/
├── .claude/
│   └── agents/               # Project-level agents
│       ├── backend-specialist.md
│       └── ...
└── ...
```

### Agent Priority
Claude Code uses this priority order:
1. **Project agents** (`.claude/agents/`) - highest priority
2. **User agents** (`~/.claude/agents/`) - fallback
3. **Built-in agents** - default fallback

### Customizing Agents
You can modify agents for your specific needs:

```bash
# Copy agent to project directory for customization
cp ~/.claude/agents/backend-specialist.md .claude/agents/

# Edit the agent
vim .claude/agents/backend-specialist.md

# Modify the content while keeping YAML frontmatter intact
```

## 🎯 Integration Features

### Keyword-Based Auto-Selection

These keywords trigger specific agents:

#### Backend Specialist
- `API`, `REST`, `GraphQL`, `database`, `SQL`, `backend`, `server`
- `microservices`, `authentication`, `authorization`
- `PostgreSQL`, `MongoDB`, `Redis`, `cache`

#### Frontend Specialist  
- `React`, `Vue`, `Angular`, `component`, `UI`, `frontend`
- `responsive`, `CSS`, `JavaScript`, `TypeScript`
- `performance`, `bundle`, `webpack`, `vite`

#### DevOps Engineer
- `deployment`, `CI/CD`, `Docker`, `Kubernetes`, `pipeline`
- `AWS`, `Azure`, `GCP`, `infrastructure`, `monitoring`
- `automation`, `terraform`, `ansible`

#### Security Engineer
- `security`, `vulnerability`, `authentication`, `authorization`
- `encryption`, `HTTPS`, `compliance`, `audit`
- `OWASP`, `penetration`, `threat`

### Task Tool Integration

#### Sequential Workflows
```bash
# Step-by-step feature development
claude-code
> Use Task tool for shopping cart feature:
  Step 1: product-owner - define requirements
  Step 2: software-architect - design system  
  Step 3: backend-specialist - implement API
  Step 4: frontend-specialist - build UI
  Step 5: qa-engineer - create tests
```

#### Parallel Investigations
```bash
# Emergency response coordination
claude-code  
> Production issue investigation using Task tool:
  Parallel Track 1: devops-engineer - infrastructure analysis
  Parallel Track 2: backend-specialist - application logs
  Parallel Track 3: security-engineer - security assessment
```

## 🔍 Troubleshooting

### Common Issues

#### Agents Not Showing Up
```bash
# Check Claude Code configuration directory
ls -la ~/.claude/agents/

# Verify agent file format
head -10 ~/.claude/agents/backend-specialist.md
# Should show YAML frontmatter:
# ---
# name: backend-specialist  
# description: "..."
# color: yellow
# ---
```

#### Wrong Agent Auto-Selected
```bash
# Use explicit agent selection
> Use backend-specialist to help with database design

# Add more specific keywords to your query
> Use backend-specialist to optimize PostgreSQL database performance

# Check agent descriptions for better keyword matching
> /agents
```

#### Task Tool Not Working with Agents
```bash
# Verify Task tool syntax
> Use Task tool with backend-specialist to analyze codebase

# Alternative syntax
> Launch backend-specialist task to review API design

# Check Claude Code version
claude-code --version
```

### Agent File Validation

#### Check YAML Frontmatter
```bash
# Validate YAML syntax
python3 -c "
import yaml
with open('~/.claude/agents/backend-specialist.md') as f:
    content = f.read()
    yaml_part = content.split('---')[1]
    yaml.safe_load(yaml_part)
print('YAML is valid')
"
```

#### Required Fields
Ensure each agent has:
- `name`: unique, kebab-case identifier
- `description`: clear use case description  
- `color`: unique color for visual distinction

### Performance Optimization

#### Agent Loading Speed
```bash
# Reduce agent count for faster loading
mkdir ~/.claude/agents-backup
mv ~/.claude/agents/*.md ~/.claude/agents-backup/
cp ~/.claude/agents-backup/{backend-specialist,frontend-specialist,devops-engineer}.md ~/.claude/agents/

# Restore when needed
cp ~/.claude/agents-backup/*.md ~/.claude/agents/
```

#### Memory Usage
```bash
# Monitor Claude Code memory usage
ps aux | grep claude-code

# Use project-specific agents to reduce global memory footprint
rm ~/.claude/agents/*.md  # Remove global agents
# Use .claude/agents/ in each project instead
```

## 📊 Usage Analytics and Monitoring

### Track Agent Usage
```bash
# Monitor which agents are used most frequently
grep -r "Use.*-specialist" ~/.claude/logs/ | sort | uniq -c | sort -nr

# Analyze auto-selection accuracy
grep -r "automatically suggests" ~/.claude/logs/
```

### Performance Metrics
```bash
# Measure response times with different agents
time claude-code -c "Use backend-specialist to explain REST API design"

# Compare Task tool performance
time claude-code -c "Use Task tool with backend-specialist for complex analysis"
```

## 🔄 Updates and Maintenance

### Updating Agents
```bash
# Pull latest agent updates
cd claude-code-specialized-agents
git pull origin main

# Update installed agents
cp agents/* ~/.claude/agents/

# Or update specific agents
cp agents/backend-specialist.md ~/.claude/agents/
```

### Backup and Restore
```bash
# Backup current agents
mkdir -p ~/claude-agents-backup/$(date +%Y%m%d)
cp ~/.claude/agents/* ~/claude-agents-backup/$(date +%Y%m%d)/

# Restore from backup
cp ~/claude-agents-backup/20241201/* ~/.claude/agents/
```

### Version Compatibility
```bash
# Check Claude Code version compatibility
claude-code --version

# Verify agent compatibility
claude-code
> /agents
# All agents should load without errors
```

## 🚀 Advanced Integration

### Custom Workflows
Create custom workflows combining multiple agents:

```bash
# Save workflow as script
cat > workflow-fullstack-feature.sh << 'EOF'
#!/bin/bash
echo "Starting full-stack feature development workflow..."

claude-code -c "Use product-owner to define requirements for: $1"
read -p "Press Enter to continue to architecture phase..."

claude-code -c "Use software-architect to design system for: $1"  
read -p "Press Enter to continue to implementation..."

claude-code -c "Use backend-specialist to implement API for: $1"
claude-code -c "Use frontend-specialist to build UI for: $1"
claude-code -c "Use qa-engineer to create tests for: $1"

echo "Workflow complete!"
EOF

chmod +x workflow-fullstack-feature.sh

# Use the workflow
./workflow-fullstack-feature.sh "user authentication system"
```

### IDE Integration
```bash
# VS Code integration (if available)
code --install-extension claude-code-extension

# Configure VS Code settings
mkdir -p .vscode
cat > .vscode/settings.json << 'EOF'
{
  "claude-code.enableAgents": true,
  "claude-code.preferredAgents": [
    "backend-specialist",
    "frontend-specialist", 
    "devops-engineer"
  ]
}
EOF
```

## 📚 Additional Resources

### Official Documentation
- [Claude Code CLI Reference](https://docs.anthropic.com/claude-code/cli-reference)
- [Agent System Documentation](https://docs.anthropic.com/claude-code/agents)
- [Task Tool Guide](https://docs.anthropic.com/claude-code/task-tool)

### Community Resources  
- [Agent Best Practices](agent-best-practices.md)
- [Workflow Patterns](../examples/workflow-patterns.md)
- [Usage Examples](../examples/usage-examples.md)

### Support
- [GitHub Issues](https://github.com/irenicj/claude-code-agents/issues)
- [Claude Code Community](https://docs.anthropic.com/claude-code/community)
- [Official Support](https://docs.anthropic.com/claude-code/support)

---

**Ready to transform your development workflow with specialized AI agents!** 🚀