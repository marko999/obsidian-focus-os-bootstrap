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
The sample content walks through building a **Todo Web App**. Peek at:
- `01 - Focuses/Todo Web App.md` for the project brief.
- `02 - Tasks/` for concrete steps (UI, backend, CI pipeline).
- `04 - Daily Focus/2025-01-15 — Todo Web App.md` to see a logged workday and distraction capture.

```bash
# focus task (run from repo root)
./scripts/new_task.sh sample_vault "Implement recurring tasks" "Todo Web App" high 2025-01-22

# distraction (run from repo root)
./scripts/new_distraction.sh sample_vault "Deep-dive new framework" 2025-01-22
```
