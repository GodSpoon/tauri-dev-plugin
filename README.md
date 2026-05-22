# Tauri Dev Plugin

Complete Tauri v2 development toolkit for Claude Code. Provides skills, commands, and agents for scaffolding, developing, debugging, and shipping Tauri desktop applications.

## Quick Start

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USER/tauri-dev-plugin/main/scripts/install.sh | bash
```

### Manual Install

```bash
git clone --recursive https://github.com/YOUR_USER/tauri-dev-plugin.git ~/.claude/plugins/tauri-dev-plugin
cd ~/.claude/plugins/tauri-dev-plugin
git submodule update --init --depth 1
```

Then restart Claude Code or enable the plugin.

## What's Included

### Skills (Auto-Activating)
- **Tauri Agent Development** - Comprehensive toolkit for Tauri v2 apps. Triggers on Tauri-related keywords.

### Commands
- `/tauri-scaffold` - Scaffold a new project from official or bundled templates
- `/tauri-add-plugin` - Add and configure official Tauri plugins with capabilities

### Agents
- **Rust Backend Agent** - Specialized for Tauri Rust backend (commands, state, plugins, security)
- **Frontend Agent** - Specialized for Tauri frontend (React/Vue/Svelte, invoke, events)

### Bundled Templates (Git Submodules)

| Resource | Path | Description |
|----------|------|-------------|
| `dannysmith/tauri-template` | `vendor/tauri-template` | Production React + shadcn/ui + multi-window |
| `alysonhower/tauri2-svelte5-shadcn` | `vendor/tauri-svelte-template` | Production Svelte 5 + shadcn-svelte |
| `tauri-apps/plugins-workspace` | `vendor/plugins-workspace` | Official plugins source code |
| `tauri-apps/awesome-tauri` | `vendor/awesome-tauri` | Community templates and resources |

### Reference Materials
- `skills/tauri-agent-dev/references/tools.md` - Oh-My-Pi, Kimi, DevTools setup
- `skills/tauri-agent-dev/references/templates.md` - Template catalog and selection guide
- `skills/tauri-agent-dev/references/tauri-core.md` - Detailed patterns (commands, events, state, security, sidecars)

## Usage

### Scaffold a Project

```
/tauri-scaffold production my-app
```

Or manually:
```bash
cp -r ~/.claude/plugins/tauri-dev-plugin/vendor/tauri-template ./my-app
cd my-app && npm install && npm run tauri dev
```

### Add a Plugin

```
/tauri-add-plugin shell
```

## Plugin Structure

```
tauri-dev-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── commands/                 # Slash commands
│   ├── scaffold.md
│   └── add-plugin.md
├── agents/                   # Subagent definitions
│   ├── rust-backend.md
│   └── frontend-dev.md
├── skills/
│   └── tauri-agent-dev/
│       ├── SKILL.md         # Auto-activating skill
│       └── references/      # Knowledge base
│           ├── tools.md
│           ├── templates.md
│           └── tauri-core.md
├── scripts/
│   └── install.sh           # One-line installer
└── vendor/                  # Git submodules
    ├── tauri-template/
    ├── tauri-svelte-template/
    ├── plugins-workspace/
    └── awesome-tauri/
```

## Requirements

- [Claude Code](https://claude.ai/code) with plugin support
- Git (for cloning and submodule management)
- For actual Tauri development: Rust, Node.js, and platform-specific dependencies

## License

MIT
