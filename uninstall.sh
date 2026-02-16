#!/usr/bin/env bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USE_CONFIG=false
FORCE_YES=false

# Parse arguments
for arg in "$@"; do
  case $arg in
    --config|-c) USE_CONFIG=true ;;
    --yes|-y) FORCE_YES=true ;;
    --help|-h)
      echo "Usage: ./uninstall.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --config, -c    Use uninstall_config.sh instead of interactive menu"
      echo "  --yes, -y       Skip confirmation prompts"
      echo "  --help, -h      Show this help message"
      exit 0
      ;;
  esac
done

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Shell Bootstrap Uninstaller${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo ""

# ============================================================
# GUARDS
# ============================================================
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo -e "${RED}❌ This uninstaller is for macOS only${NC}"
  exit 1
fi

# ============================================================
# HELPER FUNCTIONS
# ============================================================
confirm() {
  local prompt="$1"
  local default="${2:-n}"
  
  if [[ "$FORCE_YES" == true ]]; then
    return 0
  fi
  
  if [[ "$default" == "y" ]]; then
    read -p "$prompt [Y/n] " -n 1 -r
  else
    read -p "$prompt [y/N] " -n 1 -r
  fi
  echo ""
  
  if [[ "$default" == "y" ]]; then
    [[ ! $REPLY =~ ^[Nn]$ ]]
  else
    [[ $REPLY =~ ^[Yy]$ ]]
  fi
}

remove_if_exists() {
  local path="$1"
  if [[ -e "$path" ]] || [[ -L "$path" ]]; then
    rm -rf "$path"
    echo -e "  ${GREEN}✔${NC} Removed: $path"
    return 0
  fi
  return 1
}

uninstall_brew_package() {
  local pkg="$1"
  if brew list "$pkg" &>/dev/null; then
    brew uninstall "$pkg"
    echo -e "  ${GREEN}✔${NC} Uninstalled: $pkg"
    return 0
  else
    echo -e "  ${YELLOW}⚠${NC} Not installed: $pkg"
    return 1
  fi
}

# ============================================================
# LOAD CONFIG OR USE INTERACTIVE MENU
# ============================================================
if [[ "$USE_CONFIG" == true ]]; then
  # Config-based uninstall
  CONFIG_FILE="$SCRIPT_DIR/uninstall_config.sh"
  if [[ -f "$CONFIG_FILE" ]]; then
    echo -e "${BLUE}▶ Loading configuration from uninstall_config.sh...${NC}"
    source "$CONFIG_FILE"
  else
    echo -e "${RED}❌ uninstall_config.sh not found${NC}"
    echo "   Create it or run without --config for interactive mode"
    exit 1
  fi
else
  # Interactive menu
  echo "What would you like to uninstall?"
  echo ""
  echo -e "  ${YELLOW}1)${NC} Everything (full uninstall)"
  echo -e "  ${YELLOW}2)${NC} Shell configuration only (keep packages)"
  echo -e "  ${YELLOW}3)${NC} Packages only (keep configuration)"
  echo -e "  ${YELLOW}4)${NC} Select specific components"
  echo -e "  ${YELLOW}5)${NC} Cancel"
  echo ""
  read -p "Enter choice [1-5]: " -n 1 -r CHOICE
  echo ""
  echo ""

  # Initialize all to false
  UNINSTALL_SHELL_CONFIG=false
  UNINSTALL_ANTIDOTE=false
  UNINSTALL_STARSHIP=false
  UNINSTALL_ZELLIJ=false
  UNINSTALL_BAT=false
  UNINSTALL_EZA=false
  UNINSTALL_FZF=false
  UNINSTALL_FD=false
  UNINSTALL_RIPGREP=false
  UNINSTALL_JQ=false
  UNINSTALL_YQ=false
  UNINSTALL_AG=false
  UNINSTALL_ZOXIDE=false
  UNINSTALL_TREE=false
  UNINSTALL_WATCH=false
  UNINSTALL_HTOP=false
  UNINSTALL_KUBECTX=false
  UNINSTALL_STERN=false
  UNINSTALL_K9S=false
  UNINSTALL_ET=false
  UNINSTALL_OH_MY_ZSH=false
  CREATE_MINIMAL_ZSHRC=true
  CLEANUP_HOMEBREW=true

  case $CHOICE in
    1) 
      # Everything
      UNINSTALL_SHELL_CONFIG=true
      UNINSTALL_ANTIDOTE=true
      UNINSTALL_STARSHIP=true
      UNINSTALL_ZELLIJ=true
      UNINSTALL_BAT=true
      UNINSTALL_EZA=true
      UNINSTALL_FZF=true
      UNINSTALL_FD=true
      UNINSTALL_RIPGREP=true
      UNINSTALL_JQ=true
      UNINSTALL_YQ=true
      UNINSTALL_AG=true
      UNINSTALL_ZOXIDE=true
      UNINSTALL_TREE=true
      UNINSTALL_WATCH=true
      UNINSTALL_HTOP=true
      UNINSTALL_KUBECTX=true
      UNINSTALL_STERN=true
      UNINSTALL_K9S=true
      UNINSTALL_ET=true
      UNINSTALL_OH_MY_ZSH=true
      ;;
    2)
      # Config only
      UNINSTALL_SHELL_CONFIG=true
      ;;
    3)
      # Packages only
      UNINSTALL_ANTIDOTE=true
      UNINSTALL_STARSHIP=true
      UNINSTALL_ZELLIJ=true
      UNINSTALL_BAT=true
      UNINSTALL_EZA=true
      UNINSTALL_FZF=true
      UNINSTALL_FD=true
      UNINSTALL_RIPGREP=true
      UNINSTALL_JQ=true
      UNINSTALL_YQ=true
      UNINSTALL_AG=true
      UNINSTALL_ZOXIDE=true
      UNINSTALL_TREE=true
      UNINSTALL_WATCH=true
      UNINSTALL_HTOP=true
      UNINSTALL_KUBECTX=true
      UNINSTALL_STERN=true
      UNINSTALL_K9S=true
      UNINSTALL_ET=true
      ;;
    4)
      # Selective
      echo -e "${BLUE}Select components to uninstall:${NC}"
      echo ""
      
      if [[ -d "$HOME/.shell" ]]; then
        if confirm "  Remove shell configuration (~/.shell, ~/.zshrc)?"; then
          UNINSTALL_SHELL_CONFIG=true
        fi
      fi
      
      echo ""
      echo "  Shell packages:"
      confirm "    - antidote?" && UNINSTALL_ANTIDOTE=true
      confirm "    - starship?" && UNINSTALL_STARSHIP=true
      confirm "    - zellij?" && UNINSTALL_ZELLIJ=true
      
      echo ""
      echo "  CLI tools:"
      confirm "    - bat, eza, fzf, fd, ripgrep, jq, yq, ag, zoxide? (all)" && {
        UNINSTALL_BAT=true
        UNINSTALL_EZA=true
        UNINSTALL_FZF=true
        UNINSTALL_FD=true
        UNINSTALL_RIPGREP=true
        UNINSTALL_JQ=true
        UNINSTALL_YQ=true
        UNINSTALL_AG=true
        UNINSTALL_ZOXIDE=true
      }
      
      echo ""
      echo "  System utilities:"
      confirm "    - tree, watch, htop? (all)" && {
        UNINSTALL_TREE=true
        UNINSTALL_WATCH=true
        UNINSTALL_HTOP=true
      }
      
      echo ""
      echo "  DevOps tools:"
      confirm "    - kubectx, stern, k9s, et? (all)" && {
        UNINSTALL_KUBECTX=true
        UNINSTALL_STERN=true
        UNINSTALL_K9S=true
        UNINSTALL_ET=true
      }
      
      if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo ""
        if confirm "  Remove Oh My Zsh?"; then
          UNINSTALL_OH_MY_ZSH=true
        fi
      fi
      ;;
    5|*)
      echo -e "${YELLOW}Cancelled.${NC}"
      exit 0
      ;;
  esac
