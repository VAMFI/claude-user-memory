# Example: Direct Specialist Usage

While the `chief-architect` is best for complex tasks, you can still invoke specialist agents directly for simple, focused requests.

## User Goal

In this scenario, you have already done the research and planning yourself and just need the code implemented.

```
> I have a plan to refactor the `database.js` file. Use the code-implementer to apply it.
```

## Agent Workflow

1.  **Claude Code** identifies the `code-implementer` keyword and the user's intent to skip the orchestration workflow.

2.  **Claude Code** directly invokes the **`code-implementer`** agent.

3.  The `code-implementer` will ask for the implementation plan.

4.  The user provides the plan.

5.  The `code-implementer` executes the plan, runs tests, and completes the task.

This allows you to maintain fine-grained control and use the specialists as powerful, standalone tools when you don't need the full orchestration process.
