#!/usr/bin/env bash
# ============================================================
# Shell Bootstrap Uninstall Configuration
# ============================================================
# Edit this file to customize what gets uninstalled.
# Set to "true" to uninstall, "false" to keep.
# Then run: ./uninstall.sh --config
# ============================================================

# ============================================================
# CONFIGURATION FILES
# ============================================================
UNINSTALL_SHELL_CONFIG=true    # ~/.shell, ~/.zshrc, ~/.zprofile
UNINSTALL_STARSHIP_CONFIG=true # ~/.config/starship
UNINSTALL_ZELLIJ_CONFIG=true   # Zellij config
UNINSTALL_FZF_CONFIG=true      # ~/.fzf.zsh

# ============================================================
# SHELL CORE
# ============================================================
UNINSTALL_ANTIDOTE=true
UNINSTALL_STARSHIP=true
UNINSTALL_ZELLIJ=true
UNINSTALL_OH_MY_ZSH=false      # ⚠️ Keep by default (may have personal customizations)

# ============================================================
# CLI ESSENTIALS
# ============================================================
UNINSTALL_BAT=true
UNINSTALL_EZA=true
UNINSTALL_FZF=true
UNINSTALL_FD=true
UNINSTALL_RIPGREP=true
UNINSTALL_JQ=true
UNINSTALL_YQ=true
UNINSTALL_AG=true              # Silver Searcher
UNINSTALL_ZOXIDE=true

# ============================================================
# SYSTEM UTILITIES
# ============================================================
UNINSTALL_TREE=true
UNINSTALL_WATCH=true
UNINSTALL_HTOP=true

# ============================================================
# DEVOPS TOOLS
# ============================================================
UNINSTALL_KUBECTX=true
UNINSTALL_STERN=true
UNINSTALL_K9S=true
UNINSTALL_ET=true              # Eternal Terminal

# ============================================================
# OPTIONS
# ============================================================
CREATE_MINIMAL_ZSHRC=true      # Create basic .zshrc after uninstall
CLEANUP_HOMEBREW=true          # Run brew cleanup after uninstall
