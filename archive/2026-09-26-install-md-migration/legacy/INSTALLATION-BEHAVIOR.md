# Installation Behavior - Agentic Substrate v4.1

## Overview

The Agentic Substrate installation system uses a manifest-driven approach with special handling for user data and customizations.

## Key Features

### 1. Data Preservation

**Protected Directory**: `~/.claude/data/`

The `data/` folder contains user cache files, configurations, and other persistent data. This directory is **fully protected** during installation:

- ✅ Preserved on upgrades
- ✅ Preserved on reinstallation
- ✅ Never overwritten or deleted
- ✅ Listed in `protected_paths` array in manifest

**Files Stored in data/**:
- `mcp-config.json` - MCP server configuration (user customizations)
- Cache files (if any)
- Future user data

### 2. Smart CLAUDE.md Merging

**Location**: `~/.claude/CLAUDE.md`

**Behavior**:
- **First Install**: Copies template directly
- **Upgrade**: Performs smart-merge
  1. Creates backup: `~/.claude/CLAUDE.md.backup`
  2. Appends user's existing CLAUDE.md to new template
  3. Preserves all user customizations

**Template Source**: `templates/CLAUDE.md.user-level`

**Why Smart-Merge**:
- Users often add custom instructions to CLAUDE.md
- Simple overwrite would lose customizations
- Appending preserves everything while providing updates

### 3. MCP Config Install-If-Missing

**Location**: `~/.claude/data/mcp-config.json`

**Behavior**:
- **If missing**: Install from template
- **If exists**: Preserve user's configuration completely
- **Template**: `data/mcp-config-template.json`

**Why Install-If-Missing**:
- Users customize which MCP servers are enabled
- Users add their own MCP servers
- Configuration contains personal preferences
- Overwriting would break user's setup

## Special Handling Configuration

From `manifest-template.json`:

```json
{
  "special_handling": {
    "pattern-index.json": {
      "action": "preserve",
      "reason": "User-generated pattern learning data"
    },
    "CLAUDE.md": {
      "action": "smart-merge",
      "source": "templates/CLAUDE.md.user-level",
      "reason": "User-level configuration file - preserve user customizations"
    },
    "data/mcp-config.json": {
      "action": "install-if-missing",
      "source": "data/mcp-config-template.json",
      "reason": "MCP server configuration - preserve user's existing config"
    }
  }
}
```

## Protected Paths

From `manifest-template.json`:

```json
{
  "protected_paths": [
    "data/",
    "debug/",
    "file-history/",
    "history.jsonl",
    "projects/",
    "session-env/",
    "settings.json",
    "settings.local.json",
    "shell-snapshots/",
    "statsig/",
    "todos/",
    "plugins/",
    "ide/",
    ".circuit-breaker-state",
    ".DS_Store"
  ]
}
```

**Behavior**: Files and directories in `protected_paths` are **never modified or deleted** during installation or uninstallation.

## Installation Flow

### Normal Installation

1. **Preflight Checks**: Verify source directory exists
2. **Create Backup**: Backup existing `~/.claude/` installation
3. **Install Files**: Copy all managed files from manifest
4. **Set Permissions**: Make scripts executable
5. **Smart-Merge CLAUDE.md**: Append user's CLAUDE.md to template
6. **Install MCP Config**: Copy template only if missing
7. **Install MCP Servers**: Configure DeepWiki via Claude CLI
8. **Preserve Special Files**: Ensure pattern-index.json preserved
9. **Generate Manifest**: Create installation manifest
10. **Write Version**: Write version file
11. **Generate Rollback**: Create rollback script
12. **Validate**: Verify installation success

### Dry-Run Mode

```bash
./install.sh --dry-run
```

Shows what would be installed without making any changes.

## Uninstallation

### Safe Uninstallation

The uninstall script (`uninstall.sh`) automatically preserves:

- ✅ All files in `data/` directory
- ✅ Modified files (detected via checksum)
- ✅ User customizations (CLAUDE.md if modified)
- ✅ Knowledge files
- ✅ Backup files
- ✅ Custom additions

### Uninstall Modes

```bash
# Normal uninstall (preserves data and modified files)
./uninstall.sh

# Dry-run (show what would be removed)
./uninstall.sh --dry-run

# Preserve everything (only remove manifest)
./uninstall.sh --preserve-all

# Skip confirmation
./uninstall.sh --force
```

## Upgrade Behavior

When upgrading from v4.0 to v4.1:

1. **Backup Created**: Old installation backed up
2. **Managed Files Updated**: All template files refreshed
3. **Data Preserved**: `~/.claude/data/` untouched
4. **CLAUDE.md Smart-Merged**: User customizations appended to new template
5. **MCP Config Preserved**: Existing configuration kept as-is
6. **Rollback Available**: `rollback-to-previous.sh` script created

## Testing

### Test Installation

```bash
# Dry-run to see what would be installed
./install.sh --dry-run

# Actual installation
./install.sh
```

### Test Uninstallation

```bash
# Dry-run to see what would be removed
./uninstall.sh --dry-run

# Actual uninstallation (with confirmation)
./uninstall.sh
```

### Verify Data Preservation

```bash
# Create test data file
echo "test" > ~/.claude/data/test-cache.txt

# Upgrade installation
./install.sh

# Verify data preserved
cat ~/.claude/data/test-cache.txt  # Should output: test
```

### Verify CLAUDE.md Smart-Merge

```bash
# Add custom content to CLAUDE.md
echo "# My Custom Instructions" >> ~/.claude/CLAUDE.md
echo "Always use tabs instead of spaces" >> ~/.claude/CLAUDE.md

# Upgrade installation
./install.sh

# Verify custom content preserved
grep "My Custom Instructions" ~/.claude/CLAUDE.md  # Should be found
grep "Always use tabs" ~/.claude/CLAUDE.md  # Should be found

# Check backup created
ls -la ~/.claude/CLAUDE.md.backup
```

## Manifest Version

**Current**: v1.0.0

**Substrate Version**: v3.1.0

**Total Managed Files**: 36
- Agents: 9
- Skills: 5
- Commands: 5
- Hooks: 7
- Validators: 2
- Metrics: 1
- Templates: 6
- Data: 1 (mcp-config-template.json)

## Troubleshooting

### Issue: Installation fails to preserve data

**Solution**: Check that `data/` is in `protected_paths` in manifest

### Issue: CLAUDE.md customizations lost

**Solution**: Check `~/.claude/CLAUDE.md.backup` for previous content

### Issue: MCP config overwritten

**Solution**: Restore from backup (`~/.claude.backup-<timestamp>/data/mcp-config.json`)

### Issue: Manifest shows 35 files instead of 36

**Solution**: Ensure `data/mcp-config-template.json` exists in repository and is listed in manifest

---

**Last Updated**: 2025-11-22
**Version**: 4.1.0
**Status**: Production-Ready
