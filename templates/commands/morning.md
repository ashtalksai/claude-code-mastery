---
name: morning
description: Morning standup preparation and project status check
---

# Morning Standup Prep

Quick status check to prepare for standup or start the day.

## 1. Yesterday's Work

```bash
git log --since="yesterday" --oneline --author="$(git config user.name)" 2>/dev/null || echo "No commits found or not in git repo"
```

Summarize what was accomplished yesterday.

## 2. Current Project State

### Uncommitted Changes
```bash
git status --short 2>/dev/null || echo "Not a git repository"
```

### Test Status
```bash
npm test 2>/dev/null || pnpm test 2>/dev/null || echo "No test script found"
```

### Lint Status
```bash
npm run lint 2>/dev/null || pnpm lint 2>/dev/null || echo "No lint script found"
```

### Type Check
```bash
npx tsc --noEmit 2>/dev/null || echo "No TypeScript config found"
```

## 3. Today's Focus

Check for priorities:
- Look at docs/PRD.md for next P0/P1 items
- Search for TODO comments in recent files
- Check for any failing tests that need fixing

## 4. Blockers

Identify any issues:
- Failing tests?
- Unresolved errors?
- Waiting on external dependencies?
- Questions that need answers?

---

## Output Format

Provide a concise standup summary:

```
## Standup Summary

**Yesterday:**
- [Completed item 1]
- [Completed item 2]

**Today:**
- [Priority 1]
- [Priority 2]

**Blockers:**
- [Blocker] or "None"

**Notes:**
- [Any relevant context]
```