fi

# ============================================================
# SHOW SUMMARY AND CONFIRM
# ============================================================
echo ""
echo -e "${YELLOW}The following will be uninstalled:${NC}"
echo ""

[[ "$UNINSTALL_SHELL_CONFIG" == true ]] && echo "  • Shell configuration"
[[ "$UNINSTALL_ANTIDOTE" == true ]] && echo "  • antidote"
[[ "$UNINSTALL_STARSHIP" == true ]] && echo "  • starship"
[[ "$UNINSTALL_ZELLIJ" == true ]] && echo "  • zellij"
[[ "$UNINSTALL_BAT" == true ]] && echo "  • bat"
[[ "$UNINSTALL_EZA" == true ]] && echo "  • eza"
[[ "$UNINSTALL_FZF" == true ]] && echo "  • fzf"
[[ "$UNINSTALL_FD" == true ]] && echo "  • fd"
[[ "$UNINSTALL_RIPGREP" == true ]] && echo "  • ripgrep"
[[ "$UNINSTALL_JQ" == true ]] && echo "  • jq"
[[ "$UNINSTALL_YQ" == true ]] && echo "  • yq"
[[ "$UNINSTALL_AG" == true ]] && echo "  • the_silver_searcher"
[[ "$UNINSTALL_ZOXIDE" == true ]] && echo "  • zoxide"
[[ "$UNINSTALL_TREE" == true ]] && echo "  • tree"
[[ "$UNINSTALL_WATCH" == true ]] && echo "  • watch"
[[ "$UNINSTALL_HTOP" == true ]] && echo "  • htop"
[[ "$UNINSTALL_KUBECTX" == true ]] && echo "  • kubectx"
[[ "$UNINSTALL_STERN" == true ]] && echo "  • stern"
[[ "$UNINSTALL_K9S" == true ]] && echo "  • k9s"
[[ "$UNINSTALL_ET" == true ]] && echo "  • et"
[[ "$UNINSTALL_OH_MY_ZSH" == true ]] && echo "  • Oh My Zsh"

