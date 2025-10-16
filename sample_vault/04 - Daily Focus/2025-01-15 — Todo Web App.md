---
type: focus
date: 2025-01-15
focus: [[Todo Web App]]
---

# 2025-01-15 — Focus: Todo Web App

## 🎯 Main Focus
[[Todo Web App]]

## ✅ Tasks (Linked to Focus)
```dataview
TABLE file.link AS Task, due
FROM "02 - Tasks"
WHERE regexreplace(string(default(focus, "")), "\\[|\\]", "") = regexreplace(string(default(this.focus, "")), "\\[|\\]", "")
  AND default(distraction, false) = false
  AND status != "done"
SORT due ASC
```

## ⚡ Distractions (standalone)
```dataview
TABLE file.link AS Distraction,
      choice(date(due) and dateformat(date(due), "yyyy-MM-dd") = dateformat(date(today), "yyyy-MM-dd"),
             choice(dateformat(date(due), "HH:mm") != "00:00",
                    dateformat(date(due), "HH:mm"),
                    dateformat(file.ctime, "HH:mm")),
             choice(date(due),
                    dateformat(date(due), "yyyy-MM-dd"),
                    "")) AS Due
FROM "02 - Tasks"
WHERE default(distraction, false) = true
  AND status != "done"
SORT date(due) ASC
```

## 🧠 Notes
- UI flow feels tight after morning sketching session.
- Need confirmation from backend on auth flow before wiring forms.
- Remember to commit after CI workflow passes.
