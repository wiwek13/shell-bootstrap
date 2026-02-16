#!/usr/bin/env bash
# ============================================================
# Shell Organizer Agent Launcher
# ============================================================
# Invokes the AI agent to analyze, clean, and reorganize
# shell configuration files.
#
# SAFETY: Dry-run is DEFAULT. Use --apply to make changes.
#
# Usage: ./organize_shell.sh [options]
#   (default)    Preview changes only (dry-run)
#   --apply      Apply changes (creates backup first)
#   --backup     Create backup only (no agent)
#   --help       Show this help message
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$HOME/.shell-backup-$(date +%Y%m%d-%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default: dry-run mode (safe)
APPLY_CHANGES=false
BACKUP_ONLY=false

# Parse arguments
for arg in "$@"; do
  case $arg in
    --apply)
      APPLY_CHANGES=true
      ;;
    --backup)
      BACKUP_ONLY=true
      ;;
    --help|-h)
      echo "Shell Organizer Agent"
      echo ""
      echo "Usage: ./organize_shell.sh [options]"
      echo ""
      echo "Options:"
      echo "  (default)    Preview changes only (dry-run, SAFE)"
      echo "  --apply      Apply changes (creates backup first)"
      echo "  --backup     Create backup only (no agent)"
      echo "  --help       Show this help message"
      echo ""
      echo "Environment:"
      echo "  SHELL_AGENT_MODEL           AI model (default: openrouter/mistralai/devstral-2512:free)"
      echo "  SHELL_AGENT_OPENROUTER_KEY  OpenRouter API key"
      echo ""
      echo "This agent will:"
      echo "  • Analyze .zshrc, .zprofile, ~/.shell/zsh/*.zsh"
      echo "  • Detect duplicates and clutter"
      echo "  • Suggest reorganization (dry-run shows preview)"
      echo "  • Apply only with --apply flag"
      exit 0
      ;;
  esac
done

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          Shell Config Organizer Agent                  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

if [[ "$APPLY_CHANGES" != true ]]; then
  echo -e "${YELLOW}⚠️  DRY-RUN MODE (default) - No changes will be made${NC}"
  echo -e "${YELLOW}   Use --apply to apply changes${NC}"
  echo ""
fi

# ============================================================
# CHECK PREREQUISITES
# ============================================================
echo -e "${YELLOW}▶ Checking prerequisites...${NC}"

# Check for OpenRouter API key
API_KEY="${SHELL_AGENT_OPENROUTER_KEY:-$OPENROUTER_API_KEY}"
if [[ -z "$API_KEY" ]]; then
  echo -e "${RED}❌ SHELL_AGENT_OPENROUTER_KEY or OPENROUTER_API_KEY not set${NC}"
  echo ""
  echo "Set your OpenRouter API key:"
  echo "  export SHELL_AGENT_OPENROUTER_KEY='your-key-here'"
  echo ""
  echo "Get a free key at: https://openrouter.ai/keys"
  exit 1
fi
echo -e "  ${GREEN}✔ OpenRouter API key found${NC}"

# Check for opencode
if ! command -v opencode &>/dev/null; then
  echo -e "${RED}❌ OpenCode not installed${NC}"
  echo ""
  echo "Install OpenCode:"
  echo "  brew tap anomalyco/tap && brew install opencode"
  exit 1
fi
echo -e "  ${GREEN}✔ OpenCode installed${NC}"

# ============================================================
# CREATE BACKUP (always, before any analysis)
# ============================================================
echo ""
echo -e "${YELLOW}▶ Creating backup...${NC}"

mkdir -p "$BACKUP_DIR"

