---
description: Compose a structured prompt for another agent, gathering context from project files, skills, and model config.
---

# Compose Prompt Command

You are composing a structured prompt for another OpenCode agent to execute.

## Handle arguments

Arguments: $ARGUMENTS

If arguments are provided, use them as the task description for the prompt you will compose. If no arguments are provided, ask the user what task they want to compose a prompt for.

## Steps

1. Load the `agent-prompt-composer` skill via the `skill` tool
2. Follow the skill's instructions to gather context:
   - Read project instructions (AGENTS.md, CLAUDE.md, etc.)
   - Discover available skills
   - Check model awareness
   - Scan project structure and entrypoints
3. Compose the prompt using the structure from the skill (Task, Context, Requirements, Verification)
4. If the task is ambiguous, ask clarifying questions before composing
5. Output the final prompt wrapped in a code block for easy copying
