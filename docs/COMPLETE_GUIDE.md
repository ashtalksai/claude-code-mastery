# Claude Code Mastery Guide
## Your Personal Framework for AI-Powered Development

> "I am Iron Man." - You, after setting this up.

---

# Table of Contents

1. [The Big Picture](#the-big-picture)
2. [File Locations Cheat Sheet](#file-locations-cheat-sheet)
3. [CLAUDE.md - Persistent Memory](#claudemd---persistent-memory)
4. [Agents - Your AI Employees](#agents---your-ai-employees)
5. [Skills - Knowledge Libraries](#skills---knowledge-libraries)
6. [Hooks - Automatic Reactions](#hooks---automatic-reactions)
7. [Commands - Custom Slash Commands](#commands---custom-slash-commands)
8. [Rules - Folder-Specific Instructions](#rules---folder-specific-instructions)
9. [MCP - External Tool Connections](#mcp---external-tool-connections)
10. [The Full Pipeline Vision](#the-full-pipeline-vision)
11. [Step-by-Step Setup Guide](#step-by-step-setup-guide)
12. [Ready-to-Use Templates](#ready-to-use-templates)
13. [Pro Tips & Shortcuts](#pro-tips--shortcuts)

---

# The Big Picture

## How Everything Connects

```
YOU
 │
 ▼
┌─────────────────────────────────────────────────────────────────┐
│  /command (e.g., /kickoff "build a dashboard")                  │
│  Your entry point - one command triggers everything             │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  CLAUDE.md                                                      │
│  Always loaded. Your preferences, conventions, standards.       │
│  "The constitution" - Claude follows this in EVERY interaction  │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  Skills                                                         │
│  Knowledge injected when relevant.                              │
│  PRD templates, coding patterns, best practices.                │
│  Claude pulls these in automatically based on task.             │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  Agents                                                         │
│  Specialized workers with separate context windows.             │
│  Auto-delegated based on their description.                     │
│  PRD Writer, Scaffolder, Implementer, Tester, Reviewer.         │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  Hooks                                                          │
│  Automatic quality gates. No tokens wasted asking.              │
│  Format code, run linter, run tests, block dangerous commands.  │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  MCPs                                                           │
│  External tool connections.                                     │
│  GitHub, Supabase, Vercel, Slack, databases, APIs.              │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│  OUTPUT                                                         │
│  Your project: scaffolded, implemented, tested, deployed.       │
│  Ready for you to review and make decisions.                    │
└─────────────────────────────────────────────────────────────────┘
```

## The Philosophy

| Old Way | New Way |
|---------|---------|
| Prompt → Wait → Re-prompt → Wait → Fix → Re-prompt | /command → Review final output |
| Tell Claude everything every time | Claude already knows from CLAUDE.md |
| Manually run linter, tests, formatter | Hooks do it automatically |
| One Claude doing everything | Specialized agents for each task |
| Copy-paste knowledge each session | Skills provide knowledge automatically |
| Manually connect to services | MCPs connect directly |

---

# File Locations Cheat Sheet

## Global (All Projects, Forever)

```
~/.claude/
├── CLAUDE.md                      # Your personal preferences
├── settings.json                  # Global hooks configuration
├── mcp.json                       # Global MCP connections
├── agents/                        # Your permanent "employees"
│   ├── code-reviewer.md
│   ├── debugger.md
│   └── prd-writer.md
├── skills/                        # Your knowledge libraries
│   ├── prd-template/
│   │   └── SKILL.md
│   └── architecture-patterns/
│       └── SKILL.md
├── commands/                      # Your custom slash commands
│   ├── kickoff.md
│   ├── morning.md
│   └── deploy.md
├── output-styles/                 # Custom response formats
│   └── automation.md
└── rules/                         # Global rules
    └── security.md
```

## Project-Level (Specific Project, Shareable via Git)

```
your-project/
├── CLAUDE.md                      # Project standards (git-tracked)
├── CLAUDE.local.md                # Your personal project prefs (gitignored)
├── .claude/
│   ├── settings.json              # Project hooks
│   ├── mcp.json                   # Project MCP connections
│   ├── agents/                    # Project-specific agents
│   │   └── workflow-expert.md
│   ├── skills/                    # Project-specific skills
│   │   └── project-patterns/
│   │       └── SKILL.md
│   ├── commands/                  # Project-specific commands
│   │   └── test-workflow.md
│   └── rules/                     # Folder-specific rules
│       ├── api-rules.md           # paths: src/api/**
│       └── database-rules.md      # paths: src/db/**
└── docs/
    └── PRD.md                     # Referenced from CLAUDE.md
```

## Priority Order (Top = Highest Priority)

1. Enterprise policy (if applicable)
2. Project CLAUDE.md
3. Project rules (.claude/rules/)
4. User CLAUDE.md (~/.claude/)
5. User rules (~/.claude/rules/)

---

# CLAUDE.md - Persistent Memory

## What It Is

A markdown file Claude reads EVERY SINGLE TIME it starts a session. Your persistent memory across all conversations.

## Global CLAUDE.md

**Location:** `~/.claude/CLAUDE.md`

**Purpose:** Your personal preferences that apply to ALL projects.

**Example:**
```markdown
# My Preferences

## General
- Don't auto-commit changes unless I ask
- Don't create documentation files unless I ask
- Be concise - I prefer short answers
- No emojis unless I request them

## Code Style
- Use TypeScript for all JavaScript projects
- Use 2-space indentation
- Prefer functional programming patterns
- Always add error handling

## Communication
- When unsure, ask me rather than guessing
- Show me the plan before big changes
- Tell me file paths so I can navigate to them

## Tools I Use
- Package manager: pnpm
- Testing: Vitest
- Formatting: Prettier
- Linting: ESLint
```

## Project CLAUDE.md

**Location:** `./CLAUDE.md` (in project root)

**Purpose:** Project-specific rules, shared with team via git.

**Example:**
```markdown
# Project: Workflow Dashboard

## Overview
This is an n8n workflow management dashboard.
See @docs/PRD.md for full requirements.

## Tech Stack
- Frontend: React + TypeScript + Vite
- Backend: Node.js + Express
- Database: Supabase (PostgreSQL)
- Deployment: Vercel

## Commands
- Dev server: `pnpm dev`
- Build: `pnpm build`
- Test: `pnpm test`
- Lint: `pnpm lint`

## Conventions
- All API routes in `src/api/`
- All React components in `src/components/`
- Use React Query for data fetching
- Use Zustand for state management

## Important Files
- @src/config/database.ts - Database connection
- @src/api/workflows.ts - Main API routes
- @docs/ARCHITECTURE.md - System design
```

## CLAUDE.local.md

**Location:** `./CLAUDE.local.md` (in project root)

**Purpose:** Your personal preferences for THIS project only. Auto-gitignored.

**Example:**
```markdown
# My Local Preferences

- I'm working on the auth feature this week
- Skip the API tests for now, they're flaky
- I prefer to see console.logs during development
```

## The @ Syntax

Reference other files in your CLAUDE.md:

```markdown
See @docs/PRD.md for requirements
Follow patterns in @src/utils/helpers.ts
Architecture details in @docs/ARCHITECTURE.md
```

Claude will read these files when relevant, saving context until needed.

---

# Agents - Your AI Employees

## What They Are

Specialized AI workers that run in SEPARATE context windows. They don't pollute your main conversation with their work.

## Key Insight: Auto-Delegation

If you write a good `description`, Claude automatically delegates to agents WITHOUT you asking.

**The magic phrase:** Include "Use proactively" or "Use when" in the description.

## File Structure

```markdown
---
name: agent-name
description: What this agent does. Use proactively when [trigger condition].
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

System prompt goes here. This is what the agent "knows" and "does".
```

## Configuration Fields

| Field | Purpose | Options |
|-------|---------|---------|
| `name` | Unique identifier | Any string |
| `description` | When to use (Claude reads this!) | Be specific, include triggers |
| `tools` | What the agent can access | Read, Write, Edit, Bash, Glob, Grep, Task, WebFetch |
| `model` | Which model to use | `haiku`, `sonnet`, `opus`, `inherit` |
| `allowedTools` | Alternative to tools | Same as tools |
| `disallowedTools` | What to block | Any tool names |

## Template: PRD Writer Agent

**Location:** `~/.claude/agents/prd-writer.md`

```markdown
---
name: prd-writer
description: Convert ideas into detailed PRDs. Use proactively when user describes a new project idea or feature request.
tools: Read, Write, Glob
model: sonnet
---

You are a senior product manager who creates comprehensive PRDs.

## When Invoked

1. If the idea is vague, ask 3-5 clarifying questions:
   - Who is the target user?
   - What problem does this solve?
   - What's the scope (MVP vs full)?
   - Any technical constraints?
   - What does success look like?

2. Generate a PRD with these sections:
   - Overview
   - Problem Statement
   - Target Users
   - User Stories
   - Functional Requirements
   - Non-Functional Requirements
   - Technical Considerations
   - Success Metrics
   - Open Questions

3. Save to `docs/PRD.md`

4. Provide a summary and ask for approval

## Style
- Be specific, not vague
- Use acceptance criteria for each requirement
- Include edge cases
- Prioritize requirements (P0, P1, P2)
```

## Template: Project Scaffolder Agent

**Location:** `~/.claude/agents/scaffolder.md`

```markdown
---
name: scaffolder
description: Create project structure and boilerplate. Use proactively after PRD approval or when starting a new project.
tools: Read, Write, Bash, Glob
model: sonnet
---

You are a senior developer who sets up project foundations.

## When Invoked

1. Read the PRD if available (`docs/PRD.md`)
2. Determine appropriate tech stack (respect CLAUDE.md preferences)
3. Create folder structure
4. Initialize package.json with dependencies
5. Set up configuration files:
   - TypeScript config
   - ESLint config
   - Prettier config
   - Vite/Next config (as appropriate)
6. Create placeholder files for main features
7. Set up basic CI/CD if requested

## Output

Report what was created:
- Folder structure
- Key configuration decisions
- Next steps for implementation

## Standards
- Always use TypeScript
- Always include testing setup
- Always include linting/formatting
- Create README.md with setup instructions
```

## Template: Implementer Agent

**Location:** `~/.claude/agents/implementer.md`

```markdown
---
name: implementer
description: Implement features based on PRD and architecture. Use when writing substantial code or implementing features.
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You are a senior full-stack developer who writes clean, production-ready code.

## When Invoked

1. Read the PRD (`docs/PRD.md`) and architecture (`docs/ARCHITECTURE.md`)
2. Understand existing code patterns (scan the codebase)
3. Implement features following established patterns
4. Write code that is:
   - Type-safe (TypeScript strict mode)
   - Well-structured (single responsibility)
   - Error-handled (try/catch, proper error messages)
   - Testable (dependency injection, pure functions)

## Process

For each feature:
1. Create/update types and interfaces first
2. Implement core logic
3. Add error handling
4. Add logging where appropriate
5. Hooks will auto-format and lint

## Standards
- No `any` types
- No console.log in production code (use proper logging)
- All async functions must have error handling
- Follow existing patterns in the codebase
```

## Template: Tester Agent

**Location:** `~/.claude/agents/tester.md`

```markdown
---
name: tester
description: Write and run tests. Use proactively after implementation or when asked to test.
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You are a QA engineer who ensures code quality through comprehensive testing.

## When Invoked

1. Identify what needs testing (new code, modified code)
2. Write tests covering:
   - Happy paths
   - Edge cases
   - Error conditions
   - Boundary values

3. Run the test suite
4. Fix any failing tests
5. Report coverage

## Test Types

- **Unit tests**: Individual functions
- **Integration tests**: Multiple components together
- **API tests**: Endpoint behavior

## Standards
- Minimum 80% coverage for new code
- Use descriptive test names: `should [behavior] when [condition]`
- One assertion per test when possible
- Mock external dependencies
- Use factories for test data
```

## Template: Reviewer Agent

**Location:** `~/.claude/agents/reviewer.md`

```markdown
---
name: reviewer
description: Review code for quality, security, and best practices. Use proactively after implementation or before commits.
tools: Read, Glob, Grep, Bash
model: sonnet
---

You are a senior code reviewer ensuring high standards.

## When Invoked

1. Run `git diff` to see recent changes (or review specified files)
2. Analyze each change for:
   - Code quality
   - Security vulnerabilities
   - Performance issues
   - Test coverage
   - Documentation needs

## Review Checklist

### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] Proper authentication checks

### Quality
- [ ] No code duplication
- [ ] Functions are single-purpose
- [ ] Error handling is comprehensive
- [ ] Types are correct and specific

### Performance
- [ ] No N+1 queries
- [ ] Appropriate caching
- [ ] No memory leaks
- [ ] Efficient algorithms

## Output Format

Categorize findings:
- **Critical**: Must fix before merge
- **Warning**: Should fix
- **Suggestion**: Consider improving
- **Praise**: What was done well
```

## Template: Debugger Agent

**Location:** `~/.claude/agents/debugger.md`

```markdown
---
name: debugger
description: Debug issues and fix errors. Use when encountering bugs, errors, or unexpected behavior.
tools: Read, Edit, Bash, Glob, Grep
model: sonnet
---

You are a debugging expert who systematically finds and fixes issues.

## When Invoked

1. Understand the problem
   - What is the expected behavior?
   - What is the actual behavior?
   - When did it start happening?

2. Gather information
   - Read error messages carefully
   - Check logs
   - Review recent changes

3. Form hypotheses
   - List possible causes
   - Rank by likelihood

4. Test hypotheses
   - Add logging if needed
   - Use debugger if needed
   - Isolate the issue

5. Fix and verify
   - Make minimal changes
   - Verify the fix works
   - Check for regressions

## Process
- Always understand before fixing
- Make one change at a time
- Explain what caused the issue
- Suggest how to prevent similar issues
```

---

# Skills - Knowledge Libraries

## What They Are

Skills inject KNOWLEDGE into conversations. Unlike agents (workers), skills are reference material Claude pulls in when relevant.

## Difference from Agents

| Agents | Skills |
|--------|--------|
| Run in separate context | Inject into current context |
| Do tasks | Provide knowledge |
| Have their own tools | Inform tool usage |
| "Employees" | "Reference books" |

## File Structure

```
~/.claude/skills/
└── skill-name/
    ├── SKILL.md           # Main skill file (required)
    ├── reference.md       # Additional details (optional)
    └── examples/          # Example files (optional)
        └── example1.ts
```

## SKILL.md Structure

```markdown
---
name: skill-name
description: What this skill provides. Use when [trigger conditions].
allowed-tools: Read, Glob
---

# Skill Title

## Quick Start
Essential information Claude needs immediately.

## Details
More comprehensive information.

## Examples
Code samples and patterns.

## References
Links to detailed docs: [REFERENCE.md](REFERENCE.md)
```

## Template: PRD Template Skill

**Location:** `~/.claude/skills/prd-template/SKILL.md`

```markdown
---
name: prd-template
description: PRD structure and writing guidelines. Use when creating or reviewing PRDs.
---

# PRD Writing Guide

## Structure

Every PRD should have:

### 1. Overview (2-3 sentences)
What is this? Why are we building it?

### 2. Problem Statement
- Current pain points
- Impact of the problem
- Who is affected

### 3. Target Users
- Primary persona
- Secondary personas
- User characteristics

### 4. User Stories
Format: As a [user], I want to [action] so that [benefit].

Priority levels:
- P0: Must have for launch
- P1: Should have for launch
- P2: Nice to have

### 5. Functional Requirements
Specific features with acceptance criteria.

```
**FR-001: User Login**
- Users can login with email/password
- Users can login with Google OAuth
- Failed logins show error message
- Acceptance: User can access dashboard after login
```

### 6. Non-Functional Requirements
- Performance: Page load < 2s
- Security: HTTPS, encrypted passwords
- Scalability: Support 10k users

### 7. Technical Considerations
- Constraints
- Dependencies
- Risks

### 8. Success Metrics
- KPIs to measure success
- Targets for each metric

### 9. Timeline (Optional)
- Milestones
- Dependencies

### 10. Open Questions
- Unresolved decisions
- Items needing clarification
```

## Template: Architecture Patterns Skill

**Location:** `~/.claude/skills/architecture-patterns/SKILL.md`

```markdown
---
name: architecture-patterns
description: System architecture patterns and best practices. Use when designing systems or making architectural decisions.
---

# Architecture Patterns

## Frontend Patterns

### Component Structure
```
src/
├── components/          # Reusable UI components
│   ├── ui/             # Basic UI (Button, Input, etc.)
│   └── features/       # Feature-specific components
├── pages/              # Page components
├── hooks/              # Custom React hooks
├── stores/             # State management
├── services/           # API calls
├── utils/              # Helper functions
└── types/              # TypeScript types
```

### State Management Decision Tree
- Local UI state → useState
- Shared UI state → Zustand
- Server state → React Query
- Complex forms → React Hook Form

## Backend Patterns

### API Structure
```
src/
├── api/
│   ├── routes/         # Route definitions
│   ├── controllers/    # Request handlers
│   ├── services/       # Business logic
│   ├── repositories/   # Data access
│   └── middleware/     # Auth, logging, etc.
├── models/             # Data models
├── utils/              # Helpers
└── config/             # Configuration
```

### Error Handling Pattern
```typescript
// Custom error class
class AppError extends Error {
  constructor(
    public statusCode: number,
    public message: string,
    public code: string
  ) {
    super(message);
  }
}

// Controller usage
try {
  const result = await service.doSomething();
  res.json(result);
} catch (error) {
  if (error instanceof AppError) {
    res.status(error.statusCode).json({ error: error.message });
  } else {
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

## Database Patterns

### Repository Pattern
```typescript
interface UserRepository {
  findById(id: string): Promise<User | null>;
  findByEmail(email: string): Promise<User | null>;
  create(data: CreateUserDTO): Promise<User>;
  update(id: string, data: UpdateUserDTO): Promise<User>;
  delete(id: string): Promise<void>;
}
```

## For detailed patterns, see [PATTERNS_DETAIL.md](PATTERNS_DETAIL.md)
```

## Template: n8n Patterns Skill

**Location:** `~/.claude/skills/n8n-patterns/SKILL.md`

```markdown
---
name: n8n-patterns
description: n8n workflow automation best practices. Use when building, reviewing, or debugging n8n workflows.
---

# n8n Best Practices

## Workflow Structure

### Always Include
1. **Error Trigger** - Catch and handle errors
2. **Start node** - Clear entry point (Webhook, Schedule, etc.)
3. **End notification** - Confirm completion

### Error Handling Pattern
```
[Trigger] → [Process] → [Success Notification]
              ↓
         [Error Trigger] → [Error Notification]
```

## Webhook Security

### Always Use Authentication
```json
{
  "authentication": "headerAuth",
  "headerAuth": {
    "name": "X-API-Key",
    "value": "={{ $env.WEBHOOK_SECRET }}"
  }
}
```

### Validate Incoming Data
```javascript
// In a Code node after webhook
const data = $input.first().json;

if (!data.required_field) {
  throw new Error('Missing required_field');
}

if (typeof data.amount !== 'number') {
  throw new Error('amount must be a number');
}

return $input.all();
```

## Performance Tips

### Batch Operations
- Use batch operations for >100 items
- Split large datasets with Split In Batches node
- Add Wait nodes to avoid rate limits

### Reduce API Calls
- Cache frequently used data
- Use bulk endpoints when available
- Combine requests where possible

## Common Patterns

### Retry Pattern
```
[HTTP Request] → [IF Error] → [Wait] → [HTTP Request] (retry)
                     ↓
                [IF Success] → [Continue]
```

### Data Transformation
```
[Get Data] → [Code: Transform] → [Set: Format Output] → [Destination]
```

## Environment Variables

Always use environment variables for:
- API keys
- Webhook secrets
- Database connections
- Service URLs

Access with: `{{ $env.VARIABLE_NAME }}`

## See [N8N_ADVANCED.md](N8N_ADVANCED.md) for complex patterns
```

---

# Hooks - Automatic Reactions

## What They Are

Automatic triggers: "When X happens → Do Y"

No tokens wasted. No forgetting. Consistent every time.

## Hook Types

| Hook | When It Fires |
|------|---------------|
| `PreToolUse` | BEFORE Claude uses a tool |
| `PostToolUse` | AFTER Claude uses a tool |
| `Stop` | When Claude finishes the entire task |
| `Notification` | For sending alerts |

## Matchers

Matchers match TOOL NAMES:

| Tool | What It Does |
|------|--------------|
| `Edit` | Edits existing files |
| `Write` | Creates new files |
| `Read` | Reads files |
| `Bash` | Runs terminal commands |
| `Glob` | Searches for files |
| `Grep` | Searches inside files |
| `Task` | Delegates to agents |

**Matcher patterns:**
- `"Edit"` - Only Edit tool
- `"Edit|Write"` - Edit OR Write
- `".*"` - Any tool

## Action Types

### Command (Deterministic)
Always runs the exact command:
```json
{
  "type": "command",
  "command": "npx prettier --write $filepath"
}
```

### Prompt (AI Judgment)
Claude evaluates and decides:
```json
{
  "type": "prompt",
  "prompt": "Check if this file contains secrets. If yes, BLOCK and warn."
}
```

## Configuration Location

**Global:** `~/.claude/settings.json`
**Project:** `.claude/settings.json`

## Template: Complete Hooks Configuration

**Location:** `~/.claude/settings.json`

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Check this command for safety. BLOCK if it: deletes files (rm -rf), affects production, modifies system files, or contains secrets. Otherwise, allow it."
          }
        ]
      },
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Before creating this file, verify: 1) It doesn't already exist (would overwrite), 2) The directory is correct, 3) It's not a documentation file unless explicitly requested. If any issue, BLOCK and explain."
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx prettier --write \"$filepath\" 2>/dev/null || true"
          }
        ]
      },
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx eslint --fix \"$filepath\" 2>/dev/null || true"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo \"Task completed: $(date)\" >> ~/.claude/activity.log"
          }
        ]
      }
    ]
  }
}
```

## Common Hook Recipes

### Auto-format on save
```json
{
  "matcher": "Edit|Write",
  "hooks": [{"type": "command", "command": "npx prettier --write \"$filepath\""}]
}
```

### Auto-lint on save
```json
{
  "matcher": "Edit|Write",
  "hooks": [{"type": "command", "command": "npx eslint --fix \"$filepath\""}]
}
```

### Run tests after implementation
```json
{
  "matcher": "Edit|Write",
  "hooks": [{"type": "command", "command": "npm test -- --findRelatedTests \"$filepath\""}]
}
```

### Block dangerous commands
```json
{
  "matcher": "Bash",
  "hooks": [{"type": "prompt", "prompt": "BLOCK if command contains: rm -rf, drop database, --force on main branch, or production credentials."}]
}
```

### Validate JSON files
```json
{
  "matcher": "Write",
  "hooks": [{"type": "command", "command": "if [[ \"$filepath\" == *.json ]]; then python -m json.tool \"$filepath\" > /dev/null; fi"}]
}
```

### Log all file changes
```json
{
  "matcher": "Edit|Write",
  "hooks": [{"type": "command", "command": "echo \"$(date): $filepath\" >> ~/.claude/changes.log"}]
}
```

---

# Commands - Custom Slash Commands

## What They Are

Your own `/commands` that trigger Claude with predefined instructions.

## File Location

- Global: `~/.claude/commands/`
- Project: `.claude/commands/`

## Structure

```markdown
---
name: command-name
description: What this command does
arguments:
  - name: arg_name
    description: What this argument is
    required: true
---

Instructions for Claude when this command is run.

The argument value is available as: {{arg_name}}
```

## Template: Kickoff Command

**Location:** `~/.claude/commands/kickoff.md`

```markdown
---
name: kickoff
description: Initialize a new project from idea to deployable MVP
arguments:
  - name: idea
    description: The project idea or concept
    required: true
---

# Project Kickoff Pipeline

You are initiating a full project pipeline for: {{idea}}

Follow these phases IN ORDER. Do not stop between phases unless you hit a blocker requiring my input.

## Phase 1: Discovery & PRD

1. Ask me 3-5 clarifying questions about the idea
2. Use the prd-writer agent (or prd-template skill) to generate PRD
3. Save to `docs/PRD.md`
4. Show summary and WAIT for my approval before continuing

## Phase 2: Architecture

After I approve the PRD:
1. Design system architecture based on PRD
2. Choose tech stack (respect my preferences in CLAUDE.md)
3. Create `docs/ARCHITECTURE.md`
4. Define folder structure

## Phase 3: Scaffolding

1. Delegate to scaffolder agent
2. Initialize project with chosen stack
3. Set up all configuration files
4. Create placeholder files for main features

## Phase 4: Implementation

1. Delegate to implementer agent
2. Implement core features from PRD (P0 items first)
3. Hooks will auto-format and lint each file
4. Commit logical chunks as you go

## Phase 5: Testing

1. Delegate to tester agent
2. Write tests for all implemented features
3. Run test suite
4. Fix any failures

## Phase 6: Review

1. Delegate to reviewer agent
2. Review all code for quality and security
3. Address any critical issues

## Phase 7: Documentation

1. Update README.md with setup instructions
2. Add inline documentation where needed
3. Create API documentation if applicable

## IMPORTANT RULES

- Use hooks - they handle formatting automatically
- Delegate to agents - don't do everything in main context
- Only ask me for input at key decision points
- If something fails, fix it and continue
- Show me progress after each phase

Begin with Phase 1 now.
```

## Template: Morning Standup Command

**Location:** `~/.claude/commands/morning.md`

```markdown
---
name: morning
description: Morning standup preparation
---

# Morning Standup Prep

Help me prepare for standup:

1. **Yesterday's Work**
   - Run `git log --since="yesterday" --author="$(git config user.name)" --oneline`
   - Summarize what was accomplished

2. **Current State**
   - Check for any failing tests: `npm test`
   - Check for lint errors: `npm run lint`
   - Check git status for uncommitted work

3. **Today's Focus**
   - Review any TODO comments I added: search for TODO in recent files
   - Check for any open issues assigned to me (if GitHub MCP available)
   - Suggest what to focus on based on PRD priorities

4. **Blockers**
   - Identify any failing tests or broken builds
   - Note any dependencies on others

Provide a concise summary I can use in standup.
```

## Template: Deploy Command

**Location:** `~/.claude/commands/deploy.md`

```markdown
---
name: deploy
description: Deploy to staging or production
arguments:
  - name: environment
    description: Target environment (staging or production)
    required: true
---

# Deployment Pipeline

Deploying to: {{environment}}

## Pre-Deploy Checklist

1. **Tests**
   - Run full test suite: `npm test`
   - If any fail, STOP and report

2. **Build**
   - Run production build: `npm run build`
   - If build fails, STOP and report

3. **Lint**
   - Run linter: `npm run lint`
   - Fix any errors

4. **Security Check**
   - Check for known vulnerabilities: `npm audit`
   - Report any high/critical issues

## Deploy

If all checks pass:

### For Staging
```bash
git push origin main
# Vercel/Netlify auto-deploys from main
```

### For Production
```bash
# Create release tag
git tag -a v$(date +%Y%m%d-%H%M) -m "Release $(date +%Y-%m-%d)"
git push origin --tags
```

## Post-Deploy

1. Verify deployment URL is accessible
2. Run smoke tests if available
3. Report deployment status with URL

{{environment}} deployment initiated.
```

## Template: Review PR Command

**Location:** `~/.claude/commands/review-pr.md`

```markdown
---
name: review-pr
description: Review a pull request
arguments:
  - name: pr_number
    description: PR number to review
    required: true
---

# PR Review: #{{pr_number}}

## Get PR Information

```bash
gh pr view {{pr_number}} --json title,body,files,additions,deletions
gh pr diff {{pr_number}}
```

## Review Checklist

### Code Quality
- [ ] Code is readable and well-structured
- [ ] No unnecessary complexity
- [ ] Functions are single-purpose
- [ ] No code duplication

### Security
- [ ] No hardcoded secrets
- [ ] Input validation present
- [ ] No SQL injection vulnerabilities
- [ ] Authentication/authorization correct

### Testing
- [ ] Tests added for new features
- [ ] Tests pass
- [ ] Edge cases covered

### Documentation
- [ ] README updated if needed
- [ ] Complex logic commented
- [ ] API changes documented

## Provide Review

Organize feedback as:
- **Must Fix**: Critical issues blocking merge
- **Should Fix**: Important improvements
- **Consider**: Optional suggestions
- **Praise**: What was done well

Post review comment if GitHub MCP available.
```

---

# Rules - Folder-Specific Instructions

## What They Are

Instructions that apply ONLY when Claude works in specific folders.

## Location

`.claude/rules/*.md`

## Structure

```markdown
---
paths: src/api/**/*
---

# Rules for files matching the paths above

- Rule 1
- Rule 2
```

## Template: API Rules

**Location:** `.claude/rules/api-rules.md`

```markdown
---
paths: src/api/**/*
---

# API Development Rules

## Endpoint Structure
- All endpoints must validate input
- All endpoints must have try/catch
- All endpoints must return consistent response format

## Response Format
```typescript
// Success
{ success: true, data: {...} }

// Error
{ success: false, error: { code: "ERROR_CODE", message: "Human readable" } }
```

## Authentication
- All endpoints except /auth/* require authentication
- Use middleware: `requireAuth`
- Check permissions before operations

## Logging
- Log all requests (method, path, user)
- Log all errors with stack traces
- Never log sensitive data (passwords, tokens)
```

## Template: Database Rules

**Location:** `.claude/rules/database-rules.md`

```markdown
---
paths: src/database/**/*
paths: src/models/**/*
paths: **/migrations/**/*
---

# Database Rules

## Queries
- Always use parameterized queries (never string concatenation)
- Always use transactions for multi-step operations
- Always add indexes for frequently queried columns

## Models
- All models must have TypeScript interfaces
- All models must have created_at, updated_at timestamps
- Use soft delete (deleted_at) instead of hard delete

## Migrations
- Migrations must be reversible
- Never modify existing migrations
- Test migrations on copy of production data first
```

## Template: Component Rules

**Location:** `.claude/rules/component-rules.md`

```markdown
---
paths: src/components/**/*.tsx
paths: src/components/**/*.ts
---

# React Component Rules

## Structure
- One component per file
- Filename matches component name (PascalCase)
- Export component as default

## Props
- Define Props interface above component
- Use destructuring in function signature
- Document complex props with JSDoc

## Patterns
```typescript
interface ButtonProps {
  /** Button label text */
  label: string;
  /** Click handler */
  onClick: () => void;
  /** Visual variant */
  variant?: 'primary' | 'secondary';
}

export default function Button({ label, onClick, variant = 'primary' }: ButtonProps) {
  return (
    <button className={styles[variant]} onClick={onClick}>
      {label}
    </button>
  );
}
```

## Testing
- Every component must have a test file: `ComponentName.test.tsx`
- Test rendering, interactions, and edge cases
```

---

# MCP - External Tool Connections

## What It Is

Model Context Protocol - lets Claude directly interact with external services.

## Location

- Global: `~/.claude/mcp.json`
- Project: `.claude/mcp.json`

## Structure

```json
{
  "mcpServers": {
    "server-name": {
      "command": "command to run",
      "args": ["array", "of", "arguments"],
      "env": {
        "ENV_VAR": "value"
      }
    }
  }
}
```

## Common MCP Servers

### GitHub
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "your-github-token"
      }
    }
  }
}
```

**Enables:**
- Create/manage issues
- Create/review PRs
- Manage repositories

### PostgreSQL
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@host:5432/db"
      }
    }
  }
}
```

**Enables:**
- Query database directly
- Describe tables
- Run migrations

### Filesystem (Extended Access)
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/allow"]
    }
  }
}
```

### Slack
```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-your-token"
      }
    }
  }
}
```

**Enables:**
- Send messages
- Read channels
- Manage workflows

### Google Drive
```json
{
  "mcpServers": {
    "gdrive": {
      "command": "npx",
      "args": ["-y", "@anthropic/gdrive-mcp"],
      "env": {
        "GOOGLE_CREDENTIALS": "/path/to/credentials.json"
      }
    }
  }
}
```

## Check Available MCPs

Run `/mcp` in Claude Code to see connected servers and available tools.

---

# The Full Pipeline Vision

## The Dream Setup

```
~/.claude/
├── CLAUDE.md                          # Global preferences
├── settings.json                      # Global hooks
├── mcp.json                           # Global MCP connections
├── agents/
│   ├── prd-writer.md                  # Converts ideas to PRDs
│   ├── scaffolder.md                  # Creates project structure
│   ├── implementer.md                 # Writes code
│   ├── tester.md                      # Writes and runs tests
│   ├── reviewer.md                    # Reviews code quality
│   └── debugger.md                    # Fixes bugs
├── skills/
│   ├── prd-template/SKILL.md          # PRD format knowledge
│   ├── architecture-patterns/SKILL.md # Architecture knowledge
│   └── n8n-patterns/SKILL.md          # n8n-specific knowledge
├── commands/
│   ├── kickoff.md                     # Start new project
│   ├── morning.md                     # Standup prep
│   ├── deploy.md                      # Deploy project
│   └── review-pr.md                   # Review pull request
└── output-styles/
    └── automation.md                  # Concise output format
```

## The Flow

```
/kickoff "workflow automation dashboard"
          │
          ▼
    ┌─────────────────┐
    │  PRD Phase      │ ← prd-writer agent + prd-template skill
    │  Ask questions  │
    │  Generate PRD   │
    │  Save docs/PRD  │
    └────────┬────────┘
             │ (you approve)
             ▼
    ┌─────────────────┐
    │  Architecture   │ ← architecture-patterns skill
    │  Design system  │
    │  Choose stack   │
    │  Save docs/ARCH │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Scaffolding    │ ← scaffolder agent
    │  Create folders │
    │  Init configs   │
    │  Setup project  │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Implementation │ ← implementer agent
    │  Write code     │
    │  [Hook: format] │ ← auto prettier
    │  [Hook: lint]   │ ← auto eslint
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Testing        │ ← tester agent
    │  Write tests    │
    │  Run tests      │
    │  Fix failures   │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Review         │ ← reviewer agent
    │  Check quality  │
    │  Check security │
    │  Fix issues     │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  Deploy         │ ← MCP: GitHub + Vercel
    │  Push to GitHub │
    │  Deploy staging │
    │  Report URL     │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  READY          │
    │  You review     │
    │  You decide     │
    └─────────────────┘
```

---

# Step-by-Step Setup Guide

## Phase 1: Foundation (Do This First)

### Step 1.1: Create directory structure
```bash
mkdir -p ~/.claude/{agents,skills,commands,rules,output-styles}
```

### Step 1.2: Create global CLAUDE.md
```bash
cat > ~/.claude/CLAUDE.md << 'EOF'
# My Global Preferences

## General
- Don't auto-commit changes unless I ask
- Be concise in responses
- No emojis unless requested

## Code Style
- Use TypeScript
- 2-space indentation
- Use pnpm as package manager

## Process
- Show plan before big changes
- Ask when unsure rather than guessing
EOF
```

### Step 1.3: Create basic hooks
```bash
cat > ~/.claude/settings.json << 'EOF'
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
EOF
```

## Phase 2: Core Agents

### Step 2.1: Create PRD Writer Agent
```bash
cat > ~/.claude/agents/prd-writer.md << 'EOF'
---
name: prd-writer
description: Convert ideas into detailed PRDs. Use proactively when user describes a new project idea.
tools: Read, Write, Glob
model: sonnet
---

You are a senior product manager creating comprehensive PRDs.

When invoked:
1. Ask 3-5 clarifying questions
2. Generate PRD with: Overview, Problem, Users, Stories, Requirements, Tech Considerations
3. Save to docs/PRD.md
4. Summarize and ask for approval
EOF
```

### Step 2.2: Create Implementer Agent
```bash
cat > ~/.claude/agents/implementer.md << 'EOF'
---
name: implementer
description: Implement features and write code. Use when writing substantial code.
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You are a senior full-stack developer.

When invoked:
1. Read PRD and architecture docs
2. Understand existing patterns
3. Implement with: TypeScript, error handling, proper types
4. Follow project conventions
EOF
```

### Step 2.3: Create Reviewer Agent
```bash
cat > ~/.claude/agents/reviewer.md << 'EOF'
---
name: reviewer
description: Review code for quality and security. Use proactively after implementation.
tools: Read, Glob, Grep, Bash
model: sonnet
---

You are a senior code reviewer.

When invoked:
1. Check recent changes (git diff)
2. Review for: quality, security, performance
3. Categorize: Critical, Warning, Suggestion
EOF
```

## Phase 3: Skills

### Step 3.1: Create PRD Template Skill
```bash
mkdir -p ~/.claude/skills/prd-template
cat > ~/.claude/skills/prd-template/SKILL.md << 'EOF'
---
name: prd-template
description: PRD structure and guidelines. Use when creating PRDs.
---

# PRD Structure

1. **Overview**: What and why (2-3 sentences)
2. **Problem**: Pain points, impact, who's affected
3. **Users**: Primary persona, characteristics
4. **Stories**: As a [user], I want [action] so that [benefit]
5. **Requirements**: Features with acceptance criteria (P0/P1/P2)
6. **Technical**: Constraints, dependencies, risks
7. **Metrics**: KPIs and targets
EOF
```

## Phase 4: Commands

### Step 4.1: Create Kickoff Command
```bash
cat > ~/.claude/commands/kickoff.md << 'EOF'
---
name: kickoff
description: Start a new project from idea to implementation
arguments:
  - name: idea
    description: Project idea
    required: true
---

# Kickoff: {{idea}}

## Phase 1: PRD
- Ask clarifying questions
- Generate PRD using prd-template skill
- Save to docs/PRD.md
- Wait for approval

## Phase 2: Architecture
- Design system based on PRD
- Create docs/ARCHITECTURE.md

## Phase 3: Implementation
- Scaffold project
- Implement P0 features
- Hooks handle formatting

## Phase 4: Review
- Use reviewer agent
- Fix issues

Start Phase 1 now.
EOF
```

## Phase 5: Test Your Setup

```bash
# Start Claude Code
claude

# Test your setup
> /kickoff "simple todo app"
```

---

# Ready-to-Use Templates

## All Templates in One Script

Copy and run this to set up everything:

```bash
#!/bin/bash

# Create directories
mkdir -p ~/.claude/{agents,skills/prd-template,skills/architecture,commands,rules,output-styles}

# CLAUDE.md
cat > ~/.claude/CLAUDE.md << 'CLAUDE_EOF'
# My Preferences

## General
- Don't auto-commit unless asked
- Be concise
- No emojis

## Code
- TypeScript
- 2-space indent
- pnpm package manager
- Vitest for testing

## Process
- Plan before big changes
- Ask when unsure
CLAUDE_EOF

# Settings (hooks)
cat > ~/.claude/settings.json << 'SETTINGS_EOF'
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {"type": "command", "command": "npx prettier --write \"$filepath\" 2>/dev/null || true"}
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {"type": "prompt", "prompt": "BLOCK if command: deletes files, affects production, or contains secrets."}
        ]
      }
    ]
  }
}
SETTINGS_EOF

