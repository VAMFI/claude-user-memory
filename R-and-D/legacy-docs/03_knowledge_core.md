# The Knowledge Core

The `knowledge-core.md` file is the persistent memory of the agent system. It is the single source of truth for the project's architecture, patterns, and key decisions.

## How It Works

1.  **Read First**: Before starting any task, every agent is instructed to read this file. This ensures its actions are aligned with the project's established context.

2.  **Adhere to Patterns**: Agents must follow the rules and patterns documented in the core. If the core states that "all API endpoints must be snake_case," the agent must conform to this.

3.  **Suggest Updates**: After completing a significant task that establishes a new pattern or makes a key decision, the agent is required to suggest an addition to the Knowledge Core in its final report. This is how the system learns.

## Structure of the Knowledge Core

The file is typically organized into three sections:

### 1. Architectural Principles
High-level, guiding rules for the project.
- *Example*: "All services must be stateless."

### 2. Established Patterns
Concrete, recurring implementation patterns.
- *Example*: "React components should be styled using CSS Modules."

### 3. Key Decisions & Learnings
- A chronological log of important decisions and their rationale.
- *Example*: "(2025-07-30): Switched from REST to GraphQL for the public API to reduce over-fetching."
