#!/usr/bin/env bash
# update-knowledge-core.sh
# Stop hook: Update knowledge-core.md with patterns from session
# Runs at end of Claude Code session to capture institutional knowledge

set -e

GREEN='\033[0;32m'
NC='\033[0m'

echo "🧠 Checking for knowledge core updates..."

KNOWLEDGE_FILE="knowledge-core.md"

# Check if any implementations happened this session
# Look for recent modifications to source files
RECENT_CHANGES=$(find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.py" -o -name "*.go" -o -name "*.rs" \) \
    -mmin -60 ! -path "*/node_modules/*" ! -path "*/.git/*" 2>/dev/null | wc -l)

if [ "$RECENT_CHANGES" -eq 0 ]; then
    echo "   No recent code changes detected - skipping knowledge core update"
    exit 0
fi

echo "   Found $RECENT_CHANGES recent code change(s)"

# Check if knowledge-core.md exists
if [ ! -f "$KNOWLEDGE_FILE" ]; then
    echo "   Creating knowledge-core.md..."
    cat > "$KNOWLEDGE_FILE" << 'EOF'
# Knowledge Core

Last Updated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
Version: 1.0

## 1. Architectural Principles

*Document high-level architectural rules that apply across the codebase here.*

Example:
### Dependency Injection
All external services (databases, caches, APIs) should be injected as dependencies, not instantiated directly in business logic.

**Rationale**: Improves testability and flexibility
**Established**: [Date]
**Applies to**: All service classes

---

## 2. Established Patterns

*Document specific, reusable implementation patterns here.*

Example:
### Service Layer Pattern

**Context**: When implementing business logic that interacts with data sources

**Problem**: Business logic scattered across controllers and repositories

**Solution**: Create dedicated service classes that encapsulate business logic

**Implementation Example**:
```typescript
// File: src/services/ProductService.ts
class ProductService {
  constructor(private repo: ProductRepository) {}

  async getProduct(id: string): Promise<Product> {
    // Business logic here
    return this.repo.findById(id);
  }
}
```

**Files Demonstrating Pattern**: [Add as patterns are established]

---

## 3. Key Decisions & Learnings

*Chronological log of important decisions and discoveries.*

Example:
### 2025-10-17: Caching Strategy
**Decision**: Use Redis for application-level caching
**Context**: Need to reduce database load for frequently accessed data
**Alternatives**: Memcached (simpler but less features), Application-level in-memory (doesn't scale)
**Rationale**: Redis provides rich data structures and persistence options
**Implementation**: See `src/services/CacheService.ts`
**Status**: Active

---

*This file is automatically updated by the pattern-recognition skill at the end of successful implementations.*
EOF
fi

# Increment version
CURRENT_VERSION=$(grep "^Version:" "$KNOWLEDGE_FILE" | awk '{print $2}' || echo "1.0")
NEW_VERSION=$(echo "$CURRENT_VERSION" | awk -F. '{print $1"."$2+1}')

# Update timestamp and version
if command -v gsed &> /dev/null; then
    SED_CMD="gsed"
else
    SED_CMD="sed"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/^Last Updated:.*/Last Updated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")/" "$KNOWLEDGE_FILE"
    sed -i '' "s/^Version:.*/Version: $NEW_VERSION/" "$KNOWLEDGE_FILE"
else
    # Linux
    sed -i "s/^Last Updated:.*/Last Updated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")/" "$KNOWLEDGE_FILE"
    sed -i "s/^Version:.*/Version: $NEW_VERSION/" "$KNOWLEDGE_FILE"
fi

echo -e "${GREEN}✅ Knowledge core metadata updated (v$NEW_VERSION)${NC}"
echo ""
echo "💡 Tip: After successful implementations, Claude should:"
echo "   1. Identify patterns from the code changes"
echo "   2. Document them in appropriate sections of knowledge-core.md"
echo "   3. Use pattern-recognition skill for systematic capture"
echo ""
echo "   This hook updates metadata; pattern capture happens via LLM analysis"

exit 0
