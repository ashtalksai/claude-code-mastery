# Frontend Developer Setup

> Optimized for React/Vue/Svelte development with modern tooling.

## Overview

This setup is tailored for frontend developers who:
- Build user interfaces with React, Vue, or Svelte
- Work with modern CSS (Tailwind, CSS Modules)
- Create responsive, accessible applications
- Focus on user experience and performance

## Global CLAUDE.md

```markdown
# Frontend Developer Preferences

## General
- Don't auto-commit unless I ask
- Show me the component code, not lengthy explanations
- No emojis

## Code Style
- React with TypeScript (strict mode)
- Functional components only
- Custom hooks for reusable logic
- CSS Modules or Tailwind for styling

## UI/UX Preferences
- Mobile-first responsive design
- Accessibility (ARIA, keyboard navigation)
- Loading and error states for all async operations
- Optimistic updates where appropriate

## Tools
- Vite for build
- Vitest for testing
- React Query for server state
- Zustand for client state
- Tailwind CSS for styling
```

## Recommended Agents

### component-builder.md
```markdown
---
name: component-builder
description: Build React/Vue/Svelte components. Use when creating new UI components.
tools: Read, Write, Edit, Glob
---

You are a senior frontend developer specializing in component architecture.

When building components:
1. Start with TypeScript interface for props
2. Handle all states: loading, error, empty, success
3. Make accessible (ARIA labels, keyboard nav)
4. Keep components focused (single responsibility)
5. Extract hooks for reusable logic

Component structure:
- Props interface with JSDoc comments
- Hooks at the top
- Event handlers
- Early returns for special states
- Main render

Always consider:
- Responsive design (mobile-first)
- Keyboard accessibility
- Screen reader support
```

### ui-reviewer.md
```markdown
---
name: ui-reviewer
description: Review UI code for accessibility, performance, and best practices. Use after building components.
tools: Read, Glob, Grep
---

You are a frontend code reviewer focusing on quality.

Review checklist:
1. Accessibility
   - Semantic HTML
   - ARIA attributes
   - Keyboard navigation
   - Color contrast

2. Performance
   - Unnecessary re-renders
   - Large bundle imports
   - Image optimization
   - Lazy loading

3. Code Quality
   - TypeScript types (no any)
   - Component size (<200 lines)
   - Prop drilling (use context?)
   - Error boundaries

4. UX
   - Loading states
   - Error states
   - Empty states
   - Responsive design
```

## Recommended Skills

### react-patterns/SKILL.md
```markdown
---
name: react-patterns
description: React patterns and best practices. Use when building React applications.
---

# React Patterns

## Component Patterns

### Container/Presentation
```tsx
// Container: Logic
function UserListContainer() {
  const { data, isLoading } = useUsers();
  return <UserList users={data} loading={isLoading} />;
}

// Presentation: Pure UI
function UserList({ users, loading }: Props) {
  if (loading) return <Skeleton />;
  return <ul>{users.map(u => <UserItem key={u.id} user={u} />)}</ul>;
}
```

### Compound Components
```tsx
<Card>
  <Card.Header>Title</Card.Header>
  <Card.Body>Content</Card.Body>
  <Card.Footer>Actions</Card.Footer>
</Card>
```

### Custom Hooks
```tsx
function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState(value);
  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(timer);
  }, [value, delay]);
  return debouncedValue;
}
```

## State Management Decision Tree
- Form input → useState
- Shared UI state → Zustand
- Server data → React Query
- URL state → useSearchParams
```

## Recommended Hooks

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx prettier --write \"$filepath\" 2>/dev/null || true"
          }
        ]
      }
    ]
  }
}
```

## Recommended Commands

### /component
```markdown
---
name: component
description: Create a new React component
arguments:
  - name: name
    description: Component name (PascalCase)
    required: true
---

# Create Component: {{name}}

Use the component-builder agent to create {{name}}.

Create:
- {{name}}/
  - {{name}}.tsx (component)
  - {{name}}.test.tsx (tests)
  - {{name}}.module.css (styles, if needed)
  - index.ts (export)

Include:
- TypeScript props interface
- Loading/error/empty states
- Basic accessibility
- At least one test
```

## Directory Structure

```
~/.claude/
├── CLAUDE.md                    # Frontend preferences above
├── agents/
│   ├── component-builder.md
│   └── ui-reviewer.md
├── skills/
│   └── react-patterns/SKILL.md
├── commands/
│   └── component.md
├── rules/
│   └── component-rules.md
└── settings.json                # Hooks above
```
