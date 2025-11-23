#!/usr/bin/env bash
# Agentic Substrate v3.1 - Safe Selective Installation
# Manifest-driven installation with data preservation

set -e

VERSION="4.1.0"

# Parse flags
DRY_RUN=false
FORCE=false
while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run) DRY_RUN=true; shift ;;
    --force) FORCE=true; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Logging functions
function log_info() { echo "ℹ️  $1"; }
function log_success() { echo "✅ $1"; }
function log_warning() { echo "⚠️  $1"; }
function log_error() { echo "❌ $1"; }

# Detect if running via curl | bash (stdin is not a terminal and no source files)
CURL_INSTALL=false
if [ ! -t 0 ] || [ ! -d "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.claude" ]; then
    CURL_INSTALL=true
fi

# Repository URL
REPO_URL="https://github.com/VAMFI/claude-user-memory.git"
REPO_BRANCH="main"

# Get script directory or temp directory for curl install
if [ "$CURL_INSTALL" = true ]; then
    SCRIPT_DIR=$(mktemp -d)
    TEMP_CLONE=true
else
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    TEMP_CLONE=false
fi

CLAUDE_SOURCE="$SCRIPT_DIR/.claude"
CLAUDE_TARGET="$HOME/.claude"
MANIFEST_TEMPLATE="$SCRIPT_DIR/manifest-template.json"

# Clone repository if needed (for curl install)
function clone_repository() {
    if [ "$CURL_INSTALL" = true ]; then
        log_info "Downloading Agentic Substrate from GitHub..."

        if ! command -v git &> /dev/null; then
            log_error "Git is required but not installed"
            log_error "Please install git or use: git clone $REPO_URL && cd claude-user-memory && ./install.sh"
            exit 1
        fi

        if ! git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" "$SCRIPT_DIR" > /dev/null 2>&1; then
            log_error "Failed to clone repository from GitHub"
            exit 1
        fi

        log_success "Repository downloaded successfully"
    fi
}

