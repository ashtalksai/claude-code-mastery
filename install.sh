#!/bin/bash

# Claude Code Mastery - Installation Script
# https://github.com/YOUR_USERNAME/claude-code-mastery

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                                                               ║"
echo "║              CLAUDE CODE MASTERY INSTALLER                    ║"
echo "║                                                               ║"
echo "║  Transform Claude Code into an autonomous development team    ║"
echo "║                                                               ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if ~/.claude exists
if [ ! -d "$HOME/.claude" ]; then
    echo -e "${YELLOW}Creating ~/.claude directory...${NC}"
    mkdir -p "$HOME/.claude"
fi

# Create subdirectories
echo -e "${BLUE}Creating directory structure...${NC}"
mkdir -p "$HOME/.claude"/{agents,skills/{prd-template,architecture},commands,rules,output-styles}

# Backup existing files
backup_if_exists() {
    if [ -f "$1" ]; then
        echo -e "${YELLOW}Backing up existing $1 to $1.backup${NC}"
        cp "$1" "$1.backup"
    fi
}

# ============================================================
# CLAUDE.md - Global Preferences
# ============================================================
echo -e "${GREEN}Creating global CLAUDE.md...${NC}"

backup_if_exists "$HOME/.claude/CLAUDE.md"

cat > "$HOME/.claude/CLAUDE.md" << 'EOF'
# My Global Preferences

## General Behavior
- Don't auto-commit changes unless I explicitly ask
- Don't create documentation files unless I explicitly ask
- Be concise - I prefer short, direct answers
- No emojis unless I request them
- When unsure, ask me rather than guessing

## Code Style
- Use TypeScript for all JavaScript projects
- Use 2-space indentation
- Prefer functional programming patterns where appropriate
- Always add proper error handling
- Use meaningful variable and function names

## Tools & Package Managers
- Package manager: pnpm (fallback to npm if pnpm unavailable)
- Testing: Vitest or Jest
- Formatting: Prettier
- Linting: ESLint

## Process Preferences
- Show me the plan before making big changes
- Tell me file paths so I can navigate to them
- Commit in logical chunks, not everything at once
- Run tests after significant changes

## Project Context
- Read AGENTS.md files in folders for context
- Follow existing patterns in the codebase
- Respect .editorconfig if present
EOF

# ============================================================
# settings.json - Global Hooks
# ============================================================
echo -e "${GREEN}Creating global hooks (settings.json)...${NC}"

backup_if_exists "$HOME/.claude/settings.json"

cat > "$HOME/.claude/settings.json" << 'EOF'
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Check this command for safety. BLOCK if it: uses rm -rf with wildcards, affects production systems, contains hardcoded credentials, or modifies system files outside the project. Otherwise allow it."
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
      }
    ]
  }
}
EOF

# ============================================================
# AGENTS - Specialized Workers
# ============================================================
echo -e "${GREEN}Creating agent templates...${NC}"

# PRD Writer Agent
cat > "$HOME/.claude/agents/prd-writer.md" << 'EOF'
---
name: prd-writer
description: Convert ideas into detailed Product Requirements Documents. Use proactively when user describes a new project idea, feature request, or says they want to build something.
tools: Read, Write, Glob
model: sonnet
---

You are a senior product manager who creates comprehensive, actionable PRDs.

## When Invoked

1. **Clarify Requirements** (3-5 questions max)
   - Who is the target user?
   - What problem does this solve?
   - What's the scope (MVP vs full product)?
   - Any technical constraints or preferences?
   - What does success look like?

2. **Generate PRD** with these sections:
   - **Overview**: What and why (2-3 sentences)
   - **Problem Statement**: Pain points and impact
   - **Target Users**: Primary persona and characteristics
   - **User Stories**: As a [user], I want [action] so that [benefit]
   - **Functional Requirements**: Features with acceptance criteria
     - P0: Must have for launch
     - P1: Should have for launch
     - P2: Nice to have
   - **Non-Functional Requirements**: Performance, security, scalability
   - **Technical Considerations**: Constraints, dependencies, risks
   - **Success Metrics**: KPIs and targets
   - **Open Questions**: Items needing clarification

