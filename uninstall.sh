#!/usr/bin/env bash
# Agentic Substrate v4.1 - Safe Uninstallation
# Removes installed files while preserving user data and customizations

set -e

VERSION="4.1.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse flags
DRY_RUN=false
FORCE=false
PRESERVE_ALL=false
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
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Logging functions
function log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
function log_success() { echo -e "${GREEN}✅ $1${NC}"; }
function log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
function log_error() { echo -e "${RED}❌ $1${NC}"; }
function log_action() {
  if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}[DRY RUN] Would: $1${NC}"
  else
    echo -e "${GREEN}➤ $1${NC}"
  fi
}

CLAUDE_TARGET="$HOME/.claude"
MANIFEST_FILE="$CLAUDE_TARGET/.agentic-substrate-manifest.json"
BACKUP_DIR="$CLAUDE_TARGET/backups/uninstall-$(date +%Y%m%d-%H%M%S)"

# Check if installed
if [ ! -f "$MANIFEST_FILE" ]; then
  log_warning "Agentic Substrate not found (no manifest at $MANIFEST_FILE)"
  log_info "Nothing to uninstall"
  exit 0
fi

# Get installed version
if [ -f "$CLAUDE_TARGET/.agentic-substrate-version" ]; then
  INSTALLED_VERSION=$(cat "$CLAUDE_TARGET/.agentic-substrate-version")
else
  INSTALLED_VERSION="unknown"
fi

# Show what will be removed
log_info "Agentic Substrate Uninstaller v$VERSION"
log_info "Installed version: $INSTALLED_VERSION"
echo ""

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

# Function to check if file was modified
function is_modified() {
  local file="$1"
  # Check if file exists in manifest with checksum
  if [ -f "$MANIFEST_FILE" ] && command -v jq &> /dev/null; then
    local original_checksum=$(jq -r ".files.\"$(basename "$file")\".checksum // \"\"" "$MANIFEST_FILE" 2>/dev/null)
    if [ -n "$original_checksum" ] && [ -f "$file" ]; then
      local current_checksum=$(shasum -a 256 "$file" | awk '{print $1}')
      if [ "$original_checksum" != "$current_checksum" ]; then
        return 0 # Modified
      fi
    fi
  fi
  return 1 # Not modified or can't determine
}

# Count files to remove
TOTAL_FILES=0
MODIFIED_FILES=0
for category_desc in "${REMOVE_CATEGORIES[@]}"; do
  IFS=':' read -r category description <<< "$category_desc"
  if [ -d "$CLAUDE_TARGET/$category" ]; then
    for file in "$CLAUDE_TARGET/$category"/*; do
      if [ -f "$file" ]; then
        ((TOTAL_FILES++))
        if is_modified "$file"; then
          ((MODIFIED_FILES++))
        fi
      fi
    done
  fi
done

log_info "Found $TOTAL_FILES files from Agentic Substrate"
if [ $MODIFIED_FILES -gt 0 ]; then
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
  mkdir -p "$BACKUP_DIR"
  log_action "Created backup directory: $BACKUP_DIR"
fi

# Function to safely remove file
function safe_remove() {
  local file="$1"
  local category="$2"

  if [ ! -f "$file" ]; then
    return
  fi

  local filename=$(basename "$file")

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
      cp "$file" "$BACKUP_DIR/$filename.preserved"
    fi
    return
  fi

  # Backup and remove
  if [ "$DRY_RUN" = true ]; then
    log_action "Remove $category/$filename"
  else
    cp "$file" "$BACKUP_DIR/$filename"
    rm -f "$file"
    log_success "Removed $category/$filename"
  fi
}

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
        cp "$CLAUDE_TARGET/$special_file" "$BACKUP_DIR/$special_file.preserved"
      fi
    elif [ "$PRESERVE_ALL" != true ]; then
      if [ "$DRY_RUN" = true ]; then
        log_action "Remove $special_file"
      else
        cp "$CLAUDE_TARGET/$special_file" "$BACKUP_DIR/$special_file"
        rm -f "$CLAUDE_TARGET/$special_file"
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
    remaining=$(find "$CLAUDE_TARGET" -type f | wc -l)
    if [ $remaining -gt 0 ]; then
      log_info "Note: $remaining files remain in $CLAUDE_TARGET (user customizations)"
    fi
  fi
fi

echo ""
log_info "Thank you for using Agentic Substrate!"
log_info "To reinstall: curl -sSL https://vamfi.org/install-claude | bash"

# Clean up empty directories (except data and backups)
if [ "$DRY_RUN" != true ] && [ "$PRESERVE_ALL" != true ]; then
  for dir in agents skills commands hooks templates validators integrations; do
    if [ -d "$CLAUDE_TARGET/$dir" ]; then
      if [ -z "$(ls -A "$CLAUDE_TARGET/$dir")" ]; then
        rmdir "$CLAUDE_TARGET/$dir" 2>/dev/null || true
      fi
    fi
  done
fi

exit 0