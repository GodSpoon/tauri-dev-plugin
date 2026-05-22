# Tauri v2 Core Knowledge

## Project Structure

```
tauri-app/
├── src/                    # Frontend (React/Vue/Svelte)
├── src-tauri/
│   ├── src/main.rs        # Rust entry
│   ├── src/lib.rs         # Shared Rust code
│   ├── src/commands.rs    # Tauri commands
│   ├── capabilities/      # Permission definitions (.toml)
│   ├── Cargo.toml         # Rust deps
│   ├── build.rs           # Build script
│   └── tauri.conf.json    # Tauri config
├── package.json
└── vite.config.ts
```

---

## Core Patterns

### Commands (Rust -> Frontend)

```rust
// src-tauri/src/commands.rs
use serde::Serialize;

#[derive(Serialize)]
pub struct Response {
    pub data: String,
}

#[tauri::command]
pub async fn my_command(input: String) -> Result<Response, String> {
    // ... logic
    Ok(Response { data: input.to_uppercase() })
}
```

```rust
// src-tauri/src/main.rs - register commands
.invoke_handler(tauri::generate_handler![
    commands::my_command,
    commands::other_command,
])
```

```typescript
// Frontend invoke
import { invoke } from '@tauri-apps/api/core';
const result = await invoke<Response>('my_command', { input: 'hello' });
```

### Events (Bidirectional)

```rust
// Emit from Rust
app_handle.emit("event-name", payload)?;
```

```typescript
// Listen from frontend
import { listen } from '@tauri-apps/api/event';
const unlisten = await listen<string>('event-name', (event) => {
  console.log(event.payload);
});
```

### State Management

```rust
// Define state
use std::sync::Mutex;

pub struct AppState {
    pub counter: Mutex<i32>,
}

// Manage in builder
.manage(AppState { counter: Mutex::new(0) })

// Access in command
#[tauri::command]
fn increment(state: tauri::State<AppState>) {
    let mut counter = state.counter.lock().unwrap();
    *counter += 1;
}
```

---

## Security Model (Capabilities)

Tauri v2 uses capability files for permissions:

```toml
# src-tauri/capabilities/default.toml
$schema = "../gen/schemas/desktop-schema.json"
identifier = "default"
description = "Default capabilities"
windows = ["main"]
permissions = [
  "core:default",
  "shell:allow-open",
  "dialog:allow-open",
  "fs:allow-read",
  "fs:allow-write",
]
```

Scoped permissions:
```toml
[[permission]]
identifier = "fs:scope"
allow = [{ path = "$HOME/.myapp/*" }]
```

Rules:
1. Always use capability files - never disable security
2. Scope permissions to specific paths/operations
3. Validate all inputs in commands
4. Use `tauri::ipc::CommandScope` for fine-grained access

**Reference:** https://v2.tauri.app/concept/security/

---

## Official Plugins Quick Reference

| Plugin | Cargo Add | Purpose |
|--------|-----------|---------|
| shell | `cargo add tauri-plugin-shell` | Execute commands, sidecars |
| fs | `cargo add tauri-plugin-fs` | File system ops |
| dialog | `cargo add tauri-plugin-dialog` | Native dialogs |
| notification | `cargo add tauri-plugin-notification` | System notifications |
| clipboard | `cargo add tauri-plugin-clipboard-manager` | Clipboard |
| global-shortcut | `cargo add tauri-plugin-global-shortcut` | Hotkeys |
| http | `cargo add tauri-plugin-http` | HTTP requests |
| store | `cargo add tauri-plugin-store` | Key-value storage |
| updater | `cargo add tauri-plugin-updater` | Auto-update |
| window-state | `cargo add tauri-plugin-window-state` | Persist window geometry |
| single-instance | `cargo add tauri-plugin-single-instance` | Single instance lock |
| process | `cargo add tauri-plugin-process` | Process management |
| os | `cargo add tauri-plugin-os` | OS info |
| devtools | `cargo add tauri-plugin-devtools` | DevTools (debug only) |

**Plugin source:** `${CLAUDE_PLUGIN_ROOT}/vendor/plugins-workspace`

---

## Type Safety (tauri-specta)

Generate TypeScript types from Rust:

```bash
cargo add specta tauri-specta
```

```rust
use specta::Type;
use tauri_specta::{collect_commands, ts};

#[derive(Type, serde::Serialize)]
pub struct MyResponse {
    pub count: i32,
}

#[tauri::command]
#[specta::specta]
fn get_data() -> MyResponse {
    MyResponse { count: 42 }
}

// Export bindings
fn main() {
    ts::export(
        collect_commands![get_data],
        "../src/bindings.ts",
    ).unwrap();
    // ...
}
```

**Reference:** https://github.com/specta-rs/specta

---

## Sidecar Pattern

Bundle external binaries (Python, Go, etc.):

```json
// tauri.conf.json
"bundle": {
  "externalBin": ["binaries/my-sidecar"]
}
```

```rust
use tauri_plugin_shell::ShellExt;

let sidecar = app.shell().sidecar("my-sidecar").unwrap();
let (mut rx, mut child) = sidecar.spawn().expect("spawn failed");
```

**Reference:** https://v2.tauri.app/develop/sidecar/

---

## Error Handling Pattern

```rust
use serde::Serialize;
use thiserror::Error;

#[derive(Error, Debug, Serialize)]
pub enum AppError {
    #[error("IO error: {0}")]
    Io(String),
    #[error("Invalid input: {0}")]
    InvalidInput(String),
}

// Tauri auto-converts Result<T, AppError> to frontend-friendly JSON
#[tauri::command]
fn risky_operation() -> Result<String, AppError> {
    std::fs::read_to_string("file.txt")
        .map_err(|e| AppError::Io(e.to_string()))
}
```

**Reference:** https://v2.tauri.app/develop/calling-rust/#error-handling

---

## Build Commands

| Task | Command |
|------|---------|
| Dev server | `npm run tauri dev` |
| Release build | `npm run tauri build` |
| Specific target | `cargo tauri build --target x86_64-pc-windows-msvc` |
| Check only | `cargo check` |
| Lint Rust | `cargo clippy` |
| Lint JS | `npm run lint` |
| Run tests | `cargo test` + `npm test` |
| Update deps | `cargo update` + `npm update` |

---

## Key Documentation Links

| Topic | URL |
|-------|-----|
| Official Docs | https://v2.tauri.app/ |
| JavaScript API | https://v2.tauri.app/reference/javascript/ |
| Rust API (docs.rs) | https://docs.rs/tauri/ |
| Plugin Workspace | https://github.com/tauri-apps/plugins-workspace/tree/v2 |
| Security Guide | https://v2.tauri.app/concept/security/ |
| Distribution | https://v2.tauri.app/distribute/ |
| Sidecar | https://v2.tauri.app/develop/sidecar/ |
| Commands | https://v2.tauri.app/develop/calling-rust/ |