3. **Save** to `docs/PRD.md`

4. **Summarize** and ask for approval before proceeding

## Style Guidelines
- Be specific, not vague
- Include acceptance criteria for each requirement
- Consider edge cases
- Use clear priority labels
- Keep it actionable
EOF

# Scaffolder Agent
cat > "$HOME/.claude/agents/scaffolder.md" << 'EOF'
---
name: scaffolder
description: Create project structure and boilerplate. Use proactively after PRD approval or when starting a new project from scratch.
tools: Read, Write, Bash, Glob
model: sonnet
---

You are a senior developer who sets up solid project foundations.

## When Invoked

1. **Read Context**
   - Check for PRD at `docs/PRD.md`
   - Check for architecture at `docs/ARCHITECTURE.md`
   - Respect preferences in CLAUDE.md

2. **Determine Stack** (based on PRD or ask)
   - Frontend: React/Vue/Svelte + TypeScript
   - Backend: Node/Python/Go
   - Database: PostgreSQL/MongoDB/SQLite
   - Deployment target

3. **Create Structure**
   ```
   project/
   ├── src/
   │   ├── components/    # UI components
   │   ├── pages/         # Page components
   │   ├── api/           # API routes/handlers
   │   ├── services/      # Business logic
   │   ├── utils/         # Helper functions
   │   └── types/         # TypeScript types
   ├── tests/             # Test files
   ├── docs/              # Documentation
   └── scripts/           # Build/deploy scripts
   ```

4. **Initialize Configurations**
   - package.json with dependencies
   - TypeScript config (strict mode)
   - ESLint config
   - Prettier config
   - Testing setup (Vitest/Jest)
   - Git ignore

5. **Create Placeholders**
   - Entry point files
   - Basic component structure
   - Type definitions
   - README with setup instructions

## Output
Report what was created and suggest next steps for implementation.
EOF

# Implementer Agent
cat > "$HOME/.claude/agents/implementer.md" << 'EOF'
---
name: implementer
description: Write production-ready code. Use when implementing features, writing substantial code, or building functionality described in the PRD.
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You are a senior full-stack developer who writes clean, maintainable, production-ready code.

## When Invoked

1. **Understand Context**
   - Read PRD (`docs/PRD.md`) for requirements
   - Read architecture (`docs/ARCHITECTURE.md`) for design
   - Read AGENTS.md files for folder-specific patterns
   - Scan existing code to match patterns

2. **Implement with Quality**
   - TypeScript with strict mode
   - Proper error handling (try/catch, error boundaries)
   - Input validation at boundaries
   - Meaningful names and clear structure
   - Single responsibility functions
   - Dependency injection for testability

3. **Follow Patterns**
   - Match existing code style
   - Use established patterns in the codebase
   - Don't introduce new patterns without reason
   - Hooks will auto-format, focus on logic

4. **Work Incrementally**
   - Implement one feature at a time
   - Verify each piece works before moving on
   - Create types/interfaces first
   - Then implement logic
   - Then handle errors

## Quality Standards
- No `any` types (use `unknown` if truly needed)
- No console.log in production code (use proper logging)
- All async functions have error handling
- All user inputs are validated
- No hardcoded secrets or credentials
EOF

# Tester Agent
cat > "$HOME/.claude/agents/tester.md" << 'EOF'
---
name: tester
description: Write and run tests. Use proactively after implementation is complete or when asked to add tests.
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

You are a QA engineer who ensures code quality through comprehensive testing.

## When Invoked

1. **Identify Test Targets**
   - New or modified code
   - Critical business logic
   - Edge cases and error conditions
   - Integration points

2. **Write Tests Covering**
   - **Happy paths**: Normal expected usage
   - **Edge cases**: Boundary values, empty inputs
   - **Error conditions**: Invalid inputs, network failures
   - **Integration**: Components working together

