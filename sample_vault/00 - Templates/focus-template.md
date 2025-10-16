<%*
const focusFolderPath = "01 - Focuses";
const isoDate = tp.date.now("YYYY-MM-DD");

const sanitize = (value) =>
  value
    .replace(/[\\/:|?*"<>\n\r]/g, " ")
    .replace(/\s+/g, " ")
    .trim();

let focusTitle = await tp.system.prompt("Focus title", { defaultValue: "New Focus" });
if (!focusTitle || !focusTitle.trim()) {
  focusTitle = "New Focus";
}
focusTitle = focusTitle.trim();

const safeTitle = sanitize(focusTitle) || "New Focus";
let targetBase = safeTitle;
const exists = (path) => app.vault.getAbstractFileByPath(path);
let counter = 2;
while (exists(`${focusFolderPath}/${targetBase}.md`)) {
  targetBase = `${safeTitle} (${counter})`;
  counter += 1;
}

await tp.file.rename(targetBase);
await tp.file.move(`${focusFolderPath}/${targetBase}.md`);

const statusOptions = ["active", "paused", "done"];
let status = await tp.system.suggester(
  statusOptions.map(s => s.charAt(0).toUpperCase() + s.slice(1)),
  statusOptions,
  false,
  "Initial status"
);
if (!status) {
  status = "active";
}

let description = await tp.system.prompt("Short description (optional)");
description = description && description.trim() ? description.trim() : "Summarize what this focus is about and the primary outcome you want.";

const lines = [
  '---',
  'type: focus',
  `status: ${status}`,
  `created: ${isoDate}`,
  '---',
  '',
  `# ${focusTitle}`,
  '',
  '## 🎯 Description',
  `${description}`,
  '',
  '## 🔗 Related Canvases',
  '- [[03 - Canvases/main-focus-with-focus-tasks.canvas]]',
  '- [[03 - Canvases/main-focus-with-distractions.canvas]]',
  '',
  '## ✅ Active Tasks',
  '```dataview',
  'TABLE file.link as Task, status, due',
  'FROM "02 - Tasks"',
  'WHERE regexreplace(string(default(focus, "")), "\\\\[|\\\\]", "") = this.file.name',
  '  AND default(distraction, false) = false',
  '  AND status != "done"',
  'SORT due ASC',
  '```',
  '',
  '## 🧠 Ideas & Notes',
  '- idea 1',
  '- idea 2'
];

tR += lines.join('\n') + '\n';
-%>
