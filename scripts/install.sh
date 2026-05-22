#!/bin/bash
set -e

# Tauri Dev Plugin Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/GodSpoon/tauri-dev-plugin/main/scripts/install.sh | bash

PLUGIN_NAME="tauri-dev-plugin"
PLUGIN_REPO="${TAURI_DEV_PLUGIN_REPO:-https://github.com/GodSpoon/tauri-dev-plugin.git}"
CLAUDE_PLUGINS_DIR="${HOME}/.claude/plugins"
INSTALL_DIR="${CLAUDE_PLUGINS_DIR}/${PLUGIN_NAME}"

echo "=== Tauri Dev Plugin Installer ==="
echo ""

# Check for git
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed."
    exit 1
fi

# Create plugins directory
mkdir -p "${CLAUDE_PLUGINS_DIR}"

# Remove existing installation
if [ -d "${INSTALL_DIR}" ]; then
    echo "Removing existing installation..."
    rm -rf "${INSTALL_DIR}"
fi

# Clone with submodules
echo "Cloning ${PLUGIN_NAME}..."
git clone --recursive "${PLUGIN_REPO}" "${INSTALL_DIR}"

# Update submodules (shallow)
cd "${INSTALL_DIR}"
git submodule update --init --depth 1

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Plugin installed to: ${INSTALL_DIR}"
echo ""
echo "Bundled resources:"
echo "  - vendor/tauri-template         (Production React template)"
echo "  - vendor/tauri-svelte-template  (Production Svelte template)"
echo "  - vendor/plugins-workspace      (Official plugins source)"
echo "  - vendor/awesome-tauri          (Community resources)"
echo ""
echo "To use the plugin, restart Claude Code or run:"
echo "  claude plugin enable ${INSTALL_DIR}"
echo ""
echo "To scaffold a project from a bundled template:"
echo "  cp -r ${INSTALL_DIR}/vendor/tauri-template ./my-app"
echo ""
