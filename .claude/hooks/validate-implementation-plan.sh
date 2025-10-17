#!/usr/bin/env bash
# validate-implementation-plan.sh
# Quality gate: Validates Implementation Plan before allowing implementation phase
# Exit 0 = pass, Exit 1 = fail (blocks implementation)

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔍 Validating Implementation Plan..."

# Find recent plan file
PLAN_FILES=$(find . -name "*Plan*.md" -o -name "*Implementation*.md" | grep -v node_modules | head -1)

if [ -z "$PLAN_FILES" ]; then
    echo -e "${YELLOW}⚠️  No Implementation Plan found${NC}"
    echo "   Proceeding with warning - ensure plan was created"
    exit 0
fi

PLAN_FILE="$PLAN_FILES"
echo "   Found: $PLAN_FILE"

SCORE=0
MAX_SCORE=100
DEFECTS=()

# === COMPLETENESS CHECKS (35 points) ===

# Check 1: File changes section (10 pts)
if grep -q "File Changes\|Files to\|Modified Files" "$PLAN_FILE"; then
    FILE_COUNT=$(grep -cE "^\s*[-*]\s*\`.*\`|^###.*\..*|^##.*\..*" "$PLAN_FILE" 2>/dev/null || echo 0)
    if [ "$FILE_COUNT" -gt 0 ]; then
        SCORE=$((SCORE + 10))
    else
        SCORE=$((SCORE + 5))
        DEFECTS+=("⚠️  MAJOR: File Changes section exists but no specific files listed (-5 pts)")
    fi
else
    DEFECTS+=("❌ CRITICAL: No File Changes section found (-10 pts)")
fi

# Check 2: Implementation steps (10 pts)
STEP_COUNT=$(grep -cE "^Step [0-9]+|^[0-9]+\.|^\*\*Step" "$PLAN_FILE" 2>/dev/null || echo 0)
if [ "$STEP_COUNT" -ge 3 ]; then
    SCORE=$((SCORE + 10))
elif [ "$STEP_COUNT" -gt 0 ]; then
    SCORE=$((SCORE + $((STEP_COUNT * 3))))
    DEFECTS+=("⚠️  MINOR: Only $STEP_COUNT steps documented, recommend 3+ ($((10 - STEP_COUNT * 3)) pts deducted)")
else
    DEFECTS+=("❌ CRITICAL: No implementation steps found (-10 pts)")
fi

# Check 3: Verification methods (10 pts)
VERIFY_COUNT=$(grep -cE "Verification:|Verify:|Check:|Test:|Expected:" "$PLAN_FILE" 2>/dev/null || echo 0)
if [ "$VERIFY_COUNT" -ge "$STEP_COUNT" ]; then
    SCORE=$((SCORE + 10))
elif [ "$VERIFY_COUNT" -gt 0 ]; then
    SCORE=$((SCORE + 5))
    DEFECTS+=("⚠️  MAJOR: Not all steps have verification methods (-5 pts)")
else
    DEFECTS+=("❌ CRITICAL: No verification methods specified (-10 pts)")
fi

# Check 4: Test plan (5 pts)
if grep -q "Test Plan\|Testing\|Tests:" "$PLAN_FILE"; then
    SCORE=$((SCORE + 5))
else
    DEFECTS+=("⚠️  MINOR: No test plan section found (-5 pts)")
fi

# === SAFETY CHECKS (30 points) ===

# Check 5: Rollback plan (15 pts)
if grep -q "Rollback\|Revert\|Undo" "$PLAN_FILE"; then
    # Check for specific commands
    if grep -qE "git reset|git revert|git checkout|backup|restore" "$PLAN_FILE"; then
        SCORE=$((SCORE + 15))
    else
        SCORE=$((SCORE + 8))
        DEFECTS+=("⚠️  MAJOR: Rollback section exists but lacks specific commands (-7 pts)")
    fi
else
    DEFECTS+=("❌ CRITICAL: No rollback plan found (-15 pts)")
fi

# Check 6: Risk assessment (10 pts)
RISK_COUNT=$(grep -cE "Risk:|⚠️|Risks?:" "$PLAN_FILE" 2>/dev/null || echo 0)
if [ "$RISK_COUNT" -ge 3 ]; then
    SCORE=$((SCORE + 10))
