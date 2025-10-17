---
name: research
description: Quick command to invoke docs-researcher for rapid documentation research. Fetches version-accurate, authoritative sources and creates ResearchPack.
---

# /research Command

Execute documentation research using the docs-researcher agent.

## Usage

```
/research <topic or library>
```

## What This Does

1. Invokes `@docs-researcher` with your topic
2. Applies `research-methodology` skill automatically
3. Creates ResearchPack with:
   - Library version detection
   - Key APIs (minimum 3)
   - Setup instructions
   - Code examples
   - Source citations
4. Validates ResearchPack (must score 80+)
5. Returns ready for planning phase

## Examples

```
/research Redis caching for Node.js
/research NextAuth.js authentication
/research PostgreSQL connection pooling
/research AWS S3 SDK for Python
```

## Output

You'll receive a complete ResearchPack including:
- ✅ Target library with version
- ✅ Documented APIs with signatures
- ✅ Setup/configuration steps
- ✅ Working code examples
- ✅ Source URLs for all information
- ✅ Confidence level assessment
- ✅ Implementation checklist

## Quality Gate

ResearchPack will be automatically validated:
- Score must be ≥ 80/100
- If score < 80, you'll see specific defects to fix
- Validation ensures completeness, accuracy, citation, actionability

## Next Steps

After `/research` completes:
1. Review the ResearchPack
2. Run `/plan` to create implementation strategy
3. Or use `@implementation-planner` directly

## Time

Typical completion: **< 2 minutes**

---

**Executing command...**

Please invoke: `@docs-researcher {args}`

The research-methodology skill will be automatically applied to ensure systematic, accurate documentation gathering with proper citations.
