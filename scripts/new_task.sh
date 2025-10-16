#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/new_task.sh [VAULT_DIR] [TASK_TITLE] [FOCUS_TITLE] [PRIORITY] [DUE: YYYY-MM-DD]
VAULT_DIR="${1:-$HOME/FocusVault}"
TASK_TITLE="${2:-New Task}"
FOCUS_TITLE="${3:-Todo Web App}"
PRIORITY="${4:-medium}"
DUE="${5:-$(date +%F)}"

SAFE_TASK="$(echo "$TASK_TITLE" | sed 's/[[:space:]]\+/-/g' | tr '[:upper:]' '[:lower:]')"
FILE="$VAULT_DIR/02 - Tasks/${SAFE_TASK}.md"
FOCUS_LINK="[[${FOCUS_TITLE}]]"

mkdir -p "$VAULT_DIR/02 - Tasks"

cat > "$FILE" <<EOF
---
type: task
status: todo
priority: $PRIORITY
due: $DUE
focus: ${FOCUS_LINK}
distraction: false
tags: [task]
---

# ${TASK_TITLE}

Linked focus: ${FOCUS_LINK}

## 💬 Description
- 

## ✅ Checklist
- [ ] 

---
Backlinks: [[04 - Daily Focus/$(date +%F) — ${FOCUS_TITLE}]]
EOF

echo "✅ Task created: $FILE"
