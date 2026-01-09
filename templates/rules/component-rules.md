---
paths: src/components/**/*
paths: components/**/*
paths: app/components/**/*
---

# React/Vue/Svelte Component Rules

> These rules apply when working with UI components.

## File Organization

- One component per file
- Filename matches component name (PascalCase): `UserCard.tsx`
- Colocate related files:
  ```
  UserCard/
  ├── UserCard.tsx
  ├── UserCard.test.tsx
  ├── UserCard.module.css (or .styles.ts)
  └── index.ts
  ```

## Component Structure (React Example)

```typescript
// 1. Imports (external first, then internal)
import { useState, useEffect } from 'react';
import { Button } from '@/components/ui';
import { formatDate } from '@/utils';

// 2. Types
interface UserCardProps {
  /** The user to display */
  user: User;
  /** Called when edit button clicked */
  onEdit?: (user: User) => void;
}

// 3. Component
export function UserCard({ user, onEdit }: UserCardProps) {
  // 4. Hooks (always at the top)
  const [isExpanded, setIsExpanded] = useState(false);

  // 5. Derived state
  const fullName = `${user.firstName} ${user.lastName}`;

  // 6. Event handlers
  const handleEditClick = () => {
    onEdit?.(user);
  };

  // 7. Effects (if needed)
  useEffect(() => {
    // Effect logic
  }, [dependency]);

  // 8. Early returns for loading/error states
  if (!user) return null;

  // 9. Main render
  return (
    <div className="user-card">
      <h2>{fullName}</h2>
      {onEdit && <Button onClick={handleEditClick}>Edit</Button>}
    </div>
  );
}
```

## Best Practices

- **Props**: Define explicit TypeScript interface
- **State**: Keep minimal, derive when possible
- **Events**: Name handlers `handleXxxClick`, `handleXxxChange`
- **Conditionals**: Early return for special cases
- **Children**: Use composition over configuration

## Do NOT

- Use `any` type for props
- Put business logic in components (use hooks/services)
- Create god components (>200 lines is a smell)
- Mutate props or state directly
- Forget cleanup in useEffect
