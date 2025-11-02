#!/usr/bin/env bash
# Agentic Substrate - Intelligent Update Script
# Selectively updates only changed files, preserves user data

set -e

NEW_VERSION="3.1.0"

# Logging functions
function log_info() { echo "ℹ️  $1"; }
function log_success() { echo "✅ $1"; }
function log_warning() { echo "⚠️  $1"; }
function log_error() { echo "❌ $1"; }

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLAUDE_SOURCE="$SCRIPT_DIR/.claude"
CLAUDE_TARGET="$HOME/.claude"
MANIFEST_TEMPLATE="$SCRIPT_DIR/manifest-template.json"

# Detect current version
function detect_current_version() {
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        echo "none"
        return
    fi

    cat "$CLAUDE_TARGET/.agentic-substrate-version"
}

# Detect changes
function detect_changes() {
    log_info "Detecting changes..."

    # Read new manifest
    NEW_FILES=$(python3 -c "import json; print('\n'.join(json.load(open('$MANIFEST_TEMPLATE'))['managed_files']))")

    # If no existing installation, all files are new
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        log_info "No existing installation detected - will install all files"
        CHANGED_FILES="$NEW_FILES"
        return 0
    fi

    # Compare files
    CHANGED_FILES=""
    while IFS= read -r file; do
        SOURCE_FILE="$CLAUDE_SOURCE/$file"
        TARGET_FILE="$CLAUDE_TARGET/$file"

        if [ ! -f "$TARGET_FILE" ]; then
            # File doesn't exist in installation
            CHANGED_FILES="$CHANGED_FILES$file"$'\n'
        elif ! cmp -s "$SOURCE_FILE" "$TARGET_FILE"; then
            # File exists but content differs
            CHANGED_FILES="$CHANGED_FILES$file"$'\n'
        fi
    done <<< "$NEW_FILES"

    CHANGED_COUNT=$(echo "$CHANGED_FILES" | grep -c . || echo "0")
    log_success "Found $CHANGED_COUNT file(s) to update"
}

# Detect user modifications
function detect_user_modifications() {
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

    MODIFIED_COUNT=$(echo "$MODIFIED_FILES" | grep -c . || echo "0")

    if [ "$MODIFIED_COUNT" -gt 0 ]; then
        log_warning "Update will overwrite $MODIFIED_COUNT file(s)"
    fi
}

# Prompt user
function prompt_user() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Update Summary"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "From: v$CURRENT_VERSION"
    echo "To:   v$NEW_VERSION"
    echo ""

    local change_count=$(echo "$CHANGED_FILES" | grep -c . || echo "0")
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
function backup_changed_files() {
    BACKUP_DIR="$HOME/.claude.backup-$(date +%Y%m%d-%H%M%S)"
    log_info "Creating backup: $BACKUP_DIR"

    # Full backup for safety
    cp -r "$CLAUDE_TARGET" "$BACKUP_DIR"

    log_success "Backup created"

    # Store for rollback script
    BACKUP_LOCATION="$BACKUP_DIR"
}

# Update files
function update_files() {
    log_info "Updating files..."

    local count=0
    local total=$(echo "$CHANGED_FILES" | grep -c . || echo "0")

    while IFS= read -r file; do
        [ -z "$file" ] && continue

        ((count++))

        local source_file="$CLAUDE_SOURCE/$file"
        local target_file="$CLAUDE_TARGET/$file"

        if [ ! -f "$source_file" ]; then
            log_warning "Source file not found (skipping): $file"
            continue
        fi

        # Create parent directory if needed
        mkdir -p "$(dirname "$target_file")"

        # Copy file
        cp "$source_file" "$target_file"

        # Log progress every 5 files or last file
        if [ $((count % 5)) -eq 0 ] || [ $count -eq $total ]; then
            log_info "Progress: $count/$total files updated"
        fi
    done <<< "$CHANGED_FILES"

    log_success "All files updated ($count files)"
}

