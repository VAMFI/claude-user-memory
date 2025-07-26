# Contributing to Claude User Memory

Thank you for your interest in contributing to this project! This Claude user memory repository aims to provide high-quality, personalized AI agent orchestration for the Claude Code CLI community.

## 🎯 Project Goals

- Create Claude's personalized memory system for development workflows
- Maintain a curated collection of professional-grade AI specialists
- Ensure intelligent agent orchestration works seamlessly with Claude Code CLI
- Provide comprehensive coverage of software development roles with user adaptation
- Keep agents up-to-date with modern development practices and user preferences

## 🚀 Getting Started

### Prerequisites
- [Claude Code CLI](https://docs.anthropic.com/claude-code) installed
- Basic understanding of AI system prompts
- Experience with the software development role you're contributing to

### Development Setup
```bash
# Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/claude-user-memory.git
cd claude-user-memory

# Create a development branch
git checkout -b feature/your-contribution

# Install agents locally for testing
cp agents/* ~/.claude/agents/
```

## 📋 Types of Contributions

### 1. New Agent Creation
Adding entirely new specialist roles to the collection.

**Current Priority Roles:**
- mobile-app-developer (React Native, Flutter, iOS, Android)
- data-engineer (ETL, data pipelines, analytics)
- ui-ux-designer (Design systems, prototyping, user research)
- blockchain-developer (Web3, smart contracts, DeFi)
- game-developer (Unity, Unreal, game design)

### 2. Agent Enhancement
Improving existing agents with:
- Additional technical expertise areas
- More comprehensive examples
- Updated technology stacks
- Better enterprise context adaptation

### 3. Documentation Improvements
- Usage examples and tutorials
- Installation guides
- Best practices documentation
- Community resources

### 4. Quality Assurance
- Testing agents with Claude Code CLI
- Validating agent responses and behavior
- Reporting bugs and inconsistencies

## 📝 Agent Structure Guidelines

All agents must follow this consistent structure:

### 1. Frontmatter
```yaml
---
name: agent-name
description: Clear description with examples of when to use this agent
color: agent-color
---
```

### 2. Required Sections
- **Core Identity & Role**: Define responsibilities and scope
- **Philosophy**: Core principles and approach
- **Communication Style**: How the agent interacts
- **Technical Expertise Areas**: Specific technology domains
- **Enterprise Context Adaptation**: Startup, growth, enterprise considerations
- **Success Metrics**: Measurable outcomes
- **Technology Stack**: Preferred tools and frameworks
- **Constraints & Guidelines**: Limitations and best practices

### 3. Quality Standards
- **Professional tone**: Enterprise-ready communication
- **Practical examples**: Real-world use cases with context
- **Technical accuracy**: Up-to-date technology references
- **Comprehensive coverage**: Address the full scope of the role
- **Clear boundaries**: Define what the agent does/doesn't handle

## 🛠 Creating a New Agent

### Step 1: Research and Planning
- Study existing agents for structure and quality
- Research the target role's responsibilities and expertise areas
- Identify key technologies and frameworks for the role
- Plan the agent's unique value proposition

### Step 2: Agent Development
```bash
# Create new agent file
cp agents/backend-specialist.md agents/your-new-agent.md
```

### Step 3: Content Development
1. **Update frontmatter** with appropriate name, description, and color
2. **Define core identity** and role responsibilities
3. **Establish philosophy** and guiding principles
4. **Detail technical expertise** areas with specific technologies
5. **Add enterprise context** for different company sizes
6. **Define success metrics** and measurable outcomes
7. **List technology stack** preferences and recommendations

### Step 4: Testing
```bash
# Install agent locally
cp agents/your-new-agent.md ~/.claude/agents/

# Test with Claude Code
claude-code
# Use /agents command to verify agent appears
# Test agent responses with relevant queries
```

### Step 5: Documentation Updates
- Add agent to README.md agent table
- Update agent count references
- Add usage examples if needed

## 🔍 Enhancement Guidelines

### Improving Existing Agents
1. **Maintain backward compatibility**: Don't break existing functionality
2. **Add value incrementally**: Focus on clear improvements
3. **Update technology references**: Keep frameworks and tools current
4. **Enhance examples**: Add more practical, real-world scenarios
5. **Expand expertise areas**: Cover emerging technologies and practices

### Technology Stack Updates
- Research current industry preferences
- Include both established and emerging technologies
- Consider enterprise vs. startup contexts
- Maintain balance between innovation and stability

## ✅ Pull Request Process

### Before Submitting
- [ ] Agent follows the established structure
- [ ] All sections are complete and comprehensive
- [ ] Technology references are current and accurate
- [ ] Agent has been tested with Claude Code CLI
- [ ] README.md is updated if adding new agent
- [ ] Commit messages are clear and descriptive

### PR Requirements
1. **Clear title**: Describe the change concisely
2. **Detailed description**: Explain what was added/changed and why
3. **Testing notes**: How you tested the changes
4. **Breaking changes**: Note any compatibility issues
5. **Documentation updates**: List any doc changes needed

### Review Process
1. **Automated checks**: Verify file structure and formatting
2. **Content review**: Assess quality, accuracy, and completeness
3. **Testing**: Verify agent works correctly with Claude Code
4. **Community feedback**: Get input from other contributors
5. **Merge**: Approved PRs are merged to main branch

## 🐛 Bug Reports

### Reporting Issues
Use the GitHub issue template with:
- **Agent name**: Which agent has the issue
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Claude Code version**: Your CLI version
- **Reproduction steps**: How to reproduce the issue
- **System info**: OS, Node.js version, etc.

### Issue Labels
- `bug`: Something isn't working correctly
- `enhancement`: New feature or improvement request
- `documentation`: Documentation needs improvement
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention needed

## 🌟 Best Practices

### Code Quality
- Follow consistent formatting and structure
- Use clear, professional language
- Include comprehensive examples
- Test thoroughly before submitting
- Keep technology references current

### Community Standards
- Be respectful and inclusive
- Provide constructive feedback
- Help newcomers get started
- Share knowledge and expertise
- Maintain high quality standards

### Documentation
- Write clear, actionable instructions
- Include practical examples
- Keep information up-to-date
- Consider different user levels
- Test instructions with fresh eyes

## 🎉 Recognition

Contributors are recognized through:
- GitHub contributor stats
- Special mentions in release notes
- Community showcases
- Maintainer recognition for outstanding contributions

## 📞 Getting Help

- **GitHub Discussions**: For questions and community chat
- **GitHub Issues**: For bug reports and feature requests
- **Discord/Slack**: [Link to community chat if available]

## 📚 Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Original System Prompts](https://github.com/x1xhlol/system-prompts-and-models-of-ai-tools)
- [AI Prompt Engineering Best Practices](https://docs.anthropic.com/claude/docs/prompt-engineering)

---

Thank you for contributing to the Claude Code community! 🚀