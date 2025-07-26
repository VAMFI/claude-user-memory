# Workflow Patterns (Context-Optimized)

## 🔄 Multi-Agent Workflows with Sub-Agent Delegation

### Sequential Patterns (Context-Efficient)
```markdown
Simple Feature Development:
Main Context: product-owner → software-architect → agent selection
Sub-Agent: Specialist implementation (separate context)
Coordination: Results aggregated in main context

Complex Project Workflow:  
Main Context: enterprise-cto → strategic planning
Sub-Agent 1: software-architect (technical design)
Sub-Agent 2: Implementation specialists (development)
Sub-Agent 3: qa-engineer + devops-engineer (deployment)
```

### Parallel Patterns (Sub-Agent Coordination)
```markdown
Emergency Response (Context-Preserving):
Main Context: Coordination hub, status tracking
├─ Sub-Agent A: devops-engineer (infrastructure analysis)
├─ Sub-Agent B: security-engineer (security assessment)  
├─ Sub-Agent C: backend-specialist (application analysis)
└─ Results: Aggregated findings in main context

Performance Investigation:
Main Context: Problem coordination
├─ Sub-Agent 1: devops-engineer (infrastructure metrics)
├─ Sub-Agent 2: backend-specialist (database performance)
├─ Sub-Agent 3: frontend-specialist (client-side optimization)
└─ Synthesis: Integrated solution in main context
```

## 🎯 Context Window Workflow Rules

### When to Use Sub-Agents
```markdown
Criteria for sub-agent delegation:
✅ Main context >120k tokens
✅ Complex multi-step processing required  
✅ Parallel investigation needed
✅ Heavy technical analysis required
✅ Multiple domain expertise needed simultaneously
```

### Workflow Context Management
```markdown
Main Context (Coordination - Keep Lightweight):
- High-level planning and coordination
- Agent selection decisions
- Result aggregation and synthesis
- User communication and guidance
- Context window monitoring

Sub-Agent Context (Processing - Separate):
- Detailed technical analysis
- Complex implementation work
- Heavy documentation generation
- Specialized domain processing
- Intensive workflow execution
```

## 🚨 Context-Aware Emergency Patterns

### Production Incident Response
```markdown
Context Strategy: Parallel investigation with minimal main context usage

Main Context (~15k tokens):
- Incident coordinator (senior-fullstack-developer)
- Status tracking and communication
- Decision aggregation
- User updates and guidance

Sub-Agent Contexts (Separate processing):
├─ Infrastructure team: devops-engineer + monitoring analysis
├─ Security team: security-engineer + breach assessment  
├─ Application team: backend-specialist + error analysis
└─ Recovery coordination: Results synthesis

Benefits:
✅ Main context preserved for coordination
✅ Parallel investigation without token limits
✅ Comprehensive analysis without overflow
✅ Fast response with efficient context usage
```

## 🏗️ Enterprise Workflows (Context-Scalable)

### Large Project Coordination
```markdown
Phase-Based Context Management:

Phase 1 - Strategic Planning (Main Context):
- enterprise-cto: Technology strategy
- software-architect: High-level architecture
- Context preservation: Key decisions documented

Phase 2 - Implementation (Sub-Agent Delegation):
- Sub-projects handled in separate contexts
- Regular sync points in main context
- Progress aggregation without token bloat

Phase 3 - Integration (Controlled Context):
- senior-fullstack-developer: Integration coordination
- Selective module loading based on current needs
- Context optimization throughout process
```

## 💡 Workflow Optimization Strategies

### Context-Efficient Patterns
```markdown
1. Lazy Workflow Loading:
   - Start with minimal agent set
   - Load additional agents only when needed
   - Use sub-agents for heavy processing

2. Strategic Context Breaks:
   - Plan /clear usage between major phases
   - Preserve critical decisions before clearing
   - Resume with focused agent selection

3. Modular Workflow Execution:
   - Break large workflows into focused chunks
   - Use Task tool for sub-workflow delegation
   - Maintain coordination in main context
```

### Performance Monitoring
```markdown
Track workflow efficiency:
- Context usage per workflow phase
- Sub-agent delegation frequency
- Main context preservation success
- User satisfaction with workflow coordination
```

---

Load this module only when complex multi-agent workflows are required. For simple single-agent tasks, the core CLAUDE.md provides sufficient guidance while preserving context capacity.