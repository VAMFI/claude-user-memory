# Claude Code CLI - Quick Reference Guide
**Last Updated**: 2025-10-17
**Version**: 2.0.20

---

## What's New (October 2025)

### Latest Features
- **Skills System** (v2.0.20) - NEW! Model-invoked modular capabilities
- **Haiku 4.5** (v2.0.17) - Auto-switching for plan/execute modes
- **Explore Subagent** (v2.0.17) - Efficient codebase searching
- **Plugin System** (v2.0.12) - Custom commands, agents, hooks, MCP servers
- **PreToolUse Hook Modification** (v2.0.10) - Hooks can modify tool inputs

---

## Essential Commands

### Core Workflow
```bash
claude                    # Start Claude Code
/help                    # List all commands
/init                    # Initialize project with CLAUDE.md
/status                  # Check version, model, connectivity
```

### Session Management
```bash
/clear                   # Clear history (saves 50-70% tokens)
/compact [focus]         # Compact conversation
Esc + Esc               # Rewind to previous state
/rewind                  # Same as Esc+Esc
```

### Configuration
```bash
/config                  # Open settings
/model                   # Switch Claude models
/memory                  # Edit CLAUDE.md files
/permissions             # Manage tool permissions
```

### Token & Cost
```bash
/cost                    # Show token usage
/usage                   # Show plan limits, rate limits
```

### Mode Switching
```bash
Shift+Tab (twice)        # Enter Plan Mode (read-only)
Shift+Tab                # Return to Execution Mode
```

### Advanced Features
```bash
/agents                  # Manage subagents
/plugin                  # Plugin browser
/mcp                     # MCP server management
/vim                     # Vim mode
Ctrl+G                   # Edit prompt in system editor
Ctrl+R                   # Search prompt history
Ctrl+B                   # Background bash command
```

---

## File Structure

### Essential Directories
```
project/
├── .claude/
│   ├── CLAUDE.md              # Project memory (team-shared)
│   ├── settings.json          # Configuration
│   ├── agents/                # Project-specific agents
│   ├── skills/                # Project-specific skills
│   ├── commands/              # Custom slash commands
│   └── hooks/                 # Event automation
├── CLAUDE.md                  # Alternative location for project memory
└── CLAUDE.local.md            # Local memory (gitignored) [DEPRECATED]

~/.claude/
├── CLAUDE.md                  # User memory (all projects)
├── agents/                    # Personal agents
├── skills/                    # Personal skills
└── commands/                  # Personal commands
```

---

## Memory System (CLAUDE.md)

### Priority Order (Highest to Lowest)
1. Enterprise Policy (`/Library/Application Support/ClaudeCode/CLAUDE.md`)
2. Project Memory (`./CLAUDE.md` or `./.claude/CLAUDE.md`)
3. User Memory (`~/.claude/CLAUDE.md`)
4. Local Project Memory (`./CLAUDE.local.md`) [DEPRECATED]

### Best Practices
- Keep lean (loaded every session)
- Be specific ("Use 2-space indentation")
- Use markdown headings and bullets
- Put ad-hoc docs in `docs/` and reference via `@docs/filename.md`
- Quick add: Start input with `#`

### Imports
```markdown
@path/to/import          # Relative or absolute
@~/.claude/standards.md  # User standards
@docs/architecture.md    # Project docs
```
Maximum recursion: 5 hops

---

## Agent System

### Built-in Subagents
- **Explore** (v2.0.17+): Haiku-powered codebase search

### Storage Locations
- **User**: `~/.claude/agents/` (all projects)
- **Project**: `.claude/agents/` (team-shared)
- **Conflict**: Project takes precedence

### Invocation
```bash
@agent-name Task description
```

### Performance
- 72.5% on SWE-bench
- 10x parallel execution
- 90.2% improvement (multi-agent vs single)

---

## Skills System (NEW - Oct 16, 2025)

