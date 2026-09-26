# Contributing to Claude Code Workflow Agents

Thank you for your interest in contributing! This repository provides the official Research → Plan → Implement workflow agents for Claude Code CLI.

## 🎯 Project Philosophy

This project implements a systematic three-phase development workflow:
1. **Research**: Gather authoritative, version-accurate documentation
2. **Plan**: Create detailed, actionable implementation blueprints
3. **Implement**: Execute precise, minimal code changes

All contributions must align with this philosophy.

## 🚀 Getting Started

### Prerequisites
- [Claude Code CLI](https://docs.anthropic.com/claude-code) installed and configured
- Understanding of the research-plan-implement workflow
- Experience with AI agent prompts and YAML frontmatter

### Development Setup
```bash
# Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/claude-code-workflow-agents.git
cd claude-code-workflow-agents

# Create a development branch
git checkout -b feature/your-contribution

# Install agents locally for testing
cp agents/* ~/.claude/agents/

# Test with Claude Code
claude-code
> /agents  # Verify the 3 agents appear
```

## 📋 Types of Contributions

### 1. Agent Enhancement
Improving the three workflow agents:
- **docs-researcher**: Better documentation fetching strategies
- **implementation-planner**: More comprehensive planning templates
- **code-implementer**: Improved code execution patterns

### 2. Workflow Examples
- Real-world scenarios demonstrating the workflow
- Integration patterns with Claude Code features
- Multi-technology implementation examples

### 3. Documentation Improvements
- Clearer explanations of the workflow philosophy
- Better installation and usage guides
- Troubleshooting and best practices

### 4. Quality Assurance
- Testing the workflow with various technologies
- Validating agent dependencies and outputs
- Ensuring ResearchPack and Plan quality

## 📝 Agent Development Guidelines

### Core Principles

#### 1. Maintain Workflow Integrity
- docs-researcher must produce valid ResearchPacks
- implementation-planner must require ResearchPacks
- code-implementer must require both ResearchPack and Plan

#### 2. Documentation-First Approach
- Never allow coding from memory
- Always cite authoritative sources
- Verify library versions before implementation

#### 3. Minimal, Reversible Changes
- Plans must include rollback strategies
- Implementations should be surgical and precise
- Every change must be testable

### Agent Structure

All agents must maintain their YAML frontmatter and core responsibilities:

```yaml
---
name: agent-name
description: "Clear description with examples for auto-selection"
color: unique-color
---
```

### Quality Standards

#### Research Quality (docs-researcher)
- Fetch only from official documentation
- Include version-specific information
- Provide complete API references
- Link all sources

#### Planning Quality (implementation-planner)
- Create specific, actionable steps
- Include comprehensive test criteria
- Assess and mitigate risks
- Design rollback procedures

#### Implementation Quality (code-implementer)
- Follow the plan exactly
- Make minimal changes
- Verify with tests
- Report any deviations

## 🛠 Enhancing Agents

### Step 1: Understand Current Implementation
```bash
# Read the agent you want to enhance
cat agents/docs-researcher.md
# or
cat agents/implementation-planner.md
# or
cat agents/code-implementer.md
```

### Step 2: Identify Enhancement Opportunities
- More comprehensive prompts
- Better error handling
- Improved output formatting
- Additional validation checks

### Step 3: Test Your Changes
```bash
# Install modified agent
cp agents/your-modified-agent.md ~/.claude/agents/

# Test the complete workflow
claude-code
> Research Redis documentation
> Plan Redis caching implementation
> Implement the Redis caching plan
```

### Step 4: Validate Workflow Dependencies
Ensure:
- ResearchPacks contain all required information
- Plans reference the ResearchPack correctly
- Implementation cites both Research and Plan

## ✅ Pull Request Process

### Before Submitting
- [ ] Changes align with the three-phase workflow philosophy
- [ ] Agent dependencies are maintained (Research → Plan → Implement)
- [ ] Documentation reflects any changes
- [ ] Tested complete workflow with Claude Code
- [ ] Examples demonstrate the enhancement

### PR Requirements
1. **Clear title**: Describe the enhancement concisely
2. **Detailed description**: Explain what was improved and why
3. **Testing notes**: Show complete workflow execution
4. **Philosophy alignment**: Confirm adherence to core principles

### Review Process
1. **Workflow integrity check**: Verify dependencies maintained
2. **Quality assessment**: Ensure improvements add value
3. **Claude Code testing**: Test with various scenarios
4. **Documentation review**: Check all docs are updated
5. **Community feedback**: Gather input from users

## 🐛 Bug Reports and Issues

### Reporting Workflow Issues
Include:
- **Workflow phase**: Which agent/phase has the issue
- **Expected flow**: How the workflow should proceed
- **Actual behavior**: What went wrong
- **ResearchPack/Plan**: Relevant outputs if applicable
- **Claude Code version**: Your CLI version

### Issue Labels
- `bug`: Workflow or agent malfunction
- `enhancement`: Improvement to agents or workflow
- `documentation`: Documentation needs update
- `workflow`: Issues with the three-phase flow
- `research`: docs-researcher specific
- `planning`: implementation-planner specific
- `implementation`: code-implementer specific

## 🌟 Best Practices

### Workflow Integrity
- Never bypass the research phase
- Always validate ResearchPack completeness
- Ensure plans are comprehensive and safe
- Keep implementations minimal and tested

### Documentation Standards
- Cite all sources with links
- Include version information
- Provide clear examples
- Explain the "why" not just the "how"

### Testing Guidelines
- Test the complete workflow end-to-end
- Verify with multiple technologies
- Check edge cases and error handling
- Ensure rollback procedures work

## 🎉 Recognition

Contributors are recognized through:
- GitHub contributor stats
- Mentions in release notes
- Credit in documentation examples
- Community acknowledgment

## 📞 Getting Help

### Resources
- **GitHub Issues**: Bug reports and enhancements
- **Discussions**: Questions and ideas
- **Claude Code Docs**: [Official documentation](https://docs.anthropic.com/claude-code)

### Workflow Resources
- [Agent System Guide](https://docs.anthropic.com/claude-code/agents)
- [Task Tool Documentation](https://docs.anthropic.com/claude-code/task-tool)

## 🚀 Quick Contribution Checklist

### For Agent Enhancements
1. [ ] Understand the current agent implementation
2. [ ] Identify specific improvement opportunity
3. [ ] Maintain workflow dependencies
4. [ ] Test complete Research → Plan → Implement flow
5. [ ] Update relevant documentation
6. [ ] Submit PR with workflow test results

### For Documentation
1. [ ] Clarify workflow concepts
2. [ ] Add practical examples
3. [ ] Improve troubleshooting guides
4. [ ] Test all code examples
5. [ ] Submit PR with preview

Thank you for contributing to the Claude Code workflow! 🎯

*Together, we're building systematic, quality-driven software development.*