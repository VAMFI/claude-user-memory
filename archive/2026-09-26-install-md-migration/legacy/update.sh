#!/usr/bin/env bash
# Agentic Substrate v4.1 - Intelligent Update Script (Robust Cross-Platform)
# Selectively updates only changed files, preserves user data

VERSION="4.1.0"

# DO NOT use set -e - we want explicit error handling
# set -e causes immediate exit on any error, preventing cleanup

# Global variables
OS_TYPE="unknown"
SUPPORTS_EMOJI=true
LOCK_FILE="$HOME/.claude/.agentic-substrate-update.lock"

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

# Cross-platform date function
safe_date() {
    # Try ISO 8601 format
    if date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null; then
        return 0
    fi

    # Try without -u
    if date +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null; then
        return 0
    fi

    # Fallback to simple format
    date +"%Y%m%d-%H%M%S" 2>/dev/null || echo "unknown-date"
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

# Parse JSON array with fallbacks
parse_json_array() {
    local json_file="$1"
    local array_name="$2"

    if [ ! -f "$json_file" ]; then
        return 1
    fi

    # Try python3
    if command -v python3 >/dev/null 2>&1; then
        python3 -c "import json; print('\n'.join(json.load(open('$json_file'))['$array_name']))" 2>/dev/null && return 0
    fi

    # Try python
    if command -v python >/dev/null 2>&1; then
        python -c "import json; print '\n'.join(json.load(open('$json_file'))['$array_name'])" 2>/dev/null && return 0
    fi

    # Try jq if available
    if command -v jq >/dev/null 2>&1; then
        jq -r ".$array_name[]" "$json_file" 2>/dev/null && return 0
    fi

    # Fallback: bash parsing
    sed -n "/\"$array_name\"/,/\]/p" "$json_file" | grep '"' | sed 's/.*"\([^"]*\)".*/\1/' | grep -v "$array_name" 2>/dev/null
}

# Cross-platform file comparison
files_differ() {
    local file1="$1"
    local file2="$2"

    if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
        return 1
    fi

    # Try cmp (most Unix systems)
    if command -v cmp >/dev/null 2>&1; then
        if cmp -s "$file1" "$file2" 2>/dev/null; then
            return 1  # Files are same
        else
            return 0  # Files differ
        fi
    fi

    # Try diff
    if command -v diff >/dev/null 2>&1; then
        if diff -q "$file1" "$file2" >/dev/null 2>&1; then
            return 1  # Files are same
        else
            return 0  # Files differ
        fi
    fi

    # Fallback: compare sizes
    local size1=$(wc -c < "$file1" 2>/dev/null | tr -d ' ')
    local size2=$(wc -c < "$file2" 2>/dev/null | tr -d ' ')

    if [ "$size1" != "$size2" ]; then
        return 0  # Different sizes, files differ
    fi

    # If same size, assume same (not perfect but best we can do)
    return 1
}

# Lock file management
acquire_lock() {
    if [ -f "$LOCK_FILE" ]; then
        local lock_pid
        lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)

        # Check if process is still running
        if [ -n "$lock_pid" ] && kill -0 "$lock_pid" 2>/dev/null; then
            log_error "Another update is running (PID: $lock_pid)"
            log_info "If this is a stale lock, remove: $LOCK_FILE"
            exit 1
        else
            # Stale lock, remove it
            rm -f "$LOCK_FILE" 2>/dev/null || true
        fi
    fi

    # Create lock file with our PID
    echo "$$" > "$LOCK_FILE" 2>/dev/null || {
        log_warning "Could not create lock file (continuing anyway)"
    }
}

release_lock() {
    rm -f "$LOCK_FILE" 2>/dev/null || true
}

# Cleanup on exit
cleanup() {
    local exit_code=$?
    release_lock
    exit $exit_code
}

# Set trap for cleanup
trap cleanup EXIT INT TERM

# Safe copy with error handling
safe_cp() {
    local src="$1"
    local dst="$2"

    if [ ! -f "$src" ]; then
        log_warning "Source file not found: $src"
        return 1
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")" 2>/dev/null || {
        log_error "Could not create directory: $(dirname "$dst")"
        return 1
    }

    cp "$src" "$dst" 2>/dev/null || {
        log_error "Could not copy: $src to $dst"
        return 1
    }

    return 0
}

