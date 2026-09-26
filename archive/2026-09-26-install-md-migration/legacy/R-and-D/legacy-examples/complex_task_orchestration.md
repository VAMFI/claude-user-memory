# Example: Complex Task Orchestration

This example demonstrates how the `chief-architect` manages a multi-step project from start to finish.

## User Goal

```
> Add a Redis-based caching layer to our Express.js API to improve performance.
```

## Agent Workflow

1.  **Claude Code** routes this complex request to the **`chief-architect`**.

2.  **`chief-architect`** analyzes the goal and creates a plan:
    > "Okay, I will add a Redis caching layer. Here is my plan:
    > 1.  Research best practices for adding Redis to an Express app.
    > 2.  Plan the necessary code changes, including a new caching middleware.
    > 3.  Implement the changes and add tests.
    > I will now delegate these tasks to my specialist team."

3.  **`chief-architect`** invokes **`docs-researcher`**:
    > "Research the official documentation for the `redis` npm package and how to integrate it with Express.js."

4.  **`docs-researcher`** returns a ResearchPack with links and code snippets.

5.  **`chief-architect`** invokes **`implementation-planner`**, providing the ResearchPack:
    > "Based on this research, create a plan to add a caching middleware. The plan should include file changes, new dependencies, and a test plan."

6.  **`implementation-planner`** returns a detailed plan.

7.  **`chief-architect`** invokes **`code-implementer`**, providing the plan:
    > "Execute this plan to implement the Redis caching middleware."

8.  **`code-implementer`** writes the code. It then runs the tests. If they fail, it attempts one fix. Once tests pass, it reports success.

9.  **`chief-architect`** synthesizes all the steps into a final report for the user, including a suggestion to add "Use Redis for API caching" to the `knowledge-core.md`.
