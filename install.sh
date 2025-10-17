#!/usr/bin/env bash
# Claude User Memory - Global Installation Script
# Installs to ~/.claude/ with automatic backup

set -e

echo "🚀 Claude User Memory - Advanced Workflow System"
echo "=================================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLAUDE_SOURCE="$SCRIPT_DIR/.claude"
CLAUDE_TARGET="$HOME/.claude"

# Check if source .claude directory exists
if [ ! -d "$CLAUDE_SOURCE" ]; then
    echo "❌ Error: .claude directory not found in $SCRIPT_DIR"
    echo "   Make sure you're running this script from the repository root."
    exit 1
fi

# Backup existing .claude if it exists
if [ -d "$CLAUDE_TARGET" ]; then
    BACKUP_DIR="$HOME/.claude.backup-$(date +%Y%m%d-%H%M%S)"
    echo "📦 Existing .claude found - creating backup..."
    echo "   Backing up to: $BACKUP_DIR"
    cp -r "$CLAUDE_TARGET" "$BACKUP_DIR"
    echo "   ✅ Backup complete!"
    echo ""
fi

# Install to home directory
echo "📋 Installing workflow system to $CLAUDE_TARGET..."
# Remove existing directory if it exists (already backed up)
rm -rf "$CLAUDE_TARGET"
# Create target directory
mkdir -p "$CLAUDE_TARGET"
# Copy contents of .claude to ~/.claude
cp -r "$CLAUDE_SOURCE"/* "$CLAUDE_TARGET"/
echo "   ✅ Files copied!"
echo ""

# Make hooks executable
echo "🔧 Making hooks and validators executable..."
chmod +x "$CLAUDE_TARGET/hooks"/*.sh 2>/dev/null || true
chmod +x "$CLAUDE_TARGET/validators"/*.sh 2>/dev/null || true
chmod +x "$CLAUDE_TARGET/metrics"/*.sh 2>/dev/null || true
echo "   ✅ Permissions set!"
echo ""

# Success message
echo "✅ Installation complete!"
echo ""
echo "📚 What was installed:"
echo "   • 4 Specialized Agents (chief-architect, docs-researcher, implementation-planner, code-implementer)"
echo "   • 4 Auto-Applied Skills (research, planning, validation, pattern recognition)"
echo "   • 5 Quality Gates (hooks for workflow enforcement)"
echo "   • 2 Enhanced Validators (API matcher, circuit breaker)"
echo "   • 4 Slash Commands (/research, /plan, /implement, /workflow)"
echo ""
echo "🎯 Quick Start:"
echo "   1. Start Claude Code CLI"
echo "   2. Try: /workflow Add weather API integration"
echo "   3. Or step-by-step: /research → /plan → /implement"
echo ""

if [ -n "$BACKUP_DIR" ]; then
    echo "💾 Restore Previous Configuration:"
    echo "   If you want to restore your previous setup:"
    echo "   rm -rf ~/.claude && mv $BACKUP_DIR ~/.claude"
    echo ""
fi

echo "📖 Documentation:"
echo "   • README.md - Quick reference and examples"
echo "   • TROUBLESHOOTING.md - Solutions for common issues"
echo "   • examples/v2/ - Complete workflow examples"
echo ""
echo "🌟 Thank you for using Claude User Memory!"
echo "   Report issues: https://github.com/VAMFI/claude-user-memory/issues"
echo ""
