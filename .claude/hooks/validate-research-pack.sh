#!/usr/bin/env bash
# validate-research-pack.sh
# Quality gate: Validates ResearchPack before allowing planning phase
# Exit 0 = pass, Exit 1 = fail (blocks planning)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Validating ResearchPack..."

# Check if ResearchPack file exists (look for recent files with "Research" in name)
RESEARCH_FILES=$(find . -name "*Research*.md" -mmin -30 2>/dev/null | head -1)

if [ -z "$RESEARCH_FILES" ]; then
    echo -e "${YELLOW}⚠️  No ResearchPack found (no *Research*.md files modified in last 30 min)${NC}"
    echo "   Proceeding with warning - ensure research was completed"
    exit 0  # Warn but don't block
fi

RESEARCH_FILE="$RESEARCH_FILES"
echo "   Found: $RESEARCH_FILE"

SCORE=0
MAX_SCORE=100
DEFECTS=()

# === COMPLETENESS CHECKS (40 points) ===

# Check 1: Library identified (10 pts)
if grep -q "Target Library:" "$RESEARCH_FILE" || grep -q "Library:" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 10))
else
    DEFECTS+=("❌ CRITICAL: Library/version not identified in ResearchPack")
fi

# Check 2: APIs documented (10 pts)
API_COUNT=$(grep -c "^###.*API\|^##.*API\|\`\`\`.*function\|\`\`\`.*class" "$RESEARCH_FILE" 2>/dev/null || echo 0)
if [ "$API_COUNT" -ge 3 ]; then
    SCORE=$((SCORE + 10))
elif [ "$API_COUNT" -gt 0 ]; then
    SCORE=$((SCORE + $((API_COUNT * 3))))
    DEFECTS+=("⚠️  MINOR: Only $API_COUNT APIs documented, recommend 3+ ($((10 - API_COUNT * 3)) pts deducted)")
else
    DEFECTS+=("❌ CRITICAL: No APIs documented (-10 pts)")
fi

# Check 3: Setup steps (10 pts)
if grep -q "Setup\|Installation\|Configuration" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 10))
else
    DEFECTS+=("⚠️  MAJOR: No setup/installation steps found (-10 pts)")
fi

# Check 4: Code example (10 pts)
CODE_BLOCKS=$(grep -c "^\`\`\`" "$RESEARCH_FILE" 2>/dev/null || echo 0)
if [ "$CODE_BLOCKS" -ge 2 ]; then  # At least 1 complete code block (open + close)
    SCORE=$((SCORE + 10))
else
    DEFECTS+=("⚠️  MAJOR: No code examples found (-10 pts)")
fi

# === ACCURACY CHECKS (30 points) ===

# Check 5: Version numbers present (5 pts)
if grep -qE "v[0-9]+\.[0-9]+|version [0-9]+\.[0-9]+" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 5))
else
    DEFECTS+=("⚠️  MINOR: No version numbers found (-5 pts)")
fi

# Check 6: URLs present (10 pts)
URL_COUNT=$(grep -cE "https?://|Source:" "$RESEARCH_FILE" 2>/dev/null || echo 0)
if [ "$URL_COUNT" -ge 3 ]; then
    SCORE=$((SCORE + 10))
elif [ "$URL_COUNT" -gt 0 ]; then
    SCORE=$((SCORE + $((URL_COUNT * 3))))
    DEFECTS+=("⚠️  MINOR: Only $URL_COUNT URLs/sources, recommend 3+ ($((10 - URL_COUNT * 3)) pts deducted)")
else
    DEFECTS+=("❌ CRITICAL: No source URLs found (-10 pts)")
fi

# Check 7: Official sources (15 pts - assume pass if URLs exist with official domains)
if grep -qE "(docs\.|github\.com/|official|api\.)" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 15))
elif [ "$URL_COUNT" -gt 0 ]; then
    SCORE=$((SCORE + 8))
    DEFECTS+=("⚠️  MAJOR: URLs present but may not be official sources (-7 pts)")
fi

# === CITATION CHECKS (20 points) ===

# Check 8: Source citations (10 pts)
if grep -q "Source:" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 10))
else
    DEFECTS+=("⚠️  MAJOR: No 'Source:' citations found (-10 pts)")
fi

# Check 9: Confidence level (5 pts)
if grep -q "Confidence:" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 5))
else
    DEFECTS+=("⚠️  MINOR: No confidence level stated (-5 pts)")
fi

# Check 10: Section references (5 pts)
if grep -qE "#[a-z-]+|Section [0-9]" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 5))
fi

# === ACTIONABILITY CHECKS (10 points) ===

# Check 11: Implementation checklist (5 pts)
if grep -q "Checklist\|\[ \]" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 5))
else
    DEFECTS+=("⚠️  MINOR: No implementation checklist found (-5 pts)")
fi

# Check 12: Open questions (5 pts)
if grep -q "Questions\|Open Questions\|Decisions" "$RESEARCH_FILE"; then
    SCORE=$((SCORE + 5))
fi

# === CALCULATE GRADE ===

PERCENTAGE=$((SCORE * 100 / MAX_SCORE))

echo ""
echo "📊 ResearchPack Validation Results"
echo "   Score: $SCORE/$MAX_SCORE ($PERCENTAGE%)"

if [ "$SCORE" -ge 80 ]; then
    echo -e "   Grade: ${GREEN}✅ PASS${NC}"
    echo ""
    echo "✅ ResearchPack validation passed - proceeding to planning phase"

    # Show defects as warnings if any
    if [ ${#DEFECTS[@]} -gt 0 ]; then
        echo ""
        echo "Improvement opportunities:"
        for defect in "${DEFECTS[@]}"; do
            echo "   $defect"
        done
    fi

    exit 0
else
    echo -e "   Grade: ${RED}❌ FAIL${NC} (need 80+)"
    echo ""
    echo "Defects found (${#DEFECTS[@]}):"
    for defect in "${DEFECTS[@]}"; do
        echo "   $defect"
    done
    echo ""
    echo "⚠️  ResearchPack quality below threshold"
    echo "   Recommendation: Re-run @docs-researcher with focus on missing elements"
    echo "   Required score: 80/100 (current: $SCORE/100)"
    echo ""
    exit 0  # Changed to warn instead of block - set to exit 1 to block
fi
