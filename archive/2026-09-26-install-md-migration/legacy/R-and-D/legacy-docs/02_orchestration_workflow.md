# The Orchestration Workflow

The primary workflow is managed by the `chief-architect` agent. This workflow is designed for complex tasks that require multiple steps and different areas of expertise.

## The Workflow Steps

1.  **User Goal**: The user provides a high-level goal.
    - *Example*: "Add Google OAuth to our application."

2.  **Decomposition (Chief Architect)**: The `chief-architect` analyzes the goal and breaks it down into a sequence of tasks.
    - *Example Plan*:
        1.  Research the latest Google OAuth 2.0 and NextAuth.js implementation guides.
        2.  Plan the required backend changes (new API routes, database schema updates).
        3.  Plan the required frontend changes (login button, callback page).
        4.  Implement the backend changes.
        5.  Implement the frontend changes.

3.  **Delegation (Chief Architect)**: The `chief-architect` invokes the appropriate specialist agent for each task in the plan, passing the necessary context.
    - `docs-researcher` gets Task 1.
    - `implementation-planner` gets Tasks 2 & 3.
    - `code-implementer` gets Tasks 4 & 5.

4.  **Execution (Specialists)**: Each specialist completes its assigned task and reports the result back to the orchestrator.

5.  **Synthesis (Chief Architect)**: The `chief-architect` reviews the outputs, ensures they work together, and prepares a final summary report for the user.

## Invoking the Workflow

To start this workflow, simply give the Claude Code CLI a complex task. The system is configured to route such tasks to the `chief-architect` by default.

```bash
> Refactor the user authentication flow to use JWT instead of sessions.
# The chief-architect will automatically take the lead.
```
