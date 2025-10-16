#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/new_distraction.sh [VAULT_DIR] [TITLE] [DUE: YYYY-MM-DD|HH:MM]
VAULT_DIR="${1:-$HOME/FocusVault}"
TITLE="${2:-New Distraction}"
DUE="${3:-}"

SAFE_TITLE="$(echo "$TITLE" | sed 's/[[:space:]]\+/-/g' | tr '[:upper:]' '[:lower:]')"
FILE="$VAULT_DIR/02 - Tasks/${SAFE_TITLE}.md"

mkdir -p "$VAULT_DIR/02 - Tasks"

if [[ -n "${DUE// }" ]]; then
  DUE_LINE="due: $DUE"$'\n'
else
  DUE_LINE=""
fi

cat > "$FILE" <<EOF
---
type: task
status: todo
priority: low
${DUE_LINE}distraction: true
tags: [distraction, task]
---

# ${TITLE}

## 💬 Description
- 
EOF

echo "✅ Distraction created: $FILE"
