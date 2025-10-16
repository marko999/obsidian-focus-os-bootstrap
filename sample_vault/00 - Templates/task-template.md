<%*
const tasksFolderPath = "02 - Tasks";
const focusFolderPath = "01 - Focuses";
const isoToday = tp.date.now("YYYY-MM-DD");

const sanitize = (value) =>
  value
    .replace(/[\\/:|?*"<>\n\r]/g, " ")
    .replace(/\s+/g, " ")
    .trim();

let taskTitle = await tp.system.prompt("Task title", { defaultValue: "New Task" });
if (!taskTitle || !taskTitle.trim()) {
  taskTitle = "New Task";
}
taskTitle = taskTitle.trim();

const baseSlug = taskTitle
  .toLowerCase()
  .replace(/[^a-z0-9\s-]/g, "")
  .trim()
  .replace(/\s+/g, "-")
  || "task";
let targetSlug = baseSlug;
let slugCounter = 2;
while (app.vault.getAbstractFileByPath(`${tasksFolderPath}/${targetSlug}.md`)) {
  targetSlug = `${baseSlug}-${slugCounter}`;
  slugCounter += 1;
}

await tp.file.rename(targetSlug);
await tp.file.move(`${tasksFolderPath}/${targetSlug}.md`);

const focusFolder = app.vault.getAbstractFileByPath(focusFolderPath);
let focusOptions = [];
if (focusFolder && focusFolder.children) {
  focusOptions = focusFolder.children
    .filter(child => child.extension === "md")
    .map(child => child.basename)
    .sort((a, b) => a.localeCompare(b));
}

let focusName = focusOptions.length
  ? await tp.system.suggester(focusOptions, focusOptions, false, "Attach to which focus?")
  : null;

if (!focusName) {
  focusName = await tp.system.prompt("Focus name (must match note title)", {
    defaultValue: focusOptions[0] || "Primary Focus"
  });
}
if (!focusName || !focusName.trim()) {
  focusName = focusOptions[0] || "Primary Focus";
}
focusName = focusName.trim();

const priorityOptions = ["high", "medium", "low"];
let priority = await tp.system.suggester(
  priorityOptions.map(p => p.charAt(0).toUpperCase() + p.slice(1)),
  priorityOptions,
  false,
  "Priority?"
);
if (!priority) {
  priority = "medium";
}

let dueInput = await tp.system.prompt("Due date (YYYY-MM-DD)", { defaultValue: isoToday });
dueInput = (dueInput ?? "").toString().trim();
if (!dueInput) {
  dueInput = isoToday;
}

const linkFocus = `[[${focusName}]]`;
const safeFocus = sanitize(focusName) || "Focus";
const dailyBase = `${isoToday} — ${safeFocus}`;
const displayDaily = `${isoToday} — ${focusName}`;
const dailyLink = `[[04 - Daily Focus/${dailyBase}|${displayDaily}]]`;

const lines = [
  '---',
  'type: task',
  'status: todo',
  `priority: ${priority}`,
  `due: ${dueInput}`,
  `focus: ${linkFocus}`,
  'distraction: false',
  'tags: [task]',
  '---',
  '',
  `# ${taskTitle}`,
  '',
  `Linked focus: ${linkFocus}`,
  '',
  '## 💬 Description',
  '- ',
  '',
  '## ✅ Checklist',
  '- [ ] ',
  '',
  '---',
  `Backlinks: ${dailyLink}`
];

tR += lines.join('\n') + '\n';
-%>
