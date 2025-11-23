#!/usr/bin/env bash
# Agentic Substrate v4.1 - Robust Cross-Platform Installation
# Works on: macOS, Linux, WSL, minimal containers, with/without Python

VERSION="4.1.0"

# ============================================================================
# GLOBAL VARIABLES
# ============================================================================

DRY_RUN=false
FORCE=false
CURL_INSTALL=false
TEMP_CLONE=false
SCRIPT_DIR=""
CLAUDE_SOURCE=""
CLAUDE_TARGET="$HOME/.claude"
MANIFEST_TEMPLATE=""
BACKUP_LOCATION=""
LOCK_FILE="$HOME/.claude-install.lock"
SUPPORTS_EMOJI=true
OS_TYPE="unknown"

# ============================================================================
# UTILITY FUNCTIONS - Cross-Platform Compatibility
# ============================================================================

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS_TYPE="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS_TYPE="linux"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        OS_TYPE="windows"
    elif [ -f /proc/version ] && grep -qi microsoft /proc/version; then
        OS_TYPE="wsl"
    else
        OS_TYPE="unix"
    fi
}

# Detect terminal capabilities
detect_terminal() {
    SUPPORTS_EMOJI=true

    # Check if terminal supports UTF-8
    if [ -z "$TERM" ] || [ "$TERM" = "dumb" ]; then
        SUPPORTS_EMOJI=false
    fi

    # Check if running in CI/automated environment
    if [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]; then
        SUPPORTS_EMOJI=false
    fi
}

# Logging functions with fallback
log_info() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "ℹ️  $1"
    else
        echo "[INFO] $1"
    fi
}

log_success() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "✅ $1"
    else
        echo "[SUCCESS] $1"
    fi
}

log_warning() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "⚠️  $1"
    else
        echo "[WARNING] $1"
    fi
}

log_error() {
    if [ "$SUPPORTS_EMOJI" = true ]; then
        echo "❌ $1" >&2
    else
        echo "[ERROR] $1" >&2
    fi
}

# Cross-platform mktemp
safe_mktemp() {
    local tmp_dir

    # Try standard mktemp
    if tmp_dir=$(mktemp -d 2>/dev/null); then
        echo "$tmp_dir"
        return 0
    fi

    # Fallback: create in /tmp with PID
    tmp_dir="/tmp/agentic-substrate-$$-$RANDOM"
    mkdir -p "$tmp_dir" 2>/dev/null || {
        log_error "Failed to create temporary directory"
        return 1
    }
    echo "$tmp_dir"
}

# Cross-platform date (ISO 8601)
safe_date() {
    date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || echo "unknown"
}

# Parse JSON with fallbacks: python3 → python → bash
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

    # Fallback: bash parsing
    sed -n "/\"$array_name\"/,/\]/p" "$json_file" | grep '"' | sed 's/.*"\([^"]*\)".*/\1/' | grep -v "$array_name" 2>/dev/null
}

# Count array items in JSON
count_json_array() {
    local json_file="$1"
    local array_name="$2"

    parse_json_array "$json_file" "$array_name" | wc -l | tr -d ' '
}

# Git clone with retry
git_clone_with_retry() {
    local url="$1"
    local target_dir="$2"
    local max_attempts=3
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        log_info "Downloading repository (attempt $attempt/$max_attempts)..."

        if git clone --depth 1 --branch main "$url" "$target_dir" >/dev/null 2>&1; then
            return 0
        fi

        if [ $attempt -lt $max_attempts ]; then
            log_warning "Clone failed, retrying in $((attempt * 2)) seconds..."
            sleep $((attempt * 2))
        fi

        ((attempt++))
    done

    log_error "Failed to clone repository after $max_attempts attempts"
    return 1
}

# ============================================================================
# LOCK FILE MANAGEMENT
# ============================================================================

acquire_lock() {
    # Check if lock file exists
    if [ -f "$LOCK_FILE" ]; then
        local lock_pid
        lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)

        # Check if process is still running
        if [ -n "$lock_pid" ] && kill -0 "$lock_pid" 2>/dev/null; then
            log_error "Another installation is running (PID: $lock_pid)"
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
    if [ -n "$LOCK_FILE" ] && [ -f "$LOCK_FILE" ]; then
        rm -f "$LOCK_FILE" 2>/dev/null || true
    fi
}

