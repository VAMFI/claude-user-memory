#!/usr/bin/env bash
# Agentic Substrate v4.0 - Customization Interface
# User-friendly configuration for MCP servers and agent mappings

set -e

VERSION="4.0.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration paths
CLAUDE_DIR="$HOME/.claude"
DATA_DIR="$CLAUDE_DIR/data"
CONFIG_FILE="$DATA_DIR/mcp-config.json"
CONFIG_TEMPLATE="$DATA_DIR/mcp-config-template.json"
BACKUP_DIR="$DATA_DIR/backups"

# Logging functions
function log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
function log_success() { echo -e "${GREEN}✅ $1${NC}"; }
function log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
function log_error() { echo -e "${RED}❌ $1${NC}"; }

# Check dependencies
function check_dependencies() {
  if ! command -v jq &> /dev/null; then
    log_error "jq is required but not installed"
    log_info "Install with: brew install jq (macOS) or apt-get install jq (Linux)"
    exit 1
  fi
}

# Initialize configuration if needed
function init_config() {
  mkdir -p "$DATA_DIR"
  mkdir -p "$BACKUP_DIR"

  if [ ! -f "$CONFIG_FILE" ]; then
    if [ -f "$CONFIG_TEMPLATE" ]; then
      cp "$CONFIG_TEMPLATE" "$CONFIG_FILE"
      log_success "Created configuration from template"
    else
      log_error "Configuration template not found at $CONFIG_TEMPLATE"
      log_info "Run install.sh first to set up Agentic Substrate"
      exit 1
    fi
  fi
}

# Backup current configuration
function backup_config() {
  local backup_file="$BACKUP_DIR/mcp-config-$(date +%Y%m%d-%H%M%S).json"
  cp "$CONFIG_FILE" "$backup_file"
  log_info "Backed up configuration to: $backup_file"
}

# List all available MCP servers
function list_mcps() {
  echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
  echo -e "${CYAN}           Available MCP Servers                      ${NC}"
  echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"

  local servers=$(jq -r '.servers | keys[]' "$CONFIG_FILE")
  for server in $servers; do
    local enabled=$(jq -r ".servers.\"$server\".enabled" "$CONFIG_FILE")
    local description=$(jq -r ".servers.\"$server\".description" "$CONFIG_FILE")
    local status_icon=$([ "$enabled" = "true" ] && echo "✓" || echo "✗")
    local status_color=$([ "$enabled" = "true" ] && echo "$GREEN" || echo "$RED")

    printf "${status_color}%-4s${NC} ${MAGENTA}%-20s${NC} %s\n" "[$status_icon]" "$server" "$description"
  done
  echo ""
}

# List all agents
function list_agents() {
  echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
  echo -e "${CYAN}           Configured Agents                          ${NC}"
  echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"

  local agents=$(jq -r '.agent_mappings | keys[]' "$CONFIG_FILE")
  for agent in $agents; do
    local mcps=$(jq -r ".agent_mappings.\"$agent\".mcps | join(\", \")" "$CONFIG_FILE")
    printf "${MAGENTA}%-25s${NC} → %s\n" "$agent" "$mcps"
  done
  echo ""
}

# Enable an MCP server
function enable_mcp() {
  local server="$1"

  if ! jq -e ".servers.\"$server\"" "$CONFIG_FILE" > /dev/null 2>&1; then
    log_error "MCP server '$server' not found"
    log_info "Available servers: $(jq -r '.servers | keys | join(", ")' "$CONFIG_FILE")"
    return 1
  fi

  backup_config

  jq ".servers.\"$server\".enabled = true" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && \
    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

  log_success "Enabled MCP server: $server"
}

# Disable an MCP server
function disable_mcp() {
  local server="$1"

  if ! jq -e ".servers.\"$server\"" "$CONFIG_FILE" > /dev/null 2>&1; then
    log_error "MCP server '$server' not found"
    return 1
  fi

  backup_config

  jq ".servers.\"$server\".enabled = false" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && \
    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

  log_success "Disabled MCP server: $server"
}

# Assign MCP to agent
function assign_mcp() {
  local mcp="$1"
  local agent="$2"

  if ! jq -e ".servers.\"$mcp\"" "$CONFIG_FILE" > /dev/null 2>&1; then
    log_error "MCP server '$mcp' not found"
    return 1
  fi

  if ! jq -e ".agent_mappings.\"$agent\"" "$CONFIG_FILE" > /dev/null 2>&1; then
    log_error "Agent '$agent' not found"
    log_info "Available agents: $(jq -r '.agent_mappings | keys | join(", ")' "$CONFIG_FILE")"
    return 1
  fi

  backup_config

  # Add MCP to agent's list if not already present
  local current_mcps=$(jq -r ".agent_mappings.\"$agent\".mcps | .[]" "$CONFIG_FILE")
  if echo "$current_mcps" | grep -q "^$mcp$"; then
    log_warning "MCP '$mcp' already assigned to agent '$agent'"
  else
    jq ".agent_mappings.\"$agent\".mcps += [\"$mcp\"]" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && \
      mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
    log_success "Assigned MCP '$mcp' to agent '$agent'"
  fi
}