echo ""
if ! confirm "Proceed with uninstall?" "n"; then
  echo -e "${YELLOW}Cancelled.${NC}"
  exit 0
fi

echo ""

# ============================================================
# UNINSTALL SHELL CONFIGURATION
# ============================================================
if [[ "$UNINSTALL_SHELL_CONFIG" == true ]]; then
  echo -e "${BLUE}▶ Removing shell configuration...${NC}"
  
  remove_if_exists "$HOME/.shell" || true
  remove_if_exists "$HOME/.zshrc" || true
  remove_if_exists "$HOME/.zprofile" || true
  remove_if_exists "$HOME/.zsh_plugins.txt" || true
  remove_if_exists "$HOME/.zsh_plugins.zsh" || true
  remove_if_exists "$HOME/.cache/antidote" || true
  
  echo ""
fi

# Granular config removal (can be set independently of UNINSTALL_SHELL_CONFIG)
if [[ "${UNINSTALL_STARSHIP_CONFIG:-$UNINSTALL_SHELL_CONFIG}" == true ]]; then
  remove_if_exists "$HOME/.config/starship" || true
fi

if [[ "${UNINSTALL_FZF_CONFIG:-$UNINSTALL_SHELL_CONFIG}" == true ]]; then
  remove_if_exists "$HOME/.fzf.zsh" || true
  remove_if_exists "$HOME/.fzf.bash" || true
fi

# ============================================================
# UNINSTALL PACKAGES
# ============================================================
echo -e "${BLUE}▶ Removing packages...${NC}"

