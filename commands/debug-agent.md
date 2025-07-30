# Debug Agent Command

Debug and troubleshoot agent operations when they get stuck or behave unexpectedly.

## Usage
```
/debug-agent [agent-name or current]
```

## Examples
- `/debug-agent docs-researcher`
- `/debug-agent current`
- `/debug-agent all`

## Diagnostic checks
1. **Context Window**
   - Current usage percentage
   - Tokens remaining
   - Recommendation to clear/compact

2. **Agent Status**
   - Last progress update
   - Current operation
   - Time elapsed

3. **Performance Metrics**
   - Response time
   - Token usage
   - Success rate

## Actions available
- `--verbose`: Enable detailed logging
- `--reset`: Clear agent context
- `--timeout`: Set custom timeout
- `--test`: Run agent self-test

## Common issues diagnosed
- Context window overflow
- Network timeouts
- Missing prerequisites
- Malformed agent files
- Permission issues

## Output includes
- Diagnostic summary
- Recommended fixes
- Performance tips