# Contributing to Claude Code Specialized Agents

Thank you for your interest in contributing! This repository provides high-quality, specialized AI agents designed to enhance software development workflows with Claude Code CLI.

## 🎯 Project Goals

- Maintain a curated collection of professional-grade AI agents for Claude Code
- Ensure seamless integration with Claude Code's native agent system
- Provide comprehensive coverage of software development roles and specializations
- Keep agents up-to-date with modern development practices and technologies
- Foster a community-driven approach to improving Claude Code's capabilities

## 🚀 Getting Started

### Prerequisites
- [Claude Code CLI](https://docs.anthropic.com/claude-code) installed and configured
- Basic understanding of AI agent prompts and YAML frontmatter
- Experience with the software development role you're contributing to
- Understanding of Claude Code's Task tool and `/agents` command

### Development Setup
```bash
# Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/claude-code-specialized-agents.git
cd claude-code-specialized-agents

# Create a development branch
git checkout -b feature/your-contribution

# Install agents locally for testing
cp agents/* ~/.claude/agents/

# Test with Claude Code
claude-code
> /agents  # Verify agents appear
```

## 📋 Types of Contributions

### 1. New Agent Creation
Adding entirely new specialist roles to the collection.

**High Priority Roles:**
- **mobile-developer** (React Native, Flutter, iOS, Android native)
- **data-engineer** (ETL pipelines, data warehousing, analytics)
- **ui-ux-designer** (Design systems, prototyping, user research)
- **blockchain-developer** (Web3, smart contracts, DeFi protocols)
- **game-developer** (Unity, Unreal Engine, game design patterns)
- **ml-engineer** (Machine learning models, MLOps, data science)
- **cloud-architect** (Multi-cloud strategies, serverless, infrastructure)

### 2. Agent Enhancement
Improving existing agents with:
- Updated technology stacks and frameworks
- Additional technical expertise areas
- More comprehensive real-world examples
- Better integration with Claude Code features
- Enhanced prompts for specific use cases

### 3. Documentation Improvements
- Installation and setup guides
- Usage examples and best practices
- Workflow patterns and integration guides
- Claude Code feature integration tutorials

### 4. Quality Assurance
- Testing agents with Claude Code CLI's Task tool
- Validating agent responses and behavior
- Reporting bugs and inconsistencies
- Performance and usability improvements

## 📝 Agent Development Guidelines

### Required Agent Structure

All agents must follow this consistent structure:

#### 1. YAML Frontmatter
```yaml
---
name: agent-name
description: "Clear description of when to use this agent with specific examples"
color: unique-color
---
```

**Requirements:**
- `name`: kebab-case format, descriptive and unique
- `description`: Specific use cases and triggers for Claude Code's auto-selection
- `color`: Unique color for visual distinction (avoid duplicates)

#### 2. Core Content Sections
1. **Core Identity & Role**: Define responsibilities and scope clearly
2. **Philosophy**: Core principles and approach to problems
3. **Communication Style**: How the agent interacts with developers
4. **Technical Expertise Areas**: Specific technologies and domains
5. **Enterprise Context Adaptation**: Considerations for different org sizes
6. **Success Metrics**: Measurable outcomes and quality indicators

### Quality Standards

#### Professional Excellence
- **Enterprise-ready communication**: Professional, actionable guidance
- **Technical accuracy**: Up-to-date technology references and best practices
- **Practical examples**: Real-world scenarios with concrete implementations
- **Comprehensive coverage**: Address the full scope of the role
- **Clear boundaries**: Define what the agent does and doesn't handle

#### Claude Code Integration
- **Task tool compatibility**: Agents should work effectively with complex workflows
- **Auto-selection support**: Use clear keywords in descriptions
- **Workflow integration**: Consider multi-agent collaboration patterns
- **Performance optimization**: Efficient prompts that work well with Claude Code

## 🛠 Creating a New Agent

### Step 1: Research and Planning
1. Study existing agents for structure and quality benchmarks
2. Research the target role's responsibilities in modern development
3. Identify key technologies, frameworks, and tools
4. Plan unique value proposition and differentiation
5. Consider integration points with other agents

### Step 2: Agent Development
```bash
# Create new agent file
cp agents/backend-specialist.md agents/your-new-agent.md
```

### Step 3: Content Development
1. **Update YAML frontmatter** with appropriate name, description, and unique color
2. **Define core identity** with specific, actionable responsibilities
3. **Establish philosophy** and guiding principles for decision-making
4. **Detail technical expertise** with current technologies and frameworks
5. **Add enterprise context** for startup, mid-size, and enterprise scenarios
6. **Define success metrics** and measurable outcomes

### Step 4: Testing and Validation
```bash
# Install agent locally
cp agents/your-new-agent.md ~/.claude/agents/

# Test with Claude Code
claude-code

# Test scenarios:
# 1. Agent auto-selection with relevant keywords
# 2. Explicit agent usage with "Use your-new-agent for..."
# 3. Task tool integration for complex workflows
# 4. Multi-agent collaboration scenarios
```

### Step 5: Documentation
- Add agent to README.md agent table with clear use cases
- Update agent count references
- Add usage examples to relevant documentation
- Include workflow patterns if applicable

## 🔍 Agent Enhancement Guidelines

### Improving Existing Agents
1. **Maintain compatibility**: Don't break existing Claude Code integrations
2. **Add incremental value**: Focus on clear, measurable improvements
3. **Update technology references**: Keep frameworks and tools current
4. **Enhance examples**: Add more practical, real-world scenarios
5. **Expand expertise areas**: Cover emerging technologies and practices

### Technology Stack Updates
- Research current industry preferences and trends
- Include both established and emerging technologies
- Consider different organizational contexts (startup vs enterprise)
- Balance innovation with stability and proven practices

## ✅ Pull Request Process

### Before Submitting
- [ ] Agent follows the established structure and quality standards
- [ ] All required sections are complete and comprehensive
- [ ] Technology references are current and accurate
- [ ] Agent tested with Claude Code CLI and Task tool
- [ ] Documentation updated (README.md, examples)
- [ ] Unique color assigned (no conflicts with existing agents)
- [ ] Commit messages are clear and descriptive

### PR Requirements
1. **Clear title**: Describe the change concisely
2. **Detailed description**: Explain what was added/changed and why
3. **Testing notes**: How you tested with Claude Code CLI
4. **Integration notes**: How agent works with Task tool and other agents
5. **Breaking changes**: Note any compatibility issues (should be rare)

### Review Process
1. **Automated checks**: Verify YAML frontmatter and file structure
2. **Content review**: Assess quality, accuracy, and completeness
3. **Claude Code testing**: Verify agent works correctly with CLI
4. **Integration testing**: Test Task tool and multi-agent scenarios
5. **Community feedback**: Get input from other contributors
6. **Merge**: Approved PRs are merged to main branch

## 🐛 Bug Reports and Issues

### Reporting Issues
Use GitHub issues with this information:
- **Agent name**: Which agent has the issue
- **Claude Code version**: Your CLI version
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Reproduction steps**: How to reproduce with Claude Code
- **System info**: OS, Node.js version, etc.

### Issue Labels
- `bug`: Something isn't working correctly
- `enhancement`: New feature or improvement request
- `documentation`: Documentation needs improvement
- `agent-new`: Request for new specialized agent
- `agent-enhancement`: Improvement to existing agent
- `claude-code-integration`: Claude Code specific issues
- `good-first-issue`: Good for newcomers
- `help-wanted`: Extra attention needed

## 🌟 Best Practices

### Agent Development
- Follow consistent formatting and structure across all agents
- Use clear, professional language appropriate for enterprise environments
- Include comprehensive examples with modern technology stacks
- Test thoroughly with Claude Code before submitting
- Keep technology references current and industry-relevant

### Claude Code Integration
- Design agents to work seamlessly with the Task tool
- Consider multi-agent workflow patterns
- Optimize prompts for Claude Code's auto-selection
- Test agent responses with various Claude Code scenarios
- Ensure compatibility with Claude Code's features and limitations

### Community Standards
- Be respectful and inclusive in all interactions
- Provide constructive feedback on contributions
- Help newcomers get started with agent development
- Share knowledge and expertise with the community
- Maintain high quality standards for all contributions

### Documentation
- Write clear, actionable instructions
- Include practical examples with real-world context
- Keep information up-to-date with latest practices
- Consider different user experience levels
- Test documentation with fresh perspective

## 🎉 Recognition and Community

### Contributor Recognition
Contributors are recognized through:
- GitHub contributor stats and profiles
- Special mentions in release notes
- Community showcases and highlights
- Maintainer recognition for outstanding contributions
- Featured examples in documentation

### Community Engagement
- Join discussions about agent improvements
- Share experiences and best practices
- Help troubleshoot issues for other users
- Contribute to workflow patterns and examples
- Provide feedback on Claude Code integration

## 📞 Getting Help

### Support Channels
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions, ideas, and community chat
- **Claude Code Documentation**: [Official Claude Code guides](https://docs.anthropic.com/claude-code)
- **Community Resources**: Examples, tutorials, and best practices

### Development Resources
- [Claude Code CLI Documentation](https://docs.anthropic.com/claude-code)
- [Agent System Guide](https://docs.anthropic.com/claude-code/agents)
- [Task Tool Documentation](https://docs.anthropic.com/claude-code/task-tool)
- [AI Prompt Engineering Best Practices](https://docs.anthropic.com/claude/docs/prompt-engineering)

---

## 🚀 Quick Contribution Checklist

For new contributors, here's a quick checklist:

### New Agent Contribution
1. [ ] Research role and plan agent specialization
2. [ ] Create agent file with proper YAML frontmatter
3. [ ] Write comprehensive agent content following guidelines
4. [ ] Test agent with Claude Code CLI and Task tool
5. [ ] Update README.md and documentation
6. [ ] Submit PR with clear description and testing notes

### Agent Enhancement Contribution  
1. [ ] Identify specific improvement opportunities
2. [ ] Maintain compatibility with existing usage
3. [ ] Test changes with Claude Code CLI
4. [ ] Update relevant documentation
5. [ ] Submit PR with detailed change explanation

Thank you for contributing to the Claude Code community! 🎯

*Together, we're building the future of AI-assisted software development.*