# Claude User Memory v2.0 - Examples

Comprehensive examples demonstrating the Research → Plan → Implement workflow with quality gates and self-correction.

---

## 📚 Available Examples

### Beginner

**[01-simple-api-integration.md](./01-simple-api-integration.md)** ⭐
- **Scenario**: Add OpenWeather API to show current weather
- **Time**: ~10 minutes
- **Features**: Research, planning, implementation, self-correction
- **Demonstrates**: Basic workflow, API integration, error handling

### Intermediate

**02-caching-layer-implementation.md** ⭐⭐ *(Coming soon)*
- **Scenario**: Add Redis caching with TTL configuration
- **Time**: ~15 minutes
- **Features**: Service layer pattern, configuration management
- **Demonstrates**: Multiple file changes, testing, rollback procedures

**03-authentication-middleware.md** ⭐⭐ *(Coming soon)*
- **Scenario**: Add JWT authentication middleware
- **Time**: ~20 minutes
- **Features**: Security best practices, middleware pattern
- **Demonstrates**: Security review, comprehensive testing

### Advanced

**04-database-migration.md** ⭐⭐⭐ *(Coming soon)*
- **Scenario**: Add new table with relationships and migrations
- **Time**: ~25 minutes
- **Features**: Database schema, ORM integration, data migrations
- **Demonstrates**: Reversibility, data integrity, migration rollback

**05-microservice-integration.md** ⭐⭐⭐ *(Coming soon)*
- **Scenario**: Connect to external microservice with circuit breaker
- **Time**: ~30 minutes
- **Features**: Service mesh, resilience patterns, monitoring
- **Demonstrates**: Complex integration, failure handling, observability

**06-full-feature-orchestration.md** ⭐⭐⭐⭐ *(Coming soon)*
- **Scenario**: Complete e-commerce checkout flow (cart + payment + inventory)
- **Time**: ~45 minutes
- **Features**: Multi-agent coordination, parallel execution
- **Demonstrates**: Chief-architect orchestration, complex workflows

---

## 🎯 Learning Path

### Path 1: Quick Start (30 minutes)
1. Example 01 (Simple API) - Learn basics
2. Example 02 (Caching) - Learn patterns
3. Example 03 (Auth) - Learn security

### Path 2: Full Mastery (2 hours)
1. All beginner examples
2. All intermediate examples
3. All advanced examples
4. Build your own feature using the workflow

---

## 📖 How to Use These Examples

### Step 1: Read the Scenario
Each example starts with a clear user request and expected outcome.

### Step 2: Follow the Workflow
Watch how the system progresses through:
- **Research** → Creates ResearchPack
- **Planning** → Creates Implementation Plan
- **Implementation** → Executes with self-correction
- **Validation** → Quality gates and knowledge capture

### Step 3: Try It Yourself
At the end of each example, try a similar task in your own project.

### Step 4: Review Learnings
Each example highlights:
- ✅ What worked well
- ❌ Common pitfalls avoided
- 💡 Best practices demonstrated
- ⏱️ Time breakdown

---

## 🔑 Key Concepts Demonstrated

### Quality Gates
- **ResearchPack validation** - Ensures 80+ score before planning
- **Plan validation** - Ensures 85+ score before coding
- **API matching** - Verifies plan uses exact APIs from research

### Self-Correction
- **3-retry protocol** - Automatic error recovery
- **Error categorization** - Different strategies per error type
- **Circuit breaker** - Prevents infinite loops

### Knowledge Capture
- **Automatic pattern recognition** - Learns from successful implementations
- **knowledge-core.md updates** - Preserves institutional knowledge
- **Decision logging** - Records "why" behind choices

### Workflow Enforcement
- **Deterministic hooks** - Always run (not LLM-dependent)
- **Can't skip phases** - Must research before planning, plan before coding
- **Rollback procedures** - Every change is reversible

---

## 🛠️ Running the Examples

### Prerequisites
- Claude Code CLI v2.0.20+
- claude-user-memory v2.0 installed
- A test project to work in

### Setup
```bash
# Clone or install claude-user-memory
cd your-project/
cp -r /path/to/claude-user-memory/.claude .

# Verify setup
ls -la .claude/agents/
ls -la .claude/skills/
ls -la .claude/hooks/
```

### Execute
```bash
# Start Claude Code CLI
claude

# In Claude CLI, invoke agents:
@docs-researcher "..."
@implementation-planner "..."
@code-implementer "..."

# Or use chief-architect for complete workflow:
@chief-architect "Build feature X"
```

---

## 📊 Example Comparison

| Example | Difficulty | Time | Files Changed | Self-Corrections | Patterns Captured |
|---------|-----------|------|---------------|------------------|-------------------|
| 01-API | ⭐ | 10min | 4 | 1 | 2 |
| 02-Cache | ⭐⭐ | 15min | 5 | 1 | 3 |
| 03-Auth | ⭐⭐ | 20min | 6 | 2 | 4 |
| 04-DB | ⭐⭐⭐ | 25min | 8 | 2 | 5 |
| 05-Micro | ⭐⭐⭐ | 30min | 10 | 3 | 6 |
| 06-Full | ⭐⭐⭐⭐ | 45min | 15 | 3 | 8 |

---

## 🎓 What You'll Learn

By completing all examples, you'll master:

✅ **Research methodology** - Finding authoritative, version-accurate docs
✅ **Planning methodology** - Creating minimal-change, reversible plans
✅ **Implementation with self-correction** - Automatic error recovery
✅ **Quality validation** - Objective scoring and gates
✅ **Pattern recognition** - Building institutional knowledge
✅ **Multi-agent orchestration** - Coordinating complex workflows
✅ **Error handling** - Circuit breakers and graceful degradation
✅ **Knowledge management** - Preserving learnings across sessions

---

## 🆘 Troubleshooting

### Validation Fails
- **Research score < 80**: Add more APIs, setup steps, or examples
- **Plan score < 85**: Add rollback plan, risk assessment, or verification steps
- **API mismatch**: Ensure plan uses exact APIs from research

### Implementation Fails
- **Tests fail**: Check self-correction attempts (up to 3)
- **Circuit breaker opens**: Reset with `.claude/validators/circuit-breaker.sh AGENT reset`
- **Infinite loop**: Circuit breaker prevents this automatically

### Knowledge Not Captured
- **Stop hook didn't run**: Check `.claude/hooks/update-knowledge-core.sh` is executable
- **Patterns not identified**: Use `@pattern-recognition` skill explicitly
- **knowledge-core.md not updating**: Check file permissions

---

## 🚀 Next Steps

After completing these examples:

1. **Build your own feature** - Apply the workflow to real work
2. **Customize agents** - Edit `.claude/agents/*.md` for your needs
3. **Add custom skills** - Create skills for your domain
4. **Share patterns** - Contribute back to the community

---

## 📝 Contributing Examples

Have a great example? Contribute it!

1. Follow the example template (see example 01)
2. Include: Scenario, Workflow, Complete outputs, Learnings
3. Test it works end-to-end
4. Submit PR to the repository

---

**Happy learning! 🎉**

*Examples created for claude-user-memory v2.0*
*Last updated: 2025-10-17*
