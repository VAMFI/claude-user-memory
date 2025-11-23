#!/usr/bin/env bash
# Agentic Substrate v4.1 - Safe Uninstallation (Robust Cross-Platform)
# Removes installed files while preserving user data and customizations

VERSION="4.1.0"

# DO NOT use set -e - we want explicit error handling
# set -e causes immediate exit on any error, preventing cleanup

# Global variables
OS_TYPE="unknown"
SUPPORTS_EMOJI=true
LOCK_FILE="$HOME/.claude/.agentic-substrate-uninstall.lock"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#==============================================================================
# UTILITY FUNCTIONS
#==============================================================================

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS_TYPE="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS_TYPE="linux"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        OS_TYPE="windows"
    elif [ -f /proc/version ] && grep -qi microsoft /proc/version 2>/dev/null; then
        OS_TYPE="wsl"
    else
        OS_TYPE="unix"
    fi
}

# Detect terminal capabilities for emoji support
detect_terminal() {
    SUPPORTS_EMOJI=true

    # Check if terminal is dumb or unset
    if [ -z "$TERM" ] || [ "$TERM" = "dumb" ]; then
        SUPPORTS_EMOJI=false
    fi

    # Check for CI environments
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        SUPPORTS_EMOJI=false
    fi
}

# Logging functions with emoji fallback
log_info() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo -e "${BLUE}ℹ️  $1${NC}"
    else
        echo -e "${BLUE}[INFO] $1${NC}"
    fi
}

log_success() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo -e "${GREEN}✅ $1${NC}"
    else
        echo -e "${GREEN}[SUCCESS] $1${NC}"
    fi
}

log_warning() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo -e "${YELLOW}⚠️  $1${NC}"
    else
        echo -e "${YELLOW}[WARNING] $1${NC}"
    fi
}

log_error() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo -e "${RED}❌ $1${NC}" >&2
    else
        echo -e "${RED}[ERROR] $1${NC}" >&2
    fi
}

log_action() {
    if [ "$DRY_RUN" = true ]; then
        if [ "$SUPPORTS_EMOJI" = true ]; then
            echo -e "${YELLOW}[DRY RUN] Would: $1${NC}"
        else
            echo -e "${YELLOW}[DRY RUN] $1${NC}"
        fi
    else
        if [ "$SUPPORTS_EMOJI" = true ]; then
            echo -e "${GREEN}➤ $1${NC}"
        else
            echo -e "${GREEN}[ACTION] $1${NC}"
        fi
    fi
}

# Safe file operations wrapper
safe_rm() {
    local path="$1"
    if [ -f "$path" ] || [ -d "$path" ]; then
        rm -rf "$path" 2>/dev/null || {
            log_warning "Could not remove: $path"
            return 1
        }
    fi
    return 0
}

safe_cp() {
    local src="$1"
    local dst="$2"
    if [ -f "$src" ]; then
        cp "$src" "$dst" 2>/dev/null || {
            log_warning "Could not copy: $src to $dst"
            return 1
        }
    fi
    return 0
}

# Parse JSON value with multiple fallback methods
parse_json_value() {
    local json_file="$1"
    local key="$2"

    if [ ! -f "$json_file" ]; then
        return 1
    fi

    # Try python3
    if command -v python3 >/dev/null 2>&1; then
        python3 -c "import json,sys; print(json.load(open('$json_file'))['$key'])" 2>/dev/null && return 0
    fi

    # Try python
    if command -v python >/dev/null 2>&1; then
        python -c "import json,sys; print json.load(open('$json_file'))['$key']" 2>/dev/null && return 0
    fi

    # Try jq if available
    if command -v jq >/dev/null 2>&1; then
        jq -r ".$key" "$json_file" 2>/dev/null && return 0
    fi

    # Fallback: bash grep/sed
    grep "\"$key\"" "$json_file" | head -1 | sed 's/.*: *"\([^"]*\)".*/\1/' 2>/dev/null
}