# Remove MCP from agent
function unassign_mcp() {
  local mcp="$1"
  local agent="$2"

  if ! jq -e ".agent_mappings.\"$agent\"" "$CONFIG_FILE" > /dev/null 2>&1; then
    log_error "Agent '$agent' not found"
    return 1
  fi

  backup_config

  jq ".agent_mappings.\"$agent\".mcps -= [\"$mcp\"]" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && \
    mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"

  log_success "Removed MCP '$mcp' from agent '$agent'"
}

# Reset to defaults
function reset_config() {
  if [ ! -f "$CONFIG_TEMPLATE" ]; then
    log_error "Configuration template not found"
    return 1
  fi

  backup_config
  cp "$CONFIG_TEMPLATE" "$CONFIG_FILE"
  log_success "Reset configuration to defaults"
}

# Interactive mode
function interactive_mode() {
  while true; do
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}       Agentic Substrate Configuration Menu           ${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════${NC}"
    echo "1) List MCP servers"
    echo "2) List agents"
    echo "3) Enable MCP server"
    echo "4) Disable MCP server"
    echo "5) Assign MCP to agent"
    echo "6) Remove MCP from agent"
    echo "7) Show full configuration"
    echo "8) Reset to defaults"
    echo "9) Exit"
    echo ""
    read -p "Select option (1-9): " choice

    case $choice in
      1) list_mcps ;;
      2) list_agents ;;
      3)
        list_mcps
        read -p "Enter MCP server to enable: " server
        enable_mcp "$server"
        ;;
      4)
        list_mcps
        read -p "Enter MCP server to disable: " server
        disable_mcp "$server"
        ;;
      5)
        list_mcps
        read -p "Enter MCP server: " mcp
        list_agents
        read -p "Enter agent: " agent
        assign_mcp "$mcp" "$agent"
        ;;
      6)
        list_agents
        read -p "Enter MCP server to remove: " mcp
        read -p "Enter agent: " agent
        unassign_mcp "$mcp" "$agent"
        ;;
      7)
        echo ""
        jq '.' "$CONFIG_FILE"
        ;;
      8)
        read -p "Reset to defaults? This will backup current config (y/N): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          reset_config
        fi
        ;;
      9)
        log_info "Configuration saved to: $CONFIG_FILE"
        exit 0
        ;;
      *)
        log_warning "Invalid option"
        ;;
    esac
  done
}

# Show help
function show_help() {
  echo "Agentic Substrate Customization v$VERSION"
  echo ""
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --enable-mcp <name>        Enable an MCP server"
  echo "  --disable-mcp <name>       Disable an MCP server"
  echo "  --assign-mcp <mcp> <agent> Assign MCP to agent"
  echo "  --unassign-mcp <mcp> <agent> Remove MCP from agent"
  echo "  --list-mcps                List all MCP servers"
  echo "  --list-agents              List all agents"
  echo "  --show-config              Show full configuration"
  echo "  --reset                    Reset to default configuration"
  echo "  --backup                   Create configuration backup"
  echo "  --interactive              Interactive configuration mode"
  echo "  --help                     Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 --enable-mcp memory"
  echo "  $0 --assign-mcp deepwiki docs-researcher"
  echo "  $0 --interactive"
  echo ""
  echo "Configuration file: $CONFIG_FILE"
}

# Main script
check_dependencies
init_config

# Parse command line arguments
if [ $# -eq 0 ]; then
  interactive_mode
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    --enable-mcp)
      enable_mcp "$2"
      shift 2
      ;;
    --disable-mcp)
      disable_mcp "$2"
      shift 2
      ;;
    --assign-mcp)
      assign_mcp "$2" "$3"
      shift 3
      ;;
    --unassign-mcp)
      unassign_mcp "$2" "$3"
      shift 3
      ;;
    --list-mcps)
      list_mcps
      shift
      ;;
    --list-agents)
      list_agents
      shift
      ;;
    --show-config)
      jq '.' "$CONFIG_FILE"
      shift
      ;;
    --reset)
      reset_config
      shift
      ;;
    --backup)
      backup_config
      shift
      ;;
    --interactive)
      interactive_mode
      shift
      ;;
    --help)
      show_help
      exit 0
      ;;
    *)
      log_error "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

exit 0