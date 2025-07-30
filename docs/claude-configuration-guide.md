# 🔧 Claude Code Configuration Guide

This guide covers everything you need to know about configuring Claude Code for optimal workflow with our trinity agents.

## 📁 Directory Structure

Claude Code uses the `~/.claude/` directory for global configuration:

```
~/.claude/
├── agents/                 # Custom agents (our trinity agents go here)
│   ├── docs-researcher.md
│   ├── implementation-planner.md
│   └── code-implementer.md
├── commands/              # Custom slash commands
│   ├── research.md
│   ├── plan.md
│   ├── implement.md
│   └── workflow.md
├── templates/             # Reusable templates
│   └── project-claude.md
├── CLAUDE.md             # Global instructions (already configured)
├── claude.json           # Main configuration file
└── settings.json         # Additional settings
```

## ⚙️ Configuration Files

### 1. ~/.claude.json (Primary Configuration)

This is the main configuration file for Claude Code:

```json
{
  "model": "claude-sonnet-4-20250514",
  "allowedTools": [
    "Task",
    "Bash",
    "Glob",
    "Grep",
    "LS",
    "Read",
    "Edit",
    "MultiEdit",
    "Write",
    "WebSearch",
    "WebFetch",
    "TodoWrite"
  ],
  "mcp": {
    "mcpServers": {}
  }
}
```

#### Model Options
- `claude-sonnet-4-20250514` - Default, balanced performance
- `claude-opus-4-20250514` - Most capable, higher cost
- `claude-3-5-haiku-20241022` - Fastest, lower cost

### 2. Project-Level Configuration

Create these files in your project root:

#### CLAUDE.md
```markdown
# Project Instructions for Claude Code

## Project Context
This is a [type] project using [stack].

## Workflow Requirements
1. Always use docs-researcher before implementing new libraries
2. Create implementation plans for features > 50 lines
3. Use code-implementer for precise changes

## Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`
```

#### .claude/settings.local.json
```json
{
  "model": "claude-opus-4-20250514",
  "additionalContext": "Always follow TDD practices"
}
```

## 🤖 Agent Configuration

Our trinity agents are already optimized, but you can customize them:

### Agent File Format
```markdown
---
name: agent-name
description: "Trigger keywords and use cases"
color: purple
---

Agent instructions go here...
```

### Key Components
1. **YAML Frontmatter**: Required metadata
2. **Progress Reporting**: Built into our agents
3. **Anti-Stagnation**: 30-second updates
4. **Structured Output**: Consistent formats

## 🎯 Custom Commands

Create shortcuts in `~/.claude/commands/`:

### Example: Full Stack Feature Command
```markdown
# /fullstack command

Execute complete full-stack feature development:

1. Use docs-researcher for all libraries
2. Use implementation-planner for architecture
3. Use code-implementer for backend
4. Use code-implementer for frontend
5. Run tests and verify

Usage: /fullstack [feature-name]
```

## 🔐 Tool Permissions

Manage what Claude can do:

```bash
# Interactive management
claude
> /permissions

# Or edit ~/.claude.json directly
```

### Recommended Permissions
- ✅ **Always Allow**: Read, Grep, Glob, LS
- ⚠️ **Project Dependent**: Write, Edit, Bash
- 🔴 **Careful**: WebFetch (for security)

## 🚀 Performance Optimization

### 1. Context Management
```bash
# Clear between major tasks
/clear

# Compact for long sessions
/compact
```

### 2. Model Selection Strategy
- **Research**: Haiku (fast, cheap)
- **Planning**: Sonnet (balanced)
- **Implementation**: Opus (precise)

### 3. Verbose Mode
```bash
# Debug agent operations
claude --verbose
```

## 📊 Environment Variables

Set these in your shell profile:

```bash
# API Key (required)
export ANTHROPIC_API_KEY="sk-ant-..."

# Optional configurations
export CLAUDE_MODEL="claude-sonnet-4-20250514"
export CLAUDE_VERBOSE="false"
export CLAUDE_MAX_TOKENS="100000"
```

## 🔄 Workflow Integration

### Git Integration
```bash
# Add to .gitignore
.claude/settings.local.json
.claude/cache/

# Commit these
CLAUDE.md
.claude/commands/
```

### CI/CD Integration
```yaml
# GitHub Actions example
- name: Claude Code Analysis
  run: |
    claude -c "Review code changes and suggest improvements"
```

## 🐛 Debugging Configuration

### Check Configuration
```bash
# Verify setup
claude doctor

# List loaded agents
claude -c "/agents"

# Check permissions
claude -c "/permissions"
```

### Common Issues

1. **Agents Not Loading**
   - Check file permissions: `ls -la ~/.claude/agents/`
   - Verify YAML frontmatter format

2. **Commands Not Working**
   - Ensure `.md` extension
   - Check command syntax

3. **Performance Issues**
   - Clear context: `/clear`
   - Check model selection
   - Use verbose mode

## 🎨 Customization Examples

### Project-Specific Agent
```markdown
---
name: myproject-specialist
description: "Custom agent for MyProject using React and PostgreSQL"
color: green
---

You are a specialist for MyProject...
```

### Workflow Automation
```bash
# Create workflow script
cat > ~/.claude/commands/deploy.md << 'EOF'
# Deploy Workflow

1. Run tests
2. Build production
3. Deploy to staging
4. Run smoke tests
5. Deploy to production

Automated with safety checks.
EOF
```

## 📚 Best Practices

1. **Keep Agents Focused**: < 2k tokens each
2. **Use Progress Indicators**: Users need feedback
3. **Structure Output**: Consistent formatting
4. **Document Everything**: In CLAUDE.md
5. **Version Control**: Track agent changes

## 🔗 Resources

- [Official Docs](https://docs.anthropic.com/claude-code)
- [Community Agents](https://github.com/hesreallyhim/awesome-claude-code-agents)
- [ClaudeLog](https://claudelog.com)
- [Our Repository](https://github.com/irenicj/claude-code-specialized-agents)

---

Remember: The trinity workflow (Research → Plan → Implement) ensures quality at every step!