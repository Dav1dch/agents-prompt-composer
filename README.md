# Agent Prompt Composer

An [OpenCode](https://opencode.ai) skill that generates structured, comprehensive prompts for OpenCode agents by gathering all relevant context automatically.

## What it does

When you need to craft a prompt for another agent to execute, load this skill and it will:

1. Read project instruction files (`AGENTS.md`, `CLAUDE.md`, cursor rules, etc.)
2. Discover and reference available skills the target agent can load
3. Adjust prompt structure for the target model (small/fast vs large capable)
4. Scan project config and entrypoints for exact build/test/lint commands
5. Produce a prompt structured as **Task → Context → Requirements → Verification**

## Usage

The skill is auto-discovered when placed at `.opencode/skills/agent-prompt-composer/SKILL.md` in an OpenCode project.

An agent loads it by calling:

```
skill({ name: "agent-prompt-composer" })
```

Once loaded, follow the skill's instructions to compose a prompt for another agent.

### Slash command

If `opencode.json` is configured with the `compose-prompt` command, you can also type:

```
/compose-prompt <describe the task for the target agent>
```

This loads the skill automatically and starts the composition process.

## Prompt structure

Every composed prompt follows this shape:

```
## Task
(one-paragraph summary)

## Context
(project instructions, skill references, model notes)

## Requirements
- (numbered constraints the agent must honor)

## Verification
- (how to confirm correctness: lint, typecheck, test commands)
```

## Installation

### Per-project

```bash
mkdir -p .opencode/skills
cp -r agent-prompt-composer .opencode/skills/
```

### Global (available in every session)

```bash
mkdir -p ~/.config/opencode/skills
cp -r agent-prompt-composer ~/.config/opencode/skills/
```

The command must be registered in the global config at `~/.config/opencode/config.json`:

```json
{
  "command": {
    "compose-prompt": {
      "description": "Compose a structured prompt for another agent...",
      "prompt": "Load the `agent-prompt-composer` skill..."
    }
  }
}
```

No additional config needed — OpenCode scans `skills/*/SKILL.md` automatically in both project and global paths.
