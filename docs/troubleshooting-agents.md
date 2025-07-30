# Troubleshooting Guide: Stuck Agents

This guide helps you diagnose and resolve issues when Claude Code agents get stuck or fail to log progress properly.

## 🚨 Quick Diagnosis

### Signs an Agent is Stuck
- No progress indicators for > 60 seconds
- No output after initial acknowledgment
- Process seems frozen but Claude Code is still running
- Context window warnings or errors

### Immediate Actions
1. **Check Progress Indicators**
   - 🔍 Starting research...
   - 📦 Detecting version...
   - 🌐 Fetching documentation...
   - ✅ Complete

2. **Use Verbose Mode**
   ```bash
   claude --verbose "Use docs-researcher to find React docs"
   ```

3. **Interrupt if Needed**
   - Press `Ctrl+C` to cancel current operation
   - Use `/clear` to reset context
   - Restart Claude Code if completely frozen

## 🔧 Common Issues & Solutions

### 1. Context Window Full
**Symptoms**: Agent starts but stops mid-operation
**Solution**: 
```bash
/compact  # Reduce context size
/clear    # Full reset (between tasks)
```

### 2. Large Codebase Analysis
**Symptoms**: Planner stuck during "Analyzing codebase..."
**Solution**: 
- Break analysis into smaller directories
- Use specific glob patterns
- Add large build dirs to `.gitignore`

### 3. Network Timeouts
**Symptoms**: Researcher stuck at "Fetching documentation..."
**Solution**:
- Check internet connection
- Try alternative documentation sources
- Use `--verbose` to see exact failure

### 4. Missing Prerequisites
**Symptoms**: Agents immediately fail with "Need ResearchPack" or "Need Plan"
**Solution**:
- Follow the workflow order: Research → Plan → Implement
- Ensure previous agent completed successfully

## 📊 Agent-Specific Timeouts

| Agent | Expected Time | Max Time | Action if Exceeded |
|-------|--------------|----------|-------------------|
| docs-researcher | < 2 min | 3 min | Interrupt, try specific search |
| implementation-planner | < 3 min | 5 min | Break into smaller scope |
| code-implementer | < 5 min | 10 min | Implement in phases |

## 🐞 Debug Commands

### Diagnostic Tools
```bash
# Check installation health
claude doctor

# Verbose mode for detailed logs
claude --verbose [command]

# MCP debugging
claude --mcp-debug

# Report issues
/bug
```

### Performance Monitoring
```bash
# Check resource usage
ps aux | grep claude-code

# Monitor in real-time
top -p $(pgrep -f claude-code)
```

## 🔄 Recovery Procedures

### Soft Reset (Preferred)
1. Save current work state
2. Use `/compact` to reduce context
3. Continue with smaller task scope

### Hard Reset
1. Press `Ctrl+C` to interrupt
2. Use `/clear` to reset context
3. Close and reopen Claude Code
4. Start fresh with smaller task

### Emergency Recovery
1. Force quit: `killall claude-code`
2. Check for corrupted state files
3. Restart terminal
4. Re-run with `--verbose` for diagnostics

## 🎯 Prevention Strategies

### Before Starting
- Break large tasks into phases
- Close Claude Code between major projects
- Clear context regularly
- Use `.gitignore` for large directories

### During Operation
- Watch for progress indicators
- Monitor agent status messages
- Interrupt early if no progress
- Use chunked operations for large files

### Task Design
- Provide specific, scoped requests
- Include version numbers explicitly
- Give agents clear success criteria
- Avoid open-ended explorations

## 📈 Performance Optimization

### Context Management
```bash
# Start fresh for new features
/clear

# Compact when switching contexts
/compact

# Check context usage
/status  # If available
```

### Agent Chaining
```bash
# Good: Explicit workflow
1. Use docs-researcher for React Router v6
2. Use implementation-planner with research
3. Use code-implementer with plan

# Bad: Vague request
"Update everything to latest versions"
```

## 🆘 Getting Help

### Self-Help Resources
1. Check agent progress indicators
2. Use verbose mode for details
3. Review this troubleshooting guide
4. Search error messages

### Reporting Issues
```bash
# In Claude Code
/bug

# On GitHub
https://github.com/anthropics/claude-code/issues
```

### Information to Include
- Exact command used
- Agent that got stuck
- Last progress indicator seen
- Time before timeout
- Verbose mode output

## 🔍 Advanced Debugging

### Log Analysis
```bash
# Find Claude Code logs (location varies)
find ~ -name "*claude*log*" -type f 2>/dev/null

# Tail logs in real-time
tail -f [log-path]
```

### Process Inspection
```bash
# Check open files
lsof -p $(pgrep -f claude-code)

# Stack trace (if supported)
kill -QUIT $(pgrep -f claude-code)
```

---

Remember: The new agent improvements include progress reporting every 30 seconds. If you don't see updates within this timeframe, the agent may be stuck and you should take action.