# Pre-flight checks
function preflight_checks() {
    log_info "Pre-flight checks..."

    # Check source directory
    if [ ! -d "$CLAUDE_SOURCE" ]; then
        log_error "Source directory not found: $CLAUDE_SOURCE"
        log_error "Make sure you're running this script from the repository root."
        exit 1
    fi

    # Check manifest exists
    if [ ! -f "$MANIFEST_TEMPLATE" ]; then
        log_error "Manifest template not found: $MANIFEST_TEMPLATE"
        exit 1
    fi

    # Validate JSON
    if ! python3 -m json.tool "$MANIFEST_TEMPLATE" > /dev/null 2>&1; then
        log_error "Manifest template is invalid JSON"
        exit 1
    fi

    # Check if already installed (unless force)
    if [ ! "$FORCE" = true ] && [ -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        INSTALLED_VERSION=$(cat "$CLAUDE_TARGET/.agentic-substrate-version")
        if [ "$INSTALLED_VERSION" = "$VERSION" ]; then
            log_warning "Agentic Substrate v$VERSION is already installed"
            log_info "Use --force to reinstall or run update.sh to upgrade"
            exit 0
        fi
    fi

    log_success "Pre-flight checks passed"
}

# Create backup
function create_backup() {
    if [ ! -d "$CLAUDE_TARGET" ]; then
        log_info "No existing installation - skipping backup"
        return 0
    fi

    BACKUP_DIR="$HOME/.claude.backup-$(date +%Y%m%d-%H%M%S)"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would create backup: $BACKUP_DIR"
        return 0
    fi

    log_info "Creating backup of existing installation..."
    cp -r "$CLAUDE_TARGET" "$BACKUP_DIR"
    log_success "Backup created: $BACKUP_DIR"

    # Store backup location for rollback script
    BACKUP_LOCATION="$BACKUP_DIR"
}

# Install files from manifest
function install_files() {
    log_info "Installing Agentic Substrate components..."

    # Create directory structure
    mkdir -p "$CLAUDE_TARGET"
    mkdir -p "$CLAUDE_TARGET/agents"
    mkdir -p "$CLAUDE_TARGET/skills"
    mkdir -p "$CLAUDE_TARGET/commands"
    mkdir -p "$CLAUDE_TARGET/hooks"
    mkdir -p "$CLAUDE_TARGET/validators"
    mkdir -p "$CLAUDE_TARGET/metrics"
    mkdir -p "$CLAUDE_TARGET/templates"

    # Read managed files from manifest
    local files=$(python3 -c "import json; m='$MANIFEST_TEMPLATE'; print('\n'.join(json.load(open(m))['managed_files']))")

    local count=0
    local total=$(echo "$files" | wc -l | tr -d ' ')

    # Install each file
    while IFS= read -r file; do
        ((count++))
        local source_file="$CLAUDE_SOURCE/$file"
        local target_file="$CLAUDE_TARGET/$file"

        if [ ! -f "$source_file" ]; then
            log_warning "Source file not found (skipping): $file"
            continue
        fi

        if [ "$DRY_RUN" = true ]; then
            log_info "[DRY RUN] Would install [$count/$total]: $file"
        else
            # Create parent directory if needed
            mkdir -p "$(dirname "$target_file")"

            # Copy file
            cp "$source_file" "$target_file"

            # Log progress every 5 files or last file
            if [ $((count % 5)) -eq 0 ] || [ $count -eq $total ]; then
                log_info "Progress: $count/$total files installed"
            fi
        fi
    done <<< "$files"

    log_success "All managed files installed ($count files)"
}

# Set executable permissions
function set_permissions() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would set executable permissions on scripts"
        return 0
    fi

    log_info "Setting executable permissions..."

    # Read executable files from manifest
    local exec_files=$(python3 -c "import json; m='$MANIFEST_TEMPLATE'; print('\n'.join(json.load(open(m))['executable_files']))")

    while IFS= read -r file; do
        chmod +x "$CLAUDE_TARGET/$file" 2>/dev/null || true
    done <<< "$exec_files"

    log_success "Permissions set on executable files"
}

# Smart-merge user-level CLAUDE.md (preserves user customizations)
function smart_merge_claude_md() {
    local source="$CLAUDE_SOURCE/templates/CLAUDE.md.user-level"
    local target="$CLAUDE_TARGET/CLAUDE.md"
    local backup="$CLAUDE_TARGET/CLAUDE.md.backup"

    if [ ! -f "$source" ]; then
        log_warning "CLAUDE.md.user-level template not found (skipping)"
        return 0
    fi

    if [ "$DRY_RUN" = true ]; then
        if [ -f "$target" ]; then
            log_info "[DRY RUN] Would smart-merge user-level CLAUDE.md (preserving user customizations)"
        else
            log_info "[DRY RUN] Would install user-level CLAUDE.md"
        fi
        return 0
    fi

    # If no existing CLAUDE.md, just copy template
    if [ ! -f "$target" ]; then
        log_info "Installing user-level CLAUDE.md..."
        cp "$source" "$target"
        log_success "User-level CLAUDE.md installed"
        return 0
    fi

    # Existing CLAUDE.md found - smart merge
    log_info "Existing CLAUDE.md found - performing smart merge..."

    # Create backup of user's existing CLAUDE.md
    cp "$target" "$backup"
    log_info "Created backup: CLAUDE.md.backup"

    # Read user's existing customizations (everything after the template marker if exists)
    # We'll append the entire existing CLAUDE.md to the new template
    local temp_merged="$CLAUDE_TARGET/CLAUDE.md.merged"

    # Copy new template
    cp "$source" "$temp_merged"

    # Add separator
    echo "" >> "$temp_merged"
    echo "---" >> "$temp_merged"
    echo "" >> "$temp_merged"
    echo "# USER CUSTOMIZATIONS (preserved from previous installation)" >> "$temp_merged"
    echo "" >> "$temp_merged"

    # Append user's existing CLAUDE.md
    cat "$target" >> "$temp_merged"

    # Replace target with merged version
    mv "$temp_merged" "$target"

    log_success "User-level CLAUDE.md smart-merged (user customizations preserved)"
    log_info "Original backed up to: CLAUDE.md.backup"
}

