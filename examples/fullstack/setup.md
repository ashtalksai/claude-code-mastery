# Fullstack Developer Setup

> Complete setup for building full applications from frontend to backend.

## Overview

This setup is for fullstack developers who:
- Build complete web applications
- Work with React + Node.js/Python backends
- Use databases (PostgreSQL, MongoDB, Supabase)
- Deploy to cloud platforms

## Global CLAUDE.md

```markdown
# Fullstack Developer Preferences

## General
- Don't auto-commit unless I ask
- Be concise
- No emojis

## Frontend
- React + TypeScript (strict)
- Tailwind CSS
- React Query for data fetching
- Zustand for state

## Backend
- Node.js + Express + TypeScript
- PostgreSQL with Prisma or Drizzle
- JWT authentication
- RESTful API design

## Code Style
- 2-space indentation
- Single quotes
- No semicolons (let prettier handle it)
- Prefer functional patterns

## Tools
- pnpm for packages
- Vite for frontend
- Vitest for testing
- Docker for local services
```

## Recommended Agents

Use ALL the agents from templates/:
- prd-writer.md
- scaffolder.md
- implementer.md
- tester.md
- reviewer.md
- debugger.md

Plus these fullstack-specific ones:

### database-designer.md
```markdown
---
name: database-designer
description: Design database schemas and migrations. Use when planning data models.
tools: Read, Write, Bash, Glob
---

You are a database architect.

When designing schemas:
1. Identify entities and relationships
2. Normalize appropriately (usually 3NF)
3. Plan indexes for query patterns
4. Consider soft deletes
5. Add audit fields (created_at, updated_at)

Output:
- Entity relationship description
- Prisma/Drizzle schema file
- Migration file
- Index recommendations
```

### api-designer.md
```markdown
---
name: api-designer
description: Design RESTful APIs. Use when planning API endpoints.
tools: Read, Write, Glob
---

You are an API architect.

When designing APIs:
1. Follow REST conventions
2. Version the API (/api/v1/)
3. Use consistent response format
4. Plan authentication/authorization
5. Document with OpenAPI/Swagger

Output:
- Endpoint list with methods
- Request/response schemas
- Auth requirements
- OpenAPI spec (if requested)
```

## Recommended Commands

### /fullstack-kickoff
```markdown
---
name: fullstack-kickoff
description: Start a complete fullstack project
arguments:
  - name: idea
    required: true
---

# Fullstack Project: {{idea}}

## Phase 1: PRD
Generate comprehensive PRD covering:
- User stories for frontend
- API requirements for backend
- Data model needs

## Phase 2: Architecture
- Frontend structure (React + routing)
- Backend structure (API + services)
- Database schema
- Authentication approach

## Phase 3: Database
- Design schema
- Create migrations
- Set up Prisma/Drizzle

## Phase 4: Backend
- Set up Express + TypeScript
- Implement API endpoints
- Add authentication
- Write API tests

## Phase 5: Frontend
- Scaffold React app
- Implement pages/components
- Connect to API
- Add auth flow

## Phase 6: Integration
- End-to-end testing
- Review and polish
```

## Project Structure

```
project/
├── apps/
│   ├── web/                 # React frontend
│   │   ├── src/
│   │   │   ├── components/
│   │   │   ├── pages/
│   │   │   ├── hooks/
│   │   │   ├── services/   # API client
│   │   │   └── stores/
│   │   └── package.json
│   └── api/                 # Node backend
│       ├── src/
│       │   ├── routes/
│       │   ├── controllers/
│       │   ├── services/
│       │   ├── middleware/
│       │   └── db/
│       └── package.json
├── packages/
│   ├── types/               # Shared TypeScript types
│   └── utils/               # Shared utilities
├── docker-compose.yml
├── pnpm-workspace.yaml
└── AGENTS.md
```

## Folder-Specific Rules

### .claude/rules/api-rules.md
(Use template from templates/rules/api-rules.md)

### .claude/rules/component-rules.md
(Use template from templates/rules/component-rules.md)

### .claude/rules/database-rules.md
(Use template from templates/rules/database-rules.md)

## Directory Structure

```
~/.claude/
├── CLAUDE.md                    # Fullstack preferences
├── agents/
│   ├── prd-writer.md
│   ├── scaffolder.md
│   ├── implementer.md
│   ├── tester.md
│   ├── reviewer.md
│   ├── debugger.md
│   ├── database-designer.md
│   └── api-designer.md
├── skills/
│   ├── prd-template/SKILL.md
│   └── architecture/SKILL.md
├── commands/
│   ├── kickoff.md
│   ├── kickoff-ralph.md
│   ├── morning.md
│   ├── deploy.md
│   └── review-pr.md
├── rules/
│   ├── api-rules.md
│   ├── component-rules.md
│   └── database-rules.md
└── settings.json
```
