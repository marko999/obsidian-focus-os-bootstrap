---
type: focus
status: active
created: 2025-01-10
---

# Todo Web App

## 🎯 Description
Ship a polished personal task manager on the web, covering capture, scheduling, and review flows end to end.

## 🔗 Related Canvases
- [[03 - Canvases/main-focus-with-focus-tasks.canvas]]
- [[03 - Canvases/main-focus-with-distractions.canvas]]

## ✅ Active Tasks
```dataview
TABLE file.link as Task, status, due
FROM "02 - Tasks"
WHERE regexreplace(string(default(focus, "")), "\\[|\\]", "") = this.file.name
  AND default(distraction, false) = false
  AND status != "done"
SORT due ASC
```

## 🧠 Ideas & Notes
- Explore keyboard-first command palette
- Evaluate sync strategy (Supabase vs. local-first)
- Draft onboarding checklist for first-launch experience