# Install MCP servers (v4.1 enhancement)
function install_mcp_servers() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would install DeepWiki MCP"
        return 0
    fi

    log_info "Configuring MCP servers..."

    # Install DeepWiki MCP for code accuracy (v4.1)
    if command -v claude &> /dev/null; then
        log_info "Installing DeepWiki MCP for repository-grounded code generation..."
        claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp 2>/dev/null || {
            log_warning "DeepWiki MCP installation failed (non-critical, continuing)"
            log_warning "You can install manually later: claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp"
        }
        if claude mcp list 2>/dev/null | grep -q deepwiki; then
            log_success "DeepWiki MCP configured successfully"
        fi
    else
        log_warning "Claude CLI not found, skipping MCP server setup"
        log_warning "Install Claude CLI then run: claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp"
    fi
}

# Install MCP config (install-if-missing to preserve user config)
function install_mcp_config() {
    local source="$CLAUDE_SOURCE/data/mcp-config-template.json"
    local target="$CLAUDE_TARGET/data/mcp-config.json"

    if [ ! -f "$source" ]; then
        log_warning "MCP config template not found (skipping)"
        return 0
    fi

    if [ "$DRY_RUN" = true ]; then
        if [ -f "$target" ]; then
            log_info "[DRY RUN] Would preserve existing MCP config (install-if-missing)"
        else
            log_info "[DRY RUN] Would install MCP config from template"
        fi
        return 0
    fi

    # If MCP config already exists, preserve it
    if [ -f "$target" ]; then
        log_info "Existing MCP config found - preserving user configuration"
        log_success "MCP config preserved (install-if-missing)"
        return 0
    fi

    # No existing config - install from template
    log_info "Installing MCP config from template..."

    # Ensure data directory exists
    mkdir -p "$CLAUDE_TARGET/data"

    # Copy template to target
    cp "$source" "$target"

    log_success "MCP config installed from template"
}

# Preserve special files
function preserve_special_files() {
    # pattern-index.json - already preserved by selective copying
    # (we don't copy it from repo, so user's version is kept)
    log_info "Special files preserved (pattern-index.json if exists)"
}

# Generate manifest in installation
function generate_manifest() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would generate installation manifest"
        return 0
    fi

    log_info "Generating installation manifest..."

    local manifest="$CLAUDE_TARGET/.agentic-substrate-manifest.json"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Copy template and add installation metadata
    python3 << EOF
import json
from datetime import datetime

# Load template
with open('$MANIFEST_TEMPLATE', 'r') as f:
    data = json.load(f)

# Add installation metadata
data['installed_at'] = '$timestamp'
data['installed_by'] = 'install.sh'

# Write to installation directory
with open('$manifest', 'w') as f:
    json.dump(data, f, indent=2)
EOF

    log_success "Installation manifest created"
}

# Write version file
function write_version() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would write version file: $VERSION"
        return 0
    fi

    log_info "Writing version file..."
    echo "$VERSION" > "$CLAUDE_TARGET/.agentic-substrate-version"
    log_success "Version file created: v$VERSION"
}

# Generate rollback script
function generate_rollback() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would generate rollback script"
        return 0
    fi

    if [ -z "$BACKUP_LOCATION" ]; then
        log_info "No backup created - skipping rollback script"
        return 0
    fi

    log_info "Generating rollback script..."

    local rollback_script="$CLAUDE_TARGET/rollback-to-previous.sh"

    cat > "$rollback_script" << EOF
