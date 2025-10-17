#!/usr/bin/env bash
# auto-format.sh
# PostToolUse hook: Automatically format code after Write/Edit operations
# This ensures consistent code style across all files

FILE_PATH="$1"  # Path to file that was just written/edited

# Only format code files (not markdown, json, etc.)
case "$FILE_PATH" in
    *.ts|*.tsx|*.js|*.jsx)
        if command -v prettier &> /dev/null; then
            prettier --write "$FILE_PATH" 2>/dev/null || true
            echo "✨ Auto-formatted: $FILE_PATH"
        fi
        ;;
    *.py)
        if command -v black &> /dev/null; then
            black "$FILE_PATH" 2>/dev/null || true
            echo "✨ Auto-formatted: $FILE_PATH"
        fi
        ;;
    *.go)
        if command -v gofmt &> /dev/null; then
            gofmt -w "$FILE_PATH" 2>/dev/null || true
            echo "✨ Auto-formatted: $FILE_PATH"
        fi
        ;;
    *.rs)
        if command -v rustfmt &> /dev/null; then
            rustfmt "$FILE_PATH" 2>/dev/null || true
            echo "✨ Auto-formatted: $FILE_PATH"
        fi
        ;;
esac

exit 0  # Never block on formatting
