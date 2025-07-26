# Context Window Management System

## 🧠 Context Window Monitoring & Optimization

### Context Window Limits
- **Total Capacity**: ~200k tokens (Claude models)
- **Safe Operating Zone**: <160k tokens (80% capacity)  
- **Warning Zone**: 160k-180k tokens (80-90% capacity)
- **Critical Zone**: >180k tokens (90%+ capacity)
- **Reserved Buffer**: 40k tokens (20%) for complex reasoning

### 🚨 Proactive Context Management

#### Automatic Monitoring
Claude will continuously monitor context usage and provide warnings:

```markdown
🔍 Context Window Status:
- Current Usage: [X]k tokens ([Y]% of capacity)
- Safe Zone: ✅ <160k tokens  
- Warning Zone: ⚠️ 160k-180k tokens
- Critical Zone: 🚨 >180k tokens
```

#### User Warning System
When approaching context limits, Claude will proactively alert:

**Warning at 160k tokens (80%):**
```
⚠️ CONTEXT WINDOW WARNING ⚠️
Current usage: 160k tokens (80% capacity)

RECOMMENDED ACTIONS:
1. Use /clear command to reset context if safe
2. Use /compact to summarize conversation  
3. Consider completing current task before proceeding

Would you like me to suggest a safe point to use /clear?
```

**Critical Alert at 180k tokens (90%):**
```
🚨 CRITICAL CONTEXT WINDOW ALERT 🚨
Current usage: 180k tokens (90% capacity)

IMMEDIATE ACTION REQUIRED:
1. STOP current complex operations
2. Use /clear command NOW to prevent overflow
3. Save important context before clearing

⚠️ Performance degradation imminent - /clear recommended immediately ⚠️
```

### 💡 /clear Command Integration

#### Safe /clear Usage Guidance
Before suggesting `/clear`, Claude will:

1. **Assess Current State**:
   - Identify critical information to preserve
   - Check if in middle of complex operation
   - Evaluate user's progress on current task

2. **Provide Clear Instructions**:
   ```
   📋 SAFE /clear PREPARATION:
   
   BEFORE using /clear:
   ✅ Current task status: [completed/in-progress/just-started]
   ✅ Important context to remember: [list key points]
   ✅ Files/agents currently active: [list]
   
   AFTER using /clear:
   ✅ Reload claude-user-memory system (automatic)
   ✅ Reference this summary: [provide key context summary]
   ✅ Continue with: [next recommended action]
   ```

3. **Smart /clear Timing**:
   - Suggest `/clear` between major tasks
   - Avoid during complex multi-agent workflows
   - Recommend at natural breakpoints

#### Context Preservation Strategy
When `/clear` is necessary, Claude will provide:

```markdown
📝 CONTEXT PRESERVATION SUMMARY:
Before using /clear, save this summary:

Current Project: [project description]
Active Agents: [list of agents being used]
Progress Status: [what's been completed]
Next Steps: [what needs to happen next]
Important Decisions: [key choices made]
User Preferences: [remembered patterns]

After /clear, provide this summary to restore context efficiently.
```

### 🔄 Context Window Recovery

#### Post-/clear Restoration
After user executes `/clear`:

1. **Automatic System Reload**: Claude reloads user memory system
2. **Context Summary Request**: Ask user to provide preservation summary
3. **Selective Module Loading**: Load only necessary modules
4. **Agent Selection**: Re-establish relevant agents based on summary

#### Emergency Context Recovery
For unexpected context overflow:

```markdown
🚨 EMERGENCY CONTEXT RECOVERY PROTOCOL:

1. IMMEDIATE /clear execution
2. System restart with minimal core loading
3. User summary request for critical context
4. Selective module restoration
5. Gradual capability rebuilding
```

### 📊 Context Optimization Strategies

#### Modular Loading Pattern
```markdown
Context-Aware Module Loading:
- Load core agent selection (5-8k tokens)
- Load specific context modules on demand
- Use sub-agents for heavy processing
- Delegate complex workflows to separate contexts
```

#### Token Conservation Techniques
1. **Lazy Loading**: Load modules only when needed
2. **Sub-Agent Delegation**: Process heavy tasks in separate contexts
3. **Selective Context**: Include only relevant agent capabilities
4. **Dynamic Unloading**: Remove unused modules from context

### 🎯 User Education & Guidance

#### Context Window Best Practices
```markdown
📚 CONTEXT WINDOW EDUCATION:

For Users:
✅ Understand /clear resets conversation memory
✅ Use /compact for summarization without reset
✅ Break large tasks into smaller chunks
✅ Save important information before /clear
✅ Monitor context warnings and act promptly

For Claude:
✅ Proactively monitor token usage
✅ Warn before reaching critical levels
✅ Suggest optimal /clear timing
✅ Provide comprehensive context preservation
✅ Guide efficient context restoration
```

#### Context Window Commands
- `/clear` - Complete context reset (nuclear option)
- `/compact` - Summarize conversation, preserve context
- Context status request: "What's my current context usage?"
- Module loading request: "Load [specific module] only"

### 🛡️ Safety Measures

#### Prevent Context Overflow
1. **Hard Stop at 185k tokens**: Refuse complex operations
2. **Auto-suggest /clear**: When safe to do so  
3. **Emergency protocols**: For unexpected overflow
4. **Graceful degradation**: Reduce functionality before failing

#### Context Recovery Protocols
1. **Preservation checklists** before /clear
2. **Restoration procedures** after /clear
3. **Backup context strategies** for critical operations
4. **Emergency recovery plans** for context loss

---

This context management system ensures optimal performance while preserving user experience and critical information through intelligent context window monitoring and proactive `/clear` command guidance.