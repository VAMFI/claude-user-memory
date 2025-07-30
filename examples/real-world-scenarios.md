# 🌍 Real-World Scenarios

> Practical examples demonstrating the Research → Plan → Implement workflow in production environments

## Table of Contents
1. [E-commerce Payment Integration](#1-e-commerce-payment-integration)
2. [Microservices Migration](#2-microservices-migration)
3. [Real-time Features with WebSockets](#3-real-time-features-with-websockets)
4. [Database Performance Crisis](#4-database-performance-crisis)
5. [Legacy System Modernization](#5-legacy-system-modernization)
6. [Multi-tenant SaaS Architecture](#6-multi-tenant-saas-architecture)
7. [CI/CD Pipeline Setup](#7-cicd-pipeline-setup)
8. [API Rate Limiting](#8-api-rate-limiting)
9. [Elasticsearch Integration](#9-elasticsearch-integration)
10. [Mobile App Backend](#10-mobile-app-backend)

---

## 1. E-commerce Payment Integration

**Scenario**: Adding Stripe payment processing to an existing e-commerce platform with subscription support.

### Research Phase
```bash
> Research Stripe integration for Node.js with subscription billing
```

**docs-researcher discovers**:
- Stripe Node.js SDK v12.18.0
- Strong Customer Authentication (SCA) requirements
- Webhook security best practices
- Subscription lifecycle management
- PCI compliance considerations

### Planning Phase
```bash
> Plan Stripe payment integration based on the research
```

**implementation-planner creates**:
```markdown
### File Changes:
- `/src/services/payment.service.js` - Core payment logic
- `/src/services/subscription.service.js` - Subscription management
- `/src/routes/payment.routes.js` - Payment endpoints
- `/src/middleware/stripe-webhook.js` - Webhook verification
- `/src/models/subscription.model.js` - Subscription data model

### Implementation Steps:
1. Install Stripe SDK and dependencies
2. Create payment service with SCA support
3. Implement subscription lifecycle handlers
4. Add webhook endpoints with signature verification
5. Create payment UI components
6. Add comprehensive error handling
7. Implement retry logic for failed payments

### Test Criteria:
- Unit tests for payment calculations
- Integration tests with Stripe test mode
- Webhook signature verification tests
- Subscription state transition tests
```

### Implementation Phase
```bash
> Implement the Stripe payment plan
```

**Result**: Fully functional payment system with:
- PCI-compliant card handling
- Automated subscription management
- Robust webhook processing
- Comprehensive audit logging

**Key Insight**: The research phase revealed SCA requirements that would have caused EU payment failures if missed.

---

## 2. Microservices Migration

**Scenario**: Breaking down a monolithic Node.js application into microservices.

### Research Phase
```bash
> Research microservices patterns and inter-service communication for Node.js
```

**docs-researcher findings**:
- Service mesh patterns (Istio, Consul)
- gRPC vs REST for internal APIs
- Distributed tracing with OpenTelemetry
- Saga pattern for distributed transactions
- Circuit breaker implementation

### Planning Phase
```bash
> Plan extraction of user service from monolith
```

**implementation-planner strategy**:
```markdown
### Phase 1: Strangler Fig Pattern
1. Create user-service repository
2. Duplicate user-related code
3. Set up service communication
4. Add feature flags for gradual migration
5. Implement distributed tracing

### Phase 2: Data Separation
1. Set up separate user database
2. Implement event sourcing for sync
3. Create data migration scripts
4. Plan rollback procedures

### Phase 3: Traffic Migration
1. Update API gateway routing
2. Monitor performance metrics
3. Gradual traffic shift (10% → 50% → 100%)
4. Deprecate monolith endpoints
```

### Implementation Phase
Executed in three phases over 6 weeks:
- Zero downtime migration
- Performance improved by 40%
- Enabled independent scaling

---

## 3. Real-time Features with WebSockets

**Scenario**: Adding real-time notifications to a collaboration platform.

### Research Phase
```bash
> Research WebSocket implementation with Socket.io for scalable real-time features
```

**Key discoveries**:
- Socket.io v4 breaking changes
- Redis adapter for multi-server setup
- Namespace and room patterns
- Authentication strategies
- Reconnection handling

### Planning Phase
Designed scalable architecture:
- Redis pub/sub for cross-server communication
- JWT-based socket authentication
- Graceful degradation for poor connections
- Event sourcing for missed messages

### Implementation Result
- 50,000+ concurrent connections
- < 100ms message delivery
- Automatic failover
- Offline message queue

---

## 4. Database Performance Crisis

**Scenario**: Production PostgreSQL queries taking 30+ seconds, causing timeouts.

### Research Phase
```bash
> Research PostgreSQL query optimization and indexing strategies
```

**Critical findings**:
- Missing indexes on foreign keys
- N+1 query problems
- Inefficient JOIN patterns
- Need for query result caching

### Planning Phase
Three-pronged approach:
1. **Immediate**: Add missing indexes
2. **Short-term**: Implement query caching
3. **Long-term**: Denormalize hot paths

### Implementation Result
- Query time: 30s → 0.2s
- Added comprehensive query monitoring
- Prevented future issues with automated analysis

---

## 5. Legacy System Modernization

**Scenario**: Modernizing a 10-year-old jQuery application to React.

### Research Phase
```bash
> Research incremental migration strategies from jQuery to React
```

**Strategies discovered**:
- Micro-frontend architecture
- React Islands approach
- Webpack Module Federation
- Gradual component replacement

### Planning Phase
12-week incremental plan:
- Week 1-2: Set up React alongside jQuery
- Week 3-6: Migrate shared components
- Week 7-10: Page-by-page migration
- Week 11-12: Remove jQuery dependencies

### Implementation Result
- No service disruption
- 60% reduction in bundle size
- Improved development velocity
- Maintained all functionality

---

## 6. Multi-tenant SaaS Architecture

**Scenario**: Converting single-tenant app to multi-tenant SaaS.

### Research Phase
```bash
> Research multi-tenant architecture patterns for SaaS applications
```

**Patterns evaluated**:
- Database per tenant
- Schema per tenant
- Shared schema with tenant ID
- Hybrid approach for different data types

### Planning Phase
Hybrid architecture chosen:
- Shared schema for users/auth
- Schema per tenant for business data
- Automated tenant provisioning
- Cross-tenant analytics capability

### Implementation Result
- Supports 1000+ tenants
- 5-minute tenant provisioning
- Tenant-level backups
- Performance isolation

---

## 7. CI/CD Pipeline Setup

**Scenario**: Setting up automated deployment pipeline for microservices.

### Research Phase
```bash
> Research CI/CD best practices for containerized microservices
```

**Tools and patterns**:
- GitOps with ArgoCD
- Helm charts for Kubernetes
- Blue-green deployments
- Automated rollback triggers

### Planning Phase
Complete pipeline design:
- GitHub Actions for CI
- Container scanning
- Automated testing gates
- Progressive deployment
- Monitoring integration

### Implementation Result
- 15-minute commit-to-production
- 99.9% deployment success rate
- Automated rollback in < 2 minutes
- Full audit trail

---

## 8. API Rate Limiting

**Scenario**: Implementing rate limiting to prevent API abuse.

### Research Phase
```bash
> Research API rate limiting strategies and Redis-based implementations
```

**Strategies analyzed**:
- Token bucket algorithm
- Sliding window
- Distributed rate limiting
- User tier management

### Planning Phase
Comprehensive solution:
- Redis-based sliding window
- Multiple limit tiers
- Graceful degradation
- Analytics integration

### Implementation Result
- Stopped abuse patterns
- Fair resource distribution
- Improved API stability
- Revenue from premium tiers

---

## 9. Elasticsearch Integration

**Scenario**: Adding full-text search to product catalog.

### Research Phase
```bash
> Research Elasticsearch integration patterns for e-commerce search
```

**Key learnings**:
- Index mapping strategies
- Relevance tuning
- Aggregations for facets
- Performance optimization

### Planning Phase
Phased approach:
1. Basic search implementation
2. Relevance tuning
3. Faceted search
4. Search analytics

### Implementation Result
- 50ms average search time
- 40% increase in conversions
- Rich filtering options
- Search-driven insights

---

## 10. Mobile App Backend

**Scenario**: Building backend for React Native mobile app.

### Research Phase
```bash
> Research mobile backend best practices for React Native apps
```

**Considerations**:
- Push notification services
- Offline data sync
- Image optimization
- Battery-efficient polling

### Planning Phase
Mobile-optimized architecture:
- GraphQL for efficient data fetching
- CDN for media delivery
- WebSocket for real-time updates
- Queue-based push notifications

### Implementation Result
- 60% reduction in data usage
- Offline-first capability
- Sub-second response times
- 98% push delivery rate

---

## Lessons Learned

### 1. Research Prevents Disasters
Every scenario revealed critical information that would have caused issues if missed.

### 2. Planning Saves Time
Upfront planning prevented costly refactoring and rewrites.

### 3. Incremental Implementation Works
Phased approaches reduced risk and allowed for course correction.

### 4. Documentation Matters
The workflow created excellent documentation for future maintenance.

### 5. Patterns Emerge
Similar challenges across projects benefit from systematic approach.

## Applying These Patterns

When facing similar scenarios:

1. **Start with Research**
   - Don't assume you know the best approach
   - Technology changes rapidly
   - Learn from others' experiences

2. **Plan for Reality**
   - Consider existing constraints
   - Design incremental changes
   - Always have rollback options

3. **Implement with Discipline**
   - Follow the plan
   - Test continuously
   - Document deviations

---

Next: [Workflow Guide](../docs/workflow-guide.md) | [Getting Started](getting-started.md)