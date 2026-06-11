#!/bin/bash
set -euo pipefail

SKILL_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills/agent-prompt-composer"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/config.json"

echo "Installing agent-prompt-composer skill globally..."

mkdir -p "$SKILL_DIR"

cp "$(dirname "$0")/.opencode/skills/agent-prompt-composer/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "  Skill copied to $SKILL_DIR/SKILL.md"

python3 -c "
import json, os
path = os.path.expanduser('$CONFIG')
try:
    with open(path) as f:
        cfg = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    cfg = {'\$schema': 'https://opencode.ai/config.json'}
cfg.setdefault('command', {})['compose-prompt'] = {
    'description': 'Compose a structured prompt for another agent, gathering context from project files, skills, and model config.',
    'prompt': \"Load the \`agent-prompt-composer\` skill, then follow its instructions to gather context and compose a prompt for the user's task. Ask clarifying questions if the task is ambiguous. Output the final prompt wrapped in a code block.\"
}
with open(path, 'w') as f:
    json.dump(cfg, f, indent=2)
    f.write('\n')
"
echo "  Command registered in $CONFIG"

echo ""
echo "Done! Restart OpenCode for the changes to take effect."
echo "Then use:  /compose-prompt <describe the task for the target agent>"
