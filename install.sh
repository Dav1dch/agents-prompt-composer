#!/bin/bash
set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
SKILL_DIR="$CONFIG_DIR/skills/agent-prompt-composer"
COMMAND_DIR="$CONFIG_DIR/commands"

if [ -f "$CONFIG_DIR/opencode.json" ]; then
  CONFIG="$CONFIG_DIR/opencode.json"
elif [ -f "$CONFIG_DIR/opencode.jsonc" ]; then
  CONFIG="$CONFIG_DIR/opencode.jsonc"
elif [ -f "$CONFIG_DIR/config.json" ]; then
  CONFIG="$CONFIG_DIR/config.json"
else
  CONFIG="$CONFIG_DIR/opencode.json"
fi

echo "Installing agent-prompt-composer skill globally..."
echo "  Config: $CONFIG"

mkdir -p "$SKILL_DIR"
mkdir -p "$COMMAND_DIR"

cp "$(dirname "$0")/.opencode/skills/agent-prompt-composer/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "  Skill copied to $SKILL_DIR/SKILL.md"

cp "$(dirname "$0")/commands/compose-prompt.md" "$COMMAND_DIR/compose-prompt.md"
echo "  Command copied to $COMMAND_DIR/compose-prompt.md"

CONFIG="$CONFIG" python3 << 'PYEOF'
import json, os
path = os.path.expanduser(os.environ["CONFIG"])
try:
    with open(path) as f:
        cfg = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    cfg = {"$schema": "https://opencode.ai/config.json"}
cfg.setdefault("command", {})["compose-prompt"] = "commands/compose-prompt.md"
with open(path, "w") as f:
    json.dump(cfg, f, indent=2)
    f.write("\n")
PYEOF
echo "  Command /compose-prompt registered"

echo ""
echo "Done! Restart OpenCode for the changes to take effect."
echo "Then use:  /compose-prompt <describe the task for the target agent>"
