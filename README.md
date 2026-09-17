# Obsidian Cheatsheet — Omarchy bar plugin

Quick-view dropdown for Obsidian shortcuts + Markdown formatting,
sourced from https://sheetly.org/cheatsheets/obsidian.

## Contents
- `manifest.json` — plugin metadata (`local.obsidian-cheatsheet`)
- `Panel.qml` — bar widget + searchable dropdown
- `cheatsheet.js` — shortcut / formatting data (Linux `Ctrl` bindings)

Features:
- Bar icon `◈` with dropdown
- Search filter across keys + descriptions
- Category tabs: All / Shortcuts / Formatting / Links
- Keyboard: ↑↓ navigate, Enter copy, Esc close
- Click/Enter copies the left-column key/syntax via `wl-copy` (falls back to `xclip`)

## Install
```bash
omarchy plugin add https://github.com/Greisyn/obsidian-cheatsheet.git --enable
```

Manual install:
```bash
mkdir -p ~/.config/omarchy/plugins/local.obsidian-cheatsheet
cp manifest.json Panel.qml cheatsheet.js ~/.config/omarchy/plugins/local.obsidian-cheatsheet/
# then enable in Omarchy menu → Style / bar settings, or add to shell.json:
# { "id": "local.obsidian-cheatsheet" }
omarchy menu refresh
```

Requires `wl-copy` (wl-clipboard) or `xclip` for copy-to-clipboard.

## Uninstall
```bash
omarchy plugin remove local.obsidian-cheatsheet
```

## Placement (left / center / right)

This is a standard `bar-widget` — it can already live in any bar section.
Placement is controlled by the shell, no plugin code change needed
(`defaultSection: center` in `manifest.json` is just the default).

```bash
omarchy plugin enable local.obsidian-cheatsheet --section left
omarchy plugin enable local.obsidian-cheatsheet --section center
omarchy plugin enable local.obsidian-cheatsheet --section right

# or move an already-enabled widget:
omarchy bar move local.obsidian-cheatsheet --section left
omarchy bar move local.obsidian-cheatsheet --section center
omarchy bar move local.obsidian-cheatsheet --section right
```
