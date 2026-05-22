---
name: tauri-scaffold
description: Scaffold a new Tauri v2 project using bundled or official templates
---

# /tauri-scaffold

Scaffold a new Tauri v2 desktop application.

## Usage

```
/tauri-scaffold [template-name] [project-name]
```

## Templates

### Official (via npm)
- `vanilla`, `vanilla-ts`
- `react`, `react-ts`
- `vue`, `vue-ts`
- `svelte`, `svelte-ts`
- `solid`, `solid-ts`
- `angular`, `preact`, `yew`, `leptos`

### Bundled (local submodules)
- `production` -> `${CLAUDE_PLUGIN_ROOT}/vendor/tauri-template`
- `svelte-prod` -> `${CLAUDE_PLUGIN_ROOT}/vendor/tauri-svelte-template`

## Steps

1. If using a bundled template, copy from `${CLAUDE_PLUGIN_ROOT}/vendor/` to target directory
2. If using official template, run `npm create tauri-app@latest`
3. Run `npm install` in the project
4. Install DevTools: `cargo add tauri-plugin-devtools --features build-script`
5. Configure capabilities in `src-tauri/capabilities/default.toml`
6. Run `npm run tauri dev` to verify

## Example

```bash
/tauri-scaffold production my-desktop-app
```
