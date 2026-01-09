#!/bin/bash

# Ralph Orchestrator
# Autonomous iteration loop with fresh context per iteration
# Based on: https://github.com/snarktank/ralph

set -e

# Configuration
MAX_ITERATIONS=${1:-10}
PRD_FILE="prd.json"
PROGRESS_FILE="progress.txt"
PROMPT_FILE="scripts/ralph/prompt.md"
AGENTS_FILE="AGENTS.md"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║                    RALPH ORCHESTRATOR                         ║"
echo "║              Autonomous Iteration Loop                        ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check required files
if [ ! -f "$PRD_FILE" ]; then
    echo -e "${RED}Error: $PRD_FILE not found${NC}"
    echo "Create a prd.json with your user stories first."
    echo "Use /kickoff to generate one, or create manually."
    exit 1
fi

if [ ! -f "$PROMPT_FILE" ]; then
    echo -e "${YELLOW}Warning: $PROMPT_FILE not found, using default prompt${NC}"
fi

# Initialize progress file if not exists
if [ ! -f "$PROGRESS_FILE" ]; then
    echo "# Ralph Progress Log" > "$PROGRESS_FILE"
    echo "# Started: $(date)" >> "$PROGRESS_FILE"
    echo "" >> "$PROGRESS_FILE"
fi

# Function to check if all stories are complete
all_complete() {
    local incomplete=$(jq '[.stories[] | select(.passes != true)] | length' "$PRD_FILE")
    [ "$incomplete" -eq 0 ]
}

# Function to get next incomplete story
get_next_story() {
    jq -r '.stories[] | select(.passes != true) | select(.status != "blocked") | .id' "$PRD_FILE" | head -1
}

# Function to mark story complete
mark_complete() {
    local story_id=$1
    local tmp_file=$(mktemp)
    jq --arg id "$story_id" '(.stories[] | select(.id == $id)) |= . + {status: "complete", passes: true}' "$PRD_FILE" > "$tmp_file"
    mv "$tmp_file" "$PRD_FILE"
}

# Main loop
iteration=0
while [ $iteration -lt $MAX_ITERATIONS ]; do
    iteration=$((iteration + 1))

    echo -e "\n${BLUE}═══ Iteration $iteration of $MAX_ITERATIONS ═══${NC}"

    # Check if all complete
    if all_complete; then
        echo -e "${GREEN}All stories complete!${NC}"
        echo "<promise>COMPLETE</promise>"
        break
    fi

    # Get next story
    next_story=$(get_next_story)
    if [ -z "$next_story" ]; then
        echo -e "${YELLOW}No actionable stories found (all may be blocked)${NC}"
        break
    fi

    echo -e "Working on: ${YELLOW}$next_story${NC}"

    # Log iteration start
    echo "" >> "$PROGRESS_FILE"
    echo "=== Iteration $iteration ($(date)) ===" >> "$PROGRESS_FILE"
    echo "Working on: $next_story" >> "$PROGRESS_FILE"

    # Build the prompt
    story_json=$(jq --arg id "$next_story" '.stories[] | select(.id == $id)' "$PRD_FILE")

    prompt="You are in a Ralph orchestration loop.

## Current Task
$(echo "$story_json" | jq -r '"Story: \(.id) - \(.title)\n\nDescription: \(.description)\n\nAcceptance Criteria:\n\(.acceptance | map(\"- \" + .) | join(\"\n\"))"')

## Context
- Read AGENTS.md for project patterns
- Read progress.txt for learnings from previous iterations
- Check git log for recent changes

## Instructions
1. Implement this story completely
2. Write tests that verify acceptance criteria
3. Run tests and ensure they pass
4. Update AGENTS.md if you discover important patterns
5. Append your learnings to progress.txt

## Completion
When the story is fully implemented and tests pass:
1. Commit your changes
2. Output: STORY_COMPLETE:$next_story

If blocked:
1. Document the blocker in progress.txt
2. Output: STORY_BLOCKED:$next_story:reason
"

    # Run Claude with the prompt
    # Note: Adjust this command based on your Claude CLI setup
    echo -e "${BLUE}Starting Claude session...${NC}"

    output=$(claude -p "$prompt" --print 2>&1) || true

    # Check output for completion signals
    if echo "$output" | grep -q "STORY_COMPLETE:$next_story"; then
        echo -e "${GREEN}Story $next_story completed!${NC}"
        mark_complete "$next_story"
        echo "Completed: $next_story" >> "$PROGRESS_FILE"
    elif echo "$output" | grep -q "STORY_BLOCKED"; then
        echo -e "${YELLOW}Story $next_story blocked${NC}"
        # Mark as blocked in prd.json
        tmp_file=$(mktemp)
        jq --arg id "$next_story" '(.stories[] | select(.id == $id)) |= . + {status: "blocked"}' "$PRD_FILE" > "$tmp_file"
        mv "$tmp_file" "$PRD_FILE"
        echo "Blocked: $next_story" >> "$PROGRESS_FILE"
    else
        echo -e "${YELLOW}Iteration completed without explicit signal${NC}"
        echo "Iteration $iteration ended without completion signal" >> "$PROGRESS_FILE"
    fi

    # Small delay between iterations
    sleep 2
done

# Final status
echo -e "\n${BLUE}═══ Ralph Complete ═══${NC}"
if all_complete; then
    echo -e "${GREEN}All stories successfully completed!${NC}"
else
    incomplete_count=$(jq '[.stories[] | select(.passes != true)] | length' "$PRD_FILE")
    echo -e "${YELLOW}$incomplete_count stories remaining${NC}"
fi

echo -e "\nProgress log: $PROGRESS_FILE"
echo "Task status: $PRD_FILE"
