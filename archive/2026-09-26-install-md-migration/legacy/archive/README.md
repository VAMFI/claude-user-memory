# Archive Directory

This directory contains deprecated scripts preserved for reference.

## Files

### update-local-installation-v3.0-to-v3.1.sh

**Original**: `update-local-installation.sh`
**Deprecated**: 2025-11-01
**Replaced by**: `update.sh` (generic version-agnostic update script)

**Why deprecated**:
- Version-specific (hardcoded v3.0 → v3.1 migration)
- Manually maintained file list
- Not reusable for future updates

**Why preserved**:
- Reference for migration patterns
- Fallback if generic update.sh has issues
- Historical record of v3.1 changes

**Restoration** (if needed):
```bash
cp archive/update-local-installation-v3.0-to-v3.1.sh ./
chmod +x update-local-installation-v3.0-to-v3.1.sh
./update-local-installation-v3.0-to-v3.1.sh
```

**Note**: Use the new `update.sh` instead - it's manifest-driven and works for any version upgrade.
