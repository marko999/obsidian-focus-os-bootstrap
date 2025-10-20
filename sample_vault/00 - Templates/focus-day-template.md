<%*
const isoDate = tp.date.now("YYYY-MM-DD");
const focusFolderPath = "01 - Focuses";
const focusDayFolderPath = "04 - Daily Focus";

const sanitize = (value) =>
  value
    .replace(/[\\/:|?*"<>\n\r]/g, " ")
    .replace(/\s+/g, " ")
    .trim();

let focusOptions = [];
const focusFolder = app.vault.getAbstractFileByPath(focusFolderPath);
if (focusFolder && focusFolder.children) {
  focusOptions = focusFolder.children
    .filter(child => child.extension === "md")
    .map(child => child.basename)
    .sort((a, b) => a.localeCompare(b));
}

let selectedFocus = null;
if (focusOptions.length) {
  selectedFocus = await tp.system.suggester(
    focusOptions,
    focusOptions,
    false,
    "Select today's focus"
  );
}
if (!selectedFocus) {
  selectedFocus = await tp.system.prompt("Focus name for today", {
    defaultValue: focusOptions[0] || "Primary Focus"
  });
}
if (!selectedFocus) {
  selectedFocus = focusOptions[0] || "Primary Focus";
}

const safeFocus = sanitize(selectedFocus);
let targetBase = `${isoDate} — ${safeFocus || "Focus"}`;
const exists = (path) => app.vault.getAbstractFileByPath(path);
let counter = 2;
while (exists(`${focusDayFolderPath}/${targetBase}.md`)) {
  targetBase = `${isoDate} — ${safeFocus || "Focus"} (${counter})`;
  counter += 1;
}

await tp.file.rename(targetBase);
await tp.file.move(`${focusDayFolderPath}/${targetBase}.md`);

const focusLink = `[[${selectedFocus}]]`;

const lines = [
  '---',
  'type: focus',
  `date: ${isoDate}`,
  `focus: ${focusLink}`,
  '---',
  '',
  `# ${isoDate} — Focus: ${selectedFocus}`,
  '',
  '## 🎯 Main Focus',
  `${focusLink}`,
  '',
  '## ✅ Tasks (Linked to Focus)',
  '```dataview',
  'TABLE file.link AS Task, due',
  'FROM "02 - Tasks"',
  'WHERE regexreplace(string(default(focus, "")), "\\\\[|\\\\]", "") = regexreplace(string(default(this.focus, "")), "\\\\[|\\\\]", "")',
  '  AND dateformat(date(due), "yyyy-MM-dd") = dateformat(date(this.date), "yyyy-MM-dd")',
  '  AND default(distraction, false) = false',
  '  AND status != "done"',
  'SORT due ASC',
  '```',
  '',
  '## ⚡ Distractions (standalone)',
  '```dataview',
  'TABLE file.link AS Distraction,',
  '      choice(date(due) and dateformat(date(due), "yyyy-MM-dd") = dateformat(date(today), "yyyy-MM-dd"),',
  '             choice(dateformat(date(due), "HH:mm") != "00:00",',
  '                    dateformat(date(due), "HH:mm"),',
  '                    dateformat(file.ctime, "HH:mm")),',
  '             choice(date(due),',
  '                    dateformat(date(due), "yyyy-MM-dd"),',
  '                    "")) AS Due',
  'FROM "02 - Tasks"',
  'WHERE default(distraction, false) = true',
  '  AND status != "done"',
  'SORT date(due) ASC',
  '```',
  '',
  '## 🧠 Notes',
  '- '
];

tR += lines.join('\n') + '\n';
-%>
