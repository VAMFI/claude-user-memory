# Claude User Memory - Context-Optimized Agent Orchestration

This Claude user memory system provides intelligent, context-aware orchestration of 12 specialized AI agents while actively managing the 200k token context window limit.

## 🧠 Context Window Management

**CRITICAL**: This system actively monitors context usage and will warn you when approaching limits.

- **Safe Zone**: <160k tokens (80% capacity) ✅
- **Warning Zone**: 160k-180k tokens ⚠️  
- **Critical Zone**: >180k tokens 🚨

**When warned about context limits, use `/clear` command to reset context safely.**

## 🚀 Core Agent Selection

### 12 Available Specialists
| Agent | Triggers | Load Size |
|-------|----------|-----------|
| **backend-specialist** | `api, database, REST, GraphQL, server` | ~8k tokens |
| **devops-engineer** | `deploy, docker, kubernetes, CI/CD` | ~8k tokens |
| **frontend-specialist** | `React, Vue, Angular, UI, CSS` | ~8k tokens |
| **qa-engineer** | `test, quality, automation, cypress` | ~8k tokens |
| **security-engineer** | `security, auth, compliance, OWASP` | ~8k tokens |
| **senior-fullstack-developer** | `fullstack, integration, mentoring` | ~8k tokens |
| **software-architect** | `architecture, design, patterns` | ~7k tokens |
| **product-owner** | `requirements, user stories, MVP` | ~7k tokens |
| **engineering-manager** | `team, process, planning, velocity` | ~6k tokens |
| **project-manager** | `timeline, resources, coordination` | ~9k tokens |
| **enterprise-cto** | `strategy, governance, enterprise` | ~5k tokens |
| **technical-writer** | `documentation, API specs, guides` | ~9k tokens |

## 🎯 Intelligent Selection Process

### Single Agent (High Confidence 90%+)
For clear requests with specific technical keywords:
- **Direct loading**: Load specific agent only (~8k tokens)
- **Immediate execution**: No additional modules needed
- **Examples**: "Create REST API", "Deploy to production", "Fix React component"

### Multi-Agent (Complex Requests)
For complex projects requiring coordination:
- **Sub-agent delegation**: Use separate contexts for heavy processing
- **Sequential coordination**: Load agents as needed
- **Context preservation**: Maintain workflow state efficiently

## 🚨 Context Window Alerts

### Proactive Monitoring
Claude will automatically alert you:

**At 160k tokens (80%):**
```
⚠️ CONTEXT WINDOW WARNING ⚠️
Recommend using /clear or /compact before continuing
```

**At 180k tokens (90%):**
```
🚨 CRITICAL: Use /clear command immediately to prevent overflow
Performance degradation imminent
```

### Safe /clear Usage
Before using `/clear`, Claude will:
1. Summarize current progress
2. List active agents and tasks
3. Provide context preservation guide
4. Suggest optimal timing

## 🔄 Modular System Architecture

### On-Demand Loading
Instead of loading all capabilities, this system:
- **Loads core logic first** (~8k tokens)
- **Loads specific agents on demand** (~8k each)
- **Uses sub-agents for complex workflows**
- **Preserves context for user tasks**

### Additional Modules (Load When Needed)
Request specific modules using the Task tool:
- `core/context-management.md` - Detailed context strategies
- `core/workflow-patterns.md` - Complex multi-agent workflows  
- `contexts/startup-context.md` - Startup-specific patterns
- `contexts/enterprise-context.md` - Enterprise-scale workflows
- `examples/usage-examples.md` - Comprehensive examples

## 💡 Usage Patterns

### Simple Requests
```
"Create a REST API for users"
→ Loads backend-specialist only (~8k tokens)
→ Direct implementation
```

### Complex Projects  
```
"Build e-commerce platform"
→ Uses sub-agent delegation
→ Coordinates multiple specialists in separate contexts
→ Preserves main context for coordination
```

### Context Management
```
"What's my context usage?"
→ Reports current token usage
→ Suggests optimization if needed
```

## 🛠️ Emergency Procedures

### Context Overflow Prevention
1. **Monitor constantly**: Track token usage during operations
2. **Early warning**: Alert at 80% capacity
3. **Graceful degradation**: Reduce functionality before failing
4. **Emergency /clear**: Guide safe context reset

### Recovery After /clear
1. **Reload core system** (this file)
2. **Request context summary** from user
3. **Load minimal agent set** for current task
4. **Use sub-agents** for complex processing

## 🎓 Best Practices

### For Users
- **Monitor context warnings** and act promptly
- **Use /clear between major task changes**
- **Save important information before /clear**
- **Break large projects into smaller chunks**

### For Claude
- **Load only necessary agents**
- **Use sub-agent delegation for heavy processing**
- **Provide clear context preservation guidance**
- **Monitor token usage continuously**

---

## 🚀 Quick Start

1. **Request specific help**: Use clear technical keywords
2. **Monitor context**: Watch for warning messages
3. **Use /clear safely**: When guided by Claude
4. **Load modules on demand**: Ask for specific additional capabilities

**This context-optimized system ensures optimal performance while preserving your valuable context for productive development work.**

---

*Your Claude User Memory - Intelligent, Context-Aware, Efficient* 🧠