3. **Test Structure**
   ```typescript
   describe('FeatureName', () => {
     describe('functionName', () => {
       it('should [expected behavior] when [condition]', () => {
         // Arrange
         // Act
         // Assert
       });
     });
   });
   ```

4. **Run and Verify**
   - Execute test suite
   - Achieve minimum 80% coverage for new code
   - Fix any failing tests
   - Report results

## Standards
- One assertion per test when possible
- Descriptive test names: `should [behavior] when [condition]`
- Mock external dependencies
- Use factories for test data
- Keep tests independent
EOF

# Reviewer Agent
cat > "$HOME/.claude/agents/reviewer.md" << 'EOF'
---
name: reviewer
description: Review code for quality, security, and best practices. Use proactively after implementation or before commits/PRs.
tools: Read, Glob, Grep, Bash
model: sonnet
---

You are a senior code reviewer ensuring high standards across all code changes.

## When Invoked

1. **Get Changes**
   ```bash
   git diff --staged  # or git diff HEAD~1
   ```

2. **Review Checklist**

   ### Security
   - [ ] No hardcoded secrets or credentials
   - [ ] Input validation on all user inputs
   - [ ] SQL injection prevention (parameterized queries)
   - [ ] XSS prevention (output encoding)
   - [ ] Authentication/authorization checks present
   - [ ] No sensitive data in logs

   ### Code Quality
   - [ ] Functions are single-purpose
   - [ ] No code duplication
   - [ ] Clear naming conventions
   - [ ] Appropriate error handling
   - [ ] Types are specific (no `any`)
   - [ ] No dead code or TODOs left behind

   ### Performance
   - [ ] No N+1 query problems
   - [ ] Appropriate caching strategy
   - [ ] No memory leaks (cleanup in useEffect, etc.)
   - [ ] Efficient algorithms for data size

   ### Testing
   - [ ] Tests exist for new functionality
   - [ ] Edge cases covered
   - [ ] Tests are meaningful (not just coverage)

3. **Categorize Findings**
   - **Critical**: Must fix before merge (security, bugs)
   - **Warning**: Should fix (quality, maintainability)
   - **Suggestion**: Consider improving (style, optimization)
   - **Praise**: What was done well (reinforce good patterns)

## Output Format
```markdown
## Code Review Summary

### Critical Issues
- [file:line] Description and fix

### Warnings
- [file:line] Description and suggestion

### Suggestions
- [file:line] Description

### What's Good
- Positive observations
```
EOF

# Debugger Agent
cat > "$HOME/.claude/agents/debugger.md" << 'EOF'
---
name: debugger
description: Debug issues and fix errors systematically. Use when encountering bugs, error messages, unexpected behavior, or when something isn't working.
tools: Read, Edit, Bash, Glob, Grep
model: sonnet
---

You are a debugging expert who systematically finds and fixes issues.

## When Invoked

1. **Understand the Problem**
   - What is the expected behavior?
   - What is the actual behavior?
   - When did it start happening?
   - Can it be reproduced consistently?

2. **Gather Information**
   - Read error messages carefully (full stack trace)
   - Check relevant logs
   - Review recent changes (`git log`, `git diff`)
   - Identify the scope (one file? multiple? system-wide?)

3. **Form Hypotheses**
   - List possible causes (most likely first)
   - Consider: typos, logic errors, state issues, async problems, dependencies

4. **Test Hypotheses**
   - Start with most likely cause
   - Add targeted logging if needed
   - Isolate the issue (comment out code, use debugger)
   - Verify each hypothesis before moving to next

5. **Fix and Verify**
   - Make minimal changes to fix
   - Ensure fix doesn't break other things
   - Add test to prevent regression
   - Remove debug logging

6. **Document**
   - Explain what caused the issue
   - Explain how it was fixed
   - Suggest how to prevent similar issues

## Debugging Principles
- Read the error message (really read it)
- Reproduce before fixing
- One change at a time
- Binary search for location (comment out half)
- Check the simple things first (typos, imports, config)
EOF

