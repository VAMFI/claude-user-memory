# Dependency Mapper & Relationship Detection

## 🕸️ Cross-Folder Dependency Mapping System

This module implements intelligent dependency analysis and relationship detection across the entire codebase, enabling context-aware folder loading and smart context prefetching.

## 🔍 Dependency Analysis Engine

### Phase 1: Static Code Analysis
```markdown
Import Statement Parsing:
- JavaScript/TypeScript: import, require, dynamic imports
- Python: import, from...import statements  
- Go: import declarations
- Java: import statements, package declarations
- C/C++: #include directives

Relative Path Resolution:
- ../shared → Parent directory shared resources
- ./utils → Same directory utilities
- ../../common → Ancestor directory common modules
- /absolute/paths → Root-relative imports
```

### Phase 2: Dependency Graph Construction
```markdown
Node Creation:
- Each folder becomes a graph node
- Files within folders become sub-nodes
- External packages become external nodes

Edge Detection:
- Direct imports create directed edges
- Bidirectional usage creates bidirectional edges
- Transitive dependencies create path chains
- Circular dependencies flagged for optimization
```

### Phase 3: Relationship Classification
```markdown
Dependency Types:
- CORE: Critical dependencies (app crashes without)
- FEATURE: Feature-specific dependencies
- UTILITY: Helper and utility dependencies  
- CONFIGURATION: Config and setup dependencies
- TESTING: Test-only dependencies

Relationship Strength:
- STRONG: Used in multiple files, critical functionality
- MEDIUM: Used occasionally, important but not critical
- WEAK: Used rarely, could be easily replaced
- DEPRECATED: Legacy dependencies marked for removal
```

## 🎯 Smart Context Prefetching

### Locality-Based Prefetching
```markdown
Temporal Locality (Recently Accessed):
- Cache recently loaded folder contexts in memory
- Priority queue based on last access time
- Automatic eviction after inactivity period
- Context warming for frequently accessed folders

Spatial Locality (Related Dependencies):
- Preload directly imported folders
- Load commonly co-accessed folder groups
- Predictive loading based on developer patterns
- Dependency-driven context suggestions
```

### Predictive Context Loading
```markdown
Development Pattern Recognition:
- Track which folders are typically accessed together
- Learn from git commit patterns and file modifications
- Identify workflow sequences (e.g., models → controllers → routes)
- Predict next likely folder based on current work context

Smart Prefetch Algorithm:
1. Current folder loaded → Analyze dependencies
2. Calculate prefetch candidates → Score by relationship strength
3. Filter by context window capacity → Select top candidates
4. Asynchronous context loading → Prepare for immediate use
5. Context cache management → Evict least useful contexts
```

## 🏗️ Dependency Mapping Data Structures

### Folder Dependency Graph
```json
{
  "folderPath": "/src/api",
  "dependencies": {
    "incoming": [
      {
        "folder": "/src/routes",
        "strength": "STRONG",
        "type": "FEATURE",
        "files": ["userRoutes.js", "authRoutes.js"],
        "usageCount": 15
      }
    ],
    "outgoing": [
      {
        "folder": "/src/models", 
        "strength": "CORE",
        "type": "CORE",
        "files": ["User.js", "Auth.js"],
        "usageCount": 8
      },
      {
        "folder": "/src/utils",
        "strength": "MEDIUM", 
        "type": "UTILITY",
        "files": ["validation.js", "helpers.js"],
        "usageCount": 5
      }
    ]
  },
  "contextMetrics": {
    "tokenSize": 750,
    "lastUpdated": "2025-01-26T10:30:00Z",
    "accessFrequency": 12,
    "prefetchPriority": 0.85
  }
}
```

### Cross-Folder Relationship Matrix
```markdown
Relationship Scoring Matrix:
                api/   models/  utils/  routes/  tests/
api/           -      0.9      0.6     0.3      0.2
models/        0.9    -        0.4     0.7      0.3  
utils/         0.6    0.4      -       0.5      0.8
routes/        0.3    0.7      0.5     -        0.4
tests/         0.2    0.3      0.8     0.4      -

Score Meaning:
0.9-1.0: Critical dependency (always preload)
0.7-0.8: Strong dependency (preload if capacity available)
0.5-0.6: Medium dependency (preload for related tasks)
0.3-0.4: Weak dependency (load on explicit request)
0.0-0.2: Minimal dependency (rarely needed together)
```

## 🚀 Dependency-Aware Context Commands

### Smart Context Loading
**Trigger**: `"Load context for feature development"`

**Algorithm**:
1. Analyze current working directory
2. Load primary folder context (800 tokens)
3. Calculate dependency scores for related folders
4. Preload high-priority dependencies within token budget
5. Queue medium-priority contexts for background loading
6. Report loaded contexts and available capacity

