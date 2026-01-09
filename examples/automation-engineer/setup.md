# Automation Engineer Setup

> Optimized for workflow automation, n8n, integrations, and DevOps tasks.

## Overview

This setup is tailored for automation engineers who:
- Build workflow automations (n8n, Zapier, Make)
- Create integrations between services
- Write scripts and automation tools
- Work with APIs and webhooks

## Global CLAUDE.md

```markdown
# Automation Engineer Preferences

## General
- Don't auto-commit unless I ask
- Be concise - show me the solution, not explanations
- No emojis

## Code Style
- TypeScript for all Node.js projects
- Python for scripts when appropriate
- Clear error messages for debugging
- Comprehensive logging

## Automation Preferences
- Always validate webhook payloads
- Use environment variables for secrets
- Include retry logic for API calls
- Add error notifications to workflows

## Tools
- n8n for workflow automation
- Node.js for custom integrations
- Python for data processing scripts
- Docker for deployment
```

## Recommended Agents

### workflow-builder.md
```markdown
---
name: workflow-builder
description: Build and review n8n workflows. Use when creating, debugging, or optimizing workflows.
tools: Read, Write, Edit, Bash, Glob
---

You are an n8n workflow expert.

When building workflows:
1. Start with clear trigger (webhook, schedule, etc.)
2. Add error handling with Error Trigger node
3. Validate inputs before processing
4. Use environment variables for credentials
5. Add logging/notification for monitoring

When reviewing workflows:
1. Check for error handling
2. Verify credential security
3. Look for rate limiting needs
4. Ensure proper data validation
```

### api-integrator.md
```markdown
---
name: api-integrator
description: Build API integrations and webhook handlers. Use when connecting services or building API clients.
tools: Read, Write, Edit, Bash, Glob, Grep
---

You are an API integration specialist.

When building integrations:
1. Read API documentation first
2. Handle rate limits with exponential backoff
3. Validate all responses
4. Log requests/responses for debugging
5. Use typed interfaces for payloads

Security:
- Never hardcode API keys
- Use HTTPS only
- Validate webhook signatures
- Sanitize all inputs
```

## Recommended Skills

### n8n-patterns/SKILL.md
```markdown
---
name: n8n-patterns
description: n8n workflow best practices and patterns. Use when building or debugging n8n workflows.
---

# n8n Best Practices

## Error Handling
Always add Error Trigger → Notification pattern

## Webhook Security
- Use header authentication
- Validate payload structure
- Check request signatures

## Performance
- Batch operations for bulk data
- Use Wait nodes for rate limits
- Split large datasets

## Common Patterns
- Webhook → Validate → Process → Notify
- Schedule → Fetch → Transform → Store
- Trigger → Branch → Multiple Actions
```

## Recommended Hooks

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "if [[ \"$filepath\" == *.json ]]; then python3 -m json.tool \"$filepath\" > /dev/null 2>&1 || echo 'Invalid JSON'; fi"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Check if this command could expose secrets (env vars, API keys, tokens). If it echoes or logs sensitive data, BLOCK it."
          }
        ]
      }
    ]
  }
}
```

## Recommended Commands

### /workflow
```markdown
---
name: workflow
description: Create or analyze n8n workflow
arguments:
  - name: action
    description: create, review, or debug
    required: true
---

# Workflow: {{action}}

Use the workflow-builder agent to {{action}} the workflow.

For create: Ask about trigger, steps, and error handling.
For review: Check for security, error handling, and optimization.
For debug: Analyze error logs and workflow execution.
```

### /integration
```markdown
---
name: integration
description: Build API integration
arguments:
  - name: service
    description: Service to integrate with
    required: true
---

# Integration: {{service}}

Use the api-integrator agent to build integration with {{service}}.

1. Fetch and analyze API documentation
2. Design the integration approach
3. Implement with proper error handling
4. Add tests for key scenarios
```

## Directory Structure

```
~/.claude/
├── CLAUDE.md                    # Automation preferences above
├── agents/
│   ├── workflow-builder.md
│   ├── api-integrator.md
│   └── script-writer.md
├── skills/
│   └── n8n-patterns/SKILL.md
├── commands/
│   ├── workflow.md
│   └── integration.md
└── settings.json                # Hooks above
```
