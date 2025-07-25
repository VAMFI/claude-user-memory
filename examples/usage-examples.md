# Usage Examples and Best Practices

This guide provides practical examples of how to effectively use the Claude Code Specialized Agents in real-world development scenarios.

## 🚀 Getting Started with Agents

### Accessing Agents
Once installed, access agents through Claude Code CLI:
```
claude-code
> /agents
```

This displays all available specialized agents with their descriptions and use cases.

### Agent Selection
Claude Code automatically suggests the most relevant agent based on your query, but you can also explicitly request a specific agent:
```
> I need help with database optimization
# Claude automatically suggests backend-specialist

> Use the backend-specialist agent to help optimize my PostgreSQL queries
# Explicitly requests specific agent
```

## 📚 Detailed Usage Scenarios

### 1. Backend Development Scenarios

#### High-Performance API Design
**Scenario**: Building a REST API that needs to handle 10,000+ requests per minute

**Query**:
```
I'm building a REST API for a social media platform that needs to handle 10k+ requests per minute. 
The API needs to support user authentication, post creation/retrieval, real-time notifications, 
and media uploads. How should I structure this for optimal performance?
```

**Expected Agent**: `backend-specialist`

**What the Agent Provides**:
- Scalable API architecture patterns
- Database optimization strategies
- Caching layer recommendations
- Load balancing approaches
- Performance monitoring setup

#### Database Performance Issues
**Scenario**: PostgreSQL queries becoming slower as data grows

**Query**:
```
My PostgreSQL database has grown to 500GB and some queries that used to take 200ms 
now take 30+ seconds. The main issues are with user activity feeds and search functionality. 
How do I systematically optimize this?
```

**Expected Agent**: `backend-specialist`

**Key Solutions**:
- Query optimization techniques
- Indexing strategies
- Database partitioning
- Query plan analysis
- Performance monitoring

### 2. Frontend Development Scenarios

#### React Performance Optimization
**Scenario**: React application with performance issues

**Query**:
```
My React app is getting slow. I have large lists (1000+ items), frequent re-renders, 
and the bundle size is over 5MB. Users are experiencing lag when scrolling and interacting. 
What's the systematic approach to fix these performance issues?
```

**Expected Agent**: `frontend-specialist`

**Optimization Areas**:
- Virtual scrolling implementation
- React.memo and useMemo optimization
- Bundle analysis and code splitting
- Lazy loading strategies
- Performance profiling

#### Component Library Development
**Scenario**: Building a reusable component library

**Query**:
```
I need to create a design system and component library that works across 5 different 
React applications. It should include theming, accessibility, and TypeScript support. 
How should I structure and build this?
```

**Expected Agent**: `frontend-specialist`

**Implementation Guide**:
- Monorepo setup with Lerna/Nx
- Component architecture patterns
- Theming system design
- Accessibility compliance
- Documentation generation

### 3. DevOps and Infrastructure Scenarios

#### CI/CD Pipeline Setup
**Scenario**: Automating deployment from GitHub to AWS

**Query**:
```
I want to automate my deployment process from GitHub to AWS EKS. Currently doing manual 
deployments which are error-prone. Need testing, security scanning, and rollback capabilities. 
How should I set this up?
```

**Expected Agent**: `devops-engineer`

**Implementation Steps**:
- GitHub Actions workflow design
- Docker containerization strategy
- Kubernetes deployment manifests
- Security scanning integration
- Monitoring and alerting setup

#### Kubernetes Scaling Issues
**Scenario**: Container orchestration problems

**Query**:
```
My Kubernetes cluster keeps crashing under load. Pods are getting OOMKilled, 
auto-scaling isn't working properly, and I'm not sure how to configure resource limits. 
Can you help debug and fix this?
```

**Expected Agent**: `devops-engineer`

**Troubleshooting Approach**:
- Resource request/limit configuration
- Horizontal Pod Autoscaler setup
- Cluster autoscaling configuration
- Monitoring and observability
- Load testing strategies

### 4. Security Engineering Scenarios

#### Multi-Tenant Security
**Scenario**: Implementing secure multi-tenant architecture

**Query**:
```
I'm building a multi-tenant SaaS application. Each tenant needs complete data isolation, 
secure authentication, and proper authorization. What's the best approach for implementing 
this securely?
```

**Expected Agent**: `security-engineer`

**Security Framework**:
- Tenant isolation strategies
- Authentication architecture (JWT, OAuth2)
- Authorization models (RBAC, ABAC)
- Data encryption standards
- Security monitoring and auditing

#### Vulnerability Remediation
**Scenario**: Addressing security scan findings

**Query**:
```
A security scan found SQL injection vulnerabilities in my Node.js API, XSS issues 
in the frontend, and insecure direct object references. How do I systematically 
fix these issues and prevent them in the future?
```

**Expected Agent**: `security-engineer`

**Remediation Plan**:
- SQL injection prevention (parameterized queries)
- XSS protection (input sanitization, CSP)
- Access control implementation
- Security testing automation
- Developer security training

### 5. Enterprise Architecture Scenarios

#### Microservices Migration
**Scenario**: Moving from monolith to microservices

**Query**:
```
We're a 200-person company with a monolithic e-commerce platform that's becoming 
hard to maintain and deploy. Should we migrate to microservices, and if so, 
what's the strategic approach?
```

**Expected Agent**: `enterprise-cto`