[[ "$UNINSTALL_ANTIDOTE" == true ]] && { uninstall_brew_package "antidote" || true; }
[[ "$UNINSTALL_STARSHIP" == true ]] && { uninstall_brew_package "starship" || true; }
[[ "$UNINSTALL_ZELLIJ" == true ]] && { uninstall_brew_package "zellij" || true; }
[[ "$UNINSTALL_BAT" == true ]] && { uninstall_brew_package "bat" || true; }
[[ "$UNINSTALL_EZA" == true ]] && { uninstall_brew_package "eza" || true; }
[[ "$UNINSTALL_FZF" == true ]] && { uninstall_brew_package "fzf" || true; }
[[ "$UNINSTALL_FD" == true ]] && { uninstall_brew_package "fd" || true; }
[[ "$UNINSTALL_RIPGREP" == true ]] && { uninstall_brew_package "ripgrep" || true; }
[[ "$UNINSTALL_JQ" == true ]] && { uninstall_brew_package "jq" || true; }
[[ "$UNINSTALL_YQ" == true ]] && { uninstall_brew_package "yq" || true; }
[[ "$UNINSTALL_AG" == true ]] && { uninstall_brew_package "the_silver_searcher" || true; }
[[ "$UNINSTALL_ZOXIDE" == true ]] && { uninstall_brew_package "zoxide" || true; }
[[ "$UNINSTALL_TREE" == true ]] && { uninstall_brew_package "tree" || true; }
[[ "$UNINSTALL_WATCH" == true ]] && { uninstall_brew_package "watch" || true; }
[[ "$UNINSTALL_HTOP" == true ]] && { uninstall_brew_package "htop" || true; }
[[ "$UNINSTALL_KUBECTX" == true ]] && { uninstall_brew_package "kubectx" || true; }
[[ "$UNINSTALL_STERN" == true ]] && { uninstall_brew_package "stern" || true; }
[[ "$UNINSTALL_K9S" == true ]] && { uninstall_brew_package "k9s" || true; }
[[ "$UNINSTALL_ET" == true ]] && { uninstall_brew_package "et" || true; }

echo ""

# ============================================================
# UNINSTALL OH MY ZSH
# ============================================================
if [[ "$UNINSTALL_OH_MY_ZSH" == true ]]; then
  echo -e "${BLUE}▶ Removing Oh My Zsh...${NC}"
  
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    rm -rf "$HOME/.oh-my-zsh"
    echo -e "  ${GREEN}✔${NC} Removed: ~/.oh-my-zsh"
  fi
  
  echo ""
fi

# ============================================================
# CREATE MINIMAL ZSHRC IF REMOVED
# ============================================================
if [[ "$UNINSTALL_SHELL_CONFIG" == true ]] && [[ "${CREATE_MINIMAL_ZSHRC:-true}" == true ]] && [[ ! -f "$HOME/.zshrc" ]]; then
  echo -e "${BLUE}▶ Creating minimal .zshrc...${NC}"
  
  cat > "$HOME/.zshrc" << 'EOF'
# Minimal zshrc (generated by shell-bootstrap uninstaller)
# Homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Basic settings
export EDITOR="nano"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"

# Prompt
PS1="%n@%m %~ %# "
EOF
  
  echo -e "  ${GREEN}✔${NC} Created minimal ~/.zshrc"
  echo ""
fi

# ============================================================
# CLEANUP BREW
# ============================================================
if [[ "${CLEANUP_HOMEBREW:-true}" == true ]]; then
  echo -e "${BLUE}▶ Cleaning up Homebrew...${NC}"
  brew cleanup -s 2>/dev/null || true
  echo -e "  ${GREEN}✔${NC} Homebrew cleaned"
fi

# ============================================================
# DONE
# ============================================================
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Uninstall complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo ""

if [[ "$UNINSTALL_SHELL_CONFIG" == true ]]; then
  echo -e "${YELLOW}Note:${NC} A minimal .zshrc was created. You may want to customize it."
  echo ""
fi
