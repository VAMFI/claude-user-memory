# Agent Handoff Protocol - Design Document (v4.1)

## Status: DESIGN ONLY - Implementation Deferred to v4.2

This document describes the design for agent-to-agent handoff capabilities based on LangGraph research and Anthropic best practices. Implementation is scheduled for v4.2.

---

## Architecture Pattern: Swarm (Lower Token Overhead)

Based on LangGraph research, we recommend the **swarm pattern** over supervisor pattern:
- **Token overhead**: 1.5x (swarm) vs 2-3x (supervisor)
- **Latency**: Lower due to direct handoffs
- **Complexity**: Simpler, no central coordinator needed
- **Flexibility**: Agents can dynamically hand off based on expertise

## State Transfer Mechanism

### Command Object Pattern (LangGraph-inspired)
```javascript
{
  "goto": "target_agent",
  "update": {
    "context": {
      "previous_agent": "docs-researcher",
      "task_description": "Research Redis caching patterns",
      "completed": true,
      "artifacts_created": ["ResearchPack-Redis.md"]
    },
    "artifacts": {
      "ResearchPack": "path/to/ResearchPack-Redis.md",
      "ImplementationPlan": null,  // Not yet created
      "ValidationReport": null      // Not yet created
    },
    "workflow_state": {
      "phase": "research",
      "next_phase": "planning",
      "completed_steps": ["version_detection", "deepwiki_query", "research_assembly"],
      "remaining_steps": ["planning", "implementation", "validation"]
    },
    "metrics": {
      "tokens_used": 5420,
      "time_elapsed": 120,  // seconds
      "retry_count": 0,
      "deepwiki_used": true
    }
  }
}
```

### Handoff Tools (To Be Implemented)
```python
# Each agent will have these tools available
def handoff_to_agent(agent_name: str, context: dict) -> Command:
    """Hand off control to another agent with context"""
    return Command(
        goto=agent_name,
        update=context,
        graph=Command.PARENT
    )

def accept_handoff() -> dict:
    """Accept handoff and retrieve context from previous agent"""
    return get_shared_state()
```

## Loop Prevention Mechanisms

### 1. Maximum Handoff Limit
```python
MAX_HANDOFFS = 5  # Per workflow
handoff_counter = 0

def check_handoff_limit():
    if handoff_counter >= MAX_HANDOFFS:
        raise HandoffLimitExceeded("Maximum handoffs reached")
```

### 2. Circuit Breaker Pattern
```python
circuit_breaker = {
    "state": "closed",  # closed, open, half-open
    "failure_count": 0,
    "last_failure": None,
    "threshold": 3
}

def handoff_with_circuit_breaker(agent, context):
    if circuit_breaker["state"] == "open":
        raise CircuitBreakerOpen("Agent handoffs temporarily disabled")

    try:
        result = handoff_to_agent(agent, context)
        circuit_breaker["failure_count"] = 0
        circuit_breaker["state"] = "closed"
    except HandoffError:
        circuit_breaker["failure_count"] += 1
        if circuit_breaker["failure_count"] >= circuit_breaker["threshold"]:
            circuit_breaker["state"] = "open"
        raise
```

### 3. Handoff Log & Deadlock Detection
```python
handoff_log = []

def detect_deadlock(from_agent, to_agent, context):
    # Check if same handoff attempted twice
    for entry in handoff_log[-3:]:  # Check last 3 handoffs
        if (entry["from"] == from_agent and
            entry["to"] == to_agent and
            entry["context_hash"] == hash(context)):
            raise DeadlockDetected(f"Circular handoff: {from_agent} → {to_agent}")

    handoff_log.append({
        "from": from_agent,
        "to": to_agent,
        "context_hash": hash(context),
        "timestamp": current_time()
    })
```

### 4. Human-in-the-Loop Interrupt
```python
def handoff_with_interrupt(agent, context):
    if requires_human_approval(agent, context):
        response = interrupt(
            value=f"Approve handoff to {agent}? Context: {context['task']}"
        )
        if response.lower() != "yes":
            return Command(goto=END)

    return handoff_to_agent(agent, context)
```

## Economic Controls