# Cross-platform checksum
calculate_checksum() {
    local file="$1"

    if [ ! -f "$file" ]; then
        return 1
    fi

    # Try shasum (macOS, most Linux)
    if command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$file" 2>/dev/null | awk '{print $1}'
        return 0
    fi

    # Try sha256sum (Linux)
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$file" 2>/dev/null | awk '{print $1}'
        return 0
    fi

    # No checksum available
    return 1
}

# Lock file management
acquire_lock() {
    if [ -f "$LOCK_FILE" ]; then
        local lock_pid
        lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)

        # Check if process is still running
        if [ -n "$lock_pid" ] && kill -0 "$lock_pid" 2>/dev/null; then
            log_error "Another uninstallation is running (PID: $lock_pid)"
            log_info "If this is a stale lock, remove: $LOCK_FILE"
            exit 1
        else
            # Stale lock, remove it
            safe_rm "$LOCK_FILE"
        fi
    fi

    # Create lock file with our PID
    echo "$$" > "$LOCK_FILE" 2>/dev/null || {
        log_warning "Could not create lock file (continuing anyway)"
    }
}

release_lock() {
    safe_rm "$LOCK_FILE"
}

# Cleanup on exit
cleanup() {
    local exit_code=$?
    release_lock
    exit $exit_code
}

# Set trap for cleanup
trap cleanup EXIT INT TERM

#==============================================================================
# MAIN UNINSTALL LOGIC
#==============================================================================

# Parse flags
DRY_RUN=false
FORCE=false
PRESERVE_ALL=false

parse_flags() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run) DRY_RUN=true; shift ;;
            --force) FORCE=true; shift ;;
            --preserve-all) PRESERVE_ALL=true; shift ;;
            --help)
                echo "Agentic Substrate Uninstaller v$VERSION"
                echo ""
                echo "Usage: ./uninstall.sh [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --dry-run       Show what would be removed without removing"
                echo "  --force         Skip confirmation prompts"
                echo "  --preserve-all  Keep everything (only remove manifest)"
                echo "  --help          Show this help message"
                echo ""
                echo "This script safely removes Agentic Substrate while preserving:"
                echo "  - User data in ~/.claude/data/"
                echo "  - Custom configurations"
                echo "  - Modified files"
                echo "  - Knowledge files"
                exit 0
                ;;
            *) log_error "Unknown option: $1"; exit 1 ;;
        esac
    done
}

CLAUDE_TARGET="$HOME/.claude"
MANIFEST_FILE="$CLAUDE_TARGET/.agentic-substrate-manifest.json"
BACKUP_DIR="$CLAUDE_TARGET/backups/uninstall-$(date +%Y%m%d-%H%M%S 2>/dev/null || echo "backup")"

# Check if file was modified
is_modified() {
    local file="$1"

    # Check if manifest exists and has checksum
    if [ ! -f "$MANIFEST_FILE" ]; then
        return 1  # Can't determine, assume not modified
    fi

    local filename
    filename=$(basename "$file")

    # Try to get original checksum from manifest
    local original_checksum
    original_checksum=$(parse_json_value "$MANIFEST_FILE" "files.$filename.checksum")

    if [ -z "$original_checksum" ]; then
        return 1  # Can't determine
    fi

    # Calculate current checksum
    local current_checksum
    current_checksum=$(calculate_checksum "$file")

    if [ -z "$current_checksum" ]; then
        return 1  # Can't calculate
    fi

    # Compare
    if [ "$original_checksum" != "$current_checksum" ]; then
        return 0  # Modified
    fi

    return 1  # Not modified
}

# Categories of files to handle
declare -a REMOVE_CATEGORIES=(
    "agents:Specialized agent files"
    "skills:Auto-invoked capabilities"
    "commands:Slash commands"
    "hooks:Automation hooks"
    "templates:Template files"
    "validators:Quality validators"
)

