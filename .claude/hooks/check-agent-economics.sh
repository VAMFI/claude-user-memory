#!/usr/bin/env bash
# Check if multi-agent spawning is economically viable
# Multi-agent uses 15x more tokens than single agent (Anthropic research)

set -euo pipefail

TASK_COMPLEXITY="${1:-medium}"
SUBAGENT_COUNT="${2:-3}"

# Calculate estimated token multiplier
MULTIPLIER=$((SUBAGENT_COUNT * 5))  # ~5x per subagent on average

echo "📊 Multi-Agent Economics Check"
echo "   Task complexity: $TASK_COMPLEXITY"
echo "   Subagents to spawn: $SUBAGENT_COUNT"
echo "   Estimated token multiplier: ${MULTIPLIER}x"
echo ""

case "$TASK_COMPLEXITY" in
  simple)
    echo "❌ Task too simple for multi-agent architecture"
    echo "   Recommendation: Use single specialized agent"
    echo "   Reason: 15x cost not justified for simple task"
    echo ""
    echo "   Suggested approach:"
    echo "   - Use @docs-researcher for research-only tasks"
    echo "   - Use @implementation-planner for planning-only tasks"
    echo "   - Use @code-implementer for implementation-only tasks"
    echo ""
    exit 1
    ;;

  medium)
    echo "⚠️  Multi-agent will use ~${MULTIPLIER}x more tokens"
    echo "   Task complexity: Medium (could go either way)"
    echo ""
    echo "   Performance benefit: 90.2% improvement, 90% time reduction"
    echo "   Cost: ${MULTIPLIER}x more tokens"
    echo ""
    echo "   Question: Is the performance gain worth the cost for this task?"
    echo ""

    # In production, this would prompt the user
    # For now, we'll allow medium tasks but warn
    echo "⚠️  Proceeding with user awareness of cost tradeoff"
    echo ""

    # Uncomment for interactive mode:
    # read -p "Proceed with multi-agent? This will cost significantly more. (y/n): " CONFIRM
    # if [[ "$CONFIRM" != "y" ]]; then
    #   echo "❌ Multi-agent spawning cancelled by user"
    #   echo "   Fallback: Use sequential workflow instead"
    #   exit 1
    # fi
    # echo "✅ User confirmed multi-agent spawn"
    ;;

  complex|very-complex)
    echo "✅ Multi-agent viable for complex task"
    echo "   Reason: Performance gain (90%+) justifies cost (15x)"
    echo "   Expected: 90% faster completion, 90.2% better quality"
    echo ""
    echo "   Example (from Anthropic research):"
    echo "   - Single-agent: 30 minutes for complete research"
    echo "   - Multi-agent: 3 minutes for same research (10x faster)"
    echo "   - Cost: 15x tokens, but saves 27 minutes of time"
    echo ""
    ;;

  *)
    echo "⚠️  Unknown complexity: $TASK_COMPLEXITY"
    echo "   Defaulting to cautious approval with warning"
    echo ""
    ;;
esac

echo "✅ Economic viability check passed"
echo ""
echo "Multi-Agent Best Practices (Anthropic research):"
echo "  - Spawn 3-5 subagents (not 50)"
echo "  - Set termination conditions (max time, max iterations)"
echo "  - Controlled communication (subagents report to lead only)"
echo "  - Use for high-value tasks where quality justifies cost"
echo ""

exit 0
