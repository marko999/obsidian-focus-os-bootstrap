<%*
const tasksFolderPath = "02 - Tasks";
const dailyFolderPath = "04 - Daily Focus";
const isoToday = tp.date.now("YYYY-MM-DD");

const sanitize = (value) =>
  value
    .replace(/[\\/:|?*"<>\n\r]/g, " ")
    .replace(/\s+/g, " ")
    .trim();

let distractionTitle = await tp.system.prompt("Distraction title", { defaultValue: "New Distraction" });
if (!distractionTitle || !distractionTitle.trim()) {
  distractionTitle = "New Distraction";
}
distractionTitle = distractionTitle.trim();

const baseSlug = distractionTitle
  .toLowerCase()
  .replace(/[^a-z0-9\s-]/g, "")
  .trim()
  .replace(/\s+/g, "-")
  || "distraction";
let targetSlug = baseSlug;
let slugCounter = 2;
while (app.vault.getAbstractFileByPath(`${tasksFolderPath}/${targetSlug}.md`)) {
  targetSlug = `${baseSlug}-${slugCounter}`;
  slugCounter += 1;
}

await tp.file.rename(targetSlug);
await tp.file.move(`${tasksFolderPath}/${targetSlug}.md`);

let dueInput = await tp.system.prompt("Due (optional — YYYY-MM-DD or HH:MM)", { defaultValue: "" });
dueInput = (dueInput ?? "").toString().trim();

const dailyFolder = app.vault.getAbstractFileByPath(dailyFolderPath);
let dailyLink = "";
if (dailyFolder && dailyFolder.children) {
  const todayNote = dailyFolder.children
    .filter(child => child.extension === "md")
    .find(child => child.basename.startsWith(`${isoToday} — ${sanitize(distractionTitle)}`) || child.basename.startsWith(isoToday));
  if (todayNote) {
    dailyLink = `[[${dailyFolderPath}/${todayNote.basename}]]`;
  }
}

const dueLine = dueInput ? `due: ${dueInput}` : null;
const backlinksBlock = dailyLink ? `Backlinks: ${dailyLink}` : '';

const lines = [
  '---',
  'type: task',
  'status: todo',
  'priority: low',
];
if (dueLine) {
  lines.push(dueLine);
}
lines.push('distraction: true');
lines.push('tags: [distraction, task]');
lines.push('---');
lines.push('');
lines.push(`# ${distractionTitle}`);
lines.push('');
lines.push('## 💬 Description');
lines.push('- ');
lines.push('');
lines.push('---');
if (backlinksBlock) {
  lines.push(backlinksBlock);
}

tR += lines.join('\n') + '\n';
-%>