### What Are Skills?
Model-invoked modular capabilities (Claude decides when to use)

### Structure
```yaml
# SKILL.md
---
name: Your Skill Name
description: When and how to use this skill
allowed-tools: [Read, Grep]  # Optional: restrict tools
---

# Skill content
```

### Storage
- Personal: `~/.claude/skills/`
- Project: `.claude/skills/`
- Plugin: Bundled with plugins

### Discovery
Automatic - Claude matches request to description

---

## Hooks System

### Hook Types
- **PreToolUse**: Before tool calls (can block/modify)
- **PostToolUse**: After tool completion
- **UserPromptSubmit**: Before processing prompts
- **Notification**: On notifications
- **Stop**: When Claude finishes
- **SubagentStop**: When subagent completes
- **PreCompact**: Before compacting
- **SessionStart**: Session begins
- **SessionEnd**: Session ends

### Common Uses
```yaml
# .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "prettier --write {{file}}"
      }
    ],
    "PreToolUse": [
      {
        "matcher": "*",
        "command": "check-permissions.sh {{tool}}"
      }
    ]
  }
}
```

---

## Plugin System

### Install & Manage
```bash
/plugin                                    # Interactive browser
/plugin marketplace add user/repo          # Add marketplace
/plugin install name@marketplace           # Install plugin
/plugin enable/disable name                # Toggle
/plugin validate                           # Check structure
```

### Plugin Components
1. Sub-agents
2. MCP Servers
3. Hooks
4. Slash Commands

### Create Plugin
```
my-plugin/
├── .claude-plugin/plugin.json    # Metadata
├── commands/                      # Slash commands
├── agents/                        # Agents
├── skills/                        # Skills
└── hooks/                         # Hooks
```

---

## Model Context Protocol (MCP)

### Setup
```bash
claude mcp add-from-claude-desktop    # Import from Desktop
/mcp                                   # Manage servers
@mcp-server-name                       # Enable/disable
```

### Common Integrations
- GitHub, JIRA, Sentry, Statsig
- PostgreSQL, MongoDB
- Figma, Slack, Gmail
- Stripe, Cloudflare, Supabase

### Output Limit
- Warning at 10,000 tokens
- Configurable: `MAX_MCP_OUTPUT_TOKENS=25000`

---

## Operating Modes

### Plan Mode (Shift+Tab twice)
- **Read-only**: Cannot modify files
- **Research**: Analyze codebase
- **Planning**: Create comprehensive plans
- **Approval**: Present plans before execution

### Thinking Mode
- **Trigger**: "think hard", "ultrathink", "deep think"
- **Extended Reasoning**: Deeper problem-solving
- **Complex Problems**: Enhanced analysis

### Execution Mode (Default)
- **Full Tools**: All capabilities enabled
- **File Operations**: Create, modify, delete
- **Command Execution**: Run bash commands

---

## Token Optimization

### Core Strategies
1. `/clear` between unrelated tasks (50-70% reduction)
2. Good CLAUDE.md configuration
3. `/compact` for long sessions
4. Reset context every 20 iterations

### Model Selection
- **Claude Opus 4.1**: Planning, architecture, final review
- **Claude Sonnet 4.5**: Main implementation (default)
- **Claude Haiku 4.5**: Syntax, linting, quick checks

### File Management
- Keep files lean and focused
- Explicit file access (avoid auto-discovery)
- Use CLAUDE.md to specify allowed/forbidden dirs
- Break large files into smaller ones

### Large Codebases
- Create ~5K token spec of key components
- Focus on one directory at a time
- Explicit context over exploration

---

## GitHub Actions

### Quick Setup
```bash
/install-github-app
```

### Use Cases
- Automated PR reviews (@claude mention)
- Feature implementation from issues
- CI/CD failure fixes
- Release note generation
- Documentation automation

