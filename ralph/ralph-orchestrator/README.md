# Ralph Orchestrator - Full Bash Orchestration

> For large projects requiring fresh context each iteration.

Ralph Orchestrator is the **robust approach** to autonomous iteration. It uses an external bash script to spawn fresh AI sessions, with memory persisted through files.

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│  BASH ORCHESTRATOR (ralph.sh)                               │
│                                                             │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐    │
│  │Session 1│ → │Session 2│ → │Session 3│ → │Session N│    │
│  │Fresh ctx│   │Fresh ctx│   │Fresh ctx│   │Fresh ctx│    │
│  │Task #1  │   │Task #2  │   │Task #3  │   │Task #N  │    │
│  └────┬────┘   └────┬────┘   └────┬────┘   └────┬────┘    │
│       │             │             │             │          │
│       ▼             ▼             ▼             ▼          │
│  ┌─────────────────────────────────────────────────────┐  │
│  │                 SHARED MEMORY (files)                │  │
│  │                                                      │  │
│  │  prd.json        - Task list with completion status  │  │
│  │  progress.txt    - Learnings from each iteration     │  │
│  │  AGENTS.md       - Patterns and conventions          │  │
│  │  git history     - All committed work                │  │
│  │                                                      │  │
│  └─────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

## Key Characteristics

| Aspect | Ralph Orchestrator |
|--------|-------------------|
| Context | Fresh each iteration (intentional) |
| Memory | prd.json + progress.txt + AGENTS.md + git |
| Orchestration | External bash script |
| Setup | More infrastructure |
| Best for | Large projects, overnight runs |

## Why Fresh Context?

- **No context degradation** - Each iteration starts clean
- **Larger total scope** - Not limited by single context window
- **Better knowledge transfer** - Forced to write things down
- **Reproducible** - Each iteration is independent

## File Structure

```
your-project/
├── scripts/ralph/
│   ├── ralph.sh           # Main orchestration script
│   └── prompt.md          # Instructions for each iteration
├── prd.json               # Task list with status
├── progress.txt           # Accumulated learnings
└── AGENTS.md              # Project patterns
```

## prd.json Format

```json
{
  "project": "My Project",
  "stories": [
    {
      "id": "US-001",
      "title": "User Registration",
      "description": "As a user, I want to register...",
      "acceptance": [
        "POST /auth/register creates user",
        "Validation errors return 400",
        "Duplicate email returns 409"
      ],
      "priority": "P0",
      "status": "pending",
      "passes": false
    },
    {
      "id": "US-002",
      "title": "User Login",
      "description": "As a user, I want to login...",
      "acceptance": [...],
      "priority": "P0",
      "status": "pending",
      "passes": false
    }
  ]
}
```

## progress.txt Format

```
=== Iteration 1 (2024-01-15 10:30) ===
Completed: US-001 User Registration
- Created user model with email, password fields
- Used bcrypt for password hashing
- Added validation with zod
Learning: Zod schemas should be in separate files for reuse

=== Iteration 2 (2024-01-15 10:45) ===
Completed: US-002 User Login
- Implemented JWT token generation
- Added refresh token support
Learning: Store refresh tokens in httpOnly cookies, not localStorage
```

## Usage

### Setup
```bash
# Copy ralph files to your project
cp -r ralph/ralph-orchestrator/scripts your-project/scripts/ralph

# Create initial prd.json (or use /kickoff to generate)
```

### Run
```bash
# Run with default 10 iterations
./scripts/ralph/ralph.sh

# Run with specific iteration count
./scripts/ralph/ralph.sh 50
```

### Monitor
```bash
# Watch progress
tail -f progress.txt

# Check task status
cat prd.json | jq '.stories[] | {id, title, passes}'
```

## When to Use Ralph Orchestrator

### Good For
- Large projects with many features
- Overnight/unattended runs
- Projects requiring multiple sessions worth of work
- When context window limits are a concern
- Team projects (progress visible in files)

### Not Good For
- Quick single features
- Tasks needing constant human input
- Highly interactive work
- Simple bug fixes

## Comparison with Ralph Wiggum

| Aspect | Wiggum | Orchestrator |
|--------|--------|--------------|
| Setup | Minimal | More involved |
| Context | Continuous | Fresh each time |
| Memory | Implicit | Explicit (files) |
| Scale | Medium tasks | Large projects |
| Monitoring | In-session | File-based |

## Credits

Based on [snarktank/ralph](https://github.com/snarktank/ralph) and the [original Ralph technique by Geoffrey Huntley](https://ghuntley.com/ralph/).
