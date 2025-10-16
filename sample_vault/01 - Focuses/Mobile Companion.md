---
type: focus
status: paused
created: 2025-01-12
---

# Mobile Companion

## 🎯 Description
Future expansion: lightweight iOS/Android client that syncs with the web app.

## 🔗 Related Canvases
- [[03 - Canvases/main-focus-with-focus-tasks.canvas]]

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
- Research offline-first storage options
- Collect native UI inspiration shots
- Wait to reactivate until web app ships
