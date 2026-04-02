#!/bin/sh
set -eu

REPO_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
CODEX_HOME="${HOME}/.codex"
GENERATOR="$CODEX_HOME/scripts/generate_codex_skills_mcp_inventory.py"
SOURCE_DOC="$CODEX_HOME/docs/skills-mcp-inventory.md"
TARGET_CODEX_DOC="$REPO_ROOT/codex/docs/skills-mcp-inventory.md"
MACHINE_NAME="${1:-$(hostname -s)}"
TARGET_DIR="$REPO_ROOT/inventories/$MACHINE_NAME"
TARGET_DOC="$TARGET_DIR/skills-mcp-inventory.md"
TARGET_META="$TARGET_DIR/metadata.txt"
TARGET_CONFIG="$REPO_ROOT/codex/mcp/config.toml"
TARGET_LOCAL_SKILLS="$REPO_ROOT/codex/skills/local"
TARGET_SYMLINKS="$REPO_ROOT/codex/skills/local-symlinks.json"

if [ ! -f "$GENERATOR" ]; then
  echo "missing inventory generator: $GENERATOR" >&2
  exit 1
fi

python3 "$GENERATOR" >/dev/null

if [ ! -f "$SOURCE_DOC" ]; then
  echo "missing generated inventory: $SOURCE_DOC" >&2
  exit 1
fi

mkdir -p "$REPO_ROOT/codex/docs" "$TARGET_DIR" "$TARGET_LOCAL_SKILLS"
cp "$CODEX_HOME/config.toml" "$TARGET_CONFIG"
cp "$SOURCE_DOC" "$TARGET_CODEX_DOC"
cp "$SOURCE_DOC" "$TARGET_DOC"

python3 - <<'PY' > "$TARGET_SYMLINKS"
from pathlib import Path
import json
root = Path.home() / ".codex" / "skills"
items = []
for p in sorted(root.iterdir()):
    if p.is_symlink():
        items.append({
            "name": p.name,
            "target": str(p.resolve()),
        })
print(json.dumps(items, ensure_ascii=False, indent=2))
PY

rsync -a --delete \
  --exclude '.DS_Store' \
  --exclude '__pycache__' \
  --exclude '.git' \
  --exclude '*.pyc' \
  "$CODEX_HOME/skills/" "$TARGET_LOCAL_SKILLS/"

find "$TARGET_LOCAL_SKILLS" -maxdepth 1 -type l -delete 2>/dev/null || true

{
  echo "machine=$MACHINE_NAME"
  echo "generated_at=$(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo "hostname=$(hostname -s)"
  echo "os=$(uname -s)"
  echo "arch=$(uname -m)"
  echo "codex_inventory_source=$SOURCE_DOC"
} > "$TARGET_META"

echo "synced:"
echo "  $TARGET_CONFIG"
echo "  $TARGET_CODEX_DOC"
echo "  $TARGET_DOC"
echo "  $TARGET_META"