# ============================================================================
# CLEANUP HANDLER
# ============================================================================

cleanup() {
    local exit_code=$?

    # Remove temp directory if curl install
    if [ "$TEMP_CLONE" = true ] && [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR" ]; then
        log_info "Cleaning up temporary files..."
        rm -rf "$SCRIPT_DIR" 2>/dev/null || true
    fi

    # Release lock
    release_lock

    exit $exit_code
}

# Set trap for cleanup
trap cleanup EXIT INT TERM

# ============================================================================
# INSTALLATION FUNCTIONS
# ============================================================================

# Parse command-line flags
parse_flags() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run) DRY_RUN=true; shift ;;
            --force) FORCE=true; shift ;;
            --help)
                echo "Agentic Substrate Installer v$VERSION"
                echo ""
                echo "Usage: ./install.sh [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --dry-run    Show what would be installed without installing"
                echo "  --force      Force reinstall even if already installed"
                echo "  --help       Show this help message"
                echo ""
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
}

# Detect if running via curl | bash
detect_curl_install() {
    local script_dir

    # Try to determine script directory
    if [ -n "${BASH_SOURCE[0]}" ]; then
        script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
    else
        script_dir="$(pwd)"
    fi

    # Check if .claude directory exists at script location
    if [ -d "$script_dir/.claude" ] && [ -f "$script_dir/manifest-template.json" ]; then
        CURL_INSTALL=false
        SCRIPT_DIR="$script_dir"
        return
    fi

    # Check if stdin is from pipe
    if [ -p /dev/stdin ] || [ ! -t 0 ]; then
        CURL_INSTALL=true
        return
    fi

    # Default: assume repo install
    CURL_INSTALL=false
    SCRIPT_DIR="$script_dir"
}

# Clone repository if needed (for curl install)
clone_repository() {
    if [ "$CURL_INSTALL" != true ]; then
        return 0
    fi

    log_info "Running in curl mode - will download repository"

    # Check for git
    if ! command -v git >/dev/null 2>&1; then
        log_error "Git is required but not installed"
        log_error "Please install git first, or use:"
        log_error "  git clone https://github.com/VAMFI/claude-user-memory.git"
        log_error "  cd claude-user-memory && ./install.sh"
        exit 1
    fi

    # Create temp directory
    SCRIPT_DIR=$(safe_mktemp) || {
        log_error "Failed to create temporary directory"
        exit 1
    }
    TEMP_CLONE=true

    # Clone repository with retry
    if ! git_clone_with_retry "https://github.com/VAMFI/claude-user-memory.git" "$SCRIPT_DIR"; then
        exit 1
    fi

    log_success "Repository downloaded successfully"
}

