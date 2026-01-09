# Claude Code Mastery - Cheatsheet

> Quick reference card. Print it, bookmark it, keep it handy.

---

## File Locations

| What | Global (All Projects) | Project-Specific |
|------|----------------------|------------------|
| Preferences | `~/.claude/CLAUDE.md` | `./CLAUDE.md` |
| Local prefs | - | `./CLAUDE.local.md` |
| Agents | `~/.claude/agents/*.md` | `.claude/agents/*.md` |
| Skills | `~/.claude/skills/*/SKILL.md` | `.claude/skills/*/SKILL.md` |
| Commands | `~/.claude/commands/*.md` | `.claude/commands/*.md` |
| Rules | `~/.claude/rules/*.md` | `.claude/rules/*.md` |
| Hooks | `~/.claude/settings.json` | `.claude/settings.json` |
| MCP | `~/.claude/mcp.json` | `.claude/mcp.json` |

---

## Agent Template

```markdown
---
name: agent-name
description: What it does. Use when [trigger].
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

System prompt here.
```

**Key:** `description` triggers auto-delegation. Include "Use proactively when..."

---

## Skill Template

```markdown
---
name: skill-name
description: What knowledge. Use when [trigger].
---

# Title

Content Claude should know.
```

---

## Command Template

```markdown
---
name: cmd-name
description: What it does
arguments:
  - name: arg
    required: true
---

Instructions using {{arg}}.
```

---

## Rules Template

```markdown
---
paths: src/api/**/*
---

Rules for matching files.
```

---

## Hooks

```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": [...] }],
    "PostToolUse": [{ "matcher": "Edit|Write", "hooks": [...] }],
    "Stop": [{ "hooks": [...] }]
  }
}
```

**Matchers:** `Edit`, `Write`, `Read`, `Bash`, `Glob`, `Grep`, `Task`, `.*` (any)

**Hook types:**
- `{"type": "command", "command": "..."}` - Run shell command
- `{"type": "prompt", "prompt": "..."}` - AI judgment

---

## Models

| Model | Use For | Speed | Cost |
|-------|---------|-------|------|
| `haiku` | Quick questions, exploration | Fast | Low |
| `sonnet` | Daily coding, implementation | Medium | Medium |
| `opus` | Architecture, complex planning | Slow | High |

Switch: `/model haiku` or `claude --model opus`

---

## Useful Commands

| Command | Action |
|---------|--------|
| `/help` | Show help |
| `/model <name>` | Switch model |
| `/compact` | Compress context |
| `/clear` | Reset conversation |
| `/mcp` | Show MCP connections |
| `/config` | Show configuration |

---

## Ralph Quick Reference

**Simple (same session):**
```
/ralph-loop "task with criteria" --max-iterations 20 --completion-promise "DONE"
```

**Orchestrated (fresh sessions):**
```bash
./ralph.sh 30  # 30 iterations max
```

---

## AGENTS.md Standard

Official open standard: [agents.md](https://agents.md/) (14.7k stars, Linux Foundation)

Put in any folder for context:

```markdown
# AGENTS.md

## Project overview
What this project/folder does.

## Dev environment tips
- `pnpm dev` for development

## Testing instructions
- `pnpm test` before committing

## Gotchas
- Thing to watch out for
```

Supported by 20+ AI tools including Claude, Copilot, Cursor, Devin.

---

## Common Hooks

**Auto-format:**
```json
{"matcher": "Edit|Write", "hooks": [{"type": "command", "command": "prettier --write \"$filepath\""}]}
```

**Block dangerous:**
```json
{"matcher": "Bash", "hooks": [{"type": "prompt", "prompt": "BLOCK if rm -rf or production"}]}
```

**Auto-lint:**
```json
{"matcher": "Edit|Write", "hooks": [{"type": "command", "command": "eslint --fix \"$filepath\""}]}
```

---

## The Stack

```
/command          →  Triggers Claude
    ↓
CLAUDE.md         →  Always loaded preferences
    ↓
Skills            →  Knowledge injected when relevant
    ↓
Agents            →  Auto-delegated specialists
    ↓
Hooks             →  Automatic quality gates
    ↓
MCPs              →  External tool connections
    ↓
Output            →  Your project, done
```

---

## Quick Setup

```bash
# Install everything
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/claude-code-mastery/main/install.sh | bash

# Start Claude
claude

# Build something
/kickoff "your idea"
```

---

**Full guide:** See `docs/COMPLETE_GUIDE.md`

**Stop prompting. Start building.**
