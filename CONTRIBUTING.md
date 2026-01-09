# Contributing to Claude Code Mastery

Thank you for your interest in contributing! This project aims to help everyone get more out of Claude Code.

## Ways to Contribute

### 1. Share Your Agents

Have a useful agent template? Add it to `templates/agents/`:

```markdown
---
name: your-agent-name
description: What it does. When to use it.
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

Your system prompt here.
```

**Guidelines:**
- Clear, specific description
- Focused on one task type
- Include usage examples in the prompt
- Test it before submitting

### 2. Share Your Skills

Have domain knowledge to share? Add it to `templates/skills/`:

```
templates/skills/your-skill/
├── SKILL.md          # Main skill file
└── REFERENCE.md      # Optional detailed reference
```

**Guidelines:**
- Start with common patterns
- Include code examples
- Keep SKILL.md focused, link to details
- Test that Claude uses it appropriately

### 3. Share Your Commands

Have a useful workflow? Add it to `templates/commands/`:

```markdown
---
name: command-name
description: What it does
arguments:
  - name: arg
    required: true
---

Instructions for Claude.
```

**Guidelines:**
- Clear, repeatable workflows
- Use placeholders for arguments: `{{arg}}`
- Include success criteria

### 4. Share Your Rules

Have folder-specific patterns? Add to `templates/rules/`:

```markdown
---
paths: src/your-folder/**/*
---

Your rules here.
```

### 5. Add Examples

Share your role-specific setup in `examples/`:
- What preferences work well
- Which agents you use
- Your hooks configuration
- Your workflow patterns

### 6. Improve Documentation

- Fix typos and unclear sections
- Add examples where helpful
- Update outdated information
- Translate to other languages

### 7. Report Issues

Found a problem? Open an issue with:
- What you expected
- What happened
- Steps to reproduce
- Your Claude Code version

## Submission Process

1. **Fork** the repository
2. **Create a branch** for your change
3. **Make your changes**
4. **Test** that they work
5. **Submit a Pull Request** with:
   - Clear description of the change
   - Why it's useful
   - Any testing you did

## Code of Conduct

- Be respectful and constructive
- Help others learn
- Give credit where due
- Focus on improving the tools

## Questions?

Open an issue with the `question` label.

---

Thank you for helping make Claude Code more powerful for everyone!
