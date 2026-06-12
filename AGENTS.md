# Prompt2Prompt — AGENTS.md

OpenCode skill for composing structured agent prompts. Not a code project — no build/test/lint pipeline.

## What this repo is

An OpenCode skill (`agent-prompt-composer`) that generates prompts for other agents by gathering project context automatically. The skill lives at `.opencode/skills/agent-prompt-composer/SKILL.md`.

## Skills

- `.opencode/skills/agent-prompt-composer/SKILL.md` — Load when composing a prompt for another agent. Gathers AGENTS.md, available skills, model info, project config, and produces a structured prompt (Task → Context → Requirements → Verification).

## Project structure

- `opencode.json` — Registers the `/compose-prompt` slash command
- `install.sh` — Copies skill globally to `~/.config/opencode/skills/` and registers the command
- `.opencode/package.json` — Only dependency: `@opencode-ai/plugin`

## Conventions

- This repo has no source code, tests, or lint. Do not add build tooling unless the project scope changes.
- The skill file (`SKILL.md`) is the single source of truth for composition logic. Edit it directly when changing behavior.
- `install.sh` targets XDG config dirs (`$XDG_CONFIG_HOME` or `~/.config`). Keep it compatible with both `opencode.json` and `opencode.jsonc` config filenames.
