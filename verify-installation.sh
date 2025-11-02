#!/usr/bin/env bash
# Comprehensive installation verification script
# Run this after installation to verify all components are present

set -e

CLAUDE_DIR="$HOME/.claude"
FAIL_COUNT=0

function check_pass() { echo "  ✅ $1"; }
function check_fail() { echo "  ❌ $1"; ((FAIL_COUNT++)); }
function check_info() { echo "  ℹ️  $1"; }

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 Agentic Substrate Installation Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if .claude exists
echo "📁 Checking installation directory..."
if [ -d "$CLAUDE_DIR" ]; then
    check_pass "Installation directory found: $CLAUDE_DIR"
else
    check_fail "Installation directory not found: $CLAUDE_DIR"
    exit 1
fi
echo ""

# Check version file
echo "📋 Checking version..."
if [ -f "$CLAUDE_DIR/.agentic-substrate-version" ]; then
    VERSION=$(cat "$CLAUDE_DIR/.agentic-substrate-version")
    check_pass "Version file found: v$VERSION"
else
    check_fail "Version file not found"
fi
echo ""

# Check agents
echo "🤖 Checking agents..."
AGENT_COUNT=$(find "$CLAUDE_DIR/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$AGENT_COUNT" -eq 9 ]; then
    check_pass "All 9 agents installed"
    check_info "$(ls $CLAUDE_DIR/agents/*.md | xargs -n1 basename | sed 's/^/    - /')"
else
    check_fail "Expected 9 agents, found $AGENT_COUNT"
fi
echo ""

# Check skills
echo "🧠 Checking skills..."
SKILL_COUNT=$(find "$CLAUDE_DIR/skills" -name "skill.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$SKILL_COUNT" -eq 5 ]; then
    check_pass "All 5 skills installed"
    check_info "$(ls -d $CLAUDE_DIR/skills/*/ | xargs -n1 basename | sed 's/^/    - /')"
else
    check_fail "Expected 5 skills, found $SKILL_COUNT"
fi
echo ""

# Check commands
echo "⚡ Checking commands..."
COMMAND_COUNT=$(find "$CLAUDE_DIR/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$COMMAND_COUNT" -eq 5 ]; then
    check_pass "All 5 commands installed"
    check_info "$(ls $CLAUDE_DIR/commands/*.md | xargs -n1 basename | sed 's/\.md$//' | sed 's/^/    \/ /')"
else
    check_fail "Expected 5 commands, found $COMMAND_COUNT"
fi
echo ""

# Check hooks
echo "🔗 Checking hooks..."
HOOK_COUNT=$(find "$CLAUDE_DIR/hooks" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
if [ "$HOOK_COUNT" -eq 7 ]; then
    check_pass "All 7 hooks installed"
    # Check if executable
    NON_EXEC=$(find "$CLAUDE_DIR/hooks" -name "*.sh" ! -perm -111 2>/dev/null | wc -l | tr -d ' ')
    if [ "$NON_EXEC" -eq 0 ]; then
        check_pass "All hooks are executable"
    else
        check_fail "$NON_EXEC hooks are not executable"
    fi
else
    check_fail "Expected 7 hooks, found $HOOK_COUNT"
fi
echo ""

# Check validators
echo "✔️  Checking validators..."
VALIDATOR_COUNT=$(find "$CLAUDE_DIR/validators" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
if [ "$VALIDATOR_COUNT" -eq 2 ]; then
    check_pass "All 2 validators installed"
    # Check if executable
    NON_EXEC=$(find "$CLAUDE_DIR/validators" -name "*.sh" ! -perm -111 2>/dev/null | wc -l | tr -d ' ')
    if [ "$NON_EXEC" -eq 0 ]; then
        check_pass "All validators are executable"
    else
        check_fail "$NON_EXEC validators are not executable"
    fi
else
    check_fail "Expected 2 validators, found $VALIDATOR_COUNT"
fi
echo ""

# Check metrics
echo "📊 Checking metrics..."
METRIC_COUNT=$(find "$CLAUDE_DIR/metrics" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
if [ "$METRIC_COUNT" -eq 1 ]; then
    check_pass "Metrics tracker installed"
else
    check_fail "Expected 1 metric tracker, found $METRIC_COUNT"
fi
echo ""

# Check templates
echo "📝 Checking templates..."
TEMPLATE_COUNT=$(find "$CLAUDE_DIR/templates" -type f 2>/dev/null | wc -l | tr -d ' ')
if [ "$TEMPLATE_COUNT" -eq 6 ]; then
    check_pass "All 6 templates installed"
else
    check_fail "Expected 6 templates, found $TEMPLATE_COUNT"
    check_info "Found: $(find $CLAUDE_DIR/templates -type f | xargs -n1 basename | sed 's/^/    - /')"
fi
echo ""

# Check CLAUDE.md
echo "📖 Checking CLAUDE.md..."
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    SIZE=$(wc -c < "$CLAUDE_DIR/CLAUDE.md" | tr -d ' ')
    check_pass "CLAUDE.md installed ($SIZE bytes)"
else
    check_fail "CLAUDE.md not found"
fi
echo ""

# Check manifest
echo "📜 Checking manifest..."
if [ -f "$CLAUDE_DIR/.agentic-substrate-manifest.json" ]; then
    check_pass "Installation manifest found"
else
    check_fail "Installation manifest not found"
fi
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ "$FAIL_COUNT" -eq 0 ]; then
    echo "✅ ALL CHECKS PASSED"
    echo ""
    echo "Your Agentic Substrate installation is complete and healthy!"
    echo ""
    echo "🚀 Quick Start:"
    echo "  1. Start Claude Code CLI"
    echo "  2. Try: /workflow Add feature X"
    echo "  3. Or: /research → /plan → /implement"
else
    echo "❌ $FAIL_COUNT CHECKS FAILED"
    echo ""
    echo "Some components are missing. Please reinstall:"
    echo "  curl -fsSL https://raw.githubusercontent.com/VAMFI/claude-user-memory/main/install.sh | bash -s -- --force"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

exit $FAIL_COUNT
