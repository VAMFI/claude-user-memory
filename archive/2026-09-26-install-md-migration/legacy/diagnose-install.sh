#!/usr/bin/env bash
# Installation diagnostic script
# Run this to diagnose installation issues

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 Agentic Substrate Installation Diagnostics"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# System info
echo "🖥️  System Information:"
echo "  OS: $(uname -s)"
echo "  Architecture: $(uname -m)"
echo "  Shell: $SHELL"
echo "  Home: $HOME"
echo ""

# Check if .claude exists
echo "📁 Installation Directory:"
if [ -d "$HOME/.claude" ]; then
    echo "  ✅ $HOME/.claude exists"
    echo "  Size: $(du -sh $HOME/.claude 2>/dev/null | cut -f1)"
else
    echo "  ❌ $HOME/.claude does NOT exist"
    echo "  → Installation has not run or failed"
    exit 1
fi
echo ""

# Check version
echo "📋 Version:"
if [ -f "$HOME/.claude/.agentic-substrate-version" ]; then
    VERSION=$(cat "$HOME/.claude/.agentic-substrate-version")
    echo "  ✅ v$VERSION"
else
    echo "  ❌ Version file missing"
    echo "  → Installation may be incomplete"
fi
echo ""

# Count each component
echo "📊 Component Counts:"
echo ""

AGENT_COUNT=$(find "$HOME/.claude/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "  Agents: $AGENT_COUNT/9"
if [ "$AGENT_COUNT" -eq 9 ]; then
    echo "    ✅ All agents present"
else
    echo "    ❌ Missing $((9 - AGENT_COUNT)) agents"
    echo "    Found:"
    find "$HOME/.claude/agents" -name "*.md" 2>/dev/null | xargs -n1 basename | sed 's/^/      - /'
fi
echo ""

SKILL_COUNT=$(find "$HOME/.claude/skills" -name "skill.md" 2>/dev/null | wc -l | tr -d ' ')
echo "  Skills: $SKILL_COUNT/5"
if [ "$SKILL_COUNT" -eq 5 ]; then
    echo "    ✅ All skills present"
else
    echo "    ❌ Missing $((5 - SKILL_COUNT)) skills"
    echo "    Found:"
    ls -d "$HOME/.claude/skills"/*/ 2>/dev/null | xargs -n1 basename | sed 's/^/      - /'
fi
echo ""

COMMAND_COUNT=$(find "$HOME/.claude/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "  Commands: $COMMAND_COUNT/5"
if [ "$COMMAND_COUNT" -eq 5 ]; then
    echo "    ✅ All commands present"
else
    echo "    ❌ Missing $((5 - COMMAND_COUNT)) commands"
    echo "    Found:"
    find "$HOME/.claude/commands" -name "*.md" 2>/dev/null | xargs -n1 basename | sed 's/\.md$//' | sed 's/^/      \/ /'
fi
echo ""

HOOK_COUNT=$(find "$HOME/.claude/hooks" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
echo "  Hooks: $HOOK_COUNT/7"
if [ "$HOOK_COUNT" -lt 7 ]; then
    echo "    ⚠️  Missing $((7 - HOOK_COUNT)) hooks"
fi
echo ""

VALIDATOR_COUNT=$(find "$HOME/.claude/validators" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
echo "  Validators: $VALIDATOR_COUNT/2"
if [ "$VALIDATOR_COUNT" -lt 2 ]; then
    echo "    ⚠️  Missing $((2 - VALIDATOR_COUNT)) validators"
fi
echo ""

METRIC_COUNT=$(find "$HOME/.claude/metrics" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
echo "  Metrics: $METRIC_COUNT/1"
echo ""

TEMPLATE_COUNT=$(find "$HOME/.claude/templates" -type f 2>/dev/null | wc -l | tr -d ' ')
echo "  Templates: $TEMPLATE_COUNT/6"
if [ "$TEMPLATE_COUNT" -lt 6 ]; then
    echo "    ⚠️  Missing $((6 - TEMPLATE_COUNT)) templates"
fi
echo ""

# Check manifest
echo "📜 Installation Manifest:"
if [ -f "$HOME/.claude/.agentic-substrate-manifest.json" ]; then
    echo "  ✅ Present"
    if command -v python3 &> /dev/null; then
        MANIFEST_FILES=$(python3 -c "import json; print(len(json.load(open('$HOME/.claude/.agentic-substrate-manifest.json'))['managed_files']))" 2>/dev/null || echo "?")
        echo "  Files tracked: $MANIFEST_FILES"
    fi
else
    echo "  ❌ Missing"
fi
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
TOTAL=$((AGENT_COUNT + SKILL_COUNT + COMMAND_COUNT + HOOK_COUNT + VALIDATOR_COUNT + METRIC_COUNT + TEMPLATE_COUNT))
echo "📊 Total files: $TOTAL/35"
echo ""

if [ "$TOTAL" -eq 35 ] && [ "$COMMAND_COUNT" -eq 5 ] && [ "$SKILL_COUNT" -eq 5 ]; then
    echo "✅ INSTALLATION COMPLETE"
    echo ""
    echo "All components installed correctly!"
elif [ "$COMMAND_COUNT" -lt 5 ] || [ "$SKILL_COUNT" -lt 5 ]; then
    echo "❌ INSTALLATION INCOMPLETE"
    echo ""
    echo "Problem: Commands and/or Skills are missing"
    echo ""
    echo "Likely causes:"
    echo "  1. Old version of install.sh (before curl fix)"
    echo "  2. Installation was interrupted"
    echo "  3. Permissions issue"
    echo ""
    echo "Solution:"
    echo "  Run installation again with latest version:"
    echo "  curl -fsSL https://raw.githubusercontent.com/VAMFI/claude-user-memory/main/install.sh | bash -s -- --force"
else
    echo "⚠️  INSTALLATION PARTIALLY COMPLETE"
    echo ""
    echo "Some files are missing. Run with --force to reinstall:"
    echo "  curl -fsSL https://raw.githubusercontent.com/VAMFI/claude-user-memory/main/install.sh | bash -s -- --force"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Detailed file listing if requested
if [ "$1" = "--verbose" ] || [ "$1" = "-v" ]; then
    echo "📝 Detailed File Listing:"
    echo ""
    find "$HOME/.claude" -type f 2>/dev/null | grep -v ".DS_Store" | sort | sed 's|'"$HOME/.claude/"'||' | sed 's/^/  /'
    echo ""
fi