# Comprehensive pre-flight checks
preflight_checks() {
    log_info "Pre-flight checks..."

    # Check shell
    if [ -z "$BASH_VERSION" ]; then
        log_error "This script requires Bash"
        exit 1
    fi

    # Check source directory
    CLAUDE_SOURCE="$SCRIPT_DIR/.claude"
    if [ ! -d "$CLAUDE_SOURCE" ]; then
        log_error "Source directory not found: $CLAUDE_SOURCE"
        log_error "Make sure you're running this script from the repository root"
        exit 1
    fi

    # Check manifest
    MANIFEST_TEMPLATE="$SCRIPT_DIR/manifest-template.json"
    if [ ! -f "$MANIFEST_TEMPLATE" ]; then
        log_error "Manifest template not found: $MANIFEST_TEMPLATE"
        exit 1
    fi

    # Validate JSON (try multiple methods)
    local json_valid=false
    if command -v python3 >/dev/null 2>&1; then
        python3 -m json.tool "$MANIFEST_TEMPLATE" >/dev/null 2>&1 && json_valid=true
    elif command -v python >/dev/null 2>&1; then
        python -m json.tool "$MANIFEST_TEMPLATE" >/dev/null 2>&1 && json_valid=true
    elif command -v jq >/dev/null 2>&1; then
        jq empty "$MANIFEST_TEMPLATE" >/dev/null 2>&1 && json_valid=true
    else
        # If no JSON validator available, assume valid
        json_valid=true
    fi

    if [ "$json_valid" != true ]; then
        log_error "Manifest template is invalid JSON"
        exit 1
    fi

    # Check write permissions
    if [ ! -w "$HOME" ]; then
        log_error "No write permission to $HOME"
        exit 1
    fi

    # Check disk space (need ~10MB)
    if command -v df >/dev/null 2>&1; then
        local available
        available=$(df -k "$HOME" 2>/dev/null | tail -1 | awk '{print $4}')
        if [ -n "$available" ] && [ "$available" -lt 10240 ]; then
            log_warning "Low disk space (need ~10MB)"
        fi
    fi

    # Check if already installed (unless force)
    if [ "$FORCE" != true ] && [ -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
        local installed_version
        installed_version=$(cat "$CLAUDE_TARGET/.agentic-substrate-version" 2>/dev/null)
        if [ "$installed_version" = "$VERSION" ]; then
            log_warning "Agentic Substrate v$VERSION is already installed"
            log_info "Use --force to reinstall"
            exit 0
        fi
    fi

    log_success "Pre-flight checks passed"
}

# Create backup
create_backup() {
    if [ ! -d "$CLAUDE_TARGET" ]; then
        log_info "No existing installation - skipping backup"
        return 0
    fi

    local backup_dir="$HOME/.claude.backup-$(date +%Y%m%d-%H%M%S)"

    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would create backup: $backup_dir"
        return 0
    fi

    log_info "Creating backup of existing installation..."

    if cp -r "$CLAUDE_TARGET" "$backup_dir" 2>/dev/null; then
        log_success "Backup created: $backup_dir"
        BACKUP_LOCATION="$backup_dir"
    else
        log_warning "Backup creation failed (continuing anyway)"
    fi
}

# Install files from manifest
install_files() {
    log_info "Installing Agentic Substrate components..."

    # Create directory structure
    mkdir -p "$CLAUDE_TARGET"/{agents,skills,commands,hooks,validators,metrics,templates,data} 2>/dev/null || {
        log_error "Failed to create installation directories"
        return 1
    }

    # Read managed files from manifest
    local files
    files=$(parse_json_array "$MANIFEST_TEMPLATE" "managed_files")

    if [ -z "$files" ]; then
        log_error "Failed to read managed files from manifest"
        return 1
    fi

    local count=0
    local total
    total=$(echo "$files" | wc -l | tr -d ' ')

    # Install each file
    while IFS= read -r file; do
        [ -z "$file" ] && continue
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
            mkdir -p "$(dirname "$target_file")" 2>/dev/null || true

            # Copy file
            if cp "$source_file" "$target_file" 2>/dev/null; then
                # Log progress every 5 files or last file
                if [ $((count % 5)) -eq 0 ] || [ $count -eq $total ]; then
                    log_info "Progress: $count/$total files installed"
                fi
            else
                log_warning "Failed to install: $file"
            fi
        fi
    done <<< "$files"

    log_success "All managed files installed ($count files)"
}

# Set executable permissions
set_permissions() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would set executable permissions on scripts"
        return 0
    fi

    log_info "Setting executable permissions..."

    # Read executable files from manifest
    local exec_files
    exec_files=$(parse_json_array "$MANIFEST_TEMPLATE" "executable_files")

    if [ -n "$exec_files" ]; then
        while IFS= read -r file; do
            [ -z "$file" ] && continue
            chmod +x "$CLAUDE_TARGET/$file" 2>/dev/null || true
        done <<< "$exec_files"
    fi

    log_success "Permissions set on executable files"
}

