#!/bin/bash

# Claude Code Multi-Agent Framework Setup Script
# This script installs the advanced multi-agent orchestration framework.

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
mkdir -p ~/.claude/agents/specialists

# Backup existing agents if they exist
if [ -d ~/.claude/agents ] && [ "$(ls -A ~/.claude/agents)" ]; then
    BACKUP_DIR=~/.claude/agents.backup-$(date +%Y%m%d-%H%M%S)
    echo -e "${YELLOW}⚠️  Found existing agents. Creating timestamped backup...${NC}"
    mkdir -p "$BACKUP_DIR"
    cp -r ~/.claude/agents/* "$BACKUP_DIR/" 2>/dev/null || true
    echo -e "${GREEN}✓ Backup created at $BACKUP_DIR${NC}"
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

# Display summary
echo -e "\n${BLUE}✨ Setup Complete!${NC}"
echo -e "${BLUE}==================${NC}"
echo ""
echo -e "${GREEN}Installed Components:${NC}"
echo "  ✓ chief-architect (The orchestrator agent)"
echo "  ✓ 12+ Specialist Agents (in ~/.claude/agents/specialists/)"
echo "  ✓ knowledge-core.md (Persistent project memory)"
echo ""
echo -e "${BLUE}Quick Start:${NC}"
echo "  1. Run 'claude-code' in your project directory."
echo "  2. Give the system a complex task, e.g., 'Refactor our auth system to use JWT.'"
echo "  3. The chief-architect will take the lead."
echo ""
echo -e "${YELLOW}Pro Tip:${NC}"
echo "  • For simple tasks, you can still invoke specialists directly."
echo "  • See the README.md for more details on the new workflow."
echo ""
echo -e "${GREEN}🎉 Happy coding with your new Multi-Agent Framework!${NC}"