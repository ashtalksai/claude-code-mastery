# Ralph Wiggum - Simple Hook-Based Iteration

> "Me fail English? That's unpossible!" - Ralph Wiggum

Ralph Wiggum is the **simple approach** to autonomous iteration. It uses a Stop hook to intercept Claude's exit attempts and feed the same prompt back, creating a self-referential loop.

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│  SINGLE CLAUDE SESSION                                      │
│                                                             │
│  You: /ralph-loop "Build X with criteria Y"                 │
│           │                                                 │
│           ▼                                                 │
│  Claude works on task                                       │
│           │                                                 │
│           ▼                                                 │
│  Claude tries to exit (task seems done)                     │
│           │                                                 │
│           ▼                                                 │
│  Stop Hook intercepts ──► Checks completion criteria        │
│           │                                                 │
│           ├──► Criteria NOT met: Feed same prompt back      │
│           │         │                                       │
│           │         ▼                                       │
│           │    Claude continues (sees previous work)        │
│           │         │                                       │
│           │         └──► Loop repeats                       │
│           │                                                 │
│           └──► Criteria MET (or max iterations): Exit       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Key Characteristics

| Aspect | Ralph Wiggum Approach |
|--------|----------------------|
| Context | Same session, continuous |
| Memory | Files + git history |
| Orchestration | None (hook trick) |
| Setup | Minimal |
| Best for | Single features, medium tasks |

## Usage

### Basic
```bash
/ralph-loop "Build a REST API for todos with full CRUD and tests. Output <promise>COMPLETE</promise> when done."
```

### With Options
```bash
/ralph-loop "Build feature X" --max-iterations 20 --completion-promise "DONE"
```

### Cancel
```bash
/cancel-ralph
```

## Writing Good Prompts

### Structure

```markdown
[Task description]

## Requirements
- Requirement 1
- Requirement 2

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] All tests pass

## Process
1. Step 1
2. Step 2
3. ...

## Completion
When ALL criteria met: <promise>COMPLETE</promise>

## If Stuck
After N iterations without progress:
- Document blockers
- Request input
```

### Examples

#### Good Prompt
```
Build a user authentication system.

Requirements:
- JWT-based authentication
- Login and register endpoints
- Password hashing with bcrypt
- Input validation

Success Criteria:
- [ ] POST /auth/register creates user
- [ ] POST /auth/login returns JWT
- [ ] Protected routes reject invalid tokens
- [ ] All tests passing

Process:
1. Create user model
2. Implement register endpoint
3. Implement login endpoint
4. Add auth middleware
5. Write tests
6. Verify all tests pass

Completion: <promise>AUTH_COMPLETE</promise>
```

#### Bad Prompt
```
Make a good authentication system.
```
(Too vague, no success criteria, no completion signal)

## When to Use Ralph Wiggum

### Good For
- Well-defined tasks with clear success criteria
- Tasks requiring iteration (getting tests to pass)
- Single features or modules
- Tasks with automatic verification

### Not Good For
- Tasks requiring human judgment
- Vague or unclear requirements
- Very large scope (use Ralph Orchestrator instead)
- Tasks needing multiple context windows

## Installation

The ralph-loop command should be available if you installed Claude Code Mastery. If not:

1. Copy `commands/ralph-loop.md` to `~/.claude/commands/`
2. Copy `hooks/stop-hook.json` to your settings

## Credits

Based on [Anthropic's ralph-wiggum plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum) and the [original Ralph technique by Geoffrey Huntley](https://ghuntley.com/ralph/).