#==============================================================================
# MAIN UPDATE LOGIC
#==============================================================================

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLAUDE_SOURCE="$SCRIPT_DIR/.claude"
CLAUDE_TARGET="$HOME/.claude"
MANIFEST_TEMPLATE="$SCRIPT_DIR/manifest-template.json"

# Detect current version
detect_current_version() {
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        echo "none"
        return
    fi

    cat "$CLAUDE_TARGET/.agentic-substrate-version" 2>/dev/null || echo "unknown"
}

# Detect changes
detect_changes() {
    log_info "Detecting changes..."

    # Read new manifest
    NEW_FILES=$(parse_json_array "$MANIFEST_TEMPLATE" "managed_files")

    if [ -z "$NEW_FILES" ]; then
        log_error "Could not read managed files from manifest"
        return 1
    fi

    # If no existing installation, all files are new
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        log_info "No existing installation detected - will install all files"
        CHANGED_FILES="$NEW_FILES"
        return 0
    fi

    # Compare files
    CHANGED_FILES=""
    while IFS= read -r file; do
        [ -z "$file" ] && continue

        SOURCE_FILE="$CLAUDE_SOURCE/$file"
        TARGET_FILE="$CLAUDE_TARGET/$file"

        if [ ! -f "$TARGET_FILE" ]; then
            # File doesn't exist in installation
            CHANGED_FILES="$CHANGED_FILES$file"$'\n'
        elif files_differ "$SOURCE_FILE" "$TARGET_FILE"; then
            # File exists but content differs
            CHANGED_FILES="$CHANGED_FILES$file"$'\n'
        fi
    done <<< "$NEW_FILES"

    CHANGED_COUNT=$(echo "$CHANGED_FILES" | grep -c . 2>/dev/null || echo "0")
    log_success "Found $CHANGED_COUNT file(s) to update"

    return 0
}

# Detect user modifications
detect_user_modifications() {
    log_info "Checking for user modifications..."

    MODIFIED_FILES=""

    # If no manifest, can't detect modifications
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        log_info "No manifest found - skipping modification detection"
        return 0
    fi

    # Check each changed file
    while IFS= read -r file; do
        [ -z "$file" ] && continue

        TARGET_FILE="$CLAUDE_TARGET/$file"

        # If file doesn't exist, not modified
        [ ! -f "$TARGET_FILE" ] && continue

        # Note: In future versions, we could use checksums from manifest
        # For now, we'll just warn about overwriting existing files
        MODIFIED_FILES="$MODIFIED_FILES$file"$'\n'
    done <<< "$CHANGED_FILES"

    MODIFIED_COUNT=$(echo "$MODIFIED_FILES" | grep -c . 2>/dev/null || echo "0")

    if [ "$MODIFIED_COUNT" -gt 0 ]; then
        log_warning "Update will overwrite $MODIFIED_COUNT file(s)"
    fi

    return 0
}

# Prompt user
prompt_user() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Update Summary"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "From: v$CURRENT_VERSION"
    echo "To:   v$VERSION"
    echo ""

    local change_count=$(echo "$CHANGED_FILES" | grep -c . 2>/dev/null || echo "0")
    echo "Files to update: $change_count"
    echo ""

    if [ "$change_count" -le 10 ]; then
        echo "Changed files:"
        echo "$CHANGED_FILES" | while IFS= read -r file; do
            [ -z "$file" ] && continue
            echo "  • $file"
        done
        echo ""
    fi

    read -p "Proceed with update? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Update cancelled"
        exit 0
    fi
}

# Backup changed files
backup_changed_files() {
    BACKUP_DIR="$HOME/.claude.backup-$(date +%Y%m%d-%H%M%S 2>/dev/null || echo "backup-$$")"
    log_info "Creating backup: $BACKUP_DIR"

    # Full backup for safety
    if ! cp -r "$CLAUDE_TARGET" "$BACKUP_DIR" 2>/dev/null; then
        log_error "Could not create backup"
        return 1
    fi

    log_success "Backup created"

    # Store for rollback script
    BACKUP_LOCATION="$BACKUP_DIR"

    return 0
}

