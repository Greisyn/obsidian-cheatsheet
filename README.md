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
mkdir -p ~/.config/omarchy/plugins/local.obsidian-cheatsheet
cp manifest.json Panel.qml cheatsheet.js ~/.config/omarchy/plugins/local.obsidian-cheatsheet/
# then enable in Omarchy menu → Style / bar settings, or add to shell.json:
# { "id": "local.obsidian-cheatsheet" }
omarchy menu refresh
```

Requires `wl-copy` (wl-clipboard) or `xclip` for copy-to-clipboard.