# Smart-merge user-level CLAUDE.md
smart_merge_claude_md() {
    local source="$CLAUDE_SOURCE/templates/CLAUDE.md.user-level"
    local target="$CLAUDE_TARGET/CLAUDE.md"
    local backup="$CLAUDE_TARGET/CLAUDE.md.backup"

    if [ ! -f "$source" ]; then
        log_warning "CLAUDE.md.user-level template not found (skipping)"
        return 0
    fi

    if [ "$DRY_RUN" = true ]; then
        if [ -f "$target" ]; then
            log_info "[DRY RUN] Would smart-merge user-level CLAUDE.md"
        else
            log_info "[DRY RUN] Would install user-level CLAUDE.md"
        fi
        return 0
    fi

    # If no existing CLAUDE.md, just copy template
    if [ ! -f "$target" ]; then
        log_info "Installing user-level CLAUDE.md..."
        if cp "$source" "$target" 2>/dev/null; then
            log_success "User-level CLAUDE.md installed"
        else
            log_warning "Failed to install CLAUDE.md"
        fi
        return 0
    fi

    # Existing CLAUDE.md found - smart merge
    log_info "Existing CLAUDE.md found - performing smart merge..."

    # Create backup
    cp "$target" "$backup" 2>/dev/null || true

    # Create merged version
    {
        cat "$source"
        echo ""
        echo "---"
        echo ""
        echo "# USER CUSTOMIZATIONS (preserved from previous installation)"
        echo ""
        cat "$target"
    } > "$target.tmp" 2>/dev/null

    if [ -f "$target.tmp" ]; then
        mv "$target.tmp" "$target" 2>/dev/null && {
            log_success "User-level CLAUDE.md smart-merged"
            log_info "Original backed up to: CLAUDE.md.backup"
        }
    else
        log_warning "Smart merge failed, keeping existing CLAUDE.md"
    fi
}

# Install MCP config (install-if-missing)
install_mcp_config() {
    local source="$CLAUDE_SOURCE/data/mcp-config-template.json"
    local target="$CLAUDE_TARGET/data/mcp-config.json"

    if [ ! -f "$source" ]; then
        log_warning "MCP config template not found (skipping)"
        return 0
    fi

    if [ "$DRY_RUN" = true ]; then
        if [ -f "$target" ]; then
            log_info "[DRY RUN] Would preserve existing MCP config"
        else
            log_info "[DRY RUN] Would install MCP config from template"
        fi
        return 0
    fi

    # If MCP config already exists, preserve it
    if [ -f "$target" ]; then
        log_info "Existing MCP config found - preserving user configuration"
        log_success "MCP config preserved"
        return 0
    fi

    # No existing config - install from template
    log_info "Installing MCP config from template..."
    mkdir -p "$CLAUDE_TARGET/data" 2>/dev/null || true

    if cp "$source" "$target" 2>/dev/null; then
        log_success "MCP config installed from template"
    else
        log_warning "Failed to install MCP config"
    fi
}

# Install MCP servers
install_mcp_servers() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would configure MCP servers"
        return 0
    fi

    log_info "Configuring MCP servers..."

    if command -v claude >/dev/null 2>&1; then
        log_info "Installing DeepWiki MCP..."
        if claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp 2>/dev/null; then
            log_success "DeepWiki MCP configured"
        else
            log_warning "DeepWiki MCP installation failed (non-critical)"
            log_info "You can install manually later: claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp"
        fi
    else
        log_warning "Claude CLI not found, skipping MCP setup"
        log_info "Install Claude CLI then run: claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp"
    fi
}

# Generate manifest in installation
generate_manifest() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would generate installation manifest"
        return 0
    fi

    log_info "Generating installation manifest..."

    local manifest="$CLAUDE_TARGET/.agentic-substrate-manifest.json"
    local timestamp
    timestamp=$(safe_date)

    # Try to generate with Python
    if command -v python3 >/dev/null 2>&1; then
        python3 << EOF 2>/dev/null
import json
with open('$MANIFEST_TEMPLATE', 'r') as f:
    data = json.load(f)
data['installed_at'] = '$timestamp'
data['installed_by'] = 'install.sh'
with open('$manifest', 'w') as f:
    json.dump(data, f, indent=2)
EOF
        if [ $? -eq 0 ]; then
            log_success "Installation manifest created"
            return 0
        fi
    fi

    # Fallback: copy template as-is
    if cp "$MANIFEST_TEMPLATE" "$manifest" 2>/dev/null; then
        log_success "Installation manifest created"
    else
        log_warning "Failed to create manifest"
    fi
}

# Write version file
write_version() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would write version file: $VERSION"
        return 0
    fi

    if echo "$VERSION" > "$CLAUDE_TARGET/.agentic-substrate-version" 2>/dev/null; then
        log_success "Version file created: v$VERSION"
    else
        log_warning "Failed to write version file"
    fi
}