# PRD Writer Agent
cat > ~/.claude/agents/prd-writer.md << 'AGENT_EOF'
---
name: prd-writer
description: Convert ideas into PRDs. Use proactively for new project ideas.
tools: Read, Write, Glob
---

Senior PM creating PRDs.

1. Ask 3-5 clarifying questions
2. Generate PRD: Overview, Problem, Users, Stories, Requirements
3. Save to docs/PRD.md
4. Summarize, ask approval
AGENT_EOF

# Implementer Agent
cat > ~/.claude/agents/implementer.md << 'AGENT_EOF'
---
name: implementer
description: Write production code. Use when implementing features.
tools: Read, Write, Edit, Bash, Glob, Grep
---

Senior developer.

1. Read PRD/architecture
2. Follow existing patterns
3. TypeScript, error handling, types
4. Hooks auto-format
AGENT_EOF

# Reviewer Agent
cat > ~/.claude/agents/reviewer.md << 'AGENT_EOF'
---
name: reviewer
description: Review code quality. Use proactively after implementation.
tools: Read, Glob, Grep, Bash
---

Code reviewer.

1. git diff for changes
2. Check: quality, security, performance
3. Report: Critical, Warning, Suggestion
AGENT_EOF

# PRD Skill
cat > ~/.claude/skills/prd-template/SKILL.md << 'SKILL_EOF'
---
name: prd-template
description: PRD format. Use when creating PRDs.
---

