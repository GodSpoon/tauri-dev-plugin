---
name: tauri-add-plugin
description: Add and configure an official Tauri plugin with proper capabilities
---

# /tauri-add-plugin

Add an official Tauri plugin to the current project with Rust deps, JS API, and capability permissions.

## Usage

```
/tauri-add-plugin [plugin-name]
```

## Supported Plugins

| Plugin | Purpose |
|--------|---------|
| shell | Execute commands, sidecars |
| fs | File system ops |
| dialog | Native dialogs |
| notification | System notifications |
| clipboard | Clipboard access |
| global-shortcut | Hotkeys |
| http | HTTP requests |
| store | Key-value storage |
| updater | Auto-update |
| window-state | Persist window geometry |
| single-instance | Prevent multiple instances |
| process | Process management |
| os | OS info |
| devtools | DevTools (debug only) |

## Steps

1. Add Rust dependency: `cd src-tauri && cargo add tauri-plugin-{name}`
2. Register plugin in `src-tauri/src/main.rs`
3. Add permissions to `src-tauri/capabilities/default.toml`
4. Import JS API in frontend if needed

## Example

```bash
/tauri-add-plugin shell
```

This will:
- Run `cargo add tauri-plugin-shell`
- Add `.plugin(tauri_plugin_shell::init())` to main.rs
- Add `"shell:allow-open"` to capabilities