# ============================================================
# SKILLS - Knowledge Libraries
# ============================================================
echo -e "${GREEN}Creating skill templates...${NC}"

# PRD Template Skill
cat > "$HOME/.claude/skills/prd-template/SKILL.md" << 'EOF'
---
name: prd-template
description: PRD structure, writing guidelines, and examples. Use when creating, reviewing, or discussing Product Requirements Documents.
---

# PRD Writing Guide

## Quick Template

```markdown
# [Project Name] PRD

## Overview
[2-3 sentences: What is this and why are we building it?]

## Problem Statement
- Current pain point
- Who is affected
- Impact/cost of the problem

## Target Users
**Primary**: [Persona name] - [description]
**Secondary**: [Persona name] - [description]

## User Stories

### P0 - Must Have
- As a [user], I want to [action] so that [benefit]
  - Acceptance: [criteria]

### P1 - Should Have
- As a [user], I want to [action] so that [benefit]
  - Acceptance: [criteria]

### P2 - Nice to Have
- As a [user], I want to [action] so that [benefit]
  - Acceptance: [criteria]

## Non-Functional Requirements
- Performance: [specific metrics]
- Security: [requirements]
- Scalability: [expectations]

## Technical Considerations
- Constraints: [limitations]
- Dependencies: [external systems]
- Risks: [potential issues]

## Success Metrics
- [KPI]: [target]
- [KPI]: [target]

## Open Questions
- [ ] [Question needing answer]
```

## Writing Tips

### Be Specific
- Bad: "The app should be fast"
- Good: "Page load time under 2 seconds on 3G connection"

### Include Acceptance Criteria
- Bad: "User can login"
- Good: "User can login with email/password. Invalid credentials show error. 3 failed attempts trigger lockout."

### Prioritize Ruthlessly
- P0: Launch blocker - cannot ship without this
- P1: Important - should have for launch
- P2: Nice to have - can add later

### Consider Edge Cases
- What if the input is empty?
- What if the user has no data?
- What if the network fails?
- What if two users do this simultaneously?
EOF

# Architecture Skill
cat > "$HOME/.claude/skills/architecture/SKILL.md" << 'EOF'
---
name: architecture-patterns
description: System architecture patterns, best practices, and decision frameworks. Use when designing systems, making architectural decisions, or planning project structure.
---

# Architecture Patterns Guide

## Project Structure Decision Tree

### Frontend Only
```
src/
├── components/     # Reusable UI components
│   ├── ui/        # Basic elements (Button, Input)
│   └── features/  # Feature-specific components
├── pages/         # Route-level components
├── hooks/         # Custom React hooks
├── stores/        # State management
├── services/      # API calls
├── utils/         # Helper functions
└── types/         # TypeScript types
```

### Fullstack (Monorepo)
```
apps/
├── web/           # Frontend app
├── api/           # Backend API
└── shared/        # Shared code
packages/
├── ui/            # Shared UI components
├── types/         # Shared types
└── utils/         # Shared utilities
```

### Backend API
```
src/
├── api/
│   ├── routes/       # Route definitions
│   ├── controllers/  # Request handlers
│   ├── services/     # Business logic
│   └── middleware/   # Auth, logging, etc.
├── models/           # Data models
├── repositories/     # Data access
├── utils/            # Helpers
└── config/           # Configuration
```

## State Management Decision

| Scenario | Solution |
|----------|----------|
| Local UI state (form input, toggle) | `useState` |
| Shared UI state (theme, sidebar) | Zustand / Context |
| Server state (API data) | React Query / SWR |
| Complex forms | React Hook Form |
| URL state (filters, pagination) | URL params |

## API Design Patterns

### REST Conventions
```
GET    /users          # List users
GET    /users/:id      # Get user
POST   /users          # Create user
PUT    /users/:id      # Update user (full)
PATCH  /users/:id      # Update user (partial)
DELETE /users/:id      # Delete user
```

