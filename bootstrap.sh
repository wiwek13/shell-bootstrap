#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.shell-backup-$(date +%Y%m%d-%H%M%S)"

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
[[ -f "$HOME/.zshrc" ]] && EXISTING_FILES+=("~/.zshrc")
[[ -f "$HOME/.zprofile" ]] && EXISTING_FILES+=("~/.zprofile")
[[ -d "$HOME/.shell" ]] && EXISTING_FILES+=("~/.shell/")
[[ -f "$HOME/.zsh_plugins.txt" ]] && EXISTING_FILES+=("~/.zsh_plugins.txt")

if [[ ${#EXISTING_FILES[@]} -gt 0 ]]; then
  echo ""
  echo "⚠️  The following files/directories already exist and will be overwritten:"
  for f in "${EXISTING_FILES[@]}"; do
    echo "    • $f"
  done
  echo ""
  echo "  Backups will be saved to: $BACKUP_DIR"
  echo ""
  read -p "  Continue? (y/N) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted by user"
    exit 1
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

eval "$(/opt/homebrew/bin/brew shellenv)"

# ============================================================
# PACKAGE INSTALLATION
# ============================================================
echo ""
echo "▶ Installing packages..."

PACKAGES=(
  # Shell
  antidote
  starship
  zellij
  
  # CLI Tools
  bat
  eza               # Modern ls replacement (maintained fork of exa)
  the_silver_searcher
  fzf
  jq
  yq
  fd
  ripgrep
  tree
  watch
  htop
  
  # DevOps CLI
  kubectx       # Kubernetes context/namespace switching
  stern         # Multi-pod log tailing
  k9s           # Kubernetes TUI
  zoxide        # Smarter cd (directory jumping)
)

for pkg in "${PACKAGES[@]}"; do
  if ! brew list "$pkg" >/dev/null 2>&1; then
    echo "  Installing $pkg..."
    brew install "$pkg"
  else
    echo "  ✔ $pkg"
  fi
done

# Eternal Terminal (requires tap)
echo ""
echo "▶ Installing Eternal Terminal..."
if ! brew list et >/dev/null 2>&1; then
  brew tap MisterTea/et 2>/dev/null || true
  brew install MisterTea/et/et
else
  echo "  ✔ et"
fi

# ============================================================
# OH MY ZSH INSTALLATION
# ============================================================
echo ""
echo "▶ Checking Oh My Zsh..."

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "  Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "  ✔ Oh My Zsh already installed"
fi

# ============================================================
# FZF KEY BINDINGS
# ============================================================
echo ""
echo "▶ Setting up fzf..."
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
  echo "  ✔ fzf key bindings installed"
fi

# ============================================================
# DIRECTORY STRUCTURE
# ============================================================
echo ""
echo "▶ Creating directory structure..."

mkdir -p ~/.shell/{zsh,starship,zellij}
mkdir -p ~/.config/starship

# ============================================================
# COPY CONFIGURATION FILES
# ============================================================
echo ""
echo "▶ Copying configuration files..."

# Copy zsh configs
cp -v "$SCRIPT_DIR/shell/zsh/exports.zsh" ~/.shell/zsh/
cp -v "$SCRIPT_DIR/shell/zsh/aliases.zsh" ~/.shell/zsh/
cp -v "$SCRIPT_DIR/shell/zsh/functions.zsh" ~/.shell/zsh/
cp -v "$SCRIPT_DIR/shell/zsh/tools.zsh" ~/.shell/zsh/
cp -v "$SCRIPT_DIR/shell/zsh/plugins.list" ~/.shell/zsh/

# Copy starship config
cp -v "$SCRIPT_DIR/shell/starship/starship.toml" ~/.shell/starship/

# Copy zellij config
cp -v "$SCRIPT_DIR/shell/zellij/config.kdl" ~/.shell/zellij/

# ============================================================
# SYMLINKS
# ============================================================
echo ""
echo "▶ Creating symlinks..."

# Antidote plugins list
ln -sf ~/.shell/zsh/plugins.list ~/.zsh_plugins.txt
echo "  ✔ ~/.zsh_plugins.txt -> ~/.shell/zsh/plugins.list"

# Starship config (XDG compatibility)
ln -sf ~/.shell/starship/starship.toml ~/.config/starship/starship.toml
echo "  ✔ ~/.config/starship/starship.toml -> ~/.shell/starship/starship.toml"

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
EOF
echo "  ✔ ~/.zshrc"

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

echo ""
echo "📝 IMPORTANT: For best experience, install a Nerd Font"
echo "   Recommended: JetBrainsMono Nerd Font"
echo ""
echo "   brew tap homebrew/cask-fonts"
echo "   brew install --cask font-jetbrains-mono-nerd-font"
echo ""
echo "   Then set it in Warp → Settings → Appearance → Font"
echo ""
echo "════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. (Optional) Start Zellij: zellij"
echo ""
