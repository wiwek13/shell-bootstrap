#!/usr/bin/env bash
# ============================================================
# Shell Bootstrap Configuration
# ============================================================
# Edit this file to customize what gets installed.
# Set to "true" to install, "false" to skip.
# Then run: ./bootstrap.sh
# ============================================================

# ============================================================
# SHELL CORE (recommended to keep all true)
# ============================================================
INSTALL_ANTIDOTE=true       # Plugin manager (required for plugins)
INSTALL_STARSHIP=true       # Modern prompt with icons
INSTALL_ZELLIJ=true         # Terminal multiplexer (tmux alternative)
INSTALL_OH_MY_ZSH=true      # ZSH framework (required for OMZ plugins)

# ============================================================
# CLI ESSENTIALS
# ============================================================
INSTALL_BAT=true            # Cat with syntax highlighting
INSTALL_EZA=true            # Modern ls with icons
INSTALL_FZF=true            # Fuzzy finder (powers many functions)
INSTALL_FD=true             # Fast file finder
INSTALL_RIPGREP=true        # Fast grep (rg command)
INSTALL_JQ=true             # JSON processor
INSTALL_YQ=true             # YAML processor
INSTALL_AG=true             # Silver Searcher (ag command)
INSTALL_ZOXIDE=true         # Smarter cd (z command)

# ============================================================
# SYSTEM UTILITIES
# ============================================================
INSTALL_TREE=true           # Directory tree view
INSTALL_WATCH=true          # Run command repeatedly
INSTALL_HTOP=true           # Interactive process viewer

# ============================================================
# DEVOPS TOOLS
# ============================================================
INSTALL_KUBECTX=true        # Kubernetes context/namespace switcher
INSTALL_STERN=true          # Multi-pod log tailing
INSTALL_K9S=true            # Kubernetes TUI
INSTALL_ET=true             # Eternal Terminal (persistent SSH)

# ============================================================
# CONFIGURATION FILES
# ============================================================
INSTALL_ZSH_CONFIG=true     # Shell exports, aliases, functions
INSTALL_STARSHIP_CONFIG=true # Starship prompt theme
INSTALL_ZELLIJ_CONFIG=true  # Zellij terminal config

# ============================================================
# OPTIONAL: NERD FONT
# ============================================================
# Set to true to auto-install JetBrainsMono Nerd Font
# Required for icons in prompt and eza
INSTALL_NERD_FONT=true

# ============================================================
# APPLICATIONS (Brewfile)
# ============================================================
# Set to true to install applications from Brewfile
INSTALL_APPS=true

# ============================================================
# RAYCAST & MOLE INTEGRATION
# ============================================================
# NOTE: Raycast is installed via Brewfile (cask "raycast")

# Set to true to install Mole quick launchers for Raycast/Alfred
# Runs: curl -fsSL https://raw.githubusercontent.com/tw93/Mole/main/scripts/setup-quick-launchers.sh | bash
INSTALL_MOLE_LAUNCHERS=false
# ============================================================
# AI CODING AGENTS (OpenCode)
# ============================================================
# Set to true to install OpenCode (AI terminal coding agent)
# Already in Brewfile, this is for explicit control
INSTALL_OPENCODE=true

# Set to true to install Oh My OpenCode (multi-agent extension)
# Runs: npx oh-my-opencode install --no-tui
INSTALL_OH_MY_OPENCODE=true

# ============================================================
# BACKUP MANAGEMENT
# ============================================================
# Number of backup folders to keep (older ones are auto-deleted)
# Set to 0 to disable automatic cleanup
BACKUPS_TO_KEEP=1

# ============================================================
# POST-INSTALL MAINTENANCE
# ============================================================
# Set to true to run `brew upgrade` on ALL packages during bootstrap
# WARNING: This upgrades everything system-wide, not just bootstrap packages
BREW_UPGRADE_ALL=false
