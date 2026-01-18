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

# Cleanup old backups, keeping only the N most recent
cleanup_old_backups() {
  local keep="${BACKUPS_TO_KEEP:-5}"
  
  # Skip if disabled (0 or empty)
  if [[ "$keep" -le 0 ]]; then
    return 0
  fi
  
  # Find all backup directories, sorted by date (oldest first)
  local backups=()
  while IFS= read -r dir; do
    [[ -d "$dir" ]] && backups+=("$dir")
  done < <(ls -dt "$HOME"/.shell-backup-* 2>/dev/null)
  
  local total=${#backups[@]}
  local to_delete=$((total - keep))
  
  if [[ $to_delete -gt 0 ]]; then
    echo ""
    echo "▶ Cleaning up old backups (keeping $keep most recent)..."
    for ((i = keep; i < total; i++)); do
      rm -rf "${backups[$i]}"
      echo "  🗑️ Removed: ${backups[$i]}"
    done
    echo "  ✔ Removed $to_delete old backup(s)"
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
    echo "  ⏭ $pkg (already installed)"
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
    echo "  ⏭ et (already installed)"
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
APPS_FILE="$SCRIPT_DIR/Brewfile"
if [[ "${INSTALL_APPS:-true}" == true ]]; then
  if [[ -f "$APPS_FILE" ]]; then
    echo ""
    echo "▶ Installing applications from Brewfile..."
    
    # Ensure Homebrew bundle is available (it's built-in, but good to check)
    brew bundle check --file="$APPS_FILE" >/dev/null 2>&1 || {
      echo "  Running brew bundle..."
      brew bundle --file="$APPS_FILE" || echo "  ⚠️ Some packages failed to install. Check output above."
    }
    echo "  ✅ Applications up to date"
  else
    echo "  ⏭ No Brewfile found, skipping application installation"
  fi
fi

# ============================================================
# INSTALL RAYCAST (if enabled)
# ============================================================
if [[ "${INSTALL_RAYCAST:-false}" == true ]]; then
  echo ""
  echo "▶ Installing Raycast..."
  if ! brew list --cask raycast >/dev/null 2>&1; then
    brew install --cask raycast || echo "  ⚠️ Failed to install Raycast"
  else
    echo "  ⏭ Raycast already installed"
  fi
fi

# ============================================================
# INSTALL MOLE QUICK LAUNCHERS (if enabled)
# ============================================================
if [[ "${INSTALL_MOLE_LAUNCHERS:-false}" == true ]]; then
  echo ""
  echo "▶ Installing Mole quick launchers for Raycast/Alfred..."
  curl -fsSL https://raw.githubusercontent.com/tw93/Mole/main/scripts/setup-quick-launchers.sh | bash || echo "  ⚠️ Failed to install Mole launchers"
  echo "  ✔ Mole launchers installed"
fi

# ============================================================
# INSTALL OPENCODE (if enabled and not already installed)
# ============================================================
if [[ "${INSTALL_OPENCODE:-true}" == true ]]; then
  if ! command -v opencode &>/dev/null; then
    echo ""
    echo "▶ Installing OpenCode..."
    brew tap anomalyco/tap 2>/dev/null || true
    brew install anomalyco/tap/opencode || echo "  ⚠️ Failed to install OpenCode"
  else
    echo ""
    echo "  ✔ OpenCode already installed ($(opencode --version 2>/dev/null || echo 'unknown version'))"
  fi
fi

# ============================================================
# INSTALL OH MY OPENCODE (if enabled)
# ============================================================
if [[ "${INSTALL_OH_MY_OPENCODE:-false}" == true ]]; then
  echo ""
  echo "▶ Installing Oh My OpenCode (multi-agent extension)..."
  if command -v npx &>/dev/null; then
    if npx -y oh-my-opencode install --no-tui; then
      echo "  ✔ Oh My OpenCode installed"
    else
      echo "  ⚠️ Failed to install Oh My OpenCode"
    fi
  elif command -v bunx &>/dev/null; then
    if bunx -y oh-my-opencode install --no-tui; then
      echo "  ✔ Oh My OpenCode installed"
    else
      echo "  ⚠️ Failed to install Oh My OpenCode"
    fi
  else
    echo "  ⚠️ npx or bunx not found, skipping Oh My OpenCode"
    echo "     Install manually: npx -y oh-my-opencode install"
  fi
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

# Cleanup old backups
cleanup_old_backups

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

