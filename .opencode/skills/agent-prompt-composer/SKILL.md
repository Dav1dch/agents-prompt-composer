---
name: agent-prompt-composer
description: >-
  Use when composing or refining a prompt for an OpenCode agent.
  Gathers context (AGENTS.md, available skills, model info, project config)
  and structures it into a clear, complete agent prompt.
  Use ONLY when the task is to craft a prompt for another agent to execute,
  not when executing work directly.
---

# Agent Prompt Composer

When writing a prompt for another OpenCode agent, gather and include these inputs in order:

## 1. Project instructions

Read current `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`, `.cursorrules`, `.github/copilot-instructions.md`, and any `instructions` files referenced in `opencode.json`. Include the relevant rules verbatim or as a structured summary — do not just gesture at them.

## 2. Available skills

Use the `skill` tool to discover available skills. Check descriptions and consider which are relevant. Reference them directly in the prompt (e.g. "Use the `lint-runner` skill when checking code quality"). Do not describe skills the agent cannot actually load.

## 3. Model awareness

If the model is known (from `opencode.json` `model` field or user input), adjust prompt structure:
- **Small / fast models**: prefer very explicit step-by-step instructions, single-file edits, fewer parallel tool calls
- **Large models** (e.g. Claude Sonnet, GPT-4o, Gemini 2.5 Pro): can handle multi-step reasoning, parallel tool batches, generating complex code
- **Best effort**: if unknown, write for a capable model and note the assumption

## 4. Project structure & entrypoints

Scan relevant config (`package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, etc.) and entrypoint files. Include:
- Where source code lives
- How builds/tests/lint run
- The exact dev commands and their order

## 5. Task framing

Write the prompt in this structure:
```
## Task
(one-paragraph summary)

## Context
(project instructions, skill references, model notes)

## Requirements
- (numbered constraints the agent must honor)

## Verification
- (how to confirm the work is correct: lint, typecheck, test commands)
```

## Rules

- Never include generic advice the agent already knows.
- Never fabricate commands, scripts, or tool capabilities — verify each one.
- Prefer short, specific guidance over long explanations.
- If the task is ambiguous, include a question for the user to resolve.
- End every composed prompt with `---` to mark the boundary.