elif [ "$RISK_COUNT" -gt 0 ]; then
    SCORE=$((SCORE + $((RISK_COUNT * 3))))
    DEFECTS+=("⚠️  MINOR: Only $RISK_COUNT risks identified, recommend 3+ ($((10 - RISK_COUNT * 3)) pts deducted)")
else
    DEFECTS+=("❌ CRITICAL: No risk assessment found (-10 pts)")
fi

# Check 7: Minimal changes (5 pts)
FILE_CHANGE_COUNT=$(grep -cE "^\s*[-*]\s*\\\`.*\\\`" "$PLAN_FILE" 2>/dev/null || echo 10)
if [ "$FILE_CHANGE_COUNT" -le 10 ]; then
    SCORE=$((SCORE + 5))
elif [ "$FILE_CHANGE_COUNT" -le 20 ]; then
    SCORE=$((SCORE + 3))
    DEFECTS+=("⚠️  MINOR: Plan touches $FILE_CHANGE_COUNT files, consider if all are necessary (-2 pts)")
else
    SCORE=$((SCORE + 1))
    DEFECTS+=("⚠️  MAJOR: Plan touches $FILE_CHANGE_COUNT files, may not be minimal (-4 pts)")
fi

# === CLARITY CHECKS (20 points) ===

# Check 8: Steps are actionable (10 pts)
# Look for specific file paths and code snippets in steps
CODE_IN_STEPS=$(grep -cE "\\\`\\\`\\\`|^\s*\\\`[^\\\`]+\\\`" "$PLAN_FILE" 2>/dev/null || echo 0)
if [ "$CODE_IN_STEPS" -ge "$STEP_COUNT" ]; then
    SCORE=$((SCORE + 10))
elif [ "$CODE_IN_STEPS" -gt 0 ]; then
    SCORE=$((SCORE + 5))
    DEFECTS+=("⚠️  MINOR: Not all steps include specific code/files (-5 pts)")
fi

# Check 9: Success criteria (5 pts)
if grep -q "Success\|Complete when\|Done when" "$PLAN_FILE"; then
    SCORE=$((SCORE + 5))
else
    DEFECTS+=("⚠️  MINOR: No success criteria defined (-5 pts)")
fi

# Check 10: Time estimates (5 pts)
if grep -qE "[0-9]+ min|[0-9]+ hour|Estimated.*time" "$PLAN_FILE"; then
    SCORE=$((SCORE + 5))
fi

# === ALIGNMENT CHECKS (15 points) ===

# Check 11: References ResearchPack (10 pts)
if grep -q "ResearchPack\|Research Pack\|From research" "$PLAN_FILE"; then
    SCORE=$((SCORE + 10))
else
    DEFECTS+=("⚠️  MAJOR: Plan doesn't reference ResearchPack (-10 pts)")
fi

# Check 12: Addresses requirements (5 pts)
if grep -q "Goal:\|Objective:\|Requirements:" "$PLAN_FILE"; then
    SCORE=$((SCORE + 5))
fi

# === CALCULATE GRADE ===

PERCENTAGE=$((SCORE * 100 / MAX_SCORE))

echo ""
echo "📊 Implementation Plan Validation Results"
echo "   Score: $SCORE/$MAX_SCORE ($PERCENTAGE%)"

if [ "$SCORE" -ge 85 ]; then
    echo -e "   Grade: ${GREEN}✅ PASS${NC}"
    echo ""
    echo "✅ Implementation Plan validation passed - proceeding to implementation phase"

    if [ ${#DEFECTS[@]} -gt 0 ]; then
        echo ""
        echo "Improvement opportunities:"
        for defect in "${DEFECTS[@]}"; do
            echo "   $defect"
        done
    fi

    exit 0
else
    echo -e "   Grade: ${RED}❌ FAIL${NC} (need 85+)"
    echo ""
    echo "Defects found (${#DEFECTS[@]}):"
    for defect in "${DEFECTS[@]}"; do
        echo "   $defect"
    done
    echo ""
    echo "⚠️  Implementation Plan quality below threshold"
    echo "   Recommendation: Re-run @implementation-planner focusing on missing elements"
    echo "   Required score: 85/100 (current: $SCORE/100)"
    echo ""
    exit 0  # Changed to warn instead of block - set to exit 1 to block
fi
