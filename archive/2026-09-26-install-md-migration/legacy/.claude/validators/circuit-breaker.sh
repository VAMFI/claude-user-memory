#!/usr/bin/env bash
# circuit-breaker.sh
# Prevents infinite retry loops by tracking consecutive failures
# Opens circuit after 3 consecutive failures, requires manual reset

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

CIRCUIT_FILE=".claude/.circuit-breaker-state"
AGENT_NAME="$1"
MAX_FAILURES=3

# Create circuit breaker file if doesn't exist
if [ ! -f "$CIRCUIT_FILE" ]; then
    echo "{}" > "$CIRCUIT_FILE"
fi

# Function to get failure count for agent
get_failure_count() {
    local agent="$1"
    local count=$(grep "\"$agent\":" "$CIRCUIT_FILE" 2>/dev/null | grep -oE '[0-9]+' | tail -1)
    echo "${count:-0}"
}

# Function to increment failure count
increment_failure() {
    local agent="$1"
    local current=$(get_failure_count "$agent")
    local new_count=$((current + 1))

    # Update or add entry
    if grep -q "\"$agent\":" "$CIRCUIT_FILE"; then
        sed -i.bak "s/\"$agent\": [0-9]*/\"$agent\": $new_count/" "$CIRCUIT_FILE"
    else
        # Add new entry
        sed -i.bak "s/}/  \"$agent\": $new_count\n}/" "$CIRCUIT_FILE"
    fi
}

# Function to reset circuit
reset_circuit() {
    local agent="$1"
    if grep -q "\"$agent\":" "$CIRCUIT_FILE"; then
        sed -i.bak "s/\"$agent\": [0-9]*/\"$agent\": 0/" "$CIRCUIT_FILE"
    fi
}

# Function to check if circuit is open
is_circuit_open() {
    local agent="$1"
    local count=$(get_failure_count "$agent")
    count=${count:-0}  # Default to 0 if empty
    [ "$count" -ge "$MAX_FAILURES" ]
}

# Main logic
case "$2" in
    "check")
        if is_circuit_open "$AGENT_NAME"; then
            echo -e "${RED}🚫 CIRCUIT BREAKER OPEN${NC}"
            echo ""
            echo "Agent: $AGENT_NAME"
            echo "Status: BLOCKED (too many consecutive failures)"
            echo "Failure count: $(get_failure_count "$AGENT_NAME")/$MAX_FAILURES"
            echo ""
            echo "This prevents infinite retry loops."
            echo ""
            echo "To reset:"
            echo "  .claude/validators/circuit-breaker.sh $AGENT_NAME reset"
            echo ""
            echo "Before resetting, investigate why failures are occurring:"
            echo "  1. Check error messages from previous runs"
            echo "  2. Verify ResearchPack and Plan quality"
            echo "  3. Ensure all prerequisites are met"
            echo "  4. Consider if task is actually feasible"
            echo ""
            exit 1
        else
            echo -e "${GREEN}✅ Circuit OK${NC}"
            echo "Agent: $AGENT_NAME"
            echo "Failures: $(get_failure_count "$AGENT_NAME")/$MAX_FAILURES"
            exit 0
        fi
        ;;

    "fail")
        increment_failure "$AGENT_NAME"
        NEW_COUNT=$(get_failure_count "$AGENT_NAME")

        echo -e "${YELLOW}⚠️  Failure recorded${NC}"
        echo "Agent: $AGENT_NAME"
        echo "Failure count: $NEW_COUNT/$MAX_FAILURES"

        if [ "$NEW_COUNT" -ge "$MAX_FAILURES" ]; then
            echo ""
            echo -e "${RED}🚫 CIRCUIT BREAKER OPENED${NC}"
            echo ""
            echo "Agent has failed $MAX_FAILURES times consecutively."
            echo "Blocking further attempts to prevent infinite loops."
            echo ""
            echo "Reset with: .claude/validators/circuit-breaker.sh $AGENT_NAME reset"
            exit 1
        else
            REMAINING=$((MAX_FAILURES - NEW_COUNT))
            echo "Remaining attempts: $REMAINING"
            exit 0
        fi
        ;;

    "success")
        reset_circuit "$AGENT_NAME"
        echo -e "${GREEN}✅ Success recorded - circuit reset${NC}"
        echo "Agent: $AGENT_NAME"
        echo "Failure count: 0/$MAX_FAILURES"
        exit 0
        ;;

    "reset")
        reset_circuit "$AGENT_NAME"
        echo -e "${GREEN}✅ Circuit breaker reset${NC}"
        echo "Agent: $AGENT_NAME"
        echo "Failure count: 0/$MAX_FAILURES"
        echo ""
        echo "You can now retry the operation."
        exit 0
        ;;

    "status")
        COUNT=$(get_failure_count "$AGENT_NAME")
        if is_circuit_open "$AGENT_NAME"; then
            echo -e "${RED}Status: OPEN (blocked)${NC}"
        else
            echo -e "${GREEN}Status: CLOSED (operational)${NC}"
        fi
        echo "Agent: $AGENT_NAME"
        echo "Failures: $COUNT/$MAX_FAILURES"
        exit 0
        ;;

    *)
        echo "Usage: $0 <agent-name> <check|fail|success|reset|status>"
        echo ""
        echo "Commands:"
        echo "  check   - Check if circuit is open (blocks if >= 3 failures)"
        echo "  fail    - Record a failure (opens circuit after 3)"
        echo "  success - Record a success (resets failure count)"
        echo "  reset   - Manually reset circuit breaker"
        echo "  status  - Show current circuit status"
        echo ""
        echo "Example:"
        echo "  $0 code-implementer check   # Before running agent"
        echo "  $0 code-implementer fail    # After agent fails"
        echo "  $0 code-implementer success # After agent succeeds"
        echo "  $0 code-implementer reset   # Manual reset"
        exit 1
        ;;
esac
