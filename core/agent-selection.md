# Core Agent Selection Logic

## 🎯 Intelligent Agent Selection System

### Primary Pattern Matching (High Confidence 90%+)

```markdown
Database & Backend:
- Triggers: api|REST|GraphQL|endpoint|microservice|database|SQL|NoSQL|ORM|cache|redis|mongodb|postgresql|backend|server
- Agent: backend-specialist
- Context: Load backend-specialist.md only

Infrastructure & Deployment:
- Triggers: deploy|pipeline|k8s|kubernetes|docker|AWS|Azure|GCP|infrastructure|helm|terraform|ansible|monitoring|CI/CD|automation
- Agent: devops-engineer  
- Context: Load devops-engineer.md only

Frontend & UI:
- Triggers: UI|frontend|React|Vue|Angular|CSS|component|responsive|accessibility|performance|webpack|vite|state management|PWA|mobile
- Agent: frontend-specialist
- Context: Load frontend-specialist.md only

Testing & Quality:
- Triggers: test|QA|quality|bug|automation|cypress|jest|selenium|coverage|regression|integration|performance testing
- Agent: qa-engineer
- Context: Load qa-engineer.md only

Security & Compliance:
- Triggers: security|vulnerability|pentest|compliance|authentication|authorization|encryption|OWASP|GDPR|SOC2|audit|threat modeling
- Agent: security-engineer
- Context: Load security-engineer.md only
```

### 🧠 Decision Process (Context-Optimized)

#### Step 1: Request Analysis
```markdown
1. Parse request for technical keywords
2. Assess complexity level (Simple/Medium/Complex/Emergency)
3. Calculate confidence score for agent selection
4. Check current context window usage
5. Determine loading strategy (single vs multi-agent)
```

#### Step 2: Context-Aware Agent Loading
```markdown
IF single agent + high confidence (>90%):
  → Load specific agent only (~8k tokens)
  → Execute immediately
  
IF multi-agent required:
  → Check context capacity
  → Load core agents sequentially
  → Use sub-agents for heavy processing
  
IF context near limit (>160k tokens):
  → Suggest /clear or /compact first
  → Load minimal agent set
  → Use sub-agent delegation pattern
```

### 🔄 Multi-Agent Coordination (Context-Efficient)

#### Sequential Patterns
```markdown
Simple Feature Development:
product-owner → [context check] → software-architect → [agent selection] → specialists

Complex Project:
enterprise-cto → [/compact suggestion] → software-architect → [sub-agent delegation] → specialists
```

#### Parallel Patterns (Sub-Agent Delegation)
```markdown
Emergency Response:
- Main context: Coordination and summary
- Sub-agent 1: devops-engineer (infrastructure analysis)  
- Sub-agent 2: security-engineer (security assessment)
- Sub-agent 3: backend-specialist (application analysis)
- Results aggregation in main context
```

### ⚡ Context Window Optimization

#### Lazy Loading Strategy
```markdown
1. Load core selection logic first (this file - ~3k tokens)
2. Load specific agent on demand (~8k tokens)
3. Load workflow patterns only when needed
4. Use sub-agents for detailed processing
```

#### Token Conservation
```markdown
Agent Loading Priority:
- Essential: Core selection logic (always loaded)
- On-Demand: Specific agent files (8k each)
- Conditional: Workflow patterns (only if multi-agent)
- Sub-Agent: Heavy processing (separate context)
```

### 🚨 Emergency Context Management

#### Critical Context Alerts
```markdown
When context >180k tokens during agent selection:
1. STOP complex agent loading
2. Alert user immediately
3. Suggest /clear with context preservation
4. Offer sub-agent delegation alternative
```

#### Recovery Procedures
```markdown
Post-/clear Agent Restoration:
1. Load core selection logic only
2. Ask user for task summary
3. Select minimal agent set
4. Use sub-agents for complex workflows
```

### 🎚️ Confidence Scoring (Context-Aware)

#### Confidence Levels & Context Impact
```markdown
Very High (95%+): Single agent, immediate load (~8k tokens)
High (85-94%): Single agent + consultation check (~12k tokens)
Medium (70-84%): Multi-agent planning required (~20k tokens)
Low (50-69%): Clarification needed, minimal loading (~5k tokens)
Very Low (<50%): Structured questions, core logic only (~3k tokens)
```

### 🔧 Sub-Agent Delegation Rules

#### When to Use Sub-Agents
```markdown
Criteria for sub-agent delegation:
- Current context >120k tokens
- Complex multi-step processing required
- Heavy workflow pattern execution needed
- Multiple parallel investigations
```

#### Sub-Agent Communication Pattern
```markdown
Main Context (Coordination):
- Agent selection decisions
- Workflow coordination
- Result aggregation
- User communication

Sub-Agent Context (Processing):  
- Detailed technical analysis
- Heavy computation
- Complex workflow execution
- Specialized domain work
```

### 📊 Performance Monitoring

#### Selection Metrics
```markdown
Track and optimize:
- Agent selection accuracy (>90% target)
- Context window efficiency (minimize token usage)
- Response time (<2 minutes target)
- User satisfaction with selections
```

#### Context Window Metrics
```markdown
Monitor:
- Initial load token usage
- Agent loading token cost
- Workflow pattern token usage
- Sub-agent delegation frequency
```

---

This core agent selection system optimizes for both accuracy and context window efficiency, ensuring intelligent agent selection while preserving context capacity for complex operations.