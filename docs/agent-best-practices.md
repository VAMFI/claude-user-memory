# Agent Best Practices

This guide covers best practices for developing, customizing, and using specialized agents with Claude Code CLI effectively.

## 🎯 Agent Development Best Practices

### YAML Frontmatter Excellence

#### Required Structure
```yaml
---
name: agent-name
description: "Specific description with use case examples that trigger auto-selection"
color: unique-color
---
```

#### Naming Conventions
- **Use kebab-case**: `backend-specialist`, `senior-fullstack-developer`
- **Be descriptive**: Clear role identification
- **Avoid redundancy**: Don't repeat "agent" or "specialist" unnecessarily
- **Consider hierarchy**: `frontend-specialist` vs `senior-frontend-architect`

#### Description Guidelines
```yaml
# ❌ Too generic
description: "Helps with backend development"

# ✅ Specific with trigger keywords
description: "Use this agent when you need API development, database design, server-side architecture, or backend performance optimization guidance."

# ❌ Too verbose
description: "This agent is designed to help developers with all aspects of frontend development including but not limited to React, Vue, Angular..."

# ✅ Concise but comprehensive
description: "Use this agent when you need UI/UX implementation, component library development, responsive design, or frontend performance optimization guidance."
```

#### Color Selection
```yaml
# Use unique, meaningful colors
backend-specialist: yellow      # ✅ Warm, server-like
frontend-specialist: cyan       # ✅ Cool, UI-like  
devops-engineer: red           # ✅ Alert, infrastructure
security-engineer: purple     # ✅ Important, secure
qa-engineer: pink             # ✅ Testing, validation

# Avoid conflicts
enterprise-cto: red           # ❌ Conflicts with devops-engineer
enterprise-cto: gold          # ✅ Executive, premium
```

### Content Structure Best Practices

#### Core Identity & Role
```markdown
## Core Identity & Role

You are responsible for:
- Specific responsibility 1 with concrete examples
- Specific responsibility 2 with measurable outcomes  
- Specific responsibility 3 with clear boundaries
- Integration points with other roles and systems
```

#### Philosophy Section
```markdown
## [Domain] Philosophy

### Core Principle 1
- Specific guideline with rationale
- Practical application examples
- Trade-off considerations

### Core Principle 2  
- Clear decision-making framework
- Real-world scenarios
- Success metrics
```

#### Technical Expertise
```markdown
## Technical Expertise Areas

### Current Technologies (Established)
- Technology 1: Specific use cases and versions
- Technology 2: Integration patterns and best practices

### Emerging Technologies (Cutting-edge)
- Technology 3: Adoption considerations and use cases
- Technology 4: Future-proofing strategies

### Enterprise Considerations
- Scalability patterns for large organizations
- Legacy system integration approaches
- Compliance and governance requirements
```

## 🚀 Usage Best Practices

### Effective Agent Communication

#### Be Specific About Context
```bash
# ❌ Too vague
> Help me with my API

# ✅ Specific context
> Use backend-specialist to design REST endpoints for a blog system with user authentication, posts, and comments

# ❌ No technology context  
> Build a dashboard

# ✅ Technology and scope specified
> Use frontend-specialist to build a React dashboard with real-time data visualization using Chart.js
```

#### Provide Technical Constraints
```bash
# ❌ No constraints
> Help me deploy this app

# ✅ Clear constraints and environment
> Use devops-engineer to deploy Node.js app to AWS EKS with auto-scaling, monitoring, and zero-downtime deployments

# ❌ Missing scale context
> Optimize database queries

# ✅ Scale and performance context
> Use backend-specialist to optimize PostgreSQL queries for 10M+ user e-commerce platform with <100ms response time requirements
```

