---
name: architecture-patterns
description: System architecture patterns, project structure, and technical decision frameworks. Use when designing systems, making architectural decisions, or planning project structure.
---

# Architecture Patterns Guide

## Project Structure Templates

### Frontend (React/Vue/Svelte)
```
src/
├── components/          # Reusable UI components
│   ├── ui/             # Primitives (Button, Input, Card)
│   └── features/       # Feature-specific (UserCard, PostList)
├── pages/              # Route-level components
├── hooks/              # Custom hooks
├── stores/             # State management (Zustand/Pinia)
├── services/           # API client functions
├── utils/              # Pure helper functions
├── types/              # TypeScript types/interfaces
└── styles/             # Global styles, themes
```

### Backend (Node/Express)
```
src/
├── api/
│   ├── routes/         # Route definitions
│   ├── controllers/    # Request handlers
│   ├── middleware/     # Auth, validation, logging
│   └── validators/     # Request validation schemas
├── services/           # Business logic
├── repositories/       # Data access layer
├── models/             # Data models/entities
├── utils/              # Helpers
├── config/             # Configuration
└── types/              # TypeScript types
```

### Fullstack Monorepo
```
apps/
├── web/                # Frontend application
├── api/                # Backend API
└── admin/              # Admin dashboard (if needed)
packages/
├── ui/                 # Shared UI components
├── types/              # Shared TypeScript types
├── utils/              # Shared utilities
└── config/             # Shared configs (ESLint, TS)
```

## Decision Frameworks

### State Management

| Data Type | Solution | When to Use |
|-----------|----------|-------------|
| Local UI state | `useState` | Form inputs, toggles, modals |
| Shared UI state | Zustand/Jotai | Theme, sidebar, user preferences |
| Server state | React Query/SWR | API data, caching, sync |
| Form state | React Hook Form | Complex forms, validation |
| URL state | URL params | Filters, pagination, shareable state |

### Database Selection

| Need | Solution |
|------|----------|
| Relational data, complex queries | PostgreSQL |
| Rapid prototyping, JSON flexibility | MongoDB |
| Serverless, edge functions | Supabase, PlanetScale |
| Local-first, offline support | SQLite, IndexedDB |
| Real-time sync | Supabase Realtime, Firebase |

### API Design

| Pattern | When to Use |
|---------|-------------|
| REST | CRUD operations, resource-based |
| GraphQL | Multiple clients, flexible queries |
| tRPC | TypeScript fullstack, type safety |
| WebSocket | Real-time, bidirectional |

## Common Patterns

### Repository Pattern
```typescript
interface Repository<T> {
  findById(id: string): Promise<T | null>;
  findMany(filter?: Partial<T>): Promise<T[]>;
  create(data: CreateInput<T>): Promise<T>;
  update(id: string, data: UpdateInput<T>): Promise<T>;
  delete(id: string): Promise<void>;
}

class UserRepository implements Repository<User> {
  constructor(private db: Database) {}

  async findById(id: string) {
    return this.db.user.findUnique({ where: { id } });
  }
  // ... other methods
}
```

### Service Layer
```typescript
class UserService {
  constructor(
    private userRepo: UserRepository,
    private emailService: EmailService
  ) {}

  async createUser(data: CreateUserDTO) {
    // Business logic here
    const user = await this.userRepo.create(data);
    await this.emailService.sendWelcome(user.email);
    return user;
  }
}
```

### Error Handling
```typescript
class AppError extends Error {
  constructor(
    public statusCode: number,
    public code: string,
    message: string
  ) {
    super(message);
    this.name = 'AppError';
  }

  static badRequest(message: string) {
    return new AppError(400, 'BAD_REQUEST', message);
  }

  static notFound(resource: string) {
    return new AppError(404, 'NOT_FOUND', `${resource} not found`);
  }

  static unauthorized() {
    return new AppError(401, 'UNAUTHORIZED', 'Authentication required');
  }
}
```

### API Response Format
```typescript
// Success
interface SuccessResponse<T> {
  success: true;
  data: T;
}

// Error
interface ErrorResponse {
  success: false;
  error: {
    code: string;
    message: string;
    details?: unknown;
  };
}

// Paginated
interface PaginatedResponse<T> {
  success: true;
  data: T[];
  meta: {
    total: number;
    page: number;
    limit: number;
    hasMore: boolean;
  };
}
```

## Architecture Documentation Template

```markdown
# [Project Name] Architecture

## Overview
[High-level description and diagram]

## Tech Stack
| Layer | Technology | Rationale |
|-------|------------|-----------|
| Frontend | React + TypeScript | [Why] |
| Backend | Node + Express | [Why] |
| Database | PostgreSQL | [Why] |
| Hosting | Vercel + Railway | [Why] |

## System Components
[Description of main components and responsibilities]

## Data Models
[Key entities and relationships]

## API Design
[Endpoint overview or API documentation link]

## Security Considerations
[Auth strategy, data protection, etc.]

## Scalability Plan
[How the system will scale]
```