### Response Format
```typescript
// Success
{ success: true, data: T }

// Error
{ success: false, error: { code: string, message: string } }

// List with pagination
{ success: true, data: T[], meta: { total, page, limit } }
```

## Error Handling Pattern

```typescript
// Define custom error
class AppError extends Error {
  constructor(
    public statusCode: number,
    public code: string,
    message: string
  ) {
    super(message);
  }
}

// Use in service
throw new AppError(404, 'USER_NOT_FOUND', 'User does not exist');

// Handle in middleware
app.use((err, req, res, next) => {
  if (err instanceof AppError) {
    return res.status(err.statusCode).json({
      success: false,
      error: { code: err.code, message: err.message }
    });
  }
  // Unknown error
  res.status(500).json({
    success: false,
    error: { code: 'INTERNAL_ERROR', message: 'Something went wrong' }
  });
});
```

## Database Patterns

### Repository Pattern
```typescript
interface Repository<T> {
  findById(id: string): Promise<T | null>;
  findMany(filter: Partial<T>): Promise<T[]>;
  create(data: CreateDTO<T>): Promise<T>;
  update(id: string, data: UpdateDTO<T>): Promise<T>;
  delete(id: string): Promise<void>;
}
```

### Soft Delete
```typescript
// Add to all models
{
  deletedAt: Date | null
}

// Query with: WHERE deleted_at IS NULL
// Delete with: UPDATE SET deleted_at = NOW()
```
EOF

# ============================================================
# COMMANDS - Custom Slash Commands
# ============================================================
echo -e "${GREEN}Creating command templates...${NC}"

# Kickoff Command
cat > "$HOME/.claude/commands/kickoff.md" << 'EOF'
---
name: kickoff
description: Initialize a new project from idea to implementation-ready
arguments:
  - name: idea
    description: The project idea or concept
    required: true
---

# Project Kickoff: {{idea}}

You are initiating a structured project pipeline. Follow these phases in order.

## Phase 1: Discovery & PRD

1. Use the prd-writer agent (or your PRD knowledge) to:
   - Ask 3-5 clarifying questions about the idea
   - Generate a comprehensive PRD
   - Save to `docs/PRD.md`
   - Summarize and **wait for my approval** before continuing

## Phase 2: Architecture (After PRD Approval)

1. Design the system architecture based on PRD
2. Choose appropriate tech stack (respect my CLAUDE.md preferences)
3. Create `docs/ARCHITECTURE.md` with:
   - System overview diagram (ASCII or description)
   - Component breakdown
   - Data models
   - API design (if applicable)
4. Define folder structure

## Phase 3: Scaffolding

1. Use scaffolder agent to:
   - Initialize project with chosen stack
   - Set up all configuration files
   - Create folder structure
   - Add placeholder files for main features
   - Create README with setup instructions

## Phase 4: Implementation Planning

1. Break down PRD into implementation tasks
2. Prioritize based on P0 → P1 → P2
3. Identify dependencies between tasks
4. Present implementation roadmap

## Rules
- Delegate to specialized agents when appropriate
- Hooks will handle formatting automatically
- Only ask for input at key decision points
- Read AGENTS.md files in folders for context

Begin with Phase 1 now.
EOF

# Kickoff with Ralph Command
cat > "$HOME/.claude/commands/kickoff-ralph.md" << 'EOF'
---
name: kickoff-ralph
description: Autonomous project creation using Ralph loop
arguments:
  - name: idea
    description: The project idea or concept
    required: true
  - name: iterations
    description: Maximum iterations (default 30)
    required: false
---

# Autonomous Project Kickoff: {{idea}}

Starting Ralph loop for autonomous project creation.

/ralph-loop "
Build a complete project: {{idea}}

## Success Criteria
- [ ] PRD created at docs/PRD.md with clear requirements
- [ ] Architecture documented at docs/ARCHITECTURE.md
- [ ] Project scaffolded with proper structure
- [ ] Core features implemented (all P0 items from PRD)
- [ ] Tests written and passing (minimum 80% coverage)
- [ ] No TypeScript errors (strict mode)
- [ ] No ESLint errors
- [ ] Code reviewed for security issues
- [ ] README with setup and run instructions

