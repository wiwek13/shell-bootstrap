#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.shell-backup-$(date +%Y%m%d-%H%M%S)"
FORCE_YES=false

# ============================================================
# LOAD CONFIGURATION
# ============================================================
CONFIG_FILE="$SCRIPT_DIR/config.sh"
if [[ -f "$CONFIG_FILE" ]]; then
  source "$CONFIG_FILE"
else
  echo "⚠️  No config.sh found, using defaults (install everything)"
  # Default: install everything
  INSTALL_ANTIDOTE=true
  INSTALL_STARSHIP=true
  INSTALL_ZELLIJ=true
  INSTALL_OH_MY_ZSH=true
  INSTALL_BAT=true
  INSTALL_EZA=true
  INSTALL_FZF=true
  INSTALL_FD=true
  INSTALL_RIPGREP=true
  INSTALL_JQ=true
  INSTALL_YQ=true
  INSTALL_AG=true
  INSTALL_ZOXIDE=true
  INSTALL_TREE=true
  INSTALL_WATCH=true
  INSTALL_HTOP=true
  INSTALL_KUBECTX=true
  INSTALL_STERN=true
  INSTALL_K9S=true
  INSTALL_ET=true
  INSTALL_ZSH_CONFIG=true
  INSTALL_STARSHIP_CONFIG=true
  INSTALL_ZELLIJ_CONFIG=true
  INSTALL_NERD_FONT=false
fi

# Parse arguments
for arg in "$@"; do
  case $arg in
    --yes|-y) FORCE_YES=true ;;
    --help|-h)
      echo "Usage: ./bootstrap.sh [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --yes, -y    Skip confirmation prompts (for CI/automation)"
      echo "  --help, -h   Show this help message"
      echo ""
      echo "Configuration:"
      echo "  Edit config.sh to choose what to install"
      exit 0
      ;;
  esac
done

echo "▶ Shell bootstrap starting (macOS only)"
echo ""

# ============================================================
# GUARDS
# ============================================================
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "❌ This bootstrap is for macOS only"
  exit 1
fi

