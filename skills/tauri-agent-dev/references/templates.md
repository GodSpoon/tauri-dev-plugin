# Tauri Templates Catalog

## Official Scaffold (use first)

**create-tauri-app** - Official project generator
```bash
npm create tauri-app@latest my-app -- --template react-ts
```

| Template | Framework | Notes |
|----------|-----------|-------|
| `vanilla` / `vanilla-ts` | Plain HTML/CSS/JS | Minimal starting point |
| `react` / `react-ts` | React + Vite | Most popular, best ecosystem |
| `vue` / `vue-ts` | Vue.js | Clean, approachable |
| `svelte` / `svelte-ts` | Svelte (frontend only) | Lightweight, fast |
| `solid` / `solid-ts` | SolidJS | Fine-grained reactivity |
| `angular` | Angular | Enterprise-scale |
| `preact` / `preact-ts` | Preact | React-compatible, smaller |
| `yew` | Rust Yew | Full Rust stack |
| `leptos` | Rust Leptos | Modern Rust framework |
| `sycamore` | Rust Sycamore | Rust reactive UI |
| `blazor` | .NET Blazor | C# backend |

**Full list:** https://v2.tauri.app/start/create-project/

---

## Bundled Templates (Git Submodules)

These templates ship with this plugin under `vendor/`:

| Template | Local Path | Stack |
|----------|-----------|-------|
| **dannysmith/tauri-template** | `${CLAUDE_PLUGIN_ROOT}/vendor/tauri-template` | Tauri v2 + React 19 + TS + shadcn/ui v4 + Tailwind v4 + tauri-specta + multi-window |
| **alysonhower/tauri2-svelte5-shadcn** | `${CLAUDE_PLUGIN_ROOT}/vendor/tauri-svelte-template` | Tauri 2.0 + Svelte 5 + shadcn-svelte + Tailwind 4 |
| **tauri-apps/awesome-tauri** | `${CLAUDE_PLUGIN_ROOT}/vendor/awesome-tauri` | Curated community templates & resources |
| **tauri-apps/plugins-workspace** | `${CLAUDE_PLUGIN_ROOT}/vendor/plugins-workspace` | Official Tauri plugins source + examples |

To scaffold from a bundled template:
```bash
cp -r ${CLAUDE_PLUGIN_ROOT}/vendor/tauri-template ./my-app
cd my-app && npm install && npm run tauri dev
```

---

## Production Community Templates

| Template | Stack | Best For | Repo |
|----------|-------|----------|------|
| **dannysmith/tauri-template** | Tauri v2 + React 19 + TS + shadcn/ui v4 + Tailwind v4 + tauri-specta + multi-window | Production apps, AI agent workflows | github.com/dannysmith/tauri-template |
| **alysonhower/tauri2-svelte5-shadcn** | Tauri 2.0 + Svelte 5 + shadcn-svelte + Tailwind 4 | Svelte apps, clean architecture | github.com/alysonhower/tauri2-svelte5-shadcn |
| **tauri-fastapi-full-stack** | Tauri + FastAPI (Python) + React + SQLite + sidecar | Python backend sidecar | awesome-tauri |
| **rust-full-stack-auth** | Tauri + Yew + Axum + sqlx + auth | Full-stack Rust with auth | awesome-tauri |
| **tauri-nextjs-template** | Tauri + Next.js SSG + Tailwind | SEO-friendly, CI-ready | awesome-tauri |

**Awesome Tauri (all community templates):** https://github.com/tauri-apps/awesome-tauri

---

## Template Selection Guide

| Need | Recommended Template |
|------|---------------------|
| Quick prototype | `npm create tauri-app@latest` with vanilla or react-ts |
| Production desktop app | `dannysmith/tauri-template` (React + tauri-specta + multi-window) |
| Svelte preference | `alysonhower/tauri2-svelte5-shadcn` |
| Python backend | `tauri-fastapi-full-stack` with sidecar |
| Full Rust stack | `yew` or `leptos` official template |
| macOS-only floating panel | `dannysmith/tauri-template` (includes tauri-nspanel) |
