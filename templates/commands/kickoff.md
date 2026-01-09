---
name: kickoff
description: Initialize a new project from idea to implementation-ready state
arguments:
  - name: idea
    description: The project idea or concept
    required: true
---

# Project Kickoff: {{idea}}

You are initiating a structured project pipeline. Follow these phases in order, completing each before moving to the next.

## Phase 1: Discovery & PRD

**Goal**: Understand requirements and document them clearly.

1. Ask 3-5 clarifying questions:
   - Who is the target user?
   - What problem does this solve?
   - What's the scope (MVP vs full)?
   - Any technical constraints or preferences?
   - What does success look like?

2. Generate comprehensive PRD with:
   - Overview and problem statement
   - Target users and personas
   - User stories (P0/P1/P2 prioritized)
   - Functional requirements with acceptance criteria
   - Non-functional requirements
   - Technical considerations
   - Success metrics

3. Save to `docs/PRD.md`

4. **STOP and wait for approval** before continuing to Phase 2

---

## Phase 2: Architecture (After PRD Approval)

**Goal**: Design the technical foundation.

1. Based on PRD, determine:
   - Tech stack (respect CLAUDE.md preferences)
   - System components
   - Data models
   - API design (if applicable)

2. Create `docs/ARCHITECTURE.md` with:
   - System overview
   - Tech stack with rationale
   - Component breakdown
   - Data models
   - API endpoints (if applicable)
   - Security considerations

3. Define folder structure for implementation

---

## Phase 3: Scaffolding

**Goal**: Create the project foundation.

1. Initialize project:
   - Create folder structure
   - Set up package.json with dependencies
   - Configure TypeScript (strict mode)
   - Set up linting and formatting
   - Configure testing framework
   - Create .gitignore and .env.example

2. Create foundation files:
   - Entry points
   - Base types/interfaces
   - Configuration files
   - README with setup instructions

3. Create `AGENTS.md` in project root with:
   - Project overview
   - Key patterns and conventions
   - Important files and their purposes

---

## Phase 4: Implementation Planning

**Goal**: Create actionable implementation roadmap.

1. Break down PRD into implementation tasks
2. Order by priority (P0 first) and dependencies
3. Estimate complexity for each task
4. Present the implementation roadmap

---

## Rules

- Delegate to specialized agents when appropriate
- Hooks will handle formatting automatically
- Only ask for input at key decision points
- Read and update AGENTS.md files for context
- Follow existing patterns once established

---

Begin with Phase 1 now. Ask your clarifying questions about: {{idea}}