### Configuration
```yaml
# .github/workflows/claude.yml
- uses: anthropics/claude-code-action@v1
  with:
    anthropic-api-key: ${{ secrets.ANTHROPIC_API_KEY }}
```

---

## Enterprise Deployment

### Platforms
- **Anthropic API**: Direct access
- **Amazon Bedrock**: AWS infrastructure, IAM auth
- **Google Vertex AI**: GCP infrastructure

### Bedrock Setup
```bash
export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION=us-east-1
```

### Features
- No training use (Enterprise/Team)
- Complete audit logs
- Contract-based usage
- Managed permissions
- Corporate proxy support

---

## Built-in Tools

| Tool | Purpose |
|------|---------|
| Bash | Execute shell commands |
| Read | Read files (2000 lines default) |
| Write | Create/overwrite files |
| Edit | Modify existing files |
| MultiEdit | Batch modifications |
| Grep | Search using ripgrep |
| Glob | File pattern matching |
| LS | Directory listing |
| NotebookRead/Edit | Jupyter notebooks |
| WebFetch | Fetch web content |
| WebSearch | Search the web |
| TodoRead/Write | Task management |

---

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| Shift+Tab | Cycle modes (Plan ↔ Execution) |
| Esc + Esc | Rewind to previous state |
| Ctrl+G | Edit prompt in system editor |
| Ctrl+R | Search prompt history |
| Ctrl+B | Background bash command |
| Shift+Enter | Newline (after `/terminal-setup`) |

---

## Troubleshooting

### Performance Issues
```bash
/doctor                  # Health check
/clear                   # Reset context
/compact                 # Compact history
/cost                    # Check token usage
```

### Session Issues
```bash
/login                   # Switch account
/logout                  # Sign out
/status                  # Check connectivity
```

### Installation Issues
```bash
npm install -g @anthropic-ai/claude-code@latest
/doctor                  # Verify installation
```

---

## Best Practices

### Do
- Use `/clear` frequently
- Keep CLAUDE.md specific and lean
- Use Plan Mode before implementing
- Monitor token usage with `/cost`
- Create reusable commands in `.claude/commands/`
- Use Skills for model-invoked capabilities
- Leverage hooks for automation
- Choose appropriate model per task

### Don't
- Let context grow indefinitely (reset every 20 iterations)
- Put everything in CLAUDE.md (use `docs/` for ad-hoc)
- Over-explore codebases (be explicit)
- Use expensive models for simple tasks
- Ignore `/doctor` warnings
- Skip Plan Mode for complex changes

---

## Quick Feature Matrix

| Feature | Available | Version | Type |
|---------|-----------|---------|------|
| Checkpoint/Rewind | ✅ | v2.0.0+ | Built-in |
| Subagents | ✅ | v2.0.0+ | Built-in |
| Hooks | ✅ | v2.0.0+ | Built-in |
| Plugins | ✅ | v2.0.12+ | Beta |
| Skills | ✅ | v2.0.20+ | New |
| MCP | ✅ | v2.0.0+ | Built-in |
| Plan Mode | ✅ | v2.0.0+ | Built-in |
| VS Code Extension | ✅ | v2.0.0+ | Beta |
| GitHub Actions | ✅ | v2.0.0+ | Official |
| Bedrock/Vertex | ✅ | All | Enterprise |

---

## Resources

### Official Documentation
- Main: https://docs.claude.com/en/docs/claude-code/overview
- Changelog: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- Best Practices: https://www.anthropic.com/engineering/claude-code-best-practices

### Community
- ClaudeLog: https://claudelog.com
- ClaudeCode.io: https://claudecode.io
- MCP Community: https://claudemcp.com

### GitHub
- Main Repo: https://github.com/anthropics/claude-code
- GitHub Action: https://github.com/anthropics/claude-code-action

---

**Version**: Claude Code 2.0.20
**Last Updated**: October 17, 2025
**Node.js Requirement**: 18+
**Installation**: `npm install -g @anthropic-ai/claude-code`
