# Claude Code Mastery

> A curated collection of patterns, templates, and workflows for Claude Code power users.

**This is not original work.** This repo curates and organizes best practices from the community, official documentation, and pioneers who figured this stuff out. We're just making it easier to get started.

**One command. Full project. Minimal prompting.**

```bash
# Install the framework
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/claude-code-mastery/main/install.sh | bash

# Start Claude Code
claude

# Build an entire project autonomously
/kickoff "workflow automation dashboard"
```

---

## What This Is

A complete framework for power users who want to:

- **Stop re-prompting** - Claude remembers your preferences forever
- **Stop micromanaging** - Specialized agents handle specific tasks
- **Stop forgetting quality** - Hooks automate formatting, linting, testing
- **Stop context from bloating** - Agents work in separate context windows
- **Build projects autonomously** - Ralph loops iterate until completion

## The Stack

| Component | What It Does |
|-----------|--------------|
| **CLAUDE.md** | Persistent memory across all sessions |
| **Agents** | Specialized workers (PRD writer, implementer, reviewer, etc.) |
| **Skills** | Knowledge libraries (patterns, templates, best practices) |
| **Hooks** | Automatic reactions (format on save, lint on save, block dangerous commands) |
| **Commands** | Custom `/slash` commands that orchestrate everything |
| **Rules** | Folder-specific instructions |
| **Ralph** | Autonomous iteration loops |
| **AGENTS.md** | Per-folder memory that survives context resets |

## Quick Start

### Option 1: Full Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/claude-code-mastery/main/install.sh | bash
```

This creates:
- `~/.claude/CLAUDE.md` - Your global preferences
- `~/.claude/agents/` - 6 ready-to-use agents
- `~/.claude/skills/` - Knowledge libraries
- `~/.claude/commands/` - Custom slash commands
- `~/.claude/settings.json` - Auto-formatting hooks

### Option 2: Pick and Choose

Copy individual templates from the `templates/` directory.

### Option 3: Just Learn

Read the [Complete Guide](docs/COMPLETE_GUIDE.md) and build your own setup.

---

## How It Works

### Before (Typical Usage)
```
You: Build me a todo app
Claude: [writes some code]
You: Add tests
Claude: [writes tests]
You: The tests fail
Claude: [fixes tests]
You: Format the code
Claude: [formats]
You: Now add authentication
Claude: [writes auth]
You: You forgot error handling
...repeat 50 times...
```

### After (With This Framework)
```
You: /kickoff "todo app with authentication"

Claude automatically:
├── Asks clarifying questions
├── Generates PRD (prd-writer agent)
├── Designs architecture (architecture skill)
├── Scaffolds project (scaffolder agent)
├── Implements features (implementer agent)
├── [Hooks auto-format every file]
├── [Hooks auto-lint every file]
├── Writes tests (tester agent)
├── Reviews code (reviewer agent)
└── Reports: "Ready for review"

You: [review and ship]
```

---

## Framework Components

### 1. CLAUDE.md - Persistent Memory

```markdown
# ~/.claude/CLAUDE.md - Applies to ALL projects

- Don't auto-commit unless I ask
- Use TypeScript, 2-space indent
- Use pnpm as package manager
- Be concise in responses
```

Claude reads this EVERY session. Your preferences, forever.

### 2. Agents - Your AI Team

```
~/.claude/agents/
├── prd-writer.md      # Converts ideas to PRDs
├── scaffolder.md      # Creates project structure
├── implementer.md     # Writes production code
├── tester.md          # Writes and runs tests
├── reviewer.md        # Reviews for quality/security
└── debugger.md        # Fixes bugs systematically
```

Agents auto-delegate based on their description. You don't ask for them - Claude uses them automatically.

### 3. Hooks - Automatic Quality

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Edit|Write",
      "hooks": [{"type": "command", "command": "prettier --write $filepath"}]
    }]
  }
}
```

Every file edit → automatically formatted. Zero tokens wasted asking.

### 4. Commands - One Trigger, Full Pipeline