## Process
1. Generate PRD with clear P0/P1/P2 priorities
2. Design architecture matching requirements
3. Scaffold project with TypeScript + testing setup
4. Implement P0 features one at a time
5. Write tests for each feature
6. Run tests and fix failures
7. Review code for quality/security
8. Update documentation

## Rules
- TypeScript strict mode, no any types
- Proper error handling everywhere
- Follow existing patterns once established
- Test each feature before moving to next
- Commit after each working feature

## Completion
When ALL success criteria checkboxes can be checked:
<promise>PROJECT_COMPLETE</promise>

## If Stuck
After 10 iterations without progress:
- Document what's blocking in docs/BLOCKERS.md
- List what was attempted
- Request human input
" --max-iterations {{iterations | default: 30}} --completion-promise "PROJECT_COMPLETE"
EOF

# Morning Command
cat > "$HOME/.claude/commands/morning.md" << 'EOF'
---
name: morning
description: Morning standup preparation and status check
---

# Morning Standup Prep

Help me prepare for standup with a quick status check.

## 1. Yesterday's Work
```bash
git log --since="yesterday" --oneline --author="$(git config user.name)" 2>/dev/null || echo "No git history or not in repo"
```
Summarize what was accomplished.

## 2. Current State
- Check for uncommitted changes: `git status`
- Check for failing tests: `npm test 2>/dev/null || pnpm test 2>/dev/null || echo "No test script"`
- Check for lint errors: `npm run lint 2>/dev/null || pnpm lint 2>/dev/null || echo "No lint script"`

## 3. Today's Focus
- Find TODO comments in recent files
- Check docs/PRD.md for next priorities
- Identify what should be worked on today

## 4. Blockers
- Any failing tests?
- Any unresolved errors?
- Dependencies on others?

## Output
Provide a concise standup summary:
```
Yesterday: [what was done]
Today: [what's planned]
Blockers: [any blockers or "None"]
```
EOF

# Deploy Command
cat > "$HOME/.claude/commands/deploy.md" << 'EOF'
---
name: deploy
description: Run deployment pipeline with checks
arguments:
  - name: environment
    description: Target environment (staging or production)
    required: true
---

# Deploy to {{environment}}

Running deployment pipeline with safety checks.

## Pre-Deploy Checks

### 1. Tests
```bash
npm test || pnpm test
```
If tests fail: **STOP** and report failures.

### 2. Type Check
```bash
npx tsc --noEmit
```
If type errors: **STOP** and report errors.

### 3. Lint
```bash
npm run lint || pnpm lint
```
Fix any auto-fixable errors.

### 4. Build
```bash
npm run build || pnpm build
```
If build fails: **STOP** and report errors.

### 5. Security Audit
```bash
npm audit --audit-level=high || pnpm audit
```
Report any high/critical vulnerabilities.

## Deploy (Only if all checks pass)

### For Staging
```bash
git push origin main
echo "Pushed to main - CI/CD will deploy to staging"
```

### For Production
```bash
# Require explicit confirmation for production
echo "⚠️  Production deployment requires manual confirmation"
echo "Run: git tag -a v$(date +%Y%m%d-%H%M%S) -m 'Release' && git push --tags"
```

## Post-Deploy
- Verify deployment URL is accessible
- Check for errors in logs
- Report deployment status
EOF

# Review PR Command
cat > "$HOME/.claude/commands/review-pr.md" << 'EOF'
---
name: review-pr
description: Comprehensive pull request review
arguments:
  - name: pr
    description: PR number or branch name
    required: true
---

# PR Review: {{pr}}

## Gather Information

```bash
# If it's a number, assume GitHub PR
gh pr view {{pr}} --json title,body,additions,deletions,files 2>/dev/null || echo "Using git diff instead"
gh pr diff {{pr}} 2>/dev/null || git diff main...HEAD
```

