# Tauri Agent Tools Reference

## 1. Oh-My-Pi (Agent Harness)

**What:** Hard fork of Pi adding ~27k lines of Rust tooling for AI agents. Provides 32 built-in tools.

**Install:**
```bash
git clone https://github.com/oh-my-pi/oh-my-pi.git
cd oh-my-pi && cargo build --release
alias oh-my-pi="$(pwd)/target/release/oh-my-pi"
```

**Essential tools for Tauri:**
| Tool | Use |
|------|-----|
| `read` / `edit` / `ast_edit` | File ops with content-hash anchoring |
| `lsp` | Rust-Analyzer + TypeScript completions, diagnostics |
| `search` | ripgrep across codebase |
| `bash` | Run `cargo`, `npm`, `tauri` CLI commands |
| `browser` | Puppeteer for frontend testing |
| `eval` | Persistent Python/JS execution |
| `debug` | DAP debugger (LLDB, GDB) |
| `task` | Subagents for parallel work (e.g., split Rust/frontend tasks) |

**Reference:** https://github.com/oh-my-pi/oh-my-pi

---

## 2. Kimi Backend (K2.5 / K2.6)

**What:** AI reasoning engine via Moonshot API. Optimized for agentic coding.

**Why for Tauri:**
- 76.8% SWE-Bench Verified
- 256K context (holds Rust + frontend simultaneously)
- Native multimodality (UI screenshots, design mockups)
- Agent swarm mode (parallel sub-agents)
- Native tool calling (integrates with Oh-My-Pi)

**Setup:**
```bash
export KIMI_API_KEY="sk-your-key"
oh-my-pi config set provider kimi
oh-my-pi config set api-key $KIMI_API_KEY
```

**API:** https://platform.moonshot.cn/docs

---

## 3. Tauri DevTools (CrabNebula)

**What:** Runtime visibility into Tauri apps. WebSocket-based, debug-builds only.

**Features:**
| Tab | Data |
|-----|------|
| Console | Rust + frontend logs in real-time |
| Calls | Every Tauri command (args, returns, timing) |
| Events | Event flow between frontend and Rust |
| Config | tauri.conf.json validation |

**Install:**
```bash
cargo add tauri-plugin-devtools --features build-script
```

**Enable (src-tauri/src/main.rs):**
```rust
#[cfg(debug_assertions)]
let devtools = tauri_plugin_devtools::init();

let mut builder = tauri::Builder::default();
#[cfg(debug_assertions)] { builder = builder.plugin(devtools); }
```

**Reference:** https://crabnebula.dev/devtools
