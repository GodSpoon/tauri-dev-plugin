---
name: Tauri Agent Development
description: Comprehensive toolkit for developing Tauri v2 desktop applications. Covers project scaffolding, template selection, Rust-frontend integration patterns, security capabilities, plugin system, sidecar architecture, type-safe bindings with tauri-specta, and distribution. Use when the user needs to create, develop, debug, or maintain Tauri v2 desktop apps; when setting up a new Tauri project; when integrating Rust backend with JavaScript/TypeScript frontend; when adding plugins, commands, events, or sidecars; when configuring security permissions or building for distribution. Triggers for keywords - Tauri, Tauri v2, desktop app, Rust desktop, tauri.conf.json, cargo tauri, invoke command, Tauri plugin, Tauri sidecar, CrabNebula, create-tauri-app.
version: 1.0.0
---

# Tauri Agent Development

Complete toolkit for building production-grade Tauri v2 applications using an AI agent workflow.

## The 3 Core Tools

| # | Tool | Role | Install |
|---|------|------|---------|
| 1 | **Oh-My-Pi** | Agent harness - 32 tools for file ops, LSP, search, bash, browser, debug | `git clone https://github.com/oh-my-pi/oh-my-pi.git && cd oh-my-pi && cargo build --release` |
| 2 | **Kimi Backend** (K2.5/K2.6) | Reasoning engine - 256K context, agent swarm, tool calling | `export KIMI_API_KEY="sk-..."` + `oh-my-pi config set provider kimi` |
| 3 | **Tauri DevTools** | Runtime visibility - command tracing, event inspection, logging | `cargo add tauri-plugin-devtools` (debug builds only) |

Detailed tool setup: [references/tools.md](references/tools.md)

## Quick Scaffold

```bash
# Official scaffold (interactive)
npm create tauri-app@latest

# Or non-interactive with specific template
npm create tauri-app@latest my-app -- --template react-ts
```

## Bundled Templates (via Git Submodules)

These templates are included as git submodules in this plugin:

| Template | Local Path | Stack |
|----------|-----------|-------|
| **dannysmith/tauri-template** | `${CLAUDE_PLUGIN_ROOT}/vendor/tauri-template` | Tauri v2 + React 19 + TS + shadcn/ui v4 + Tailwind v4 + tauri-specta + multi-window |
| **alysonhower/tauri2-svelte5-shadcn** | `${CLAUDE_PLUGIN_ROOT}/vendor/tauri-svelte-template` | Tauri 2.0 + Svelte 5 + shadcn-svelte + Tailwind 4 |
| **tauri-apps/awesome-tauri** | `${CLAUDE_PLUGIN_ROOT}/vendor/awesome-tauri` | Curated community templates & resources |
| **tauri-apps/plugins-workspace** | `${CLAUDE_PLUGIN_ROOT}/vendor/plugins-workspace` | Official Tauri plugins source |

To use a bundled template:
```bash
cp -r ${CLAUDE_PLUGIN_ROOT}/vendor/tauri-template ./my-app
cd my-app && npm install && npm run tauri dev
```

Template catalog and selection guide: [references/templates.md](references/templates.md)

## Core Development Workflow

### 1. Project Structure

```
src-tauri/
  src/main.rs          # Entry point - register plugins, commands, events
  src/commands.rs      # Tauri commands (Rust functions exposed to frontend)
  src/lib.rs           # Shared Rust code, state types
  capabilities/*.toml  # Security permission definitions
  Cargo.toml           # Rust dependencies + plugin declarations
  tauri.conf.json      # App config, bundle settings, externalBin
src/                   # Frontend code (React/Vue/Svelte)
```

### 2. Add a Command (Rust -> Frontend)

```rust
// src-tauri/src/commands.rs
#[tauri::command]
pub async fn greet(name: String) -> Result<String, String> {
    Ok(format!("Hello, {name}!"))
}
```

```rust
// src-tauri/src/main.rs
.invoke_handler(tauri::generate_handler![
    commands::greet,
])
```

```typescript
// Frontend
import { invoke } from '@tauri-apps/api/core';
const msg = await invoke<string>('greet', { name: 'World' });
```

### 3. Add a Plugin

```bash
cd src-tauri
cargo add tauri-plugin-shell tauri-plugin-dialog tauri-plugin-fs
```

```rust
// main.rs - register
.plugin(tauri_plugin_shell::init())
.plugin(tauri_plugin_dialog::init())
.plugin(tauri_plugin_fs::init())
```

```toml
# capabilities/default.toml - grant permissions
permissions = [
  "core:default",
  "shell:allow-open",
  "dialog:allow-open",
  "fs:allow-read",
  "fs:allow-write",
]
```

### 4. Type Safety with tauri-specta

```bash
cargo add specta tauri-specta
```

```rust
use specta::Type;

#[derive(Type, serde::Serialize)]
pub struct ApiResponse { pub data: String }

#[tauri::command]
#[specta::specta]
fn fetch_data() -> ApiResponse { ... }
```

Generate TypeScript bindings automatically. See tauri-core reference for full setup.

### 5. Security First - Capabilities

Always use scoped permissions:
```toml
permissions = [
  "fs:allow-read",
]

[[permission]]
identifier = "fs:scope"
allow = [{ path = "$HOME/.myapp/*" }]
```

Never disable security. Validate all command inputs.

## Reference Materials

| File | When to Read |
|------|-------------|
| [references/tools.md](references/tools.md) | Setting up Oh-My-Pi, Kimi, or DevTools |
| [references/templates.md](references/templates.md) | Choosing a project template |
| [references/tauri-core.md](references/tauri-core.md) | Detailed patterns - commands, events, state, plugins, security, sidecars, error handling, build commands |

## Common Commands

| Task | Command |
|------|---------|
| Dev server | `npm run tauri dev` |
| Release build | `npm run tauri build` |
| Check Rust | `cargo check` |
| Lint Rust | `cargo clippy` |
| Add plugin | `cargo add tauri-plugin-PLUGINNAME` |
| Update deps | `cargo update && npm update` |

## Official Resources

- **Docs:** https://v2.tauri.app/
- **JS API:** https://v2.tauri.app/reference/javascript/
- **Rust API:** https://docs.rs/tauri/
- **Plugins:** https://github.com/tauri-apps/plugins-workspace/tree/v2
- **Awesome Tauri:** https://github.com/tauri-apps/awesome-tauri
- **DevTools:** https://crabnebula.dev/devtools
- **Security:** https://v2.tauri.app/concept/security/
