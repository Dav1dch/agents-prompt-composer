#!/bin/bash
set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
SKILL_DIR="$CONFIG_DIR/skills/agent-prompt-composer"
COMMAND_DIR="$CONFIG_DIR/commands"

echo "Installing agent-prompt-composer skill globally..."

mkdir -p "$SKILL_DIR"
mkdir -p "$COMMAND_DIR"

cp "$(dirname "$0")/.opencode/skills/agent-prompt-composer/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "  Skill copied to $SKILL_DIR/SKILL.md"

cp "$(dirname "$0")/commands/compose-prompt.md" "$COMMAND_DIR/compose-prompt.md"
echo "  Command copied to $COMMAND_DIR/compose-prompt.md"

echo ""
echo "Done! Restart OpenCode for the changes to take effect."
echo "Then use:  /compose-prompt <describe the task for the target agent>"
