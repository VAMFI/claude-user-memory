#!/usr/bin/env bash
# Build .mcpb package for Desktop Extension distribution
# Agentic Substrate v3.0 - Project Brahma Demo8

set -euo pipefail

VERSION="3.0.0"
PACKAGE_NAME="agentic-substrate-${VERSION}.mcpb"

echo "🔨 Building Agentic Substrate .mcpb package v${VERSION}..."
echo ""

# Save original directory
ORIGINAL_DIR="$PWD"

# Create temp build directory
BUILD_DIR=$(mktemp -d)
echo "📁 Build directory: $BUILD_DIR"

# Copy files to build directory
echo "📋 Copying files..."

cp -r .claude "$BUILD_DIR/"
cp install.sh "$BUILD_DIR/"
cp manifest.json "$BUILD_DIR/"
cp README.md "$BUILD_DIR/"
cp PHILOSOPHY.md "$BUILD_DIR/"
cp LICENSE "$BUILD_DIR/"
cp knowledge-core.md "$BUILD_DIR/"
cp CLAUDE.md "$BUILD_DIR/" 2>/dev/null || echo "⚠️  CLAUDE.md not found, skipping"

# Copy .mcpb assets if they exist
mkdir -p "$BUILD_DIR/.mcpb"
if [ -d ".mcpb" ]; then
  cp -r .mcpb/* "$BUILD_DIR/.mcpb/" 2>/dev/null || true
fi

# Create package manifest validation
echo ""
echo "✅ Validating manifest..."
if command -v jq &> /dev/null; then
  jq '.' "$BUILD_DIR/manifest.json" > /dev/null && echo "   Manifest is valid JSON"
else
  echo "   ⚠️  jq not installed, skipping JSON validation"
fi

# Count files and calculate size
FILE_COUNT=$(find "$BUILD_DIR" -type f | wc -l | tr -d ' ')
echo ""
echo "📊 Package contents:"
echo "   Files: $FILE_COUNT"
echo "   Agents: 4"
echo "   Skills: 5"
echo "   Commands: 5"
echo "   Hooks: 8"
echo "   Templates: 5"

# Create .mcpb (zip archive)
echo ""
echo "📦 Creating .mcpb archive..."
cd "$BUILD_DIR"
zip -rq "$ORIGINAL_DIR/$PACKAGE_NAME" . -x "*.git*" -x "*.DS_Store" -x "__pycache__/*" -x "*.pyc"
cd "$ORIGINAL_DIR"

# Move to releases/
mkdir -p releases
mv "$PACKAGE_NAME" releases/

# Cleanup
rm -rf "$BUILD_DIR"

# Report results
PACKAGE_SIZE=$(du -h "releases/$PACKAGE_NAME" | cut -f1)

echo ""
echo "✅ Package built successfully!"
echo ""
echo "📦 Package Details:"
echo "   File: releases/$PACKAGE_NAME"
echo "   Size: $PACKAGE_SIZE"
echo "   Version: $VERSION"
echo ""
echo "🚀 Distribution Options:"
echo ""
echo "   1. GitHub Releases:"
echo "      - Upload to https://github.com/VAMFI/claude-user-memory/releases"
echo "      - Tag as v${VERSION}"
echo "      - Include release notes from PHILOSOPHY.md"
echo ""
echo "   2. Anthropic Extension Directory:"
echo "      - Submit to Anthropic for review"
echo "      - Wait for approval (reviewed for safety/quality)"
echo "      - Will appear in Claude Desktop > Extensions"
echo ""
echo "   3. Direct Distribution:"
echo "      - Share .mcpb file directly with users"
echo "      - Users install via Claude Desktop > Settings > Extensions > Install Extension"
echo ""
echo "   4. Installation Testing:"
echo "      - Test locally first:"
echo "        Claude Desktop > Settings > Extensions > Install Extension > Select releases/$PACKAGE_NAME"
echo "      - Restart Claude Code CLI"
echo "      - Verify with: /workflow test"
echo ""

# Generate checksum
if command -v shasum &> /dev/null; then
  CHECKSUM=$(shasum -a 256 "releases/$PACKAGE_NAME" | cut -d' ' -f1)
  echo "🔐 SHA-256 Checksum:"
  echo "   $CHECKSUM"
  echo "   (Include in release notes for verification)"
  echo ""
fi

echo "✨ Build complete!"
