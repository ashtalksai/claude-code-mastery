---
paths: src/db/**/*
paths: src/database/**/*
paths: src/models/**/*
paths: src/repositories/**/*
paths: prisma/**/*
paths: drizzle/**/*
paths: supabase/**/*
---

# Database Rules

> These rules apply when working with database code.

## Query Safety

- **ALWAYS** use parameterized queries
  ```typescript
  // GOOD
  db.query('SELECT * FROM users WHERE id = $1', [userId]);

  // BAD - SQL Injection risk!
  db.query(`SELECT * FROM users WHERE id = ${userId}`);
  ```

- Use transactions for multi-step operations
- Add indexes for frequently queried columns
- Limit result sets (always paginate)

## Model Standards

All models should have:
```typescript
interface BaseModel {
  id: string;           // UUID preferred
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;     // For soft delete
}
```

## Soft Delete Pattern

- Never hard delete user data
- Use `deletedAt` timestamp instead
- Filter deleted records in queries:
  ```typescript
  WHERE deleted_at IS NULL
  ```

## Migration Rules

- Migrations must be reversible (both `up` and `down`)
- Never modify migrations that have run in production
- Test migrations on a copy of production data first
- Name descriptively: `20240115_add_user_email_index.sql`
- One logical change per migration

## Performance

- Use `EXPLAIN ANALYZE` for complex queries
- Add indexes for:
  - Foreign keys
  - Columns used in WHERE clauses
  - Columns used in ORDER BY
- Avoid N+1 queries (use eager loading/joins)
- Use connection pooling

## Security

- Never store plaintext passwords (use bcrypt/argon2)
- Encrypt sensitive data at rest
- Use row-level security where appropriate
- Audit access to sensitive tables
- Sanitize all inputs before queries