**Strategic Assessment**:
- Cost-benefit analysis
- Migration strategy and timeline
- Team structure implications
- Technology stack decisions
- Risk mitigation planning

#### Technology Stack Selection
**Scenario**: Choosing technologies for new product

**Query**:
```
We're launching a new AI-powered analytics product. Need to choose between 
React/Vue for frontend, Node.js/Python for backend, PostgreSQL/MongoDB for database. 
What framework should guide this decision?
```

**Expected Agent**: `enterprise-cto`

**Decision Framework**:
- Technical requirements analysis
- Team expertise assessment
- Scalability considerations
- Total cost of ownership
- Long-term maintainability

### 6. Management and Process Scenarios

#### Team Performance Issues
**Scenario**: Declining sprint velocity

**Query**:
```
My team's sprint velocity has dropped 30% over the last two quarters. We're missing 
deadlines, stories are getting carried over, and team morale seems low. How do I 
diagnose and fix this systematically?
```

**Expected Agent**: `engineering-manager`

**Performance Analysis**:
- Velocity trend analysis
- Blockers and impediments identification
- Team capacity assessment
- Process optimization recommendations
- Team morale improvement strategies

#### One-on-One Effectiveness
**Scenario**: Improving individual developer conversations

**Query**:
```
I have a junior developer who seems disengaged lately. Their code quality has declined, 
they're not participating in meetings, and they seem overwhelmed. How should I approach 
our next one-on-one to address this effectively?
```

**Expected Agent**: `engineering-manager`

**Conversation Framework**:
- Active listening techniques
- Performance feedback approaches
- Career development planning
- Workload assessment
- Support and mentoring strategies

### 7. Quality Assurance Scenarios

#### Test Strategy Development
**Scenario**: Implementing comprehensive testing

**Query**:
```
I have a React frontend with Node.js backend and PostgreSQL database. Currently have 
minimal testing and bugs keep slipping to production. What testing strategy should I 
implement to catch issues early?
```

**Expected Agent**: `qa-engineer`

**Testing Framework**:
- Unit testing setup (Jest, Mocha)
- Integration testing strategy
- End-to-end testing (Cypress, Playwright)
- API testing automation
- Test coverage analysis

#### Flaky Test Resolution
**Scenario**: Unreliable automated tests

**Query**:
```
My automated tests are failing intermittently in CI but pass locally. This is blocking 
deployments and frustrating the team. How do I identify and fix these flaky tests?
```

**Expected Agent**: `qa-engineer`

**Debugging Approach**:
- Test environment standardization
- Timing and synchronization issues
- Data dependency management
- Test isolation strategies
- CI/CD pipeline optimization

## 🎯 Best Practices for Agent Usage

### 1. Provide Context
Always include relevant context about your project:
- **Technology stack**: Languages, frameworks, databases
- **Team size**: Affects architecture and process recommendations
- **Scale**: User count, data volume, transaction volume
- **Constraints**: Budget, timeline, existing systems

### 2. Be Specific About Problems
Instead of: "Help me with performance"
Use: "My React app with 1000+ item lists is laggy during scrolling and interaction"

### 3. Include Current State
Describe what you've already tried:
- Current architecture or approach
- Previous attempts at solving the problem
- Existing tools and processes in place
- Known constraints or limitations

### 4. Ask for Implementation Details
Request specific, actionable guidance:
- Step-by-step implementation plans
- Code examples and configurations
- Testing and validation approaches
- Monitoring and maintenance strategies

### 5. Follow Up with Questions
Engage in dialogue to refine solutions:
- Ask for clarification on complex concepts
- Request alternatives or trade-offs
- Seek implementation timeline guidance
- Get recommendations for next steps

## 🔄 Multi-Agent Workflows

Some complex scenarios benefit from multiple agents:

### Full-Stack Feature Development
1. **Product Owner**: Define requirements and user stories
2. **Software Architect**: Design system architecture
3. **Frontend Specialist**: Implement UI components
4. **Backend Specialist**: Develop API endpoints
5. **QA Engineer**: Create testing strategy
6. **DevOps Engineer**: Set up deployment pipeline

### Enterprise System Migration
1. **Enterprise CTO**: Strategic planning and decision framework
2. **Software Architect**: Technical architecture design
3. **Project Manager**: Timeline and resource planning
4. **Security Engineer**: Security assessment and implementation
5. **DevOps Engineer**: Infrastructure and deployment strategy

## 📊 Measuring Success

### Agent Effectiveness Indicators
- **Clarity**: Responses are clear and actionable
- **Completeness**: All aspects of the problem are addressed
- **Practicality**: Solutions are implementable given constraints
- **Quality**: Technical recommendations follow best practices
- **Context**: Responses are appropriate for your team/organization size

### When to Switch Agents
- Current agent responses seem off-topic or inappropriate
- Problem scope expands beyond agent's expertise area
- Need different perspective (strategic vs. tactical)
- Require specialized knowledge in different domain

---

## 🎓 Learning Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [AI Prompt Engineering](https://docs.anthropic.com/claude/docs/prompt-engineering)
- [Software Development Best Practices](https://github.com/topics/best-practices)
- [System Design Interviews](https://github.com/donnemartin/system-design-primer)

Remember: These agents are tools to enhance your development process. The quality of their responses depends on the clarity and context of your questions. Take time to craft detailed, specific queries for the best results.