declare -a PRESERVE_ALWAYS=(
    "data/*:User data and configurations"
    "CLAUDE.md:User instructions (if modified)"
    "knowledge-core.md:Project knowledge"
    "*.bak:Backup files"
    "backups/*:All backups"
    "custom/*:Custom additions"
)

# Safe file removal with preservation checks
safe_remove() {
    local file="$1"
    local category="$2"

    if [ ! -f "$file" ]; then
        return
    fi

    local filename
    filename=$(basename "$file")

    # Check if file should always be preserved
    for preserve_pattern in "${PRESERVE_ALWAYS[@]}"; do
        IFS=':' read -r pattern reason <<< "$preserve_pattern"
        if [[ "$file" == *$pattern* ]]; then
            log_action "Preserving $filename ($reason)"
            return
        fi
    done

    # Check if file was modified
    if is_modified "$file"; then
        log_action "Preserving $filename (modified by user)"
        if [ "$DRY_RUN" != true ]; then
            mkdir -p "$BACKUP_DIR" 2>/dev/null || true
            safe_cp "$file" "$BACKUP_DIR/$filename.preserved"
        fi
        return
    fi

    # Backup and remove
    if [ "$DRY_RUN" = true ]; then
        log_action "Remove $category/$filename"
    else
        mkdir -p "$BACKUP_DIR" 2>/dev/null || true
        safe_cp "$file" "$BACKUP_DIR/$filename"
        safe_rm "$file"
        log_success "Removed $category/$filename"
    fi
}

