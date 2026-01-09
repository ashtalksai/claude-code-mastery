---
name: prd-template
description: PRD structure, writing guidelines, and best practices. Use when creating, reviewing, or discussing Product Requirements Documents.
---

# PRD Writing Guide

## Quick Template

```markdown
# [Project Name] PRD

## Overview
[2-3 sentences: What is this and why are we building it?]

## Problem Statement
- **Current Pain**: [What's the problem today?]
- **Who's Affected**: [Who experiences this problem?]
- **Impact**: [What's the cost of not solving this?]

## Target Users

### Primary User
**[Persona Name]**: [Brief description]
- Goals: [What they want to achieve]
- Pain Points: [What frustrates them]
- Tech Savviness: [Low/Medium/High]

### Secondary Users
- [Other user types if applicable]

## User Stories

### P0 - Must Have (Launch Blockers)
1. **As a** [user type], **I want to** [action] **so that** [benefit]
   - Acceptance Criteria:
     - [ ] [Specific, testable criterion]
     - [ ] [Another criterion]

### P1 - Should Have (Launch Important)
1. **As a** [user type], **I want to** [action] **so that** [benefit]
   - Acceptance Criteria:
     - [ ] [Criterion]

### P2 - Nice to Have (Post-Launch)
1. **As a** [user type], **I want to** [action] **so that** [benefit]

## Functional Requirements

### [Feature Area 1]
| ID | Requirement | Priority | Acceptance Criteria |
|----|-------------|----------|---------------------|
| FR-001 | [Requirement] | P0 | [Criteria] |
| FR-002 | [Requirement] | P1 | [Criteria] |

## Non-Functional Requirements

| Category | Requirement | Target |
|----------|-------------|--------|
| Performance | Page load time | < 2 seconds |
| Availability | Uptime | 99.9% |
| Security | Authentication | OAuth 2.0 / JWT |
| Scalability | Concurrent users | 1,000 |

## Technical Considerations

### Constraints
- [Technical limitation or requirement]

### Dependencies
- [External system or service]

### Risks
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk] | Medium | High | [Mitigation] |

## Success Metrics

| Metric | Current | Target | Measurement |
|--------|---------|--------|-------------|
| [KPI] | [Baseline] | [Goal] | [How measured] |

## Open Questions
- [ ] [Question needing resolution]
- [ ] [Another question]

## Appendix
- [Links to research, mockups, etc.]
```

## Writing Principles

### Be Specific
```
Bad:  "The app should be fast"
Good: "Page load time under 2 seconds on 3G connection"

Bad:  "Users can manage their data"
Good: "Users can export all their data as JSON or CSV within 30 seconds"
```

### Include Acceptance Criteria
```
Bad:  "User can login"
Good: "User can login with email/password
       - Valid credentials → redirect to dashboard
       - Invalid credentials → show error message
       - 3 failed attempts → 15-minute lockout
       - Password field masked by default"
```

### Prioritize Ruthlessly
- **P0**: Cannot ship without this. Literally a launch blocker.
- **P1**: Very important. Should have for launch, but could do fast-follow.
- **P2**: Nice to have. Clearly post-launch.

### Consider Edge Cases
For every feature, ask:
- What if the input is empty?
- What if the input is very large?
- What if the user has no data yet?
- What if the network fails mid-operation?
- What if two users do this at the same time?
- What if the user doesn't have permission?
