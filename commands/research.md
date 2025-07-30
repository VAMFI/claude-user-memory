# Research Documentation Command

Quickly research any library, framework, or API using the docs-researcher agent.

## Usage
```
/research [library/framework] [version?]
```

## Examples
- `/research React hooks`
- `/research Next.js 14 App Router`
- `/research PostgreSQL jsonb operators`
- `/research AWS S3 SDK for Node.js`

## What it does
1. 🔍 Detects library version from your project
2. 📦 Fetches official documentation
3. 🌐 Gathers migration guides if needed
4. ✅ Produces ResearchPack with sources

## Tips
- Be specific about what you need
- Include version numbers when upgrading
- Mention platform (Node.js, Browser, etc)