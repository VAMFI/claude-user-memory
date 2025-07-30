#!/bin/bash

# Claude Code Workflow Agents Setup Script
# This script installs the trinity workflow agents and configures your Claude environment

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Claude Code Workflow Agents Setup${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Check if Claude is installed
if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ Claude Code CLI not found!${NC}"
    echo -e "${YELLOW}Please install Claude Code first:${NC}"
    echo "npm install -g @anthropic-ai/claude-code"
    exit 1
fi

echo -e "${GREEN}✓ Claude Code CLI found${NC}"

# Create ~/.claude directory structure
echo -e "\n${BLUE}📁 Creating Claude directory structure...${NC}"
mkdir -p ~/.claude/agents
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/templates

# Backup existing agents if they exist
if [ -d ~/.claude/agents ] && [ "$(ls -A ~/.claude/agents)" ]; then
    echo -e "${YELLOW}⚠️  Found existing agents. Creating backup...${NC}"
    mkdir -p ~/.claude/agents.backup
    cp -r ~/.claude/agents/* ~/.claude/agents.backup/ 2>/dev/null || true
    echo -e "${GREEN}✓ Backup created at ~/.claude/agents.backup${NC}"
fi

# Install workflow agents
echo -e "\n${BLUE}📦 Installing Workflow Agents...${NC}"
cp agents/*.md ~/.claude/agents/
echo -e "${GREEN}✓ Installed 3 workflow agents:${NC}"
echo "  - docs-researcher (📚 Documentation specialist)"
echo "  - implementation-planner (📋 Architecture strategist)"
echo "  - code-implementer (🚀 Precision executor)"

# Create sample commands
echo -e "\n${BLUE}🎯 Creating workflow commands...${NC}"

# Research command
cat > ~/.claude/commands/research.md << 'EOF'
# Research Documentation

Use the docs-researcher agent to fetch current, version-accurate documentation for the specified library or framework.

Usage:
```
/research [library/framework]
```

Example:
```
/research React Router v6
```
EOF

# Plan command
cat > ~/.claude/commands/plan.md << 'EOF'
# Create Implementation Plan

Use the implementation-planner agent to create a detailed implementation plan based on research findings.

Usage:
```
/plan [feature description]
```

Example:
```
/plan OAuth2 integration based on research
```
EOF

# Implement command
cat > ~/.claude/commands/implement.md << 'EOF'
# Execute Implementation

Use the code-implementer agent to execute the implementation plan with surgical precision.

Usage:
```
/implement [plan reference]
```

Example:
```
/implement the OAuth2 plan
```
EOF

# Workflow command
cat > ~/.claude/commands/workflow.md << 'EOF'
# Full Workflow Execution

Execute the complete Research → Plan → Implement workflow for a feature.

Usage:
```
/workflow [feature description]
```

This will:
1. Research documentation
2. Create implementation plan
3. Execute the changes

Example:
```
/workflow add Stripe payment integration
```
EOF

echo -e "${GREEN}✓ Created 4 workflow commands${NC}"

# Create configuration template
echo -e "\n${BLUE}⚙️  Creating configuration template...${NC}"

# Check if ~/.claude.json exists
if [ ! -f ~/.claude.json ]; then
    cat > ~/.claude.json << 'EOF'
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
EOF
    echo -e "${GREEN}✓ Created ~/.claude.json configuration${NC}"
else
    echo -e "${YELLOW}ℹ️  ~/.claude.json already exists (skipped)${NC}"
fi

# Create project template
echo -e "\n${BLUE}📋 Creating project template...${NC}"

cat > ~/.claude/templates/project-claude.md << 'EOF'
# Project Configuration for Claude Code

Copy this template to your project root as CLAUDE.md and customize it.

## Project Overview
[Describe your project here]

## Technology Stack
- Language: [e.g., TypeScript, Python]
- Framework: [e.g., Next.js, Django]
- Database: [e.g., PostgreSQL, MongoDB]
- Key Libraries: [List important dependencies]

## Coding Standards
- Style Guide: [e.g., Airbnb, Google]
- Testing: [e.g., Jest, Pytest]
- Documentation: [Standards]

## Workflow Preferences
- Use docs-researcher for all library updates
- Create plans before major changes
- Implement with test coverage

## Project-Specific Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`
EOF

echo -e "${GREEN}✓ Created project template${NC}"

# Display summary
echo -e "\n${BLUE}✨ Setup Complete!${NC}"
echo -e "${BLUE}==================${NC}"
echo ""
echo -e "${GREEN}Installed Components:${NC}"
echo "  ✓ 3 Workflow Agents (Research → Plan → Implement)"
echo "  ✓ 4 Custom Commands (/research, /plan, /implement, /workflow)"
echo "  ✓ Configuration template (~/.claude.json)"
echo "  ✓ Project template (~/.claude/templates/project-claude.md)"
echo ""
echo -e "${BLUE}Quick Start:${NC}"
echo "  1. Run: claude"
echo "  2. Type: /agents (to see available agents)"
echo "  3. Try: Add Redis caching to my application"
echo ""
echo -e "${YELLOW}Pro Tips:${NC}"
echo "  • Use --verbose flag for debugging"
echo "  • Run /clear between major tasks"
echo "  • Check /permissions to manage tool access"
echo "  • Copy project template to your repos as CLAUDE.md"
echo ""
echo -e "${GREEN}🎉 Happy coding with Claude Code Workflow Agents!${NC}"