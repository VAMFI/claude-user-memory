# Claude Code Agent Workflow Patterns

This document outlines common workflow patterns when using specialized agents with Claude Code CLI for software development tasks.

## 🔄 Single Agent Workflows

### Backend Development
```bash
# API development workflow
claude-code
> Use backend-specialist to create a REST API for user management

# Database optimization workflow  
claude-code
> backend-specialist help me optimize these PostgreSQL queries
```

### Frontend Development
```bash
# Component development workflow
claude-code
> Use frontend-specialist to create a responsive navigation component

# Performance optimization workflow
claude-code
> frontend-specialist analyze and optimize this React app's bundle size
```

### DevOps Operations
```bash
# Deployment workflow
claude-code
> Use devops-engineer to set up CI/CD pipeline for this Node.js app

# Infrastructure workflow
claude-code
> devops-engineer help me configure Kubernetes for microservices deployment
```

## 🤝 Multi-Agent Collaboration

### Full-Stack Feature Development
```bash
# Step 1: Planning
claude-code
> Use product-owner to define requirements for shopping cart feature

# Step 2: Architecture
claude-code  
> Use software-architect to design shopping cart system architecture

# Step 3: Implementation
claude-code
> Use backend-specialist to implement cart API endpoints
> Use frontend-specialist to build cart UI components

# Step 4: Quality Assurance
claude-code
> Use qa-engineer to create comprehensive test strategy for cart feature
```

### Security Review Workflow
```bash
# Step 1: Security Assessment
claude-code
> Use security-engineer to review authentication implementation

# Step 2: Code Review
claude-code
> Use senior-fullstack-developer to review security fixes

# Step 3: DevOps Security
claude-code
> Use devops-engineer to implement security scanning in CI/CD
```

## 🚨 Emergency Response Patterns

### Production Issue Investigation
```bash
# Step 1: Initial Assessment
claude-code
> production is down, need immediate help investigating

# Step 2: Infrastructure Check
claude-code  
> Use devops-engineer to check server logs and infrastructure metrics

# Step 3: Application Analysis
claude-code
> Use backend-specialist to analyze application logs and database performance

# Step 4: Frontend Impact
claude-code
> Use frontend-specialist to assess client-side errors and user impact
```

### Security Incident Response
```bash
# Step 1: Security Assessment
claude-code
> potential security breach detected, need immediate analysis

# Step 2: Immediate Response
claude-code
> Use security-engineer to assess breach scope and containment steps

# Step 3: Technical Investigation  
claude-code
> Use backend-specialist to analyze server logs for security indicators
```

## 💡 Agent Selection Tips

### When to Use Specific Agents

**backend-specialist**: API development, database work, server-side logic
**frontend-specialist**: UI/UX, React/Vue/Angular, responsive design
**devops-engineer**: CI/CD, deployment, infrastructure, monitoring
**security-engineer**: Security architecture, vulnerability assessment
**qa-engineer**: Testing strategy, test automation, quality processes
**software-architect**: System design, technical standards, architecture decisions
**senior-fullstack-developer**: Complex features, mentoring, cross-stack integration
**product-owner**: Requirements, feature prioritization, user stories
**project-manager**: Planning, timeline management, resource coordination
**engineering-manager**: Team leadership, performance optimization
**enterprise-cto**: Strategic decisions, technology roadmap, executive guidance
**technical-writer**: Documentation, API specs, user guides

### Quick Selection Keywords

Use these keywords in your prompts for faster agent selection:

- **API, database, backend, server** → backend-specialist
- **UI, frontend, React, CSS, component** → frontend-specialist  
- **deploy, CI/CD, Docker, infrastructure** → devops-engineer
- **security, vulnerability, auth, compliance** → security-engineer
- **test, QA, automation, coverage** → qa-engineer
- **architecture, design, patterns, standards** → software-architect
- **documentation, API docs, guides** → technical-writer

## 🎯 Best Practices

### Effective Agent Communication
1. **Be specific** about your technology stack and requirements
2. **Provide context** about your project size and constraints  
3. **Ask for concrete examples** when learning new concepts
4. **Request step-by-step guidance** for complex implementations
5. **Follow up** with specific questions if you need clarification

### Workflow Optimization
1. **Start with planning agents** (product-owner, software-architect) for new features
2. **Use specialized agents** for implementation (backend-specialist, frontend-specialist)
3. **Include quality agents** (qa-engineer, security-engineer) before deployment
4. **Leverage management agents** (project-manager, engineering-manager) for coordination

### Emergency Workflows
1. **Begin with immediate assessment** using the most relevant specialist
2. **Coordinate multiple agents** for comprehensive investigation
3. **Document findings** and solutions for future reference
4. **Follow up** with preventive measures using appropriate specialists