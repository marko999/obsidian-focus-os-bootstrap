# FocusVault Usage Guide

This note explains how the Focus OS vault is meant to run day to day. Start with the sample vault that ships in `sample_vault/`, then adapt the workflow to your own workspace.

## 0. Prerequisites & Setup
- Install Obsidian (desktop) and enable the following core/community plugins: Dataview, Tasks, Templater, Calendar, Periodic Notes (core Command Palette and Quick Switcher stay on).
- From the repo root you can spin up a working copy with `./scripts/setup_focusvault.sh ~/FocusVault` or manually copy `sample_vault/` into your vault directory.
- Open the target directory in Obsidian (`Cmd+O` → “Open folder as vault”).
- Default hotkeys match VS Code muscle memory: `Cmd+Shift+P` opens the Command Palette and `Cmd+P` opens the Quick Switcher (configured in `.obsidian/hotkeys.json`). Adjust in *Settings → Hotkeys* if you prefer something else.
- After pulling updates, run **Templater → Reload templates** so the new “create note” commands below show up in the palette.
- Core actions (daily log, focus, task, distraction) live under *Templater: Create new note from template* for true one-command workflows.

## 1. Folder & Note Types
- `dashboard.md` — your always-on overview: today’s focus, all active focuses, pending tasks grouped by focus, and the distraction queue.
- `00 - Templates/` — Templater starters for Focus notes, Tasks, Daily Focus logs, and the dashboard.
- `01 - Focuses/` — one note per long-running initiative. Each focus auto-lists its active tasks via Dataview.
- `02 - Tasks/` — atomic work items. “Real” tasks include a `focus:` field linking back to a Focus; distractions skip that field and flip `distraction: true`.
- `03 - Canvases/` — optional spatial boards for planning. Template links live in the Focus note.
- `04 - Daily Focus/` — daily logs centered on a single focus. They surface tasks tied to that focus plus any distractions you’ve captured.

### Required Frontmatter Fields
- Focus note: `type: focus`, `status: active|paused|done` (only *active* ones surface), `created:` ISO date.
- Task: `type: task`, `status: todo|scheduled|done`, `priority: low|medium|high`, `due:` ISO date, `focus: [[Focus Name]]` (omit for distractions), `distraction: true|false`, `tags: [...]` with plain tag names (no leading `#`).
- Daily focus: `type: focus`, `date: YYYY-MM-DD`, `focus: [[Focus Name]]`.

The Dataview queries strip `[[` `]]` automatically, so either wiki links or plain strings in `focus:` work—as long as the names match the focus note.

## 2. Core Workflow
1. **Pick (or create) the current focus.** Use `Cmd+P` to jump to `01 - Focuses/`. Fire `Cmd+Shift+P` → *Templater: Create new note from template* → *Focus* for a fresh initiative (the template asks for the name, status, and description, then files it automatically).
2. **Capture tasks and distractions.**
   - One-command capture: `Cmd+Shift+P` → *Templater: Create new note from template* → *Task*. The template prompts for the title, focus, due date, and priority, then drops the note into `02 - Tasks/`.
   - Standalone distractions: `Cmd+Shift+P` → *Templater: Create new note from template* → *Distraction*. It asks for title/due, marks `distraction: true`, and saves beside the other tasks.
   - CLI helpers still work if you prefer the terminal (`./scripts/new_task.sh` / `./scripts/new_distraction.sh`).
3. **Spin up today’s log.** Hit `Cmd+Shift+P` → *Templater: Create new note from template* → *Focus Day*. The template now asks you to pick (or type) the focus, then auto-renames the note to `YYYY-MM-DD — <Focus>` and files it under `04 - Daily Focus/`. The Dataview block pulls all unfinished tasks for that focus.
4. **Work the list.** Check items off in-place or update the task file (`status: done`) as you complete work. Dataview hides finished items automatically after a refresh.
5. **Park distractions.** When something off-focus appears, capture it quickly with the script or template (set `distraction: true`). They show up on the dashboard and the daily log but never pollute the focus task list.
6. **Wrap up.** Jot end-of-day notes in the daily log, optionally review the dashboard, and promote or archive focuses as you finish them.

Tip: Dataview sometimes needs a manual refresh (`Cmd+Shift+R` or toggle preview ↔ edit) after you edit frontmatter.

## 3. Dashboard & Reviews
- **Dashboard (`dashboard.md`)** — pin this as a starred note. It shows:
  - Today’s daily focus entry (if the note exists and its `date` matches `today`).
  - All focuses where `status: active`.
  - Pending tasks grouped by focus. The table auto-links to the focus note if you used a wiki link in the task, or it falls back to a plain link built from the focus name.
  - Distraction queue ordered by due date/time (pulls from tasks missing a `focus:` field).
- **Weekly sweep** — duplicate the Focus template for upcoming priorities, close any finished focuses by setting `status: done`, and archive or delete distractions you’ll never use.

## 4. Helper Scripts & Automation
- `scripts/new_task.sh` — CLI helper for real tasks. Arguments: vault path, task title, focus title, priority, due date.
- `scripts/new_distraction.sh` — CLI helper for quick distraction capture (`distraction: true`, no focus link).
- `scripts/setup_focusvault.sh` — clones the repo’s contents into a writable vault directory (`~/FocusVault` by default). Handy when you’re ready to use this outside the sample folder.

Pair the scripts with shell aliases (e.g., `alias ftask='./scripts/new_task.sh ~/FocusVault'`) for brain-off capture.

## 5. Customisation Checklist
- Update the templates with your own default focus name, tags, or additional fields (e.g., `effort:`) as needed.
- Add or remove columns in the Dataview tables—`due`, `priority`, and `status` are already available in frontmatter.
- Adjust `.obsidian/hotkeys.json` or Obsidian’s Settings to fit your keyboard workflow.
- Keep tag lists clean (`tags: [task, focus]` rather than `#task`). The vault avoids leading hash symbols so Dataview can parse arrays cleanly.

---
Test drive the sample files (`sample_vault/`) to get a feel for the flows. Once everything matches your mental model, copy it into your real vault and start logging a live day. Let me know where friction shows up so we can tighten the templates further.👏
