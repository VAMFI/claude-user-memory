---
name: research-methodology
description: Systematic approach for gathering authoritative, version-accurate documentation. Claude invokes this skill when research is needed before implementation. Ensures truth over speed while achieving both.
auto_invoke: true
tags: [research, documentation, verification, truth]
---

# Research Methodology Skill

This skill provides a systematic methodology for conducting rapid, accurate documentation research to ground implementations in truth rather than potentially stale LLM memory.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- User mentions implementing/using a specific library or API
- User asks about current documentation for a technology
- User requests verification of API signatures or methods
- Task requires external dependencies or third-party integrations
- Updating/upgrading to new versions of frameworks

## Core Principles (BRAHMA Constitution)

1. **Truth over speed** - But achieve both through systematic approach
2. **Never guess APIs** - Always retrieve from authoritative sources
3. **Cite everything** - Include version, URL, and section references
4. **Deterministic** - Same research query should yield consistent results

## Research Methodology Protocol

### Step 1: Rapid Assessment (< 30 seconds)

**Objectives**:
- Identify what needs to be researched
- Detect current versions from project files
- Clarify any ambiguities

**Actions**:
1. **Parse request** - Extract library/API names mentioned
2. **Version detection** - Check project dependency files:
   - `package.json` → Node.js projects
   - `requirements.txt`, `pyproject.toml`, `Pipfile` → Python
   - `go.mod` → Go
   - `Cargo.toml` → Rust
   - `build.gradle`, `pom.xml` → Java
   - `*.csproj` → C#/.NET
   - `pubspec.yaml` → Dart/Flutter
   - `composer.json` → PHP

3. **Context gathering** - Note runtime, platform, existing dependencies

**Output**:
```
Target: [library-name]
Current Version: [X.Y.Z] (detected from [file])
Platform: [Node.js 20.x / Python 3.11 / etc.]
```

**If unclear**: Ask ONE specific clarifying question rather than proceed with assumptions

### Step 2: Source Prioritization (< 10 seconds)

**Source hierarchy** (in order of preference):

1. **Official documentation** (PRIMARY)
   - Project's official website
   - Official API reference
   - Official getting started guide

2. **Official migration/upgrade guides** (if version change)
   - Breaking changes documentation
   - Migration paths
   - Deprecation notices

3. **Official release notes/changelog** (for version-specific info)
   - What's new in this version
   - Bug fixes relevant to use case
   - Known issues

4. **Official GitHub repository** (if docs sparse)
   - README.md
   - Examples directory
   - Issue tracker (for known problems)

5. **Avoid** (unless no alternatives):
   - Blog posts (may be outdated)
   - Stack Overflow (may be for wrong version)
   - AI-generated content (circular hallucination risk)

### Step 3: Information Retrieval (< 90 seconds)

**Retrieval strategy**:

```
1. Try context7 system (if available)
   └─ Fastest, curated, version-aware docs

2. Use WebFetch on known official doc URLs
   └─ Direct fetch from source

3. If URL unknown, use WebSearch
   Query format: "[library name] [version] official documentation"
   └─ Find the official site first, then fetch

4. Extract only relevant sections
   └─ Don't download entire docs, target specific info needed
```

**What to extract**:
- **API signatures** - Function names, parameters, return types
- **Setup/initialization** - How to configure and start using
- **Code examples** - Minimal working examples (with URLs to source)
- **Gotchas** - Known issues, breaking changes, version-specific warnings
- **Best practices** - Recommended usage patterns from docs

**Anti-stagnation**:
- Set 60-second timeout per source
- If source fetch fails, report and try next source
- If all sources fail, report what was attempted and suggest manual research

### Step 4: Verification & Citation (< 30 seconds)

**For every piece of information extracted**:

```markdown
API: someFunction(param1: Type): ReturnType
Source: official-docs.com/api-reference/someFunction [version X.Y.Z]
```

**Verification checklist**:
- ✓ Version matches project dependency
- ✓ Source is official (not third-party)
- ✓ URL links to specific section (not just homepage)
- ✓ Information is current (check doc version/date if shown)
- ✓ Examples are complete and runnable

**Confidence levels**:
- **HIGH**: Official docs for exact version, multiple sources corroborate
- **MEDIUM**: Official docs but slight version mismatch, or single source
- **LOW**: Only unofficial sources, version mismatch, or deprecated docs

**Report confidence**: Always indicate confidence level in research output

### Step 5: Structured Output (< 30 seconds)

**Deliver in ResearchPack format**:

```markdown
# 📋 ResearchPack: [Library Name]

## Quick Reference
- Library: [name] v[X.Y.Z]
- Official Docs: [URL]
- Confidence: [HIGH/MEDIUM/LOW]

## Key APIs
[Concise list with signatures and sources]

## Setup
[Essential steps only, not every option]

## Gotchas
[Version-specific issues to avoid]

## Example
[Minimal working code with source link]

## Implementation Checklist
[Files to modify, steps in order]

## Sources
[Numbered list with URLs and versions]

## Open Questions
[Any decisions/clarifications needed]
```

**Keep it concise**:
- Use bullet points, not paragraphs
- Include only essential information for implementation
- Provide links for deeper reading (don't excerpt everything)

## Quality Assurance

**Before delivering research**:

1. **Completeness check**:
   - ✓ Library identified with version
   - ✓ At least 3 key APIs documented
   - ✓ Setup steps provided
   - ✓ At least 1 code example
   - ✓ All claims cited with sources

2. **Accuracy check**:
   - ✓ API signatures match docs exactly (not paraphrased)
   - ✓ Version numbers correct
   - ✓ URLs all valid and point to official sources
   - ✓ No hallucinated functions/parameters

3. **Usefulness check**:
   - ✓ Implementation checklist actionable
   - ✓ Examples are complete (can be run)
   - ✓ Gotchas relevant to detected version
   - ✓ Open questions identify real decisions needed

## Common Pitfalls to Avoid

❌ **Don't**:
- Use docs from wrong version
- Guess or fill in gaps from LLM memory
- Copy-paste entire doc pages (extract key info)
- Trust unofficial blogs/tutorials over official docs
- Proceed without citing sources
- Skip version detection step

✅ **Do**:
- Always detect version from project files first
- Cite every API with source URL + section
- Extract concise, relevant info only
- Report confidence level honestly
- Link to specific doc sections, not just homepage
- Note version-specific gotchas explicitly

## Performance Targets

- **Total time**: < 2 minutes for typical library research
- **Accuracy**: 100% of APIs must match official docs
- **Citations**: 100% of claims must have sources
- **Completeness**: 95%+ of info needed for implementation

## Example Usage

**Scenario**: User says "Add Redis caching to the product service"

**Claude (using this skill)**:

```
[Internal: This requires research on Redis client library]

🔍 Activating research-methodology skill

📦 Detecting Redis version from package.json... Found redis@4.6.0

🌐 Fetching official docs from redis.io...

[Follows methodology: assess → prioritize → retrieve → verify → output]

# 📋 ResearchPack: Redis Client (Node.js)

## Quick Reference
- Library: redis v4.6.0
- Official Docs: https://redis.io/docs/clients/nodejs/
- Confidence: HIGH

## Key APIs
1. `createClient(options)` - Initialize connection
   Source: redis.io/docs/clients/nodejs/v4.6#createClient

2. `client.get(key: string): Promise<string | null>` - Retrieve value
   Source: redis.io/docs/clients/nodejs/v4.6#get

[...rest of ResearchPack]

✅ Research complete - Ready for planning phase
```

---

**This skill ensures all implementations are grounded in current, authoritative documentation rather than potentially outdated LLM knowledge.**