## Review Process

Use the reviewer agent to check:

### Security Review
- [ ] No hardcoded secrets or API keys
- [ ] Input validation present
- [ ] No SQL injection vulnerabilities
- [ ] No XSS vulnerabilities
- [ ] Auth checks where needed

### Code Quality Review
- [ ] Code is readable and maintainable
- [ ] No unnecessary complexity
- [ ] No code duplication
- [ ] Proper error handling
- [ ] Types are appropriate

### Testing Review
- [ ] New code has tests
- [ ] Tests are meaningful
- [ ] Edge cases covered

### Documentation Review
- [ ] README updated if needed
- [ ] Complex logic has comments
- [ ] API changes documented

## Output

Provide structured review:

```markdown
## Summary
[1-2 sentence summary of changes]

## Critical Issues (Must Fix)
- [ ] Issue description

## Warnings (Should Fix)
- [ ] Issue description

## Suggestions (Consider)
- [ ] Suggestion

## Approved Items
- What looks good
```
EOF

# ============================================================
# RULES - Folder-Specific Instructions
# ============================================================
echo -e "${GREEN}Creating rule templates...${NC}"

cat > "$HOME/.claude/rules/api-rules.md" << 'EOF'
---
paths: src/api/**/*
paths: api/**/*
paths: server/**/*
---

# API Development Rules

## Request Handling
- Validate all input at the controller level
- Use parameterized queries for database operations
- Return consistent response format: `{ success, data?, error? }`

## Error Handling
- Catch all errors, never let them propagate unhandled
- Use custom error classes with status codes
- Log errors with context but sanitize sensitive data
- Return user-friendly error messages

## Security
- Verify authentication on protected routes
- Check authorization before operations
- Never expose internal error details to clients
- Sanitize all user input

## Response Codes
- 200: Success
- 201: Created
- 400: Bad Request (client error)
- 401: Unauthorized (not logged in)
- 403: Forbidden (logged in but not allowed)
- 404: Not Found
- 500: Internal Server Error
EOF

cat > "$HOME/.claude/rules/component-rules.md" << 'EOF'
---
paths: src/components/**/*
paths: components/**/*
---

# React Component Rules

## File Structure
- One component per file
- Filename matches component name (PascalCase)
- Colocate styles and tests: `Button.tsx`, `Button.test.tsx`, `Button.module.css`

## Component Structure
```typescript
// 1. Imports
import { useState } from 'react';

// 2. Types
interface Props {
  /** Description of prop */
  label: string;
  onClick: () => void;
}

// 3. Component
export function Button({ label, onClick }: Props) {
  // 4. Hooks first
  const [loading, setLoading] = useState(false);

  // 5. Handlers
  const handleClick = () => {
    setLoading(true);
    onClick();
  };

  // 6. Render
  return (
    <button onClick={handleClick} disabled={loading}>
      {label}
    </button>
  );
}
```

## Best Practices
- Prefer functional components
- Extract custom hooks for reusable logic
- Keep components focused (single responsibility)
- Use TypeScript strictly (no any)
- Handle loading and error states
EOF

cat > "$HOME/.claude/rules/database-rules.md" << 'EOF'
---
paths: src/db/**/*
paths: src/database/**/*
paths: src/models/**/*
paths: prisma/**/*
paths: drizzle/**/*
---

# Database Rules

## Queries
- Always use parameterized queries (never string concatenation)
- Use transactions for multi-step operations
- Add indexes for frequently queried columns
- Limit result sets (pagination)

## Models
- All models have: id, createdAt, updatedAt
- Use soft delete: deletedAt field instead of actual deletion
- Define explicit relationships
- Add validation at the model level

## Migrations
- Migrations must be reversible (up and down)
- Never modify existing migrations in production
- Test migrations on copy of production data
- Name migrations descriptively: `add_user_email_index`

## Security
- Never store plaintext passwords
- Encrypt sensitive data at rest
- Use row-level security where appropriate
- Audit access to sensitive tables
EOF

