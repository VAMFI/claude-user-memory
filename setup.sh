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

# Install the new multi-agent framework
echo -e "\n${BLUE}📦 Installing Multi-Agent Framework...${NC}"

# Copy the chief-architect orchestrator
cp agents/chief-architect.md ~/.claude/agents/

# Create the specialists directory and copy all specialist agents
mkdir -p ~/.claude/agents/specialists
cp agents/specialists/*.md ~/.claude/agents/specialists/

# Also copy the knowledge-core file
cp knowledge-core.md ~/.claude/

echo -e "${GREEN}✓ Installation complete!${NC}"
echo "  - Installed chief-architect orchestrator"
echo "  - Installed 12+ specialist agents into ~/.claude/agents/specialists/"
echo "  - Installed knowledge-core.md into ~/.claude/"

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