### Token Budget Management
```python
economic_controls = {
    "simple_tasks": {
        "max_handoffs": 0,      # No handoffs allowed
        "max_tokens": 10000,    # 1x baseline
        "max_agents": 1         # Single agent only
    },
    "medium_tasks": {
        "max_handoffs": 2,      # Up to 2 handoffs
        "max_tokens": 25000,    # 2.5x baseline
        "max_agents": 3         # Max 3 agents
    },
    "complex_tasks": {
        "max_handoffs": 5,      # Up to 5 handoffs
        "max_tokens": 150000,   # 15x baseline (ceiling)
        "max_agents": 5         # Max 5 agents
    }
}

def check_economic_viability(task_complexity, current_metrics):
    controls = economic_controls[task_complexity]

    if current_metrics["handoffs"] >= controls["max_handoffs"]:
        raise EconomicLimitExceeded("Handoff limit reached")

    if current_metrics["tokens"] >= controls["max_tokens"]:
        raise EconomicLimitExceeded("Token budget exceeded")
```

## Handoff Patterns

### 1. Sequential Handoff (Research → Plan → Implement)
```python
# docs-researcher completes
return Command(
    goto="implementation-planner",
    update={
        "artifacts": {"ResearchPack": "path/to/research.md"},
        "next_task": "Create implementation plan based on research"
    }
)
```

### 2. Conditional Handoff (Based on Analysis)
```python
# brahma-analyzer detects issues
if quality_score < 80:
    return Command(
        goto="docs-researcher",
        update={"reason": "Missing DeepWiki research", "retry": True}
    )
else:
    return Command(
        goto="code-implementer",
        update={"validated": True}
    )
```

### 3. Parallel Handoff (Future - v4.3)
```python
# chief-architect spawns parallel tasks
return Command(
    goto=[
        Send("docs-researcher", {"task": "Research Redis"}),
        Send("docs-researcher", {"task": "Research caching patterns"}),
        Send("brahma-scout", {"task": "Analyze existing code"})
    ],
    graph=Command.PARENT
)
```

## Implementation Roadmap (v4.2)

### Phase 1: Core Infrastructure
1. Add Command object to agent base template
2. Implement shared state management
3. Create handoff tools

### Phase 2: Agent Updates
1. Update each agent to support handoff_to_agent()
2. Add accept_handoff() to initialization
3. Implement handoff decision logic

### Phase 3: Loop Prevention
1. Implement circuit breaker
2. Add handoff logging
3. Create deadlock detection

### Phase 4: Economic Controls
1. Implement token budget tracking
2. Add complexity classification
3. Create economic viability checks

### Phase 5: Testing & Validation
1. Unit tests for handoff mechanisms
2. Integration tests for full workflows
3. Load tests for economic limits

## Monitoring & Visualization (v4.2)

### Handoff Flow Visualization
```
[docs-researcher] --ResearchPack--> [implementation-planner]
                                           |
                                           v
                                    ImplementationPlan
                                           |
                                           v
                                    [brahma-analyzer]
                                           |
                                     Quality Score
                                      /          \
                              (Score>=80)      (Score<80)
                                    /              \
                           [code-implementer]   [Retry Loop]
```

### Metrics Dashboard
- Total handoffs per workflow
- Token usage per agent
- Average handoff latency
- Circuit breaker status
- Deadlock occurrences

## Known Limitations (v4.1)

Since this is design-only in v4.1:
- No actual handoff capability yet
- Agents still operate independently
- Manual orchestration required
- No state preservation between agents
- No automatic economic controls

## Migration Path (v4.1 → v4.2)

1. **Backward Compatibility**: v4.2 will support both old (independent) and new (handoff) modes
2. **Opt-in Flag**: Enable handoffs with `--enable-handoffs` flag
3. **Gradual Rollout**: Start with simple handoffs, expand to complex patterns
4. **Fallback Mode**: Automatic fallback to independent mode on handoff errors

---

## References

1. LangGraph Multi-Agent Patterns (via DeepWiki)
2. Anthropic "Building Effective Agents" (December 2024)
3. Swarm vs Supervisor architecture comparison
4. Circuit breaker pattern (Martin Fowler)

---

**Document Status**: Design Complete, Awaiting Implementation in v4.2
**Author**: Chief Architect Agent
**Date**: 2024-11-22
**Review Status**: Ready for technical review