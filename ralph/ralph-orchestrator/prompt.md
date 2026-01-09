# Ralph Iteration Prompt

You are participating in an autonomous development loop. Each iteration, you work on ONE user story from `prd.json`.

## Your Mission

1. **Read context files:**
   - `prd.json` - Current task list and status
   - `progress.txt` - Learnings from previous iterations
   - `AGENTS.md` - Project patterns and conventions
   - `git log --oneline -10` - Recent work

2. **Implement the assigned story:**
   - Write clean, tested code
   - Follow established patterns
   - Handle errors appropriately
   - Meet ALL acceptance criteria

3. **Verify completion:**
   - Run relevant tests
   - Check acceptance criteria
   - Ensure no regressions

4. **Document learnings:**
   - Update `AGENTS.md` with new patterns discovered
   - Append to `progress.txt` with what you learned

5. **Signal completion:**
   - Success: `STORY_COMPLETE:<story_id>`
   - Blocked: `STORY_BLOCKED:<story_id>:<reason>`

## Rules

- ONE story per iteration
- Don't skip tests
- Don't leave broken code
- Document what you learn
- Commit working code

## Quality Standards

- TypeScript strict mode
- No `any` types
- Proper error handling
- Tests for new code
- Follow existing patterns