# Count files to remove
count_files() {
    local total=0
    local modified=0

    for category_desc in "${REMOVE_CATEGORIES[@]}"; do
        IFS=':' read -r category description <<< "$category_desc"
        if [ -d "$CLAUDE_TARGET/$category" ]; then
            for file in "$CLAUDE_TARGET/$category"/*; do
                if [ -f "$file" ]; then
                    ((total++))
                    if is_modified "$file"; then
                        ((modified++))
                    fi
                fi
            done
        fi
    done

    echo "$total:$modified"
}

# Main uninstall function
main() {
    # Initialize
    detect_os
    detect_terminal
    parse_flags "$@"

    log_info "Agentic Substrate Uninstaller v$VERSION"

    # Check if installed
    if [ ! -f "$MANIFEST_FILE" ]; then
        log_warning "Agentic Substrate not found (no manifest at $MANIFEST_FILE)"
        log_info "Nothing to uninstall"
        exit 0
    fi

    # Get installed version
    if [ -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        INSTALLED_VERSION=$(cat "$CLAUDE_TARGET/.agentic-substrate-version" 2>/dev/null || echo "unknown")
    else
        INSTALLED_VERSION="unknown"
    fi

    log_info "Installed version: $INSTALLED_VERSION"
    echo ""

    # Acquire lock
    acquire_lock

    # Count files
    local counts
    counts=$(count_files)
    IFS=':' read -r TOTAL_FILES MODIFIED_FILES <<< "$counts"

    log_info "Found $TOTAL_FILES files from Agentic Substrate"
    if [ "$MODIFIED_FILES" -gt 0 ]; then
        log_warning "Found $MODIFIED_FILES modified files (will be preserved)"
    fi

    # Confirm with user
    if [ "$FORCE" != true ] && [ "$DRY_RUN" != true ]; then
        echo ""
        echo "This will:"
        echo "  • Remove $((TOTAL_FILES - MODIFIED_FILES)) unmodified files"
        echo "  • Preserve $MODIFIED_FILES modified files"
        echo "  • Keep all user data in ~/.claude/data/"
        echo "  • Create backup in $BACKUP_DIR"
        echo ""
        read -p "Continue with uninstallation? (y/N) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Uninstallation cancelled"
            exit 0
        fi
    fi

    # Create backup directory
    if [ "$DRY_RUN" != true ] && [ "$PRESERVE_ALL" != true ]; then
        mkdir -p "$BACKUP_DIR" 2>/dev/null || {
            log_warning "Could not create backup directory"
        }
        log_action "Created backup directory: $BACKUP_DIR"
    fi

    # Remove files by category
    if [ "$PRESERVE_ALL" != true ]; then
        for category_desc in "${REMOVE_CATEGORIES[@]}"; do
            IFS=':' read -r category description <<< "$category_desc"

            if [ -d "$CLAUDE_TARGET/$category" ]; then
                log_info "Processing $description..."

                for file in "$CLAUDE_TARGET/$category"/*; do
                    if [ -f "$file" ]; then
                        safe_remove "$file" "$category"
                    fi
                done

                # Remove directory if empty
                if [ "$DRY_RUN" != true ]; then
                    rmdir "$CLAUDE_TARGET/$category" 2>/dev/null || true
                fi
            fi
        done
    fi

    # Handle special files
    SPECIAL_FILES=(
        ".agentic-substrate-version"
        ".agentic-substrate-manifest.json"
        ".circuit-breaker-state"
        "settings.json"
    )

    for special_file in "${SPECIAL_FILES[@]}"; do
        if [ -f "$CLAUDE_TARGET/$special_file" ]; then
            if [ "$special_file" = "settings.json" ] && is_modified "$CLAUDE_TARGET/$special_file"; then
                log_action "Preserving $special_file (user customizations)"
                if [ "$DRY_RUN" != true ]; then
                    mkdir -p "$BACKUP_DIR" 2>/dev/null || true
                    safe_cp "$CLAUDE_TARGET/$special_file" "$BACKUP_DIR/$special_file.preserved"
                fi
            elif [ "$PRESERVE_ALL" != true ]; then
                if [ "$DRY_RUN" = true ]; then
                    log_action "Remove $special_file"
                else
                    mkdir -p "$BACKUP_DIR" 2>/dev/null || true
                    safe_cp "$CLAUDE_TARGET/$special_file" "$BACKUP_DIR/$special_file"
                    safe_rm "$CLAUDE_TARGET/$special_file"
                    log_success "Removed $special_file"
                fi
            fi
        fi
    done

    # Summary
    echo ""
    if [ "$DRY_RUN" = true ]; then
        log_info "DRY RUN COMPLETE - No files were actually removed"
        log_info "Run without --dry-run to perform actual uninstallation"
    elif [ "$PRESERVE_ALL" = true ]; then
        log_success "Uninstallation complete (preserve-all mode)"
        log_info "All files preserved, only manifest removed"
    else
        log_success "Uninstallation complete!"
        log_info "Backup created at: $BACKUP_DIR"
        log_info "User data preserved in: $CLAUDE_TARGET/data/"

        # Check if any custom files remain
        if [ -d "$CLAUDE_TARGET" ]; then
            remaining=$(find "$CLAUDE_TARGET" -type f 2>/dev/null | wc -l | tr -d ' ')
            if [ "$remaining" -gt 0 ]; then
                log_info "Note: $remaining files remain in $CLAUDE_TARGET (user customizations)"
            fi
        fi
    fi

    echo ""
    log_info "Thank you for using Agentic Substrate!"
    log_info "To reinstall: git clone https://github.com/VAMFI/claude-user-memory.git && cd claude-user-memory && ./install.sh"

    # Clean up empty directories (except data and backups)
    if [ "$DRY_RUN" != true ] && [ "$PRESERVE_ALL" != true ]; then
        for dir in agents skills commands hooks templates validators integrations; do
            if [ -d "$CLAUDE_TARGET/$dir" ]; then
                if [ -z "$(ls -A "$CLAUDE_TARGET/$dir" 2>/dev/null)" ]; then
                    rmdir "$CLAUDE_TARGET/$dir" 2>/dev/null || true
                fi
            fi
        done
    fi

    exit 0
}

main "$@"