#!/usr/bin/env bash
# Auto-generated rollback script for Agentic Substrate
# Created: $(date)
# Rollback from: v$VERSION
# Backup location: $BACKUP_LOCATION

echo "🔄 Rolling back Agentic Substrate..."
echo "   From: v$VERSION"
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
echo "Your installation has been restored from backup"
echo "Current state backed up to: \$ROLLBACK_BACKUP"
EOF

    chmod +x "$rollback_script"
    log_success "Rollback script created: $rollback_script"
}

# Validate installation
function validate_installation() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would validate installation"
        return 0
    fi

    log_info "Validating installation..."

    local errors=0

    # Check version file
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        log_error "Version file missing"
        ((errors++))
    fi

    # Check manifest
    if [ ! -f "$CLAUDE_TARGET/.agentic-substrate-manifest.json" ]; then
        log_error "Manifest file missing"
        ((errors++))
    fi

    # Check file count
    local expected=35
    local actual=$(python3 -c "import json; print(len(json.load(open('$CLAUDE_TARGET/.agentic-substrate-manifest.json'))['managed_files']))" 2>/dev/null || echo "0")

    if [ "$actual" -ne "$expected" ]; then
        log_error "File count mismatch: expected $expected, got $actual"
        ((errors++))
    fi

    if [ $errors -eq 0 ]; then
        log_success "Installation validation passed"
        return 0
    else
        log_error "Installation validation failed with $errors error(s)"
        return 1
    fi
}

# Display summary
function display_summary() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_success "Agentic Substrate v$VERSION installed successfully!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [ "$DRY_RUN" = true ]; then
        echo "DRY RUN COMPLETE - No changes were made"
        echo "Run without --dry-run to perform actual installation"
        echo ""
        return 0
    fi

    echo "📋 Installation Summary:"
    echo "   • Location: $CLAUDE_TARGET"
    echo "   • Version: $VERSION"
    echo "   • Managed files: 36"
    echo "   • Agents: 9"
    echo "   • Skills: 5"
    echo "   • Commands: 5"
    echo ""

    if [ -n "$BACKUP_LOCATION" ]; then
        echo "💾 Backup Information:"
        echo "   • Backup location: $BACKUP_LOCATION"
        echo "   • Rollback script: $CLAUDE_TARGET/rollback-to-previous.sh"
        echo ""
    fi

    echo "🚀 Quick Start:"
    echo "   1. Start Claude Code CLI"
    echo "   2. Try: /workflow Add feature X"
    echo "   3. Or: /research → /plan → /implement"
    echo ""

    echo "📚 Documentation:"
    echo "   • User guide: ~/.claude/CLAUDE.md"
    echo "   • Templates: ~/.claude/templates/"
    echo "   • Agents: ~/.claude/agents/"
    echo ""

    echo "🔍 Verify Installation:"
    echo "   cat ~/.claude/.agentic-substrate-version"
    echo "   ./validate-install.sh"
    echo ""
}

# Main execution
main() {
    echo "🚀 Agentic Substrate v$VERSION - Safe Selective Installation"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [ "$DRY_RUN" = true ]; then
        log_warning "DRY RUN MODE - No changes will be made"
        echo ""
    fi

    # Clone repository if running via curl
    clone_repository

    preflight_checks
    create_backup
    install_files
    set_permissions
    smart_merge_claude_md
    install_mcp_config
    install_mcp_servers
    preserve_special_files
    generate_manifest
    write_version
    generate_rollback

    if ! validate_installation; then
        log_error "Installation validation failed"

        if [ -n "$BACKUP_LOCATION" ]; then
            log_info "You can restore from backup: $CLAUDE_TARGET/rollback-to-previous.sh"
        fi

        exit 1
    fi

    display_summary

    # Cleanup temp directory if curl install
    if [ "$TEMP_CLONE" = true ] && [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR" ]; then
        log_info "Cleaning up temporary files..."
        rm -rf "$SCRIPT_DIR"
    fi
}

main
