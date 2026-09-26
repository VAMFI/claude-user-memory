#!/usr/bin/env bash
# Validation script for Agentic Substrate installation
# Tests installation integrity

ERRORS=0
CLAUDE_TARGET="$HOME/.claude"

function test_version_file() {
    echo "🧪 Testing version file..."

    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        echo "❌ Version file missing"
        ((ERRORS++))
        return 1
    fi

    VERSION=$(cat "$CLAUDE_TARGET/.agentic-substrate-version")
    if [ -z "$VERSION" ]; then
        echo "❌ Version file is empty"
        ((ERRORS++))
        return 1
    fi

    echo "✅ Version file correct (v$VERSION)"
    return 0
}

function test_manifest() {
    echo "🧪 Testing manifest..."

    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        echo "❌ Manifest missing"
        ((ERRORS++))
        return 1
    fi

    # Validate JSON
    if ! python3 -m json.tool "$CLAUDE_TARGET/.agentic-substrate-manifest.json" > /dev/null 2>&1; then
        echo "❌ Manifest is invalid JSON"
        ((ERRORS++))
        return 1
    fi

    # Check file count
    COUNT=$(python3 -c "import json; print(len(json.load(open('$CLAUDE_TARGET/.agentic-substrate-manifest.json'))['managed_files']))" 2>/dev/null || echo "0")

    if [ "$COUNT" -ne 35 ]; then
        echo "❌ Manifest incomplete: $COUNT files (expected 35)"
        ((ERRORS++))
        return 1
    fi

    echo "✅ Manifest complete ($COUNT files)"
    return 0
}

function test_all_files_present() {
    echo "🧪 Testing all managed files present..."

    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        echo "⚠️  Cannot test files (no manifest)"
        return 0
    fi

    local missing=0

    # Check each managed file
    while IFS= read -r file; do
        if [ ! -f "$CLAUDE_TARGET/$file" ]; then
            echo "   ❌ Missing file: $file"
            ((missing++))
            ((ERRORS++))
        fi
    done < <(python3 -c "import json; print('\n'.join(json.load(open('$CLAUDE_TARGET/.agentic-substrate-manifest.json'))['managed_files']))")

    if [ $missing -eq 0 ]; then
        echo "✅ All managed files present"
        return 0
    else
        echo "❌ $missing file(s) missing"
        return 1
    fi
}

function test_permissions() {
    echo "🧪 Testing executable permissions..."

    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        echo "⚠️  Cannot test permissions (no manifest)"
        return 0
    fi

    local not_executable=0

    # Check each executable file
    while IFS= read -r file; do
        if [ ! -x "$CLAUDE_TARGET/$file" ]; then
            echo "   ❌ Not executable: $file"
            ((not_executable++))
            ((ERRORS++))
        fi
    done < <(python3 -c "import json; print('\n'.join(json.load(open('$CLAUDE_TARGET/.agentic-substrate-manifest.json'))['executable_files']))")

    if [ $not_executable -eq 0 ]; then
        echo "✅ All scripts executable"
        return 0
    else
        echo "❌ $not_executable script(s) not executable"
        return 1
    fi
}

function test_protected_files_untouched() {
    echo "🧪 Testing protected files preserved..."

    local preserved=0

    # Test common CLI files (if they exist)
    if [ -f "$CLAUDE_TARGET/history.jsonl" ]; then
        echo "   ✅ history.jsonl preserved"
        ((preserved++))
    fi

    if [ -d "$CLAUDE_TARGET/projects" ]; then
        echo "   ✅ projects/ preserved"
        ((preserved++))
    fi

    if [ -d "$CLAUDE_TARGET/todos" ]; then
        echo "   ✅ todos/ preserved"
        ((preserved++))
    fi

    if [ -d "$CLAUDE_TARGET/debug" ]; then
        echo "   ✅ debug/ preserved"
        ((preserved++))
    fi

    if [ $preserved -gt 0 ]; then
        echo "✅ Protected files preserved ($preserved found)"
    else
        echo "ℹ️  No protected files found (fresh install or clean directory)"
    fi

    return 0
}

function test_directory_structure() {
    echo "🧪 Testing directory structure..."

    local missing_dirs=0
    local required_dirs=("agents" "skills" "commands" "hooks" "validators" "metrics" "templates")

    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$CLAUDE_TARGET/$dir" ]; then
            echo "   ❌ Missing directory: $dir/"
            ((missing_dirs++))
            ((ERRORS++))
        fi
    done

    if [ $missing_dirs -eq 0 ]; then
        echo "✅ Directory structure correct"
        return 0
    else
        echo "❌ $missing_dirs director(y/ies) missing"
        return 1
    fi
}

function test_claude_md() {
    echo "🧪 Testing user-level CLAUDE.md..."

    if [ ! -f "$CLAUDE_TARGET/CLAUDE.md" ]; then
        echo "⚠️  CLAUDE.md not found (optional)"
        return 0
    fi

    # Check it's not empty
    if [ ! -s "$CLAUDE_TARGET/CLAUDE.md" ]; then
        echo "❌ CLAUDE.md is empty"
        ((ERRORS++))
        return 1
    fi

    echo "✅ CLAUDE.md present"
    return 0
}

# Run all tests
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧪 Validating Agentic Substrate Installation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if installation exists
if [ ! -d "$CLAUDE_TARGET" ]; then
    echo "❌ No installation found at $CLAUDE_TARGET"
    echo ""
    echo "Run install.sh to install Agentic Substrate"
    exit 1
fi

echo "📍 Installation location: $CLAUDE_TARGET"
echo ""

# Run tests
test_version_file
echo ""

test_manifest
echo ""

test_directory_structure
echo ""

test_all_files_present
echo ""

test_permissions
echo ""

test_protected_files_untouched
echo ""

test_claude_md
echo ""

# Final result
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERRORS -eq 0 ]; then
    echo "✅ All validation tests passed!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Your Agentic Substrate installation is healthy."
    exit 0
else
    echo "❌ $ERRORS validation test(s) failed"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Please review errors above and:"
    echo "  • Run install.sh to repair installation"
    echo "  • Or run rollback script if available"
    exit 1
fi
