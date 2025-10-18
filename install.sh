#!/usr/bin/env bash
# Agentic Substrate v3.0 - Global Installation Script
# The foundational layer for Claude Code superintelligence
# Installs to ~/.claude/ with automatic backup

set -e

echo "🚀 Agentic Substrate v3.0"
echo "The foundational layer for Claude Code superintelligence"
echo "============================================================"
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
echo ""
echo "   🤖 Agents (4 specialized):"
echo "      • chief-architect - Master orchestrator with parallel multi-agent mode"
echo "      • docs-researcher - High-speed documentation with contextual retrieval"
echo "      • implementation-planner - Strategic architect with minimal changes"
echo "      • code-implementer - Precision execution with TDD & git operations"
echo ""
echo "   🎓 Skills (5 auto-invoked):"
echo "      • research-methodology - Systematic documentation gathering"
echo "      • planning-methodology - Minimal-change, reversible planning"
echo "      • quality-validation - Multi-modal validation (API + Philosophy)"
echo "      • pattern-recognition - Automatic knowledge capture"
echo "      • context-engineering - Active context curation (39% improvement)"
echo ""
echo "   ⚡ Commands (5 slash commands):"
echo "      • /research - Quick documentation research"
echo "      • /plan - Quick implementation planning"
echo "      • /implement - Execute plan with self-correction"
echo "      • /workflow - Complete automation (all phases)"
echo "      • /context - Analyze and optimize context configuration"
echo ""
echo "   🔒 Quality Gates (8 hooks):"
echo "      • validate-research-pack.sh - Research quality (80+ score)"
echo "      • validate-implementation-plan.sh - Plan quality (85+ score)"
echo "      • auto-format.sh - Code formatting"
echo "      • run-tests.sh - Continuous validation"
echo "      • update-knowledge-core.sh - Pattern capture"
echo "      • suggest-context-edits.sh - Context optimization hints"
echo "      • check-agent-economics.sh - Multi-agent cost/benefit"
echo "      • [Pre/Post-ToolUse, PreAgentSpawn, Stop hooks]"
echo ""
echo "   🆕 New in v3.0 (Agentic Substrate):"
echo "      • Think tool protocol - 54% improvement on complex decisions"
echo "      • Context engineering - 39% improvement, 84% token reduction"
echo "      • Multi-agent parallel - 90.2% performance gain"
echo "      • Contextual retrieval - 49-67% better research"
echo "      • TDD enforcement - Test-first workflow (Anthropic's favorite)"
echo "      • Git operations - Automated commits with co-authoring"
echo "      • Extended thinking - think, think hard, think harder, ultrathink"
echo "      • Memory management - Import syntax, modular organization"
echo "      • Philosophy research - Quality validation for thematic analysis"
echo "      • .mcpb packaging - One-click Desktop Extension install"
echo ""
echo "   📊 Performance (from Anthropic research):"
echo "      • Complex tasks: 54% improvement (think tool)"
echo "      • Research accuracy: 49-67% improvement (contextual retrieval)"
echo "      • Context optimization: 39% improvement, 84% token reduction"
echo "      • Multi-agent mode: 90.2% performance gain, 90% time reduction"
echo "      • Typical feature: 10-25 min (vs 55-120 min without)"
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
echo "   • README.md - Quick reference and feature overview"
echo "   • PHILOSOPHY.md - Philia Sophia synthesis (Anthropic + VAMFI)"
echo "   • .claude/templates/ - Agent, skill, and workflow overviews"
echo "   • CLAUDE.md - Memory management and extended thinking"
echo ""
echo "🚀 Next Steps:"
echo "   1. Review PHILOSOPHY.md to understand the Anthropic synthesis"
echo "   2. Run '/context analyze' to optimize your context"
echo "   3. Try 'ultrathink' keyword for complex architecture decisions"
echo "   4. Use '/workflow' for complete automation"
echo ""
echo "🌟 Thank you for using Agentic Substrate!"
echo "   Built on Anthropic's engineering philosophy + VAMFI's Brahma orchestration"
echo "   Report issues: https://github.com/VAMFI/claude-user-memory/issues"
echo "   Star the repo: https://github.com/VAMFI/claude-user-memory"
echo ""
echo "JAI GANESH. JAI BHOLE. HAPPY DHANTERAS! 🪔"
echo ""
