#!/usr/bin/env bash
# api-matcher.sh
# Enhanced validation: Matches API signatures between ResearchPack and Implementation Plan
# Ensures plan uses exact APIs from research (prevents hallucination)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

RESEARCH_FILE="$1"
PLAN_FILE="$2"

if [ -z "$RESEARCH_FILE" ] || [ -z "$PLAN_FILE" ]; then
    echo "Usage: $0 <research-pack-file> <plan-file>"
    exit 1
fi

if [ ! -f "$RESEARCH_FILE" ]; then
    echo -e "${YELLOW}⚠️  ResearchPack not found: $RESEARCH_FILE${NC}"
    exit 0
fi

if [ ! -f "$PLAN_FILE" ]; then
    echo -e "${YELLOW}⚠️  Implementation Plan not found: $PLAN_FILE${NC}"
    exit 0
fi

echo "🔍 Matching APIs between ResearchPack and Implementation Plan..."
echo ""

# Extract function/method names from ResearchPack (simple pattern matching)
# Matches: functionName(), method.call(), ClassName.method()
RESEARCH_APIS=$(grep -oE '\b[a-zA-Z_][a-zA-Z0-9_]*\(' "$RESEARCH_FILE" | sed 's/($//' | sort -u)

if [ -z "$RESEARCH_APIS" ]; then
    echo -e "${YELLOW}⚠️  No APIs found in ResearchPack${NC}"
    echo "   Skipping API matching (may be configuration-only change)"
    exit 0
fi

# Count APIs in research
API_COUNT=$(echo "$RESEARCH_APIS" | wc -l | tr -d ' ')
echo "📚 Found $API_COUNT APIs in ResearchPack"

# Extract APIs from Implementation Plan
PLAN_APIS=$(grep -oE '\b[a-zA-Z_][a-zA-Z0-9_]*\(' "$PLAN_FILE" | sed 's/($//' | sort -u)

MATCHES=0
MISMATCHES=()
HALLUCINATED=()

# Check each API in plan exists in research
while IFS= read -r plan_api; do
    if echo "$RESEARCH_APIS" | grep -qx "$plan_api"; then
        MATCHES=$((MATCHES + 1))
    else
        # Check if it's a common utility (not necessarily from research)
        if [[ "$plan_api" =~ ^(console|log|print|require|import|export|async|await)$ ]]; then
            continue  # Skip language keywords
        fi
        MISMATCHES+=("$plan_api")
    fi
done <<< "$PLAN_APIS"

# Check for potential hallucinated APIs (mentioned in plan but not in research)
echo ""
echo "📊 API Matching Results:"
echo "   ✅ Matched: $MATCHES APIs"

if [ ${#MISMATCHES[@]} -gt 0 ]; then
    echo "   ⚠️  Unmatched: ${#MISMATCHES[@]} APIs"
    echo ""
    echo "APIs in Plan but NOT in ResearchPack:"
    for api in "${MISMATCHES[@]}"; do
        echo "   ❌ $api() - Not found in research"

        # Try to find similar API in research (fuzzy match)
        SIMILAR=$(echo "$RESEARCH_APIS" | grep -i "$api" || echo "")
        if [ -n "$SIMILAR" ]; then
            echo "      💡 Similar API in research: $SIMILAR()"
            echo "      Possible typo or wrong API choice"
        else
            echo "      ⚠️  Possibly hallucinated - no similar API in research"
            HALLUCINATED+=("$api")
        fi
    done

    echo ""

    if [ ${#HALLUCINATED[@]} -gt 0 ]; then
        echo -e "${RED}❌ CRITICAL: ${#HALLUCINATED[@]} potentially hallucinated APIs${NC}"
        echo "   These APIs don't appear in ResearchPack at all:"
        for api in "${HALLUCINATED[@]}"; do
            echo "   - $api()"
        done
        echo ""
        echo "   Recommendation: Re-run @implementation-planner with strict instruction:"
        echo "   'Use ONLY APIs from ResearchPack. No hallucination allowed.'"
        echo ""
        exit 1  # Block implementation
    else
        echo -e "${YELLOW}⚠️  WARNING: Some APIs not in ResearchPack${NC}"
        echo "   These might be valid (utility functions, language features)"
        echo "   Review manually before proceeding"
        echo ""
        exit 0  # Warn but allow
    fi
else
    echo ""
    echo -e "${GREEN}✅ All APIs in Plan match ResearchPack${NC}"
    echo "   No hallucinated APIs detected"
    echo ""
    exit 0
fi