# Update files
update_files() {
    log_info "Updating files..."

    local count=0
    local total=$(echo "$CHANGED_FILES" | grep -c . 2>/dev/null || echo "0")

    while IFS= read -r file; do
        [ -z "$file" ] && continue

        ((count++))

        local source_file="$CLAUDE_SOURCE/$file"
        local target_file="$CLAUDE_TARGET/$file"

        if [ ! -f "$source_file" ]; then
            log_warning "Source file not found (skipping): $file"
            continue
        fi

        # Copy file
        if ! safe_cp "$source_file" "$target_file"; then
            log_warning "Failed to copy: $file"
            continue
        fi

        # Log progress every 5 files or last file
        if [ $((count % 5)) -eq 0 ] || [ $count -eq $total ]; then
            log_info "Progress: $count/$total files updated"
        fi
    done <<< "$CHANGED_FILES"

    log_success "All files updated ($count files)"

    return 0
}

# Set executable permissions
set_permissions() {
    log_info "Setting executable permissions..."

    # Read executable files from manifest
    local exec_files
    exec_files=$(parse_json_array "$MANIFEST_TEMPLATE" "executable_files")

    if [ -z "$exec_files" ]; then
        log_warning "Could not read executable files from manifest"
        return 0
    fi

    while IFS= read -r file; do
        [ -z "$file" ] && continue
        chmod +x "$CLAUDE_TARGET/$file" 2>/dev/null || true
    done <<< "$exec_files"

    log_success "Permissions set"

    return 0
}

# Update manifest
update_manifest() {
    log_info "Updating manifest..."

    local manifest="$CLAUDE_TARGET/.agentic-substrate-manifest.json"
    local timestamp
    timestamp=$(safe_date)

    # Try python3 first
    if command -v python3 >/dev/null 2>&1; then
        python3 << EOF 2>/dev/null || return 1
import json

# Load template
with open('$MANIFEST_TEMPLATE', 'r') as f:
    data = json.load(f)

# Add update metadata
data['installed_at'] = '$timestamp'
data['installed_by'] = 'update.sh'
data['updated_from'] = '$CURRENT_VERSION'

# Write to installation directory
with open('$manifest', 'w') as f:
    json.dump(data, f, indent=2)
EOF
        if [ $? -eq 0 ]; then
            log_success "Manifest updated"
            return 0
        fi
    fi

    # Try python
    if command -v python >/dev/null 2>&1; then
        python << EOF 2>/dev/null || return 1
import json

# Load template
with open('$MANIFEST_TEMPLATE', 'r') as f:
    data = json.load(f)

# Add update metadata
data['installed_at'] = '$timestamp'
data['installed_by'] = 'update.sh'
data['updated_from'] = '$CURRENT_VERSION'

# Write to installation directory
with open('$manifest', 'w') as f:
    json.dump(data, f, indent=2)
EOF
        if [ $? -eq 0 ]; then
            log_success "Manifest updated"
            return 0
        fi
    fi

    # Fallback: simple copy
    if safe_cp "$MANIFEST_TEMPLATE" "$manifest"; then
        log_success "Manifest copied (metadata not added)"
        return 0
    fi

    log_warning "Could not update manifest"
    return 1
}

# Update version file
update_version() {
    log_info "Updating version file..."
    echo "$VERSION" > "$CLAUDE_TARGET/.agentic-substrate-version" 2>/dev/null || {
        log_error "Could not write version file"
        return 1
    }
    log_success "Version updated to v$VERSION"
    return 0
}