# Backup all shell configs
[[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$BACKUP_DIR/"
[[ -f "$HOME/.zprofile" ]] && cp "$HOME/.zprofile" "$BACKUP_DIR/"
[[ -d "$HOME/.shell" ]] && cp -R "$HOME/.shell" "$BACKUP_DIR/"

echo -e "  ${GREEN}✔ Backup created: $BACKUP_DIR${NC}"

if [[ "$BACKUP_ONLY" == true ]]; then
  echo ""
  echo -e "${GREEN}✔ Backup complete. Exiting (--backup flag).${NC}"
  exit 0
fi

# ============================================================
# ANALYZE CURRENT CONFIG
# ============================================================
echo ""
echo -e "${YELLOW}▶ Analyzing current configuration...${NC}"

# Count current state
ZSHRC_LINES=$(wc -l < "$HOME/.zshrc" 2>/dev/null | tr -d ' ' || echo "0")
EXPORTS_LINES=$(wc -l < "$HOME/.shell/zsh/exports.zsh" 2>/dev/null | tr -d ' ' || echo "0")
ALIASES_LINES=$(wc -l < "$HOME/.shell/zsh/aliases.zsh" 2>/dev/null | tr -d ' ' || echo "0")
FUNCTIONS_LINES=$(wc -l < "$HOME/.shell/zsh/functions.zsh" 2>/dev/null | tr -d ' ' || echo "0")

echo "  Current state:"
echo "    • .zshrc: $ZSHRC_LINES lines"
echo "    • exports.zsh: $EXPORTS_LINES lines"
echo "    • aliases.zsh: $ALIASES_LINES lines"
echo "    • functions.zsh: $FUNCTIONS_LINES lines"

# ============================================================
# INVOKE AGENT
# ============================================================
echo ""
echo -e "${YELLOW}▶ Launching Shell Organizer Agent...${NC}"

# Model to use (configurable via SHELL_AGENT_MODEL env var)
MODEL="${SHELL_AGENT_MODEL:-openrouter/mistralai/devstral-2512:free}"
echo -e "  ${GREEN}Using model: $MODEL${NC}"
echo ""

# Change to agent directory for config access
cd "$SCRIPT_DIR"

# Launch opencode with appropriate prompt
if [[ "$APPLY_CHANGES" == true ]]; then
  echo -e "${YELLOW}⚠️  APPLY MODE - Changes will be made after preview${NC}"
  echo ""
  opencode -m "$MODEL" \
    --prompt "You are a shell optimization agent. Analyze my shell configuration at ~/.zshrc, ~/.zprofile, ~/.shell/zsh/*.zsh and my shell history at ~/.zsh_history.

DO THIS:
1. Check my shell history for frequently used commands that should be aliases
2. Detect deprecated tools and suggest modern alternatives (ls→eza, cat→bat, etc.)
3. Find duplicate exports/aliases/functions
4. Compare against best practices from popular GitHub dotfiles
5. Show preview of all changes FIRST
6. Ask for confirmation before making changes
7. Keep changes MINIMAL - don't reorganize everything

After changes, validate with zsh -n ~/.zshrc"
else
  echo -e "${BLUE}Preview mode - showing analysis only${NC}"
  echo ""
  opencode -m "$MODEL" \
    --prompt "You are a shell workflow and coding style analyst (EXPERIMENTAL). 

Analyze:
- Shell configs: ~/.zshrc, ~/.zprofile, ~/.shell/zsh/*.zsh
- Command frequency from history (counts only, no arguments)
- Installed tools: brew list

DO NOT make any changes. This is PREVIEW ONLY.

Produce a CRITICAL REVIEW with:

## 🔍 WORKFLOW ANALYSIS
- What tools I use most (git, kubectl, docker, etc.)
- Commands I type repeatedly that should be aliases
- Time wasted on repetitive typing (estimate)

## 💪 STRENGTHS
- What I'm doing well
- Good patterns in my config

## ⚠️ WEAKNESSES  
- Inefficient patterns I have
- Missing automations
- Outdated tools I still use

## 🎯 OPPORTUNITIES
- Tools I should learn
- Workflows I should automate
- Skills to develop

## 💡 SUGGESTED ALIASES
Based on my frequency, show table: | alias | command | times/day |

## 🚨 WASTED INSTALLS (Critical!)
Check brew list for modern tools I have installed but still use old commands:
- eza installed but using ls → should use eza
- zoxide installed but using cd → should use z
- bat installed but using cat → should use bat
- fd installed but using find → should use fd
- ripgrep installed but using grep → should use rg
Show table: | Installed | You Use | Times/Day | Switch To |

## 🔄 DEPRECATED TOOLS
Tools I use vs modern alternatives

## 📊 SCORES (be honest)
- Workflow efficiency: X/10
- Automation level: X/10
- Tool currency: X/10
- Overall: X/10

Be HONEST and ACTIONABLE. Give real feedback, not just positives."
fi

# ============================================================
# VALIDATE CONFIG (only if changes were applied)
# ============================================================
if [[ "$APPLY_CHANGES" == true ]]; then
  echo ""
  echo -e "${YELLOW}▶ Validating shell configuration...${NC}"
  
  if zsh -n "$HOME/.zshrc" 2>/dev/null; then
    echo -e "  ${GREEN}✔ .zshrc syntax valid${NC}"
  else
    echo -e "  ${RED}❌ .zshrc has syntax errors!${NC}"
    echo -e "  ${YELLOW}Restoring from backup...${NC}"
    cp "$BACKUP_DIR/.zshrc" "$HOME/.zshrc"
    [[ -d "$BACKUP_DIR/.shell" ]] && cp -R "$BACKUP_DIR/.shell" "$HOME/"
    echo -e "  ${GREEN}✔ Restored from backup${NC}"
  fi
fi

# ============================================================
# SUMMARY
# ============================================================
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
if [[ "$APPLY_CHANGES" == true ]]; then
  echo -e "${GREEN}║          Organization Complete                         ║${NC}"
else
  echo -e "${GREEN}║          Preview Complete                              ║${NC}"
fi
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  Backup location: $BACKUP_DIR"
echo ""
if [[ "$APPLY_CHANGES" != true ]]; then
  echo -e "  ${YELLOW}To apply changes, run:${NC}"
  echo "    shell-organize --apply"
  echo ""
fi
echo "  To restore from backup:"
echo "    cp -R $BACKUP_DIR/* ~/"
echo ""
echo "  To test config:"
echo "    source ~/.zshrc"
echo ""
