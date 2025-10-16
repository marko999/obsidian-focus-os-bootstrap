---
type: dashboard
---

# 🧭 Focus Dashboard

## 🌅 Today’s Focus
```dataview
LIST FROM "04 - Daily Focus"
WHERE date = date(today)
```

## 🔥 Active Focuses
```dataview
TABLE file.link AS Focus, status
FROM "01 - Focuses"
WHERE status = "active"
```

## ⏰ Pending Tasks (by focus)
```dataview
TABLE choice(
        contains(string(default(focus, "")), "[["),
        focus,
        link(
          "01 - Focuses/" + regexreplace(string(default(focus, "")), "\\[|\\]", ""),
          regexreplace(string(default(focus, "")), "\\[|\\]", "")
        )
      ) AS Focus,
      file.link AS Task,
      due
FROM "02 - Tasks"
WHERE default(distraction, false) = false
  AND status != "done"
  AND regexreplace(string(default(focus, "")), "\\[|\\]", "") != ""
SORT Focus ASC, due ASC
```

## 💡 Distractions Queue (standalone)
```dataview
TABLE file.link AS Task,
      choice(date(due),
             dateformat(date(due), "yyyy-MM-dd HH:mm"),
             choice(string(due) != "",
                    string(due),
                    "")) AS Due
FROM "02 - Tasks"
WHERE default(distraction, false) = true
  AND status != "done"
  AND !focus
SORT date(due) ASC, string(due) ASC, file.ctime ASC
```
