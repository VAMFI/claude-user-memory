# Project Knowledge Core

**Purpose**: This document is the single source of truth for this project's architectural decisions, established patterns, and key learnings. It serves as the persistent memory for all AI agents.

**Agent Instructions**:
1.  **READ FIRST**: Before starting any task, read this file to understand the project's context and history.
2.  **ADHERE TO PATTERNS**: Your work must be consistent with the patterns and decisions documented here.
3.  **SUGGEST UPDATES**: Upon completing a significant task, if you have established a new pattern or made a key architectural decision, you must suggest an addition to this file in your final report.

---

## Architectural Principles

- **Principle 1**: [e.g., All API endpoints must be authenticated by default.]
- **Principle 2**: [e.g., State management on the frontend is handled exclusively by Redux.]

## Established Patterns

- **Database Models**: [e.g., All new models must include `created_at` and `updated_at` timestamps. Foreign keys should be indexed.]
- **Component Naming**: [e.g., React components should be named using PascalCase and stored in `src/components/{ComponentName}`.]

## Key Decisions & Learnings

- **(2024-07-30)**: Decided to use PostgreSQL instead of MySQL due to its advanced support for JSONB data types.
- **(2024-07-31)**: The `send_email` function was deprecated in favor of the more robust `NotificationService.send`.