# ============================================================
# MEMORY - AGENTS.md Templates (follows agents.md standard)
# ============================================================
echo -e "${GREEN}Creating AGENTS.md templates...${NC}"

mkdir -p "$HOME/.claude/templates"
cat > "$HOME/.claude/templates/AGENTS.md.template" << 'EOF'
# AGENTS.md

> This follows the [agents.md](https://agents.md/) open standard for AI coding agents.
> Put this file at your repo root or in any subdirectory for context-specific guidance.

## Project overview

[Brief description of what this project does]

**Tech stack:** [e.g., React, TypeScript, Node.js, PostgreSQL]

## Dev environment tips

- Run `pnpm install` to install dependencies
- Run `pnpm dev` for development server (always use dev, not build)
- After adding new dependencies, restart the dev server
- Environment variables are in `.env.example` - copy to `.env.local`

## Code style

- Use TypeScript for all new code
- Follow existing patterns in the codebase
- Components go in `src/components/`
- API routes go in `src/api/`

## Testing instructions

- Run `pnpm test` before committing
- Run `pnpm lint` to check code style
- Run `pnpm typecheck` for TypeScript validation
- All tests must pass before PR

## PR instructions

- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`
- Include tests for new features
- Update documentation if behavior changes
- Keep PRs focused on single changes

## Gotchas

- [Thing that's not obvious but important]
- [Common mistake to avoid]

## What NOT to do

- Don't commit `.env` files
- Don't use `any` type in TypeScript
- Don't skip tests

---

*This file helps AI coding agents understand your project.*
*Learn more: https://agents.md/*
EOF

# ============================================================
# OUTPUT STYLES
# ============================================================
echo -e "${GREEN}Creating output style...${NC}"

cat > "$HOME/.claude/output-styles/concise.md" << 'EOF'
---
name: concise
description: Minimal, action-focused output for experienced developers
---

# Concise Mode

Be extremely brief. Assume I know what I'm doing.

## Format
- Action: What you did (1 line)
- Result: Outcome or output
- Next: What to do next (if applicable)

## Rules
- No explanations unless I ask
- No alternatives unless I ask
- No warnings about things I didn't ask about
- Show file paths so I can navigate
- Code over prose

## Examples

Good:
```
Created src/api/users.ts with CRUD endpoints.
Run `npm test` to verify.
```

Bad:
```
I've created a new file for handling user operations. This file includes
several endpoints for Create, Read, Update, and Delete operations, commonly
known as CRUD. The implementation follows RESTful conventions and includes
proper error handling. You might want to consider adding authentication
middleware to protect these endpoints. Let me know if you'd like me to
explain any part of the implementation or if you'd like to make any changes.
```
EOF

# ============================================================
# Final Setup
# ============================================================

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Created:"
echo -e "  ${BLUE}~/.claude/CLAUDE.md${NC}              - Global preferences"
echo -e "  ${BLUE}~/.claude/settings.json${NC}          - Auto-formatting hooks"
echo -e "  ${BLUE}~/.claude/agents/${NC}                - 6 specialized agents"
echo -e "  ${BLUE}~/.claude/skills/${NC}                - Knowledge libraries"
echo -e "  ${BLUE}~/.claude/commands/${NC}              - Custom slash commands"
echo -e "  ${BLUE}~/.claude/rules/${NC}                 - Folder-specific rules"
echo -e "  ${BLUE}~/.claude/output-styles/${NC}         - Output format options"
echo -e "  ${BLUE}~/.claude/templates/${NC}             - AGENTS.md template"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Review and customize ~/.claude/CLAUDE.md"
echo -e "  2. Start Claude Code: ${GREEN}claude${NC}"
echo -e "  3. Try: ${GREEN}/kickoff \"your project idea\"${NC}"
echo ""
echo -e "${BLUE}For the full guide: https://github.com/YOUR_USERNAME/claude-code-mastery${NC}"
echo ""
