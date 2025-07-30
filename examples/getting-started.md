# 🎓 Getting Started with Claude Code Workflow Agents

> A beginner-friendly, step-by-step tutorial to master the Research → Plan → Implement workflow

## Prerequisites

Before starting, ensure you have:
- ✅ Node.js installed (v16 or higher)
- ✅ Basic command line knowledge
- ✅ A code editor (VS Code, Sublime, etc.)
- ✅ 30 minutes to complete this tutorial

## Tutorial Overview

We'll build a simple **task management API** using the workflow, learning each phase hands-on. By the end, you'll understand:
- How to research documentation properly
- How to create implementation plans
- How to execute changes systematically

## Step 1: Install Claude Code

First, let's install Claude Code CLI and the workflow agents.

### Install Claude Code CLI
```bash
# Install globally
npm install -g @anthropic/claude-code

# Verify installation
claude-code --version

# First run - this creates ~/.claude directory
claude-code
```

You'll see a welcome message. Type `exit` to close for now.

### Install Workflow Agents
```bash
# Clone the workflow agents repository
git clone https://github.com/irenicj/claude-code-workflow-agents.git
cd claude-code-workflow-agents

# Copy agents to Claude Code
cp agents/* ~/.claude/agents/

# Return to your workspace
cd ..
```

### Verify Installation
```bash
# Start Claude Code
claude-code

# List available agents
> /agents
```

You should see three agents:
- 📚 docs-researcher
- 📋 implementation-planner
- 🚀 code-implementer

## Step 2: Create Your Project

Let's create a simple Node.js project for our tutorial.

```bash
# Create project directory
mkdir task-manager-api
cd task-manager-api

# Initialize Node.js project
npm init -y

# Open Claude Code in this directory
claude-code
```

## Step 3: Your First Workflow - Adding Express

Now we'll use the workflow to add Express.js to our project.

### Phase 1: Research

In Claude Code, type:
```
> I need to set up Express.js for a REST API
```

Claude will automatically use docs-researcher. Watch as it:
1. Detects your Node.js version
2. Fetches Express documentation
3. Creates a ResearchPack

**What you'll see**: A structured document with:
- Express installation instructions
- Basic setup code
- Middleware recommendations
- Links to official docs

### Phase 2: Planning

Claude will suggest creating a plan. Or you can manually request:
```
> Create a plan for setting up Express with the research
```

The implementation-planner will:
1. Analyze your empty project
2. Plan file structure
3. Design initial setup

**What you'll see**: A plan containing:
- Files to create (app.js, routes/, etc.)
- Step-by-step setup procedure
- Test criteria

### Phase 3: Implementation

Claude will ask for approval, then implement:
```
> Implement the Express setup plan
```

The code-implementer will:
1. Create necessary files
2. Install dependencies
3. Set up basic Express server

**What you'll see**: 
- Files being created
- npm install running
- Basic server code

### Test Your Server

Exit Claude Code and run:
```bash
node app.js
```

Visit `http://localhost:3000` - you should see your API running!

## Step 4: Adding a Feature - Task Endpoints

Let's add CRUD endpoints for tasks using the workflow.

### Research Phase

Back in Claude Code:
```
> Research best practices for REST API endpoints in Express
```

This triggers research on:
- RESTful conventions
- Express routing patterns
- Error handling
- Validation strategies

### Planning Phase

```
> Plan task management endpoints based on the research
```

The planner will design:
- GET /tasks - List all tasks
- POST /tasks - Create task
- GET /tasks/:id - Get one task
- PUT /tasks/:id - Update task
- DELETE /tasks/:id - Delete task

### Implementation Phase

```
> Implement the task endpoints plan
```

Watch as the implementer:
- Creates routes/tasks.js
- Adds in-memory storage
- Implements all endpoints
- Adds error handling

### Test the API

```bash
# Restart server
node app.js

# Test with curl (in new terminal)
# Create a task
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Learn Claude Code","completed":false}'

# List tasks
curl http://localhost:3000/tasks
```

## Step 5: Adding Data Validation

Let's add input validation to our API.

### Research Phase

```
> Research input validation for Express APIs
```

docs-researcher will find:
- Popular validation libraries
- Express-validator documentation
- Best practices for API validation

### Planning Phase

```
> Plan input validation for the task endpoints
```

The plan will include:
- Installing express-validator
- Adding validation middleware
- Error response formatting

### Implementation Phase

```
> Implement the validation plan
```

The implementer adds:
- Validation rules
- Error handling middleware
- Proper error responses

## Step 6: Understanding the Workflow Benefits

Let's reflect on what we've learned:

### Without the Workflow
If you had built this without the workflow, you might have:
- Used outdated Express patterns
- Missed security best practices
- Made larger, riskier changes
- Had no rollback strategy

### With the Workflow
By following Research → Plan → Implement:
- ✅ Every decision backed by current docs
- ✅ Changes were minimal and focused
- ✅ Each phase was verified
- ✅ You have a clear audit trail

## Practice Exercises

Try these on your own to reinforce learning:

### Exercise 1: Add MongoDB
```
> Add MongoDB database to store tasks persistently
```
Follow the workflow:
1. Research MongoDB with Express
2. Plan database integration
3. Implement the changes

### Exercise 2: Add Authentication
```
> Add JWT authentication to protect the endpoints
```
The workflow will:
1. Research JWT best practices
2. Plan auth middleware
3. Implement security

### Exercise 3: Add Tests
```
> Add Jest tests for the task endpoints
```
Practice:
1. Research Express testing
2. Plan test structure
3. Implement test suite

## Common Beginner Mistakes

### Mistake 1: Skipping Research
```
❌ > Just add MongoDB to my project
✅ > Research MongoDB integration with Express first
```

### Mistake 2: Vague Requests
```
❌ > Make my API better
✅ > Add input validation to the task endpoints
```

### Mistake 3: Too Many Changes
```
❌ > Add MongoDB, Redis, authentication, and tests
✅ > Let's start with adding MongoDB for persistence
```

## Tips for Success

1. **Be Specific**: Clear requests get better results
2. **One Thing at a Time**: Focus on single features
3. **Read the Output**: ResearchPacks contain valuable information
4. **Review Plans**: Understand before implementing
5. **Test Incrementally**: Verify each change works

## Next Steps

### Explore More Workflows
- Read [Real-World Scenarios](real-world-scenarios.md)
- Study the [Workflow Guide](../docs/workflow-guide.md)
- Check the [Quick Reference](../docs/quick-reference.md)

### Advanced Features
- Learn about Task tool for complex operations
- Explore parallel research techniques
- Master phased implementations

### Join the Community
- Share your experience
- Ask questions in discussions
- Contribute improvements

## Troubleshooting

### Claude Code Not Found
```bash
# Ensure global npm bin is in PATH
npm bin -g
# Add the output to your PATH
```

### Agents Not Showing
```bash
# Check agents directory
ls ~/.claude/agents/
# Should show 3 .md files
```

### Workflow Not Triggering
- Use keywords like "research", "plan", "implement"
- Be explicit: "Use docs-researcher to..."

## Summary

Congratulations! You've learned the Research → Plan → Implement workflow by:
- ✅ Installing Claude Code and agents
- ✅ Creating a working API
- ✅ Following the workflow for each feature
- ✅ Understanding the benefits

Remember: **Good software isn't written, it's researched, planned, then implemented.**

---

Ready for more? Try the [Real-World Scenarios](real-world-scenarios.md) →