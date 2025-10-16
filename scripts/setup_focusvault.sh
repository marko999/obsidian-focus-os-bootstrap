#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/setup_focusvault.sh [VAULT_DIR]
VAULT_DIR="${1:-$HOME/FocusVault}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/sample_vault/"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "❌ sample_vault directory not found at: $SOURCE_DIR" >&2
  exit 1
fi

echo "→ Initializing FocusVault at: $VAULT_DIR"
mkdir -p "$VAULT_DIR"
rsync -a --delete "$SOURCE_DIR" "$VAULT_DIR"/

echo "✅ Sample vault copied to $VAULT_DIR"
echo
echo "Next steps:"
echo "  1. Open Obsidian → 'Open folder as vault' → $VAULT_DIR"
echo "  2. Enable plugins: Templater, Dataview, Tasks, Calendar, Periodic Notes"
echo "  3. In Templater settings, set Template folder to '00 - Templates' and reload templates"
