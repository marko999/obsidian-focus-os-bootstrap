# Obsidian Focus OS (v1.0.1)

Focus-centered productivity vault for Obsidian where **Tasks belong to focuses** and **Distractions are standalone**.

## What’s new
- `focus: [[...]]` required for real tasks
- `distraction: true/false` switch in task frontmatter
- Dashboard and templates use **mutually exclusive** queries (no duplicates)
- Updated scripts: `new_task.sh`, plus new `new_distraction.sh`

## Quick start
1. Open Obsidian → **Open folder as vault** → this folder.
2. Enable community plugins: Templater, Dataview, Tasks, Calendar, Periodic Notes.
3. Optional: copy into `~/FocusVault` with:
   ```bash
   ./scripts/setup_focusvault.sh
   ```

## Helpers
```bash
# focus task
./scripts/new_task.sh ~/FocusVault "Clarify milestone" "Focus One" high 2025-01-20

# distraction
./scripts/new_distraction.sh ~/FocusVault "Movement break" 2025-01-20
```