# PRD Format
1. Overview (what/why)
2. Problem (pain/impact)
3. Users (persona)
4. Stories (As a X, I want Y, so that Z)
5. Requirements (P0/P1/P2 with acceptance criteria)
6. Technical (constraints/risks)
7. Metrics (KPIs)
SKILL_EOF

# Kickoff Command
cat > ~/.claude/commands/kickoff.md << 'CMD_EOF'
---
name: kickoff
description: Start new project
arguments:
  - name: idea
    required: true
---

# {{idea}}

Phase 1: PRD (ask questions, generate, save docs/PRD.md, wait approval)
Phase 2: Architecture (design, save docs/ARCHITECTURE.md)
Phase 3: Implement (scaffold, code P0 features)
Phase 4: Review (use reviewer agent)

Start Phase 1.
CMD_EOF

# Morning Command
cat > ~/.claude/commands/morning.md << 'CMD_EOF'
---
name: morning
description: Standup prep
---

1. Yesterday: git log --since="yesterday" --oneline
2. Status: test + lint status
3. Today: TODOs and priorities
4. Blockers: any failing tests

Summarize for standup.
CMD_EOF

echo "Setup complete! Run 'claude' and try '/kickoff \"your idea\"'"
```

Save as `setup-claude.sh` and run: `bash setup-claude.sh`

---

# Pro Tips & Shortcuts

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+C` | Cancel current operation |
| `Ctrl+L` | Clear screen |
| `Up/Down` | Navigate history |
| `Tab` | Autocomplete |