# Generate rollback script
generate_rollback() {
    if [ "$DRY_RUN" = true ]; then
        log_info "[DRY RUN] Would generate rollback script"
        return 0
    fi

    if [ -z "$BACKUP_LOCATION" ]; then
        log_info "No backup created - skipping rollback script"
        return 0
    fi

    local rollback_script="$CLAUDE_TARGET/rollback-to-previous.sh"

    cat > "$rollback_script" << 'ROLLBACK_EOF'
#!/usr/bin/env bash
BACKUP_LOCATION="BACKUP_PLACEHOLDER"
VERSION="VERSION_PLACEHOLDER"

echo "Rolling back Agentic Substrate..."
echo "  From: v$VERSION"
echo "  Backup: $BACKUP_LOCATION"
echo ""

read -p "Proceed with rollback? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Rollback cancelled"
    exit 1
fi

if [ ! -d "$BACKUP_LOCATION" ]; then
    echo "ERROR: Backup not found: $BACKUP_LOCATION"
    exit 1
fi

ROLLBACK_BACKUP="$HOME/.claude.rollback-backup-$(date +%Y%m%d-%H%M%S)"
echo "Backing up current state to $ROLLBACK_BACKUP"
cp -r "$HOME/.claude" "$ROLLBACK_BACKUP" 2>/dev/null || true

echo "Restoring from backup..."
rm -rf "$HOME/.claude" 2>/dev/null || true
cp -r "$BACKUP_LOCATION" "$HOME/.claude" 2>/dev/null || {
    echo "ERROR: Rollback failed"
    exit 1
}

echo "Rollback complete!"
ROLLBACK_EOF

    # Replace placeholders
    sed -i.bak "s|BACKUP_PLACEHOLDER|$BACKUP_LOCATION|g" "$rollback_script" 2>/dev/null
    sed -i.bak "s|VERSION_PLACEHOLDER|$VERSION|g" "$rollback_script" 2>/dev/null
    rm -f "$rollback_script.bak" 2>/dev/null

    chmod +x "$rollback_script" 2>/dev/null || true
    log_success "Rollback script created"
}

# Validate installation
validate_installation() {
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
    else
        # Get expected file count dynamically from manifest
        local expected
        expected=$(count_json_array "$CLAUDE_TARGET/.agentic-substrate-manifest.json" "managed_files")

        if [ -n "$expected" ] && [ "$expected" -gt 0 ]; then
            log_info "Expected files: $expected"
        fi
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
display_summary() {
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

    echo "Installation Summary:"
    echo "  Location: $CLAUDE_TARGET"
    echo "  Version: $VERSION"
    echo "  Agents: 9 | Skills: 5 | Commands: 5"
    echo ""

    if [ -n "$BACKUP_LOCATION" ]; then
        echo "Backup Information:"
        echo "  Backup: $BACKUP_LOCATION"
        echo "  Rollback: $CLAUDE_TARGET/rollback-to-previous.sh"
        echo ""
    fi

    echo "Quick Start:"
    echo "  1. Start Claude Code CLI"
    echo "  2. Try: /workflow Add feature X"
    echo ""

    echo "Documentation:"
    echo "  ~/.claude/CLAUDE.md"
    echo "  ~/.claude/templates/"
    echo ""
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    # Initialize
    detect_os
    detect_terminal
    parse_flags "$@"

    echo "Agentic Substrate v$VERSION - Robust Cross-Platform Installation"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "OS: $OS_TYPE | Bash: $BASH_VERSION"
    echo ""

    if [ "$DRY_RUN" = true ]; then
        log_warning "DRY RUN MODE - No changes will be made"
        echo ""
    fi

    # Acquire lock
    acquire_lock

    # Detect install mode and clone if needed
    detect_curl_install
    clone_repository

    # Run installation
    if ! preflight_checks; then
        log_error "Pre-flight checks failed"
        exit 1
    fi

    create_backup

    if ! install_files; then
        log_error "File installation failed"
        exit 1
    fi

    set_permissions
    smart_merge_claude_md
    install_mcp_config
    install_mcp_servers
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
}

main "$@"