#### Request Concrete Deliverables
```bash
# ❌ Abstract request
> Improve security

# ✅ Specific deliverables
> Use security-engineer to:
  1. Conduct security audit of authentication system
  2. Provide specific vulnerability remediation steps  
  3. Create security testing checklist for CI/CD pipeline

# ❌ Open-ended
> Help with testing

# ✅ Clear scope and deliverables  
> Use qa-engineer to create comprehensive test strategy including:
  - Unit test coverage plan (>90% target)
  - Integration test scenarios
  - E2E test automation with Cypress
```

### Multi-Agent Coordination

#### Sequential Workflows
```bash
# Planning → Design → Implementation → Quality
> Use product-owner to define requirements for payment system
# [Wait for completion, review requirements]

> Use software-architect to design payment system architecture based on requirements
# [Review architecture decisions]  

> Use backend-specialist to implement payment API based on architecture
> Use frontend-specialist to build payment UI components
# [Parallel implementation]

> Use security-engineer to review payment system security
> Use qa-engineer to create payment system test suite
# [Quality assurance phase]
```

#### Parallel Coordination
```bash
# Emergency investigation
> Production payment system failing - coordinate investigation:
  Task 1: devops-engineer - analyze infrastructure metrics and logs
  Task 2: backend-specialist - investigate application errors and database performance  
  Task 3: security-engineer - check for security incidents or anomalies
  Task 4: frontend-specialist - validate client-side errors and user impact
```

### Task Tool Integration

#### Complex Analysis Tasks
```bash
# Single-agent deep dive
> Use Task tool with backend-specialist to:
  1. Analyze entire codebase for performance bottlenecks
  2. Identify specific optimization opportunities  
  3. Provide prioritized improvement recommendations with effort estimates
  4. Create implementation roadmap

# Multi-step workflow
> Use Task tool for complete feature development:
  Phase 1: product-owner (requirements analysis)
  Phase 2: software-architect (system design)
  Phase 3: Parallel implementation (backend + frontend specialists)
  Phase 4: Quality validation (qa + security engineers)
```

#### Research and Investigation
```bash
# Technology evaluation
> Use Task tool with software-architect to:
  1. Research microservices vs monolith for our use case
  2. Evaluate specific technology stacks (Node.js vs Go vs Java)
  3. Analyze cost-benefit trade-offs
  4. Provide implementation recommendations

# Problem investigation  
> Use Task tool with devops-engineer to:
  1. Investigate intermittent production slowdowns
  2. Analyze performance metrics and logs
  3. Identify root causes and contributing factors
  4. Provide immediate fixes and long-term prevention strategies
```

## 🎯 Agent Customization Best Practices

### Project-Specific Customization

#### Technology Stack Adaptation
```markdown
# In .claude/agents/backend-specialist.md

## Technology Stack Preferences

### Primary Stack (Company Standard)
- **Runtime**: Node.js 18+ with TypeScript
- **Framework**: Express.js with Helmet for security
- **Database**: PostgreSQL 14+ with Prisma ORM
- **Cache**: Redis 7+ for session management
- **Testing**: Jest with Supertest for API testing

### Architecture Patterns (Company Approved)
- **API Design**: REST with OpenAPI specifications
- **Authentication**: JWT with refresh tokens
- **Error Handling**: Structured error responses with correlation IDs
- **Logging**: Structured JSON logging with Winston
```

#### Enterprise Context
```markdown
## Enterprise Context Adaptation

### Startup Context (< 50 employees)
- Prioritize speed and flexibility over complex architecture
- Use managed services to reduce operational overhead
- Focus on MVP and rapid iteration cycles
- Minimize technical debt while maintaining development velocity

### Growth Stage (50-200 employees)  
- Implement scalable architecture patterns
- Establish code quality and testing standards
- Begin microservices adoption for specific use cases
- Introduce monitoring and observability practices

### Enterprise (200+ employees)
- Enforce strict architectural governance
- Implement comprehensive security and compliance measures
- Use microservices with proper service mesh
- Maintain extensive documentation and knowledge management
```