# ============================================================
# BACKUP EXISTING CONFIGURATION
# ============================================================
backup_if_exists() {
  local file="$1"
  if [[ -e "$file" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -R "$file" "$BACKUP_DIR/"
    echo "  📦 Backed up: $file"
  fi
}

echo "▶ Checking for existing configurations..."

EXISTING_FILES=()
[[ -f "$HOME/.zshrc" ]] && EXISTING_FILES+=("$HOME/.zshrc")
[[ -f "$HOME/.zprofile" ]] && EXISTING_FILES+=("$HOME/.zprofile")
[[ -d "$HOME/.shell" ]] && EXISTING_FILES+=("$HOME/.shell/")
[[ -f "$HOME/.zsh_plugins.txt" ]] && EXISTING_FILES+=("$HOME/.zsh_plugins.txt")

if [[ ${#EXISTING_FILES[@]} -gt 0 ]]; then
  echo ""
  echo "⚠️  The following files/directories already exist and will be overwritten:"
  for f in "${EXISTING_FILES[@]}"; do
    echo "    • $f"
  done
  echo ""
  echo "  Backups will be saved to: $BACKUP_DIR"
  
  if [[ "$FORCE_YES" != true ]]; then
    echo ""
    read -p "  Continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "❌ Aborted by user"
      exit 1
    fi
  else
    echo ""
    echo "  --yes flag provided, continuing..."
  fi

  # Create backups
  echo ""
  echo "▶ Creating backups..."
  backup_if_exists "$HOME/.zshrc"
  backup_if_exists "$HOME/.zprofile"
  backup_if_exists "$HOME/.shell"
  backup_if_exists "$HOME/.zsh_plugins.txt"
  echo "  ✔ Backups saved to: $BACKUP_DIR"
fi

# ============================================================
# HOMEBREW INSTALLATION
# ============================================================
echo ""
echo "▶ Checking Homebrew..."

if ! command -v brew >/dev/null 2>&1; then
  echo "  Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  ✔ Homebrew already installed"
fi

# Detect Homebrew path (Apple Silicon vs Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "❌ Homebrew not found after installation"
  exit 1
fi

# ============================================================
# HELPER FUNCTION FOR PACKAGE INSTALLATION
# ============================================================
install_pkg() {
  local pkg="$1"
  if ! brew list "$pkg" >/dev/null 2>&1; then
    echo "  Installing $pkg..."
    brew install "$pkg"
  else
    echo "  ✔ $pkg"
  fi
}

skip_pkg() {
  local pkg="$1"
  echo "  ⏭ Skipping $pkg (disabled in config)"
}

# ============================================================
# PACKAGE INSTALLATION (respects config.sh)
# ============================================================
echo ""
echo "▶ Installing packages..."

# Shell core
[[ "$INSTALL_ANTIDOTE" == true ]] && install_pkg "antidote" || skip_pkg "antidote"
[[ "$INSTALL_STARSHIP" == true ]] && install_pkg "starship" || skip_pkg "starship"
[[ "$INSTALL_ZELLIJ" == true ]] && install_pkg "zellij" || skip_pkg "zellij"

# CLI essentials
[[ "$INSTALL_BAT" == true ]] && install_pkg "bat" || skip_pkg "bat"
[[ "$INSTALL_EZA" == true ]] && install_pkg "eza" || skip_pkg "eza"
[[ "$INSTALL_FZF" == true ]] && install_pkg "fzf" || skip_pkg "fzf"
[[ "$INSTALL_FD" == true ]] && install_pkg "fd" || skip_pkg "fd"
[[ "$INSTALL_RIPGREP" == true ]] && install_pkg "ripgrep" || skip_pkg "ripgrep"
[[ "$INSTALL_JQ" == true ]] && install_pkg "jq" || skip_pkg "jq"
[[ "$INSTALL_YQ" == true ]] && install_pkg "yq" || skip_pkg "yq"
[[ "$INSTALL_AG" == true ]] && install_pkg "the_silver_searcher" || skip_pkg "the_silver_searcher"
[[ "$INSTALL_ZOXIDE" == true ]] && install_pkg "zoxide" || skip_pkg "zoxide"

# System utilities
[[ "$INSTALL_TREE" == true ]] && install_pkg "tree" || skip_pkg "tree"
[[ "$INSTALL_WATCH" == true ]] && install_pkg "watch" || skip_pkg "watch"
[[ "$INSTALL_HTOP" == true ]] && install_pkg "htop" || skip_pkg "htop"

# DevOps tools
[[ "$INSTALL_KUBECTX" == true ]] && install_pkg "kubectx" || skip_pkg "kubectx"
[[ "$INSTALL_STERN" == true ]] && install_pkg "stern" || skip_pkg "stern"
[[ "$INSTALL_K9S" == true ]] && install_pkg "k9s" || skip_pkg "k9s"

# Eternal Terminal (requires tap)
if [[ "$INSTALL_ET" == true ]]; then
  echo ""
  echo "▶ Installing Eternal Terminal..."
  if ! brew list et >/dev/null 2>&1; then
    brew tap MisterTea/et 2>/dev/null || true
    brew install MisterTea/et/et
  else
    echo "  ✔ et"
  fi
else
  skip_pkg "et"
fi

# ============================================================
# OH MY ZSH INSTALLATION
# ============================================================
if [[ "$INSTALL_OH_MY_ZSH" == true ]]; then
  echo ""
  echo "▶ Checking Oh My Zsh..."

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "  Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "  ✔ Oh My Zsh already installed"
  fi
fi

# ============================================================
# FZF KEY BINDINGS
# ============================================================
if [[ "$INSTALL_FZF" == true ]]; then
  echo ""
  echo "▶ Setting up fzf..."
  if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    echo "  ✔ fzf key bindings installed"
  fi
fi

# ============================================================
# NERD FONT (optional)
# ============================================================
if [[ "$INSTALL_NERD_FONT" == true ]]; then
  echo ""
  echo "▶ Installing Nerd Font..."
  brew tap homebrew/cask-fonts 2>/dev/null || true
  if ! brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
    brew install --cask font-jetbrains-mono-nerd-font
  else
    echo "  ✔ JetBrainsMono Nerd Font already installed"
  fi
fi

# ============================================================
# DIRECTORY STRUCTURE
# ============================================================
echo ""
echo "▶ Creating directory structure..."

mkdir -p ~/.shell/{zsh,starship,zellij}
mkdir -p ~/.config/starship

# ============================================================
# COPY CONFIGURATION FILES (respects config.sh)
# ============================================================
echo ""
echo "▶ Copying configuration files..."

if [[ "$INSTALL_ZSH_CONFIG" == true ]]; then
  cp -v "$SCRIPT_DIR/shell/zsh/exports.zsh" ~/.shell/zsh/
  cp -v "$SCRIPT_DIR/shell/zsh/aliases.zsh" ~/.shell/zsh/
  cp -v "$SCRIPT_DIR/shell/zsh/functions.zsh" ~/.shell/zsh/
  cp -v "$SCRIPT_DIR/shell/zsh/tools.zsh" ~/.shell/zsh/
  cp -v "$SCRIPT_DIR/shell/zsh/plugins.list" ~/.shell/zsh/
fi

if [[ "$INSTALL_STARSHIP_CONFIG" == true ]]; then
  cp -v "$SCRIPT_DIR/shell/starship/starship.toml" ~/.shell/starship/
fi

if [[ "$INSTALL_ZELLIJ_CONFIG" == true ]]; then
  cp -v "$SCRIPT_DIR/shell/zellij/config.kdl" ~/.shell/zellij/
fi

# ============================================================
# SYMLINKS
# ============================================================
echo ""
echo "▶ Creating symlinks..."

# Antidote plugins list
if [[ "$INSTALL_ANTIDOTE" == true ]]; then
  ln -sf ~/.shell/zsh/plugins.list ~/.zsh_plugins.txt
  echo "  ✔ ~/.zsh_plugins.txt -> ~/.shell/zsh/plugins.list"
fi

# Starship config (XDG compatibility)
if [[ "$INSTALL_STARSHIP_CONFIG" == true ]]; then
  ln -sf ~/.shell/starship/starship.toml ~/.config/starship/starship.toml
  echo "  ✔ ~/.config/starship/starship.toml -> ~/.shell/starship/starship.toml"
fi

# ============================================================
# SHELL LOADER FILES
# ============================================================
echo ""
echo "▶ Writing shell loader files..."

# .zprofile (login shell)
cat > ~/.zprofile <<'EOF'
source "$HOME/.shell/zsh/exports.zsh"
EOF
echo "  ✔ ~/.zprofile"

# .zshrc (interactive shell)
cat > ~/.zshrc <<'EOF'
export ZSH="$HOME/.oh-my-zsh"

# Initialize completion system FIRST (required for compdef)
autoload -Uz compinit
compinit -C

# Load Antidote plugin manager
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"

# Source all zsh configs
for f in "$HOME"/.shell/zsh/*.zsh; do
  source "$f"
done

# Load plugins via Antidote
antidote load

# Initialize Oh My Zsh runtime
source "$ZSH/oh-my-zsh.sh"

# fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Rehash PATH to pick up new binaries
hash -r 2>/dev/null
EOF
echo "  ✔ ~/.zshrc"

# ============================================================
# INSTALL APPLICATIONS FROM apps.txt
# ============================================================
APPS_FILE="$SCRIPT_DIR/apps.txt"
if [[ "${INSTALL_APPS:-true}" == true ]] && [[ -f "$APPS_FILE" ]]; then
  echo ""
  echo "▶ Installing applications from apps.txt..."
  
  while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip empty lines and comments
    [[ -z "$line" ]] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    
    # Extract package name (remove inline comments)
    pkg=$(echo "$line" | sed 's/#.*//' | xargs)
    [[ -z "$pkg" ]] && continue
    
    # Check if it's a tap
    if [[ "$pkg" == --tap* ]]; then
      tap_name=$(echo "$pkg" | sed 's/--tap //')
      if ! brew tap | grep -q "^$tap_name$"; then
        echo "  Tapping $tap_name..."
        brew tap "$tap_name" || echo "    ⚠️ Failed to tap $tap_name"
      else
        echo "  ⏭ Skipping $tap_name (already tapped)"
      fi
    # Check if it's a cask
    elif [[ "$pkg" == --cask* ]]; then
      cask_name=$(echo "$pkg" | sed 's/--cask //')
      if ! brew list --cask "$cask_name" >/dev/null 2>&1; then
        echo "  Installing (cask) $cask_name..."
        brew install --cask "$cask_name" || echo "    ⚠️ Failed to install $cask_name"
      else
        echo "  ⏭ Skipping $cask_name (already installed)"
      fi
    else
      # Regular formula (supports tap/formula format like hashicorp/tap/terraform)
      formula_name=$(echo "$pkg" | awk -F'/' '{print $NF}')
      if ! brew list "$formula_name" >/dev/null 2>&1; then
        echo "  Installing $pkg..."
        brew install "$pkg" || echo "    ⚠️ Failed to install $pkg"
      else
        echo "  ⏭ Skipping $pkg (already installed)"
      fi
    fi
  done < "$APPS_FILE"
else
  echo ""
  echo "⏭ No apps.txt found, skipping application installation"
fi

# ============================================================
# POST-INSTALL MAINTENANCE
# ============================================================
echo ""
echo "▶ Running post-install maintenance..."

echo "  Updating Homebrew..."
brew update

echo "  Upgrading packages..."
brew upgrade

echo "  Running cleanup..."
brew cleanup -s

echo "  Running diagnostics..."
brew doctor || true

echo "  Final cleanup..."
brew cleanup

echo "  ✔ Maintenance complete"

# ============================================================
# DONE
# ============================================================
echo ""
echo "════════════════════════════════════════════════════════"
echo "✔ Bootstrap completed successfully!"
echo "════════════════════════════════════════════════════════"

if [[ -d "$BACKUP_DIR" ]]; then
  echo ""
  echo "📦 Your old configs were backed up to:"
  echo "   $BACKUP_DIR"
  echo ""
  echo "   To restore: cp -R $BACKUP_DIR/* ~/"
fi

if [[ "$INSTALL_NERD_FONT" != true ]]; then
  echo ""
  echo "📝 IMPORTANT: For best experience, install a Nerd Font"
  echo "   Enable INSTALL_NERD_FONT=true in config.sh, or manually:"
  echo ""
  echo "   brew tap homebrew/cask-fonts"
  echo "   brew install --cask font-jetbrains-mono-nerd-font"
  echo ""
  echo "   Then set it in Warp → Settings → Appearance → Font"
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. (Optional) Start Zellij: zellij"
echo ""

