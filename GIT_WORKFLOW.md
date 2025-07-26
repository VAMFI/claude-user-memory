# Git Workflow & Branching Strategy

## 🌳 Branch Structure

```
main (production-ready)
├── develop (integration branch) 
├── feature/* (new features)
│   ├── feature/context-optimization-*
│   ├── feature/agent-enhancement-*
│   └── feature/workflow-patterns-*
├── hotfix/* (urgent production fixes)
├── debug/* (investigation branches)
└── experimental/* (research branches)
```

## 📋 Branching Rules

### Main Branch Protection
- **No direct commits** to `main` branch
- All changes must go through Pull Request review
- Require at least 1 approval for merges
- Enforce linear history (squash and merge)

### Feature Development
- **Create feature branch** for any change >500 tokens
- **Use descriptive names**: `feature/context-window-optimization`
- **Keep branches focused**: One feature per branch
- **Regular rebasing**: Keep up to date with main

### Large Feature Management
- **Sub-feature branches** for changes >10k tokens
- **Break into logical chunks**: Each addressing specific concern
- **Example structure**:
  ```
  feature/context-optimization-foundation
  ├── feature/modular-architecture
  ├── feature/context-monitoring  
  └── feature/user-warnings
  ```

### Debug & Hotfix Strategy
- **Debug branches** for troubleshooting context issues
- **Hotfix branches** from main for urgent production fixes
- **Quick turnaround**: Merge directly to main after review

## 🚀 Workflow Process

### 1. Feature Development
```bash
# Start new feature
git checkout main
git pull origin main
git checkout -b feature/your-feature-name

# Work and commit
git add .
git commit -m "feat: descriptive commit message"

# Push and create PR
git push -u origin feature/your-feature-name
gh pr create --title "Feature: Your Feature Name" --body "Description"
```

### 2. Code Review Process
- **Review requirements**: Code quality, documentation, testing
- **Context window impact**: Verify token usage optimization
- **Performance testing**: Ensure no degradation
- **Approval required**: At least 1 reviewer approval

### 3. Merge Strategy
- **Squash and merge** for clean history
- **Delete branch** after successful merge
- **Update local main** after merge

## 🎯 Context Window Considerations

### Branch Creation Triggers
- **Token impact >1k**: Create feature branch
- **Multiple file changes**: Use feature branch
- **Complex logic changes**: Use feature branch
- **Experimental features**: Use experimental branch

### Context Window Testing
- **Test token usage** before creating PR
- **Verify modular loading** works correctly
- **Check performance impact** on agent selection
- **Validate user experience** with new features

## 📊 Commit Message Convention

```
type(scope): description

Types:
- feat: New feature
- fix: Bug fix  
- docs: Documentation changes
- style: Formatting changes
- refactor: Code restructuring
- perf: Performance improvements
- test: Adding tests
- chore: Maintenance tasks

Examples:
- feat(context): add proactive context monitoring
- fix(agents): resolve token overflow in selection logic
- docs(workflow): update branching strategy guide
- perf(loading): optimize module lazy-loading
```

## 🛡️ Branch Protection Rules

### Main Branch
- Require pull request reviews (1 minimum)
- Require status checks to pass
- Require branches to be up to date
- Restrict pushes that create merge commits
- Require signed commits (recommended)

### Develop Branch (Future)
- Require pull request reviews
- Allow force pushes (for rebasing)
- Require linear history

## 🚨 Emergency Procedures

### Hotfix Process
```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-fix-name

# Fix and test
git add .
git commit -m "hotfix: critical issue description"

# Create emergency PR
git push -u origin hotfix/critical-fix-name
gh pr create --title "HOTFIX: Critical Issue" --body "Emergency fix for production"
```

### Context Window Emergency
- **Immediate /clear**: If context >180k tokens
- **Emergency modularization**: Split large files immediately
- **Debug branch**: `debug/context-overflow-investigation`
- **Hotfix branch**: `hotfix/context-window-emergency`

## 📈 Metrics & Monitoring

### Branch Health Metrics
- Average PR size (target: <2k tokens)
- Time to merge (target: <24 hours)
- Number of active branches (target: <10)
- Context window impact per PR

### Quality Gates
- All tests passing
- Documentation updated
- Context window impact assessed
- Performance impact measured
- Security considerations reviewed

## 🎓 Best Practices

### Do's
- ✅ Use descriptive branch names
- ✅ Keep branches small and focused
- ✅ Write clear commit messages
- ✅ Test context window impact
- ✅ Update documentation
- ✅ Delete merged branches

### Don'ts
- ❌ Commit directly to main
- ❌ Create overly large PRs
- ❌ Use vague commit messages
- ❌ Ignore context window limits
- ❌ Leave branches stale
- ❌ Skip code review process

---

This workflow ensures professional development practices while specifically addressing context window optimization needs for the Claude User Memory system.