# Execute Implementation Command

Execute implementation plans with surgical precision using the code-implementer agent.

## Usage
```
/implement [plan reference]
```

## Prerequisites
- Must have Implementation Plan from planner
- Must have ResearchPack for API references

## Examples
- `/implement the OAuth2 plan`
- `/implement database migration plan phase 1`
- `/implement the WebSocket notification system`
- `/implement Stripe integration following the plan`

## What it does
1. 🚀 Validates prerequisites
2. 📝 Makes incremental file changes
3. 🧪 Runs tests after each change
4. ✅ Reports completion status

## Progress tracking
- File-by-file updates
- Test results after changes
- Build verification
- Clear error reporting

## Tips
- Review the plan first
- Commit before major implementations
- Use verbose mode for debugging
- Implement in phases for large changes