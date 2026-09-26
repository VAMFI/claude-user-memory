# Agent Philosophy: Orchestration, Specialization, and Knowledge

This project operates on a three-part philosophy designed to create a powerful, scalable, and intelligent agentic system for software development.

## 1. Orchestration

At the top level is a single **Orchestrator Agent** (`chief-architect`). Instead of a flat structure where all agents are peers, the orchestrator acts as a project manager. It analyzes complex, high-level goals, decomposes them into logical sub-tasks, and delegates them to the appropriate specialist.

**Benefits**:
- **Handles Complexity**: Can tackle large, multi-faceted projects that would overwhelm a single agent.
- **Strategic Oversight**: Ensures the overall project stays on track and that individual contributions align with the main goal.

## 2. Specialization

The orchestrator manages a team of **Specialist Agents**. Each specialist is an expert in a single, well-defined domain (e.g., documentation research, code implementation, security analysis). They are designed to do one thing exceptionally well.

**Benefits**:
- **Deep Expertise**: Prompts can be highly optimized for a specific task, leading to better performance.
- **Modularity & Scalability**: It's easy to add new specialists or upgrade existing ones without disrupting the entire system.

## 3. Knowledge

The entire system shares a persistent, long-term memory called the **Knowledge Core** (`knowledge-core.md`). This is a central document where key architectural decisions, established patterns, and important learnings are stored.

**Benefits**:
- **Consistency**: All agents work from the same set of established rules, preventing conflicting implementations.
- **Learning & Adaptation**: The system gets smarter over time as the Knowledge Core grows, preventing repeated mistakes and preserving institutional knowledge.
