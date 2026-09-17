// Data sourced from https://sheetly.org/cheatsheets/obsidian
// Linux-first keybindings (Ctrl-based). Each item: { k, d, cat }
var items = [
  // ---- Essential shortcuts ----
  { cat: "Shortcuts", k: "Ctrl + N", d: "Create new note" },
  { cat: "Shortcuts", k: "Ctrl + O", d: "Quick switcher (open file)" },
  { cat: "Shortcuts", k: "Ctrl + P", d: "Command palette" },
  { cat: "Shortcuts", k: "Ctrl + E", d: "Toggle edit / preview mode" },
  { cat: "Shortcuts", k: "Ctrl + G", d: "Open graph view" },
  { cat: "Shortcuts", k: "Ctrl + Shift + F", d: "Search in all files" },
  { cat: "Shortcuts", k: "Ctrl + F", d: "Search in current file" },
  { cat: "Shortcuts", k: "Ctrl + Shift + E", d: "Open file explorer" },
  { cat: "Shortcuts", k: "Ctrl + Alt + ←/→", d: "Navigate back / forward" },
  { cat: "Shortcuts", k: "Ctrl + Click", d: "Open link in new pane" },
  { cat: "Shortcuts", k: "Ctrl + K", d: "Insert link" },
  { cat: "Shortcuts", k: "Ctrl + ]", d: "Indent" },
  { cat: "Shortcuts", k: "Ctrl + [", d: "Unindent" },
  { cat: "Shortcuts", k: "Ctrl + D", d: "Delete current line" },
  { cat: "Shortcuts", k: "Ctrl + B", d: "Bold text" },
  { cat: "Shortcuts", k: "Ctrl + I", d: "Italic text" },
  { cat: "Shortcuts", k: "Ctrl + H", d: "Find and replace" },
  { cat: "Shortcuts", k: "Ctrl + ,", d: "Open settings" },
  { cat: "Shortcuts", k: "Ctrl + T", d: "Open new tab" },
  { cat: "Shortcuts", k: "Ctrl + W", d: "Close current tab" },
  { cat: "Shortcuts", k: "Ctrl + Tab", d: "Switch to next tab" },
  { cat: "Shortcuts", k: "Ctrl + Shift + Tab", d: "Switch to previous tab" },
  { cat: "Shortcuts", k: "Ctrl + Enter", d: "Toggle checkbox" },
  { cat: "Shortcuts", k: "Alt + ↑/↓", d: "Move line up / down" },
  { cat: "Shortcuts", k: "Ctrl + Home", d: "Go to top of file" },
  { cat: "Shortcuts", k: "Ctrl + End", d: "Go to bottom of file" },

  // ---- Markdown / formatting ----
  { cat: "Formatting", k: "# H1 / ## H2 / ### H3", d: "Headings" },
  { cat: "Formatting", k: "**bold**", d: "Bold" },
  { cat: "Formatting", k: "*italic*", d: "Italic" },
  { cat: "Formatting", k: "==highlight==", d: "Highlight" },
  { cat: "Formatting", k: "~~struck~~", d: "Strikethrough" },
  { cat: "Formatting", k: "`code`", d: "Inline code" },
  { cat: "Formatting", k: "``` block ```", d: "Code block (```lang … ```)" },
  { cat: "Formatting", k: "> quote", d: "Blockquote" },
  { cat: "Formatting", k: "---", d: "Horizontal rule" },
  { cat: "Formatting", k: "- item", d: "Bullet list" },
  { cat: "Formatting", k: "1. item", d: "Numbered list" },
  { cat: "Formatting", k: "- [ ] task", d: "Checkbox (unchecked)" },
  { cat: "Formatting", k: "- [x] done", d: "Checkbox (checked)" },
  { cat: "Formatting", k: "| a | b |", d: "Table: | col | col | + | --- | --- | row" },
  { cat: "Formatting", k: "![[img.png]]", d: "Embed image" },
  { cat: "Formatting", k: "![[Note]]", d: "Embed note" },

  // ---- Links / tags ----
  { cat: "Links", k: "[[Note]]", d: "Internal link" },
  { cat: "Links", k: "[[Note|Alias]]", d: "Link with custom text" },
  { cat: "Links", k: "[text](url)", d: "External link" },
  { cat: "Links", k: "[[Note#Heading]]", d: "Link to heading" },
  { cat: "Links", k: "[[Note#^block]]", d: "Link to block (^blockid)" },
  { cat: "Links", k: "#tag / #proj/work", d: "Tag (hierarchical with /)" },
  { cat: "Links", k: "aliases: [PKM, …]", d: "YAML aliases (frontmatter)" },
  { cat: "Links", k: "tags: [a, b]", d: "YAML tags (frontmatter)" }
];

var categories = ["All", "Shortcuts", "Formatting", "Links"];

function filtered(query, cat) {
  var q = (query || "").trim().toLowerCase();
  var out = [];
  for (var i = 0; i < items.length; ++i) {
    var it = items[i];
    if (cat && cat !== "All" && it.cat !== cat) continue;
    if (q !== "" && it.k.toLowerCase().indexOf(q) < 0 && it.d.toLowerCase().indexOf(q) < 0) continue;
    out.push(it);
  }
  return out;
}