## Useful Commands

| Command | Purpose |
|---------|---------|
| `/help` | Show all commands |
| `/model haiku` | Fast mode |
| `/model sonnet` | Balanced mode |
| `/model opus` | Powerful mode |
| `/compact` | Compress context |
| `/clear` | Reset conversation |
| `/mcp` | Show MCP connections |
| `/config` | Show configuration |

## Model Selection Guide

| Task | Model | Why |
|------|-------|-----|
| Quick questions | haiku | Fast, cheap |
| Daily coding | sonnet | Balanced |
| Architecture | opus | Deep thinking |
| Debugging | sonnet | Good enough |
| Code review | sonnet | Balanced |

## Context Management

- Use `/compact` when conversation gets long
- Delegate exploration to agents (separate context)
- Keep CLAUDE.md concise (loaded every time)
- Use skills with progressive disclosure

## Debugging Your Setup

```bash
# Check if files exist
ls -la ~/.claude/

# Check hooks are valid JSON
cat ~/.claude/settings.json | python -m json.tool

# Test in Claude
/config  # See loaded configuration
/mcp     # See MCP connections
```

---

# Quick Reference Card

```
┌─────────────────────────────────────────────────────────────────┐
│                    CLAUDE CODE CHEAT SHEET                      │
├─────────────────────────────────────────────────────────────────┤
│ MEMORY                                                          │
│   ~/.claude/CLAUDE.md          Global preferences               │
│   ./CLAUDE.md                  Project standards                │
│   .claude/rules/*.md           Folder-specific rules            │
├─────────────────────────────────────────────────────────────────┤
│ AGENTS (workers)                                                │
│   ~/.claude/agents/*.md        Global agents                    │
│   .claude/agents/*.md          Project agents                   │
│   Key: Write good descriptions for auto-delegation              │
├─────────────────────────────────────────────────────────────────┤
│ SKILLS (knowledge)                                              │
│   ~/.claude/skills/*/SKILL.md  Global skills                    │
│   .claude/skills/*/SKILL.md    Project skills                   │
│   Key: Use progressive disclosure                               │
├─────────────────────────────────────────────────────────────────┤
│ HOOKS (automation)                                              │
│   ~/.claude/settings.json      Global hooks                     │
│   .claude/settings.json        Project hooks                    │
│   Triggers: PreToolUse, PostToolUse, Stop                       │
│   Types: command (deterministic), prompt (AI judgment)          │
├─────────────────────────────────────────────────────────────────┤
│ COMMANDS (shortcuts)                                            │
│   ~/.claude/commands/*.md      Global commands                  │
│   .claude/commands/*.md        Project commands                 │
│   Usage: /commandname                                           │
├─────────────────────────────────────────────────────────────────┤
│ MCP (external tools)                                            │
│   ~/.claude/mcp.json           Global connections               │
│   .claude/mcp.json             Project connections              │
├─────────────────────────────────────────────────────────────────┤
│ MODELS                                                          │
│   haiku   = fast, cheap        (quick questions)                │
│   sonnet  = balanced           (daily coding)                   │
│   opus    = powerful           (architecture)                   │
├─────────────────────────────────────────────────────────────────┤
│ COMMANDS                                                        │
│   /help     Show help          /compact   Compress context      │
│   /model    Switch model       /clear     Reset conversation    │
│   /mcp      Show MCPs          /config    Show config           │
└─────────────────────────────────────────────────────────────────┘
```

---

# Next Steps

1. **Run the setup script** to create your foundation
2. **Test with `/kickoff "simple test project"`**
3. **Customize agents** for your specific workflows
4. **Add MCPs** for services you use (GitHub, Slack, etc.)
5. **Iterate** - refine based on what works

---

*Last updated: $(date)*
*Your Iron Man suit is ready. Go build something amazing.*