### Team-Specific Adaptations

#### Communication Style
```markdown
## Communication Style

### For Junior Developers
- Provide step-by-step instructions with explanations
- Include learning resources and best practice references
- Explain the "why" behind recommendations
- Offer multiple implementation approaches with trade-offs

### For Senior Developers
- Focus on architectural decisions and trade-offs
- Provide high-level guidance with implementation flexibility
- Discuss performance implications and optimization strategies
- Consider long-term maintenance and evolution

### For Cross-Functional Teams
- Use business-friendly language for non-technical stakeholders
- Emphasize user impact and business value
- Provide clear timelines and effort estimates
- Include risk assessment and mitigation strategies
```

## 📊 Quality Assurance Best Practices

### Agent Testing

#### Functional Testing
```bash
# Test basic functionality
claude-code
> Use backend-specialist to explain REST API design principles

# Test auto-selection triggers
> I need help with database optimization
# Should automatically suggest backend-specialist

# Test specific technology expertise
> Use backend-specialist to help with PostgreSQL performance tuning for high-traffic e-commerce site
```

#### Integration Testing
```bash
# Test Task tool integration
> Use Task tool with backend-specialist to analyze codebase performance

# Test multi-agent coordination
> Use product-owner then software-architect for new feature planning

# Test workflow patterns
> Emergency: production database is slow, coordinate investigation team
```

#### Edge Case Testing
```bash
# Test with minimal context
> Use backend-specialist for help

# Test with conflicting requirements
> Use backend-specialist to make system both ultra-fast and completely secure

# Test with emerging technologies
> Use backend-specialist to help with Rust for web APIs
```

### Performance Optimization

#### Prompt Engineering
```markdown
# ❌ Inefficient prompt
You are a backend specialist. Help with backend development tasks. You know many technologies and frameworks. Please provide helpful responses.

# ✅ Optimized prompt  
You are an AI Backend Specialist with deep expertise in server-side development, database systems, and API architecture. You focus on building scalable, secure, and performant backend systems that power modern applications.

## Core Identity & Role
You are responsible for:
- API design and implementation using REST, GraphQL, and gRPC protocols
- [Specific, actionable responsibilities...]
```

#### Response Optimization
```markdown
## Communication Style

- **Technical precision**: Provide specific examples with code snippets
- **Security-first**: Always consider security implications
- **Performance-aware**: Analyze optimization opportunities
- **Systematic approach**: Break complex problems into manageable components
- **Enterprise-ready**: Consider scalability and maintainability
```

### Maintenance and Updates

#### Regular Review Cycle
```bash
# Monthly agent review
1. Check technology references for currency
2. Update framework versions and best practices  
3. Review and update example code snippets
4. Validate integration with latest Claude Code features
5. Gather user feedback and incorporate improvements
```

#### Version Control
```bash
# Track agent changes
git add agents/backend-specialist.md
git commit -m "Update backend-specialist: Add Next.js 14 support and improve PostgreSQL optimization guidance"

# Tag releases
git tag -a v1.2.0 -m "Agent collection v1.2.0: Enhanced frontend and backend specialists"
```

## 🔧 Troubleshooting Best Practices

### Common Issues and Solutions

#### Agent Not Auto-Selected
```yaml
# Problem: Agent description lacks trigger keywords
description: "Helps with backend development"

# Solution: Add specific trigger keywords
description: "Use this agent when you need API development, database design, server-side architecture, or backend performance optimization guidance."
```

#### Inconsistent Responses
```markdown
# Problem: Vague philosophy section
## Backend Philosophy
- Write good code
- Make it fast

# Solution: Specific, actionable principles
## Backend Philosophy

### Scalability and Performance
- Design systems that can handle growth in users, data, and transaction volume
- Implement efficient algorithms and data structures for optimal performance
- Use caching strategies and database optimization to minimize response times
```

