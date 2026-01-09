---
name: ralph-loop
description: Start an autonomous iteration loop that continues until completion
arguments:
  - name: prompt
    description: The task prompt with success criteria
    required: true
  - name: max-iterations
    description: Maximum iterations before stopping (default unlimited)
    required: false
  - name: completion-promise
    description: Text that signals completion (default COMPLETE)
    required: false
---

# Ralph Loop Initiated

Starting autonomous iteration loop.

**Task:** {{prompt}}
**Max Iterations:** {{max-iterations | default: "unlimited"}}
**Completion Signal:** `<promise>{{completion-promise | default: "COMPLETE"}}</promise>`

---

## Instructions

You are now in a Ralph loop. This means:

1. **Work on the task** described above
2. **Check success criteria** after making progress
3. **If criteria NOT met**: Continue working (you'll see your previous work)
4. **If criteria MET**: Output the completion signal

## Important

- Your work persists in files - you can see what you did in previous iterations
- Check git status/diff to see your progress
- Each iteration builds on previous work
- Don't repeat work already done - check first

## Completion

When ALL success criteria are satisfied, output exactly:

```
<promise>{{completion-promise | default: "COMPLETE"}}</promise>
```

This will end the loop.

## If Stuck

If you cannot make progress after several attempts:
1. Document what's blocking you
2. List what you've tried
3. Output: `<promise>STUCK_NEED_HELP</promise>`

---

Begin working on the task now.
