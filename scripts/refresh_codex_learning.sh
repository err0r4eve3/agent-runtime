#!/bin/sh
set -eu

REPO_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
CODEX_HOME="${HOME}/.codex"
MACHINE_NAME="${1:-$(hostname -s)}"
RAW_DIR="$REPO_ROOT/codex/learning/generated/$MACHINE_NAME"
RAW_JSONL="$RAW_DIR/failures.jsonl"
SUMMARY_MD="$REPO_ROOT/inventories/$MACHINE_NAME/codex-learning-summary.md"
RULES_MD="$REPO_ROOT/codex/learning/distilled-rules.md"

mkdir -p "$RAW_DIR" "$REPO_ROOT/inventories/$MACHINE_NAME"

python3 "$REPO_ROOT/scripts/harvest_codex_failures.py" \
  --sessions-root "$CODEX_HOME/sessions" \
  --output-jsonl "$RAW_JSONL" \
  --summary-md "$SUMMARY_MD"

python3 "$REPO_ROOT/scripts/promote_codex_learnings.py" \
  --input "$RAW_JSONL" \
  --output-md "$RULES_MD"

echo "refreshed:"
echo "  $RAW_JSONL"
echo "  $SUMMARY_MD"
echo "  $RULES_MD"