#### Poor Multi-Agent Coordination
```bash
# Problem: Agents working in isolation
> Use backend-specialist for API
> Use frontend-specialist for UI

# Solution: Coordinated workflow
> Multi-agent shopping cart development:
  1. product-owner: Define cart requirements and user stories
  2. software-architect: Design cart system architecture
  3. backend-specialist: Implement cart API with architecture guidance
  4. frontend-specialist: Build cart UI consuming the API  
  5. qa-engineer: Test end-to-end cart functionality
```

### Performance Issues

#### Slow Agent Loading
```bash
# Diagnose loading time
time claude-code -c "/agents"

# Solutions:
1. Reduce agent file sizes by removing verbose examples
2. Use project-specific agents instead of global installation
3. Archive unused agents temporarily
```

#### Memory Usage
```bash
# Monitor memory usage
ps aux | grep claude-code

# Optimization strategies:
1. Use selective agent installation
2. Implement agent lazy loading
3. Clear agent cache periodically
```

## 📚 Advanced Patterns

### Agent Composition Patterns

#### Hierarchical Delegation
```bash
# Enterprise CTO → Software Architect → Specialists
> Use enterprise-cto for technology strategy decision
# CTO delegates to software-architect for detailed design
# Architect coordinates with specialists for implementation
```

#### Cross-Domain Collaboration
```bash
# Security + DevOps integration
> Use security-engineer to define security requirements
> Use devops-engineer to implement security in CI/CD pipeline
> Use backend-specialist to implement secure authentication
```

### Custom Workflow Creation

#### Template-Based Workflows
```bash
# Create reusable workflow templates
mkdir -p ~/.claude/workflows

cat > ~/.claude/workflows/fullstack-feature.md << 'EOF'
# Full-Stack Feature Development Workflow

## Phase 1: Planning
- product-owner: Requirements analysis
- software-architect: System design

## Phase 2: Implementation  
- backend-specialist: API development
- frontend-specialist: UI development

## Phase 3: Quality Assurance
- qa-engineer: Testing strategy
- security-engineer: Security review

## Phase 4: Deployment
- devops-engineer: Deployment and monitoring
EOF
```

#### Workflow Automation
```bash
# Script-based workflow execution
#!/bin/bash
# fullstack-workflow.sh

feature_name="$1"
echo "Starting full-stack development for: $feature_name"

# Phase 1: Planning
claude-code -c "Use product-owner to define requirements for: $feature_name"
read -p "Continue to architecture? (y/n): " continue
[[ $continue == "y" ]] || exit 1

claude-code -c "Use software-architect to design system for: $feature_name"
# Continue with implementation phases...
```

---

## 🎯 Quick Reference

### Agent Selection Keywords
- **backend-specialist**: API, database, server, backend, microservices, REST, GraphQL
- **frontend-specialist**: React, Vue, Angular, UI, frontend, component, responsive
- **devops-engineer**: deployment, CI/CD, Docker, Kubernetes, infrastructure, monitoring
- **security-engineer**: security, vulnerability, authentication, encryption, compliance
- **qa-engineer**: testing, QA, automation, coverage, validation

### Common Usage Patterns
```bash
# Single-agent tasks
> Use [agent] to [specific task] for [technology/context]

# Multi-agent workflows  
> Coordinate [agent1] → [agent2] → [agent3] for [complex project]

# Task tool integration
> Use Task tool with [agent] to [complex analysis/implementation]

# Emergency response
> [Problem description] - coordinate [multiple agents] for investigation
```

### Quality Checklist
- [ ] YAML frontmatter is valid and complete
- [ ] Description includes trigger keywords
- [ ] Color is unique and meaningful
- [ ] Content follows established structure
- [ ] Examples are current and relevant
- [ ] Integration with Claude Code tested
- [ ] Multi-agent workflows validated

**Master these practices to create and use world-class AI agents with Claude Code!** 🚀