# Generate rollback script
generate_rollback() {
    log_info "Generating rollback script..."

    local rollback_script="$CLAUDE_TARGET/rollback-to-v$CURRENT_VERSION.sh"

    cat > "$rollback_script" 2>/dev/null << EOF || {
        log_warning "Could not create rollback script"
        return 1
    }
#!/usr/bin/env bash
# Auto-generated rollback script for Agentic Substrate
# Created: $(date 2>/dev/null || echo "unknown")
# Rollback from: v$VERSION
# Rollback to: v$CURRENT_VERSION
# Backup location: $BACKUP_LOCATION

echo "🔄 Rolling back Agentic Substrate..."
echo "   From: v$VERSION"
echo "   To:   v$CURRENT_VERSION"
echo "   Backup: $BACKUP_LOCATION"
echo ""

# Confirm
read -p "Proceed with rollback? (y/N) " -n 1 -r
echo
if [[ ! \$REPLY =~ ^[Yy]$ ]]; then
    echo "Rollback cancelled"
    exit 1
fi

# Backup current state before rollback
ROLLBACK_BACKUP="\$HOME/.claude.rollback-backup-\$(date +%Y%m%d-%H%M%S 2>/dev/null || echo "backup-\$\$")"
echo "📦 Backing up current state to \$ROLLBACK_BACKUP"
cp -r "\$HOME/.claude" "\$ROLLBACK_BACKUP" 2>/dev/null || {
    echo "Warning: Could not create rollback backup"
}

# Restore from backup
BACKUP_DIR="$BACKUP_LOCATION"
if [ ! -d "\$BACKUP_DIR" ]; then
    echo "❌ Backup directory not found: \$BACKUP_DIR"
    exit 1
fi

echo "♻️  Restoring from backup..."
rm -rf "\$HOME/.claude" 2>/dev/null || true
cp -r "\$BACKUP_DIR" "\$HOME/.claude" 2>/dev/null || {
    echo "❌ Restore failed"
    exit 1
}

echo "✅ Rollback complete!"
echo ""
echo "Rolled back to v$CURRENT_VERSION"
echo "Current state backed up to: \$ROLLBACK_BACKUP"
EOF

    chmod +x "$rollback_script" 2>/dev/null || true
    log_success "Rollback script created: $rollback_script"

    return 0
}

# Validate update
validate_update() {
    log_info "Validating update..."

    local errors=0

    # Check version file
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        log_error "Version file missing"
        ((errors++))
    else
        local version
        version=$(cat "$CLAUDE_TARGET/.agentic-substrate-version" 2>/dev/null)
        if [ "$version" != "$VERSION" ]; then
            log_error "Version mismatch: expected $VERSION, got $version"
            ((errors++))
        fi
    fi

    # Check manifest
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        log_error "Manifest file missing"
        ((errors++))
    fi

    if [ $errors -eq 0 ]; then
        log_success "Validation passed"
        return 0
    else
        log_error "Validation failed with $errors error(s)"
        return 1
    fi
}

# Display summary
display_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_success "Update complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "📋 Update Summary:"
    else
        echo "Update Summary:"
    fi
    echo "   • From: v$CURRENT_VERSION"
    echo "   • To:   v$VERSION"
    echo "   • Files updated: $(echo "$CHANGED_FILES" | grep -c . 2>/dev/null || echo "0")"
    echo ""

    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "💾 Backup:"
    else
        echo "Backup:"
    fi
    echo "   • Location: $BACKUP_LOCATION"
    echo "   • Rollback: $CLAUDE_TARGET/rollback-to-v$CURRENT_VERSION.sh"
    echo ""

    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "✅ Your Agentic Substrate is now up to date!"
    else
        echo "Your Agentic Substrate is now up to date!"
    fi
    echo ""
}

# Main execution
main() {
    # Initialize
    detect_os
    detect_terminal

    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "🔄 Agentic Substrate - Intelligent Update"
    else
        echo "Agentic Substrate - Intelligent Update"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    # Acquire lock
    acquire_lock

    CURRENT_VERSION=$(detect_current_version)

    if [ "$CURRENT_VERSION" = "none" ]; then
        log_error "No installation detected"
        log_info "Run install.sh first to install Agentic Substrate"
        exit 1
    fi

    log_info "Current version: v$CURRENT_VERSION"
    log_info "New version: v$VERSION"
    echo ""

    if [ "$CURRENT_VERSION" = "$VERSION" ]; then
        log_info "Already at version $VERSION"
        log_info "Use install.sh --force to reinstall"
        exit 0
    fi

    if ! detect_changes; then
        log_error "Failed to detect changes"
        exit 1
    fi

    detect_user_modifications
    prompt_user

    if ! backup_changed_files; then
        log_error "Backup failed - aborting update"
        exit 1
    fi

    if ! update_files; then
        log_error "File update failed"
        log_info "You can restore from backup: $BACKUP_LOCATION"
        exit 1
    fi

    set_permissions
    update_manifest
    update_version
    generate_rollback

    if ! validate_update; then
        log_error "Update validation failed"
        log_info "You can rollback: $CLAUDE_TARGET/rollback-to-v$CURRENT_VERSION.sh"
        exit 1
    fi

    display_summary
}

main "$@"
