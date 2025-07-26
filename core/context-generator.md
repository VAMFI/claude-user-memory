# Context Generator Engine

## 🧠 Automatic Folder Analysis & Context Generation

This module implements the core algorithms for analyzing directory structures and automatically generating optimized .CLAUDE.md files that provide contextual knowledge to AI systems.

## 🔍 Folder Analysis Algorithm

### Phase 1: Directory Structure Analysis
```markdown
1. **Scan Directory Tree**: Recursively analyze folder hierarchy
2. **Identify File Types**: Categorize files by extension and purpose
3. **Map Dependencies**: Parse import/export statements and references
4. **Detect Patterns**: Recognize common architectural patterns (MVC, component-based, etc.)
5. **Assess Complexity**: Calculate folder complexity and relationship density
```

### Phase 2: Semantic Analysis
```markdown
1. **Parse File Headers**: Extract docstrings, comments, and metadata
2. **Analyze Function/Class Names**: Infer purpose from naming conventions
3. **Map Data Flow**: Track how data moves between files
4. **Identify Entry Points**: Find main files, configs, and initialization code
5. **Detect Frameworks**: Recognize React, Vue, Express, Django, etc.
```

### Phase 3: Context Generation
```markdown
1. **Synthesize Purpose**: Generate folder responsibility statement
2. **Prioritize Key Files**: Select most important files for documentation
3. **Map Relationships**: Document dependencies and usage patterns
4. **Generate Usage Examples**: Create typical workflow scenarios
5. **Optimize Token Usage**: Ensure context stays within 800-token limit
```

## 🎯 Context Generation Rules

### File Importance Scoring
```markdown
High Priority (Always Include):
- Entry points: index.js, main.py, app.js, server.js
- Configuration: package.json, requirements.txt, config files
- Core modules: Most imported/referenced files
- API definitions: routes, controllers, schemas

Medium Priority (Include if Space):
- Utility functions and helpers
- Type definitions and interfaces
- Test files that reveal functionality
- Documentation and README files

Low Priority (Mention Only):
- Build artifacts and generated files
- Temporary files and logs
- Third-party dependencies
```

### Dependency Mapping Logic
```markdown
Import Analysis:
- Parse `import`, `require`, `from...import` statements
- Track relative imports (../shared, ./utils)
- Identify external package dependencies
- Map circular dependencies and warn

Usage Detection:
- Find files that import from current folder
- Identify reverse dependencies
- Track API consumers and clients
- Map integration points
```

## 🏗️ Context Template Generation

### Dynamic Template Selection
Based on folder analysis, select appropriate template:

#### **API/Backend Folder Template**
```markdown
# [Folder Name] API Context

## Purpose & Responsibility
RESTful API endpoints for [domain] with [authentication/business logic]

## Key Files & Functions
- routes/[resource].js: [HTTP methods] endpoints for [operations]
- controllers/[name].js: Business logic and request handling
- models/[name].js: Data models and database interactions
- middleware/[name].js: Authentication, validation, error handling

## API Endpoints
- GET /[resource]: Retrieve [data type]
- POST /[resource]: Create new [entity]
- PUT /[resource]/:id: Update existing [entity]
- DELETE /[resource]/:id: Remove [entity]

## Dependencies & Relationships
- Database: [PostgreSQL/MongoDB] via [ORM/ODM]
- Authentication: JWT tokens, session management
- External APIs: [service integrations]

## Usage Patterns
[Common request/response cycles and error handling]
```

#### **Component/Frontend Folder Template**
```markdown
# [Folder Name] Components Context

## Purpose & Responsibility
Reusable UI components for [feature/page] with [state management]

## Key Files & Functions
- [Component].jsx: Main component with [props/state]
- [Component].styles.js: Styled components and CSS-in-JS
- index.js: Component exports and public API
- types.ts: TypeScript interfaces and prop definitions

## Component API
- Props: [prop descriptions and types]
- Events: [callback functions and handlers]
- Slots/Children: [composition patterns]

## Dependencies & Relationships
- UI Library: [Material-UI/Ant Design/styled-components]
- State: [Redux/Context/local state]
- Parent Components: [usage contexts]

## Usage Patterns
[Common composition and integration examples]
```

#### **Generic Folder Template**
```markdown
# [Folder Name] Context

## Purpose & Responsibility
[Inferred purpose based on file analysis]

## Key Files & Functions
[Top 3-5 most important files with descriptions]

## Dependencies & Relationships
[Import/export mapping and usage patterns]

## Common Patterns & Usage
[Typical workflows and interaction examples]
```

## 🚀 Context Generation Commands

### Primary Generation Command
**Trigger**: `"Generate context for this folder"`

**Algorithm**:
1. Analyze current working directory structure
2. Apply semantic analysis to understand purpose
3. Select appropriate template based on folder type
4. Generate optimized .CLAUDE.md with 800-token target
5. Save file and report generation metrics

### Batch Generation Command  
**Trigger**: `"Analyze this codebase and generate folder contexts"`

**Algorithm**:
1. Recursively scan project directory tree
2. Identify all folders that need context generation
3. Prioritize by importance (most-used folders first)
4. Generate contexts in dependency order
5. Create cross-folder relationship mappings
6. Report generation statistics and recommendations

### Update Context Command
**Trigger**: `"Update context for this folder"`

**Algorithm**:
1. Load existing .CLAUDE.md file
2. Re-analyze folder for changes
3. Compute diff between old and new analysis
4. Merge updates while preserving manual customizations
5. Optimize token usage and relationships

## 📊 Context Quality Metrics

### Generation Success Indicators
```markdown
✅ Context Token Count: 600-800 tokens (optimal range)
✅ Key File Coverage: >80% of important files documented
✅ Dependency Accuracy: All major imports/exports mapped
✅ Purpose Clarity: Clear, specific responsibility statement
✅ Usage Examples: Practical workflow demonstrations
```

### Quality Optimization
```markdown
Token Optimization:
- Prioritize most important information first
- Use concise, technical language
- Avoid redundant descriptions
- Focus on AI-actionable insights

Accuracy Validation:
- Cross-reference with actual file contents
- Verify import/export statements
- Validate framework and pattern detection
- Test context usefulness in real scenarios
```

## 🔧 Implementation Triggers

### Automatic Generation Triggers
```markdown
File System Events:
- New folder creation → Generate initial context
- Significant file additions (>3 new files) → Regenerate context
- Package.json changes → Update dependency context
- Major refactoring → Full context refresh

Development Workflow Triggers:
- Git branch creation → Generate contexts for new features
- Pull request merge → Update affected folder contexts
- Release preparation → Validate all context accuracy
```

### Manual Generation Triggers
```markdown
Developer Commands:
- "Generate context for this folder"
- "Analyze and document this codebase"
- "Update all folder contexts"
- "Validate context accuracy"
```

## 🎯 Context Engineering Integration

This context generator is the core engine that enables:
- **Hierarchical Context Loading**: Generates the folder-level contexts
- **Smart Agent Selection**: Provides contextual triggers for agent selection
- **Living Documentation**: Keeps contexts current with code evolution
- **Performance Optimization**: Maintains optimal token usage across all contexts

---

*This context generator transforms static folders into intelligent, AI-readable knowledge structures.*