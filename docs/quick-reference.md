# 🚀 Claude Code Workflow Quick Reference

> One-page reference for the Research → Plan → Implement workflow

## Workflow Overview

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  1. RESEARCH │ -> │   2. PLAN    │ -> │ 3. IMPLEMENT │
├──────────────┤    ├──────────────┤    ├──────────────┤
│    docs-     │    │implementation│    │    code-     │
│  researcher  │    │   -planner   │    │ implementer  │
└──────────────┘    └──────────────┘    └──────────────┘
```

## Quick Commands

### Start the Workflow
```bash
# Automatic (Claude selects agents)
> Add Redis caching to my application

# Manual control
> Use docs-researcher to research Redis
> Use implementation-planner to design caching strategy
> Use code-implementer to add Redis caching
```

### Skip Phases (When You Have Artifacts)
```bash
# Skip research (you have docs)
> I have Redis documentation. Plan the caching implementation.

# Skip to implementation (you have both)
> I have the ResearchPack and Plan. Execute it.
```

## Agent Triggers

### 📚 docs-researcher
| Keyword | Example |
|---------|---------|
| documentation | "Find React 18 documentation" |
| API reference | "API reference for Stripe" |
| how to use | "How to use MongoDB aggregation" |
| library/framework | "Research Express.js framework" |
| version/upgrade | "Upgrade guide for Node 18" |

### 📋 implementation-planner
| Keyword | Example |
|---------|---------|
| plan | "Plan the authentication system" |
| design | "Design database schema" |
| architecture | "Architecture for microservices" |
| what files | "What files need changes?" |
| strategy | "Implementation strategy for caching" |

### 🚀 code-implementer
| Keyword | Example |
|---------|---------|
| implement the plan | "Implement the plan" |
| execute | "Execute the changes" |
| apply | "Apply the migration plan" |
| make changes | "Make the planned changes" |

## Common Workflows

### New Feature
```bash
> Add Stripe payments to our SaaS
# 1. Research Stripe SDK
# 2. Plan integration 
# 3. Implement payments
```

### Update Dependencies
```bash
> Update React Router from v5 to v6
# 1. Research migration guide
# 2. Plan phased update
# 3. Execute migration
```

### Debug Issues
```bash
> MongoDB connection timeouts in production
# 1. Research connection best practices
# 2. Analyze and provide solution
```

### Performance Optimization
```bash
> Optimize database query performance
# 1. Research optimization techniques
# 2. Plan specific improvements
# 3. Implement optimizations
```

## Task Tool Usage

### Complex Research
```bash
> Use Task tool with docs-researcher to research OAuth2 providers
```

### Multi-Phase Planning
```bash
> Use Task tool with implementation-planner for microservices migration
```

### Large Implementation
```bash
> Use Task tool with code-implementer to refactor authentication system
```

## Key Concepts

### ResearchPack Contents
- ✓ Official documentation
- ✓ Version information
- ✓ API references
- ✓ Code examples
- ✓ Migration guides
- ✓ All sources linked

### Implementation Plan Contents
- ✓ File-by-file changes
- ✓ Step-by-step procedure
- ✓ Test criteria
- ✓ Risk assessment
- ✓ Rollback strategy

### Workflow Rules
1. **No research** → No planning
2. **No plan** → No implementation
3. **Always verify** versions
4. **Always test** changes
5. **Always plan** rollbacks

## Best Practices Checklist

### ✅ Research Phase
- [ ] Specify exact versions
- [ ] Focus on specific features
- [ ] Verify documentation is current
- [ ] Check for breaking changes

### ✅ Planning Phase
- [ ] Keep changes minimal
- [ ] Include all test criteria
- [ ] Plan rollback strategy
- [ ] Document assumptions

### ✅ Implementation Phase
- [ ] Follow plan exactly
- [ ] Make atomic commits
- [ ] Run all tests
- [ ] Document any deviations

## Common Mistakes to Avoid

### ❌ DON'T
- Skip research for "simple" features
- Plan without complete research
- Implement without a plan
- Make changes beyond the plan
- Skip verification steps

### ✅ DO
- Research even familiar libraries
- Plan even simple changes
- Test incrementally
- Document decisions
- Verify at each step

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Can't find docs | Specify exact library name/version |
| Research incomplete | Request specific missing info |
| Plan too complex | Break into phases |
| Implementation differs from plan | Stop and update plan first |
| Tests failing | Fix before proceeding |

## Emergency Commands

```bash
# When things go wrong
> The implementation isn't matching the plan
> Tests are failing after implementation
> I need to rollback the changes

# Get help
> Show me the current ResearchPack
> Show me the Implementation Plan
> What's the rollback procedure?
```

## Workflow Patterns

### Pattern: Feature Addition
```
Research API → Plan integration → Implement feature
```

### Pattern: Dependency Update  
```
Research changes → Plan migration → Execute update
```

### Pattern: Bug Fix
```
Research correct behavior → Plan fix → Implement solution
```

### Pattern: Performance Optimization
```
Research techniques → Plan improvements → Apply optimizations
```

---

**Remember**: Research → Plan → Implement. Always in that order.

Need more detail? See the [Full Workflow Guide](workflow-guide.md)