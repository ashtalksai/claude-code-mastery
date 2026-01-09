# [Project Name]

> Project-specific instructions for Claude Code.
> This file is shared with the team via git.

## Overview

[Brief description of what this project does]

See @docs/PRD.md for full requirements.
See @docs/ARCHITECTURE.md for system design.

## Tech Stack

- **Frontend**: [e.g., React + TypeScript + Vite]
- **Backend**: [e.g., Node.js + Express]
- **Database**: [e.g., PostgreSQL via Supabase]
- **Deployment**: [e.g., Vercel + Railway]

## Commands

```bash
# Development
pnpm dev          # Start dev server

# Building
pnpm build        # Production build
pnpm preview      # Preview production build

# Testing
pnpm test         # Run tests
pnpm test:watch   # Watch mode
pnpm test:coverage # With coverage

# Code Quality
pnpm lint         # Run ESLint
pnpm format       # Run Prettier
pnpm typecheck    # Run TypeScript compiler
```

## Project Conventions

### File Organization
```
src/
├── components/    # React components
├── pages/         # Page components
├── hooks/         # Custom hooks
├── services/      # API calls
├── utils/         # Helper functions
└── types/         # TypeScript types
```

### Naming Conventions
- Components: `PascalCase` (e.g., `UserCard.tsx`)
- Hooks: `camelCase` with `use` prefix (e.g., `useAuth.ts`)
- Utils: `camelCase` (e.g., `formatDate.ts`)
- Types: `PascalCase` (e.g., `User`, `ApiResponse`)

### Code Style
- Functional components only
- Props interfaces above components
- Extract logic to custom hooks
- One component per file

## Important Files

- `src/config/` - Configuration and environment
- `src/lib/` - Third-party library setup
- [Add other important files/folders]

## Environment Variables

Required environment variables (see `.env.example`):
- `DATABASE_URL` - Database connection string
- `API_KEY` - External API key
- [Add others]

## Known Issues / TODOs

- [ ] [Known issue or TODO]

---

*Last updated: [Date]*