```bash
/kickoff "your idea"     # Idea → PRD → Architecture → Code → Tests → Review
/morning                  # Standup prep
/deploy staging           # Full deployment pipeline
/review-pr 123            # Comprehensive PR review
```

### 5. Ralph - Autonomous Loops

Two approaches included:

**ralph-wiggum** (simple): Hook-based, same session continues
```bash
/ralph-loop "build REST API with tests" --max-iterations 20
```

**ralph-orchestrator** (powerful): Fresh context each iteration, file-based memory
```bash
./ralph.sh 50  # Run up to 50 iterations
```

### 6. AGENTS.md - Folder Memory

```
your-project/
├── AGENTS.md              # "Here's what you need to know about this project"
├── src/
│   ├── api/
│   │   └── AGENTS.md      # "API-specific patterns and gotchas"
│   └── database/
│       └── AGENTS.md      # "Database conventions and warnings"
```

Claude reads these when working in each folder. Memory that survives context resets.

---

## Directory Structure

```
claude-code-mastery/
├── README.md                          # You are here
├── install.sh                         # One-command setup
├── docs/
│   └── COMPLETE_GUIDE.md              # Full 2000+ line guide
├── templates/
│   ├── global/                        # Global config templates
│   ├── project/                       # Project config templates
│   ├── agents/                        # Agent templates
│   ├── skills/                        # Skill templates
│   ├── commands/                      # Command templates
│   ├── rules/                         # Rule templates
│   └── memory/                        # AGENTS.md templates
├── ralph/
│   ├── ralph-wiggum/                  # Simple hook-based loops
│   └── ralph-orchestrator/            # Full bash orchestration
├── examples/
│   ├── automation-engineer/           # Setup for automation work
│   ├── frontend-dev/                  # Setup for frontend work
│   └── fullstack/                     # Setup for fullstack work
└── cheatsheet.md                      # Quick reference card
```

---

## Real Results

From the Ralph approach:
- **6 repositories generated overnight** at Y Combinator hackathon
- **$50k contract completed for $297** in API costs
- **Entire programming language** built over 3 months

From structured Claude Code usage:
- **90% reduction in prompts** for typical projects
- **Consistent code quality** via automatic hooks
- **Knowledge preserved** across sessions and context resets

---

## Learn More

- [Complete Guide](docs/COMPLETE_GUIDE.md) - Everything explained in detail
- [Cheatsheet](cheatsheet.md) - Quick reference card
- [Examples](examples/) - Role-specific setups

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Ideas welcome:
- New agent templates
- New skill libraries
- Workflow improvements
- Documentation fixes

---

## Credits & Sources

**This repo is a curated collection. All credit goes to the original creators:**

### Core Tools
- [Claude Code](https://claude.ai/code) by Anthropic - The AI coding assistant this is built for
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code) - Official docs we learned from

### AGENTS.md Standard
- [agents.md](https://agents.md/) - The open standard for AI agent instructions
- [agentsmd/agents.md](https://github.com/agentsmd/agents.md) - Official repo (14.7k stars)
- Stewarded by the Agentic AI Foundation under the Linux Foundation

### Ralph Autonomous Loop
- [Geoffrey Huntley](https://ghuntley.com/ralph/) - Original inventor of the Ralph technique
- [Anthropic's ralph-wiggum plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum) - Official implementation
- [snarktank/ralph](https://github.com/snarktank/ralph) - Ralph Orchestrator for fresh-context iterations

### Community Knowledge
- The Claude Code Discord community
- Everyone who shared their workflows and patterns online
- All the blog posts, tweets, and videos that taught us these patterns

### Philosophy
This repo exists because:
- We're vibe coders who want to ship, not configure
- Good patterns should be accessible to everyone
- Nobody should have to figure this all out from scratch
- Sharing knowledge makes everyone better

**We don't own any of this. We just organized it.**

---

## License

MIT - Use it, modify it, share it, improve it.

**If you build something cool with this, share it back with the community.**

---

## Maintainer

**Ash Hatef** - ashkanhatef@gmail.com

Just a vibe coder trying to help other vibe coders ship faster.

---

**Stop prompting. Start building.**
