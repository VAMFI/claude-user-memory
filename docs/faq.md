# ❓ Frequently Asked Questions

> Common questions about the Claude Code Workflow Agents

## General Questions

### What are Claude Code Workflow Agents?
They are three specialized AI agents that enforce a systematic Research → Plan → Implement workflow for software development. Instead of jumping straight into coding, they ensure every change is researched, planned, and then precisely implemented.

### Why three agents instead of one?
Each agent has a focused responsibility:
- **docs-researcher**: Specializes in finding current documentation
- **implementation-planner**: Expert at creating safe, minimal change plans
- **code-implementer**: Precision-focused on executing plans exactly

This separation ensures quality at each phase and prevents shortcuts.

### Do I have to use all three agents?
Yes, for the full workflow. However, you can:
- Use just docs-researcher for research-only tasks
- Skip to planning if you already have documentation
- Jump to implementation if you have both research and plan

### Is this slower than just coding?
Initially, yes. But you save time by:
- Avoiding bugs from outdated practices
- Preventing large refactors
- Having clear rollback paths
- Creating documentation as you go

## Installation & Setup

### Where do the agents get installed?
Agents are copied to `~/.claude/agents/` for global use, or `.claude/agents/` in a specific project for project-only use.

### Can I modify the agents?
Yes! The agents are markdown files you can customize. Just maintain the YAML frontmatter structure.

### Do the agents work with Claude Code Pro/Enterprise?
Yes, they're compatible with all Claude Code versions.

### Can I use these agents in VS Code or other IDEs?
Currently, they're designed for Claude Code CLI. IDE support depends on Claude Code's IDE extensions.

## Workflow Questions

### What if I already know the library well?
Still research! Libraries change frequently. The research phase often reveals:
- Deprecated methods you might use
- New best practices
- Security updates
- Performance improvements

### Can I skip the planning phase for simple changes?
We recommend always planning because:
- "Simple" changes often have hidden complexity
- Plans include rollback strategies
- It creates documentation
- It prevents scope creep

### What's a ResearchPack?
A structured document containing:
- Official documentation excerpts
- Version-specific information
- Code examples
- Migration guides
- All sources linked

### What's an Implementation Plan?
A detailed blueprint containing:
- Specific file changes
- Step-by-step procedures
- Test criteria
- Risk assessment
- Rollback procedures

### Can I modify the plan during implementation?
No, the implementation phase follows the plan exactly. If changes are needed:
1. Stop implementation
2. Update the plan
3. Review changes
4. Resume implementation

## Technical Questions

### How do the agents know which libraries I'm using?
They examine your project files:
- `package.json` for Node.js
- `requirements.txt` for Python
- `pom.xml` for Java
- And other standard dependency files

### What if documentation isn't available?
The agent will:
1. Check official GitHub repositories
2. Look for community resources
3. Suggest alternatives
4. Warn about the risks

### How do I use the Task tool with these agents?
```bash
> Use Task tool with docs-researcher to research multiple libraries
> Use Task tool with implementation-planner for complex architectures
> Use Task tool with code-implementer for large refactoring
```

### Can agents work in parallel?
No, they work sequentially by design:
- Research produces data for planning
- Planning produces blueprint for implementation
- Each phase depends on the previous

## Troubleshooting

### "No ResearchPack found"
**Solution**: Complete research phase first
```bash
> Use docs-researcher to research [topic]
```

### "Plan is incomplete"
**Solution**: The planner needs more information
```bash
> Provide more details about [specific requirements]
```

### "Implementation doesn't match plan"
**Solution**: Stop and update the plan
```bash
> The codebase structure differs from the plan assumptions
```

### Agents not auto-selecting
**Solution**: Use trigger keywords or be explicit
```bash
# Explicit
> Use docs-researcher to find React documentation

# Keywords that trigger
> I need documentation for React hooks
> Plan the authentication system
> Implement the changes
```

### Research taking too long
**Solution**: Be more specific
```bash
# Too broad
> Research React

# Better
> Research React useEffect hook for data fetching
```

## Best Practices

### How specific should my requests be?
Very specific! Compare:
- ❌ "Add authentication"
- ✅ "Add JWT authentication to Express API with refresh tokens"

### Should I review the ResearchPack?
Yes! It contains valuable information that helps you:
- Understand what will be implemented
- Catch potential issues early
- Learn new best practices

### When should I use Task tool?
For complex operations that need extended processing:
- Researching multiple technologies
- Creating architectural plans
- Large-scale refactoring

### How do I handle urgent fixes?
Even urgent fixes benefit from the workflow:
1. Quick research (5 min) prevents wrong fixes
2. Brief plan (2 min) ensures clean implementation
3. Focused implementation with verification

## Migration from Traditional Development

### I'm used to coding first. How do I adjust?
Start with small features:
1. Pick a simple task
2. Force yourself through all three phases
3. Notice how the research reveals surprises
4. Appreciate the plan's rollback strategy
5. Enjoy the clean implementation

### My team is skeptical. How do I convince them?
- Show them a real example where research prevented issues
- Demonstrate the documentation trail
- Calculate time saved from prevented bugs
- Start with one volunteer project

### Can this work with agile/scrum?
Yes! The workflow fits perfectly:
- Research during sprint planning
- Planning in early sprint
- Implementation with clear acceptance criteria
- Built-in documentation for demos

## Advanced Usage

### Can I create custom workflow agents?
Yes, but maintain the three-phase structure. You might create:
- Specialized researchers (security-researcher)
- Domain planners (mobile-app-planner)
- Platform implementers (aws-implementer)

### How do I handle multi-service changes?
Break into service-specific workflows:
```bash
> Research API changes for service A and service B
> Plan coordinated updates for both services
> Implement service A changes first, then service B
```

### What about emergency rollbacks?
Every Implementation Plan includes rollback procedures. In emergencies:
```bash
> Show me the rollback procedure from the current plan
> Execute the rollback steps
```

## Philosophy Questions

### Why is "no coding from memory" so important?
Because:
- Libraries change faster than memory updates
- Best practices evolve
- Security vulnerabilities get discovered
- Your memory might merge different library APIs

### Isn't this overkill for experienced developers?
Experience helps you:
- Ask better research questions
- Create better plans
- Implement more efficiently

But everyone benefits from current documentation.

### How does this relate to TDD/BDD?
They complement each other:
- Research informs what to test
- Plans include test criteria
- Implementation includes test execution
- TDD/BDD happen within the implementation phase

## Future & Contribution

### Will there be more agents?
The three-agent workflow is intentionally minimal. Additional agents would need to:
- Fit within the three-phase structure
- Provide clear, unique value
- Maintain the quality standards

### Can I contribute improvements?
Yes! See [CONTRIBUTING.md](../CONTRIBUTING.md). We especially welcome:
- Agent prompt improvements
- Workflow examples
- Documentation enhancements

### Where can I get help?
- [GitHub Issues](https://github.com/irenicj/claude-code-workflow-agents/issues) for bugs
- [Discussions](https://github.com/irenicj/claude-code-workflow-agents/discussions) for questions
- [Claude Code Community](https://docs.anthropic.com/claude-code/community) for general help

---

Still have questions? Open a [discussion](https://github.com/irenicj/claude-code-workflow-agents/discussions) →