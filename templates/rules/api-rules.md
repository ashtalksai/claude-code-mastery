---
paths: src/api/**/*
paths: api/**/*
paths: server/**/*
paths: routes/**/*
---

# API Development Rules

> These rules apply when working with API-related code.

## Request Handling

- Validate ALL input at the controller/handler level
- Use parameterized queries for database operations (never string concatenation)
- Return consistent response format:
  ```typescript
  // Success
  { success: true, data: T }

  // Error
  { success: false, error: { code: string, message: string } }
  ```

## Error Handling

- Catch all errors - never let unhandled errors propagate
- Use custom error classes with status codes
- Log errors with context (request ID, user ID, endpoint)
- Sanitize errors before returning to client (no stack traces in production)
- Return user-friendly error messages

## Security Requirements

- Verify authentication on all protected routes
- Check authorization before performing operations
- Never expose internal error details to clients
- Validate and sanitize all user input
- Use HTTPS for all endpoints
- Implement rate limiting on public endpoints

## HTTP Status Codes

| Code | When to Use |
|------|-------------|
| 200 | Success (GET, PUT, PATCH) |
| 201 | Created (POST) |
| 204 | No Content (DELETE) |
| 400 | Bad Request - Invalid input |
| 401 | Unauthorized - Not authenticated |
| 403 | Forbidden - Authenticated but not allowed |
| 404 | Not Found |
| 409 | Conflict - Resource state conflict |
| 422 | Unprocessable Entity - Validation failed |
| 500 | Internal Server Error |

## Logging

- Log all requests: method, path, user (if authenticated)
- Log all errors with full context
- Never log: passwords, tokens, credit cards, PII
- Use structured logging (JSON format)
