#!/usr/bin/env bash
# Suggest context optimizations after tool use to prevent context rot
# Triggered after Read, Grep, WebFetch tools

set -euo pipefail

# Hook receives tool name and output size from Claude Code
TOOL_NAME="${1:-unknown}"
TOOL_OUTPUT_SIZE="${2:-0}"

# Configuration
LARGE_OUTPUT_THRESHOLD=1000  # tokens
CONTEXT_ROT_WARNING_THRESHOLD=50  # messages

# Only suggest for large outputs from information-gathering tools
if [[ "$TOOL_NAME" =~ ^(Read|Grep|WebFetch)$ ]]; then
  if [[ $TOOL_OUTPUT_SIZE -gt $LARGE_OUTPUT_THRESHOLD ]]; then
    echo ""
    echo "💡 Context Optimization Suggestion"
    echo "   Tool: $TOOL_NAME retrieved large output ($TOOL_OUTPUT_SIZE tokens)"
    echo ""
    echo "   Consider:"
    echo "   1. Archive important findings to knowledge-core.md"
    echo "   2. Remove stale context no longer relevant to current task"
    echo "   3. Run '/context optimize' to automatically prune"
    echo ""
    echo "   Why: 39% performance improvement, 84% token reduction (Anthropic research)"
    echo ""
  fi
fi

# Check for context rot based on conversation length
# (This would need integration with Claude Code's message counting)
# For now, this is a placeholder for when that API is available
if [[ -f "/tmp/claude-message-count" ]]; then
  MESSAGE_COUNT=$(cat /tmp/claude-message-count 2>/dev/null || echo "0")
  if [[ $MESSAGE_COUNT -gt $CONTEXT_ROT_WARNING_THRESHOLD ]]; then
    echo ""
    echo "⚠️  Context Rot Alert"
    echo "   Conversation has exceeded $MESSAGE_COUNT messages"
    echo ""
    echo "   Recommendation:"
    echo "   1. Review CLAUDE.md for stale information"
    echo "   2. Archive completed work to knowledge-core.md"
    echo "   3. Clear old conversation context if task has changed"
    echo "   4. Run '/context analyze' for detailed report"
    echo ""
    echo "   Impact: Performance degrades by ~30% after 50 messages without curation"
    echo ""
  fi
fi

# Suggest context engineering for specific patterns
case "$TOOL_NAME" in
  Read)
    # Reading multiple files? Suggest consolidation
    if [[ $TOOL_OUTPUT_SIZE -gt 2000 ]]; then
      echo "   Tip: Consider summarizing key points to CLAUDE.md instead of keeping full file contents"
    fi
    ;;

  Grep)
    # Large grep results? Suggest narrowing scope
    if [[ $TOOL_OUTPUT_SIZE -gt 1500 ]]; then
      echo "   Tip: Large search results. Consider narrowing scope or documenting pattern in CLAUDE.md"
    fi
    ;;

  WebFetch)
    # Web research? Always suggest archiving
    echo "   Tip: Archive research findings to knowledge-core.md for future reference"
    ;;
esac

# Always exit successfully (suggestions are non-blocking)
exit 0