# Set executable permissions
function set_permissions() {
    log_info "Setting executable permissions..."

    # Read executable files from manifest
    local exec_files=$(python3 -c "import json; print('\n'.join(json.load(open('$MANIFEST_TEMPLATE'))['executable_files']))")

    while IFS= read -r file; do
        chmod +x "$CLAUDE_TARGET/$file" 2>/dev/null || true
    done <<< "$exec_files"

    log_success "Permissions set"
}

# Update manifest
function update_manifest() {
    log_info "Updating manifest..."

    local manifest="$CLAUDE_TARGET/.agentic-substrate-manifest.json"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Copy template and add installation metadata
    python3 << EOF
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

    log_success "Manifest updated"
}

# Update version file
function update_version() {
    log_info "Updating version file..."
    echo "$NEW_VERSION" > "$CLAUDE_TARGET/.agentic-substrate-version"
    log_success "Version updated to v$NEW_VERSION"
}

# Generate rollback script
function generate_rollback() {
    log_info "Generating rollback script..."

    local rollback_script="$CLAUDE_TARGET/rollback-to-v$CURRENT_VERSION.sh"

    cat > "$rollback_script" << EOF
#!/usr/bin/env bash
# Auto-generated rollback script for Agentic Substrate
# Created: $(date)
# Rollback from: v$NEW_VERSION
# Rollback to: v$CURRENT_VERSION
# Backup location: $BACKUP_LOCATION

echo "🔄 Rolling back Agentic Substrate..."
echo "   From: v$NEW_VERSION"
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
ROLLBACK_BACKUP="\$HOME/.claude.rollback-backup-\$(date +%Y%m%d-%H%M%S)"
echo "📦 Backing up current state to \$ROLLBACK_BACKUP"
cp -r "\$HOME/.claude" "\$ROLLBACK_BACKUP"

# Restore from backup
BACKUP_DIR="$BACKUP_LOCATION"
if [ ! -d "\$BACKUP_DIR" ]; then
    echo "❌ Backup directory not found: \$BACKUP_DIR"
    exit 1
fi

echo "♻️  Restoring from backup..."
rm -rf "\$HOME/.claude"
cp -r "\$BACKUP_DIR" "\$HOME/.claude"

echo "✅ Rollback complete!"
echo ""
echo "Rolled back to v$CURRENT_VERSION"
echo "Current state backed up to: \$ROLLBACK_BACKUP"
EOF

    chmod +x "$rollback_script"
    log_success "Rollback script created: $rollback_script"
}

# Validate update
function validate_update() {
    log_info "Validating update..."

    local errors=0

    # Check version file
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        log_error "Version file missing"
        ((errors++))
    else
        local version=$(cat "$CLAUDE_TARGET/.agentic-substrate-version")
        if [ "$version" != "$NEW_VERSION" ]; then
            log_error "Version mismatch: expected $NEW_VERSION, got $version"
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
function display_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_success "Update complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    echo "📋 Update Summary:"
    echo "   • From: v$CURRENT_VERSION"
    echo "   • To:   v$NEW_VERSION"
    echo "   • Files updated: $(echo "$CHANGED_FILES" | grep -c . || echo "0")"
    echo ""

    echo "💾 Backup:"
    echo "   • Location: $BACKUP_LOCATION"
    echo "   • Rollback: $CLAUDE_TARGET/rollback-to-v$CURRENT_VERSION.sh"
    echo ""

    echo "✅ Your Agentic Substrate is now up to date!"
    echo ""
}

# Main execution
main() {
    echo "🔄 Agentic Substrate - Intelligent Update"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    CURRENT_VERSION=$(detect_current_version)

    if [ "$CURRENT_VERSION" = "none" ]; then
        log_error "No installation detected"
        log_info "Run install.sh first to install Agentic Substrate"
        exit 1
    fi

    log_info "Current version: v$CURRENT_VERSION"
    log_info "New version: v$NEW_VERSION"
    echo ""

    if [ "$CURRENT_VERSION" = "$NEW_VERSION" ]; then
        log_info "Already at version $NEW_VERSION"
        log_info "Use install.sh --force to reinstall"
        exit 0
    fi

    detect_changes
    detect_user_modifications
    prompt_user
    backup_changed_files
    update_files
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
