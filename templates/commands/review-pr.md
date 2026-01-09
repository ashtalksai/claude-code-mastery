---
name: review-pr
description: Comprehensive pull request code review
arguments:
  - name: pr
    description: PR number or branch name to review
    required: true
---

# Pull Request Review: {{pr}}

Conducting comprehensive code review.

---

## Gather PR Information

```bash
# Try GitHub CLI first
gh pr view {{pr}} --json title,body,additions,deletions,changedFiles 2>/dev/null

# Get the diff
gh pr diff {{pr}} 2>/dev/null || git diff main...HEAD
```

---

## Review Checklist

### Security Review
- [ ] No hardcoded secrets, API keys, or passwords
- [ ] No credentials in comments or variable names
- [ ] All user inputs validated and sanitized
- [ ] SQL queries use parameterization (no injection risk)
- [ ] Output properly encoded (no XSS risk)
- [ ] Authentication required on protected endpoints
- [ ] Authorization checked before sensitive operations
- [ ] Sensitive data not logged or exposed in errors

### Code Quality Review
- [ ] Code is readable and self-documenting
- [ ] Functions have single responsibility
- [ ] No unnecessary code duplication
- [ ] Error handling is comprehensive
- [ ] Types are specific (no `any` in TypeScript)
- [ ] No dead code or commented-out code
- [ ] Consistent with existing codebase style
- [ ] No obvious performance issues

### Testing Review
- [ ] New functionality has tests
- [ ] Edge cases are covered
- [ ] Tests are meaningful (not just coverage padding)
- [ ] No flaky tests introduced

### Documentation Review
- [ ] README updated if needed
- [ ] Complex logic has explanatory comments
- [ ] API changes documented
- [ ] Breaking changes clearly noted

---

## Review Output Format

```markdown
## PR Review: [PR Title]

### Summary
[1-2 sentence overview of changes and overall assessment]

### Critical Issues (Must Fix Before Merge)
- **[file:line]** [Issue description]
  - Why: [Why this matters]
  - Fix: [How to fix]

### Warnings (Should Fix)
- **[file:line]** [Issue description]
  - Suggestion: [How to improve]

### Suggestions (Consider)
- **[file:line]** [Suggestion]

### Questions
- [Any clarifying questions about the implementation]

### What's Good
- [Positive observations - reinforce good patterns]

### Verdict
[ ] ✅ Approve - Good to merge
[ ] 🔄 Request Changes - Address critical issues first
[ ] 💬 Comment - Discussion needed
```

---

## Post Review

If using GitHub CLI and review is complete:
```bash
# Submit review (uncomment appropriate line)
# gh pr review {{pr}} --approve --body "LGTM! [comments]"
# gh pr review {{pr}} --request-changes --body "[feedback]"
# gh pr review {{pr}} --comment --body "[comments]"
```
