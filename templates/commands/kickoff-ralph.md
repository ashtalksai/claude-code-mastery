---
name: kickoff-ralph
description: Autonomous project creation using Ralph iteration loop
arguments:
  - name: idea
    description: The project idea or concept
    required: true
  - name: iterations
    description: Maximum iterations (default 30)
    required: false
---

# Autonomous Project Kickoff: {{idea}}

Starting Ralph loop for autonomous project creation. This will iterate until completion or max iterations.

/ralph-loop "
## Mission
Build a complete, working project: {{idea}}

## Success Criteria (ALL must be true to complete)
- [ ] PRD exists at docs/PRD.md with clear P0/P1/P2 requirements
- [ ] Architecture documented at docs/ARCHITECTURE.md
- [ ] Project scaffolded with TypeScript strict mode
- [ ] All P0 features from PRD are implemented
- [ ] Tests exist and pass (minimum 80% coverage on new code)
- [ ] No TypeScript errors (npx tsc --noEmit passes)
- [ ] No ESLint errors (npm run lint passes)
- [ ] Code reviewed for obvious security issues
- [ ] README.md has setup and run instructions
- [ ] AGENTS.md documents project patterns

## Process (Follow This Order)

### Phase 1: Requirements
1. Generate comprehensive PRD
2. Save to docs/PRD.md
3. Create docs/ARCHITECTURE.md with tech decisions

### Phase 2: Foundation
1. Scaffold project structure
2. Set up TypeScript, ESLint, Prettier
3. Set up testing (Vitest/Jest)
4. Create AGENTS.md with initial context

### Phase 3: Implementation
1. Implement P0 features one at a time
2. Write tests for each feature
3. Run tests after each feature
4. Fix any failures before moving on
5. Update AGENTS.md with patterns discovered

### Phase 4: Quality
1. Run full test suite
2. Run type checker
3. Run linter
4. Review code for security issues
5. Fix any issues found

### Phase 5: Documentation
1. Update README with setup instructions
2. Add inline comments where logic is complex
3. Ensure AGENTS.md is comprehensive

## Rules
- TypeScript strict mode, no 'any' types
- Proper error handling on all async operations
- Follow patterns once established
- Test each feature before implementing next
- Commit after each working feature (if git initialized)

## Completion Signal
When ALL success criteria checkboxes can be checked, output:
<promise>PROJECT_COMPLETE</promise>

## If Stuck
After 10 iterations without meaningful progress:
1. Create docs/BLOCKERS.md documenting:
   - What's blocking progress
   - What was attempted
   - Suggested solutions
2. Output: <promise>NEEDS_HUMAN_INPUT</promise>
" --max-iterations {{iterations | default: 30}} --completion-promise "PROJECT_COMPLETE"