### Dependency Analysis Command
**Trigger**: `"Analyze folder dependencies"`

**Algorithm**:
1. Scan current folder for all import/export statements
2. Map dependencies to folder structure
3. Calculate relationship strengths and types
4. Generate dependency visualization
5. Identify optimization opportunities (circular deps, unused imports)
6. Suggest context loading strategies

### Context Optimization Command
**Trigger**: `"Optimize context loading for this workflow"`

**Algorithm**:
1. Analyze recent folder access patterns
2. Identify frequently co-accessed folder groups
3. Calculate optimal context loading sequence
4. Suggest context prefetching strategies
5. Recommend workflow-specific optimizations

## 📊 Dependency Metrics & Analytics

### Relationship Strength Calculation
```markdown
Strength Score Formula:
relationship_strength = (
  import_frequency * 0.4 +
  co_modification_frequency * 0.3 +
  developer_access_pattern * 0.2 +
  functional_coupling * 0.1
)

Factors:
- Import Frequency: How often folder A imports from folder B
- Co-modification: How often folders are changed together in commits
- Access Pattern: How often developers work on both folders in same session
- Functional Coupling: Semantic relationship strength (API→Models = high)
```

### Context Loading Efficiency Metrics
```markdown
Performance Indicators:
- Context Hit Rate: % of needed contexts already loaded
- Prefetch Accuracy: % of prefetched contexts actually used
- Memory Efficiency: Token usage vs. context utility ratio
- Load Time Optimization: Reduction in context loading delays

Target Metrics:
✅ Context Hit Rate: >85%
✅ Prefetch Accuracy: >70%
✅ Memory Efficiency: <10% wasted tokens
✅ Load Time: <500ms for context assembly
```

## 🔧 Dependency Detection Algorithms

### Import Statement Analysis
```javascript
// Example: Parsing JavaScript/TypeScript imports
const importPatterns = {
  es6Import: /import\s+.*\s+from\s+['"](.+)['"]/g,
  requireStatement: /require\(['"](.+)['"]\)/g,
  dynamicImport: /import\(['"](.+)['"]\)/g,
  relativeImport: /^\.\.?\//,
  nodeModules: /^[^.\/]/
};

function analyzeImports(fileContent, filePath) {
  const dependencies = [];
  const matches = fileContent.matchAll(importPatterns.es6Import);
  
  for (const match of matches) {
    const importPath = match[1];
    if (importPatterns.relativeImport.test(importPath)) {
      const resolvedPath = resolvePath(filePath, importPath);
      const targetFolder = getFolderFromPath(resolvedPath);
      dependencies.push({
        source: getFolderFromPath(filePath),
        target: targetFolder,
        type: 'DIRECT_IMPORT',
        strength: calculateStrength(importPath, fileContent)
      });
    }
  }
  return dependencies;
}
```

### Circular Dependency Detection
```markdown
Cycle Detection Algorithm:
1. Build directed dependency graph
2. Perform depth-first search from each node
3. Track visited nodes and recursion stack
4. Flag cycles when revisiting nodes in current path
5. Calculate cycle complexity and impact
6. Suggest refactoring strategies to break cycles

Circular Dependency Mitigation:
- Extract shared interfaces to separate folder
- Use dependency injection patterns
- Implement event-driven communication
- Create adapter/facade patterns for decoupling
```

## 🎯 Context Engineering Integration

### Hierarchical Context Loading
```markdown
Level 1 (Current Folder):
- Load primary .CLAUDE.md context (800 tokens)
- Essential for immediate task understanding

Level 2 (Direct Dependencies):
- Load CORE and STRONG dependency contexts (1-2k tokens)
- Critical for understanding data flow and APIs

Level 3 (Extended Network):
- Load MEDIUM dependency contexts if budget allows
- Useful for broader architectural understanding

Background Cache:
- Preload WEAK dependencies for potential use
- Queue contexts based on developer patterns
```

### Agent Selection Enhancement
```markdown
Dependency-Informed Agent Selection:
- Backend-specialist: Triggered by api/, models/, services/ dependencies
- Frontend-specialist: Triggered by components/, pages/, styles/ dependencies
- DevOps-engineer: Triggered by deploy/, infra/, scripts/ dependencies
- QA-engineer: Triggered by tests/, specs/, e2e/ dependencies

Multi-Agent Coordination:
- Load multiple agents when crossing dependency boundaries
- Coordinate agents based on dependency graph complexity
- Use sub-agent delegation for dependency-heavy workflows
```

---

*This dependency mapper creates intelligent context relationships that enable predictive loading and optimal context assembly.*