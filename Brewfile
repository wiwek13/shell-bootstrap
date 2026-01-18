# ============================================================
# 📦 SHELL BOOTSTRAP APPLICATIONS MANIFEST (BREWFILE)
# ============================================================
# This file defines the Homebrew formulae, casks, and taps to be installed.
# The bootstrap script installs these using `brew bundle`.
#
# 📝 INSTRUCTIONS:
# 1. ADD packages: One per line.
#    - Formula:  brew "package" (e.g., brew "wget")
#    - Cask:     cask "package" (e.g., cask "google-chrome")
#    - Tap:      tap "user/repo" (e.g., tap "hashicorp/tap")
# 2. DISABLE packages: Comment out the line with # (e.g., # cask "spotify")
# 3. SEARCH: Use `brew search <query>` to find names.
#
# 💡 TIP: Lines starting with # are ignored.
# ============================================================

# ============================================================
# 🚀 LANGUAGES & RUNTIMES
# ============================================================
brew "node"                          # Node.js runtime
brew "nvm"                           # (Formula) Node version manager
brew "python"                        # Python 3
brew "pyenv"                         # Python version manager

# ============================================================
# 🛠️ CLI CORE & HISTORY
# ============================================================
brew "curl"                          # HTTP client
brew "wget"                          # File downloader
brew "jq"                            # JSON processor
brew "tlrc"                          # Simplified man pages (tldr client)
brew "atuin"                         # Shell history sync
brew "direnv"                        # Auto-load .envrc files
brew "fastfetch"                     # System info display
brew "pre-commit"                    # Git hooks manager

# ============================================================
# 🔄 GIT & VERSION CONTROL
# ============================================================
brew "gh"                            # GitHub CLI
brew "lazygit"                       # Git TUI
brew "git-delta"                     # Better git diff viewer
tap "anomalyco/tap"           # OpenCode tap
brew "anomalyco/tap/opencode"        # AI terminal coding assistant

# ============================================================
# ☁️ INFRASTRUCTURE AS CODE (Terraform/AWS)
# ============================================================
brew "awscli"                        # AWS CLI v2
tap "hashicorp/tap"           # HashiCorp official tap
brew "hashicorp/tap/terraform"       # Terraform from official tap
brew "tfswitch"                      # Terraform version switcher

# ============================================================
# ☸️ KUBERNETES ECOSYSTEM
# ============================================================
brew "kubernetes-cli"                # kubectl
brew "kubectl-ai"                    # AI-powered kubectl
brew "helm"                          # Kubernetes package manager
brew "helmfile"                      # Helm chart management
brew "kustomize"                     # Kubernetes config customization
brew "argocd"                        # GitOps CLI
# cask "lens"                   # Kubernetes IDE (temporarily disabled - download issue)

# ============================================================
# 🐳 DOCKER & CONTAINERS
# ============================================================
cask "orbstack"               # Docker/Linux VM (lightweight)
brew "dive"                          # Docker image layer explorer
brew "trivy"                         # Container security scanner

# ============================================================
# 🔌 NETWORK & API TOOLS
# ============================================================
brew "httpie"                        # Better HTTP client
brew "grpcurl"                       # gRPC debugging
# cask "postman"                # API testing

# ============================================================
# 📊 SYSTEM MONITORING
# ============================================================
brew "btop"                          # Beautiful system monitor
brew "ncdu"                          # Disk usage analyzer (TUI)
brew "dust"                          # Modern du (disk usage)
brew "duf"                           # Modern df (disk free)
brew "procs"                         # Modern ps replacement
cask "stats"                  # Menu bar system monitor

# ============================================================
# 🖥️ TERMINAL EMULATORS
# ============================================================
cask "warp"                   # Modern AI terminal
# cask "amazon-q"               # Terminal autocomplete (temporarily disabled - download issue)

# ============================================================
# 📝 CODE EDITORS
# ============================================================
cask "antigravity"            # AI coding assistant
# cask "sublime-text"           # Fast text editor

# ============================================================
# 🌐 WEB BROWSERS
# ============================================================
cask "vivaldi"                # Vivaldi browser
cask "google-chrome"          # Google Chrome

# ============================================================
# ⚡ PRODUCTIVITY & UTILITIES
# ============================================================
cask "maccy"                  # Clipboard manager
# cask "raycast"                # Spotlight replacement (Highly Recommended)
# cask "rectangle"              # Window management
# cask "hiddenbar"              # Menu bar organizer
# cask "appcleaner"             # Clean app uninstaller
cask "obsidian"               # Note-taking (Markdown)
# cask "notion"                 # Docs & wikis

# ============================================================
# 💾 DATABASE MANAGEMENT
# ============================================================
cask "dbeaver-community"      # Database client
# cask "tableplus"              # Database GUI

# ============================================================
# 🔐 SECURITY & PASSWORDS
# ============================================================
cask "bitwarden"              # Password manager
# cask "protonvpn"              # Free VPN

# ============================================================
# 💬 COMMUNICATION
# ============================================================
cask "ayugram"                # Telegram client
cask "slack"                  # Team communication
# cask "discord"                # Gaming/community chat
# cask "zoom"                   # Video conferencing

# ============================================================
# 📥 DOWNLOAD MANAGERS
# ============================================================
tap "amir1376/tap"            # AB Download Manager tap
cask "ab-download-manager"    # AB Download Manager
# cask "free-download-manager"  # Download manager (FDM)
# cask "qbittorrent"            # Torrent client

# ============================================================
# 🎬 MEDIA & PLAYERS
# ============================================================
cask "vlc"                    # Media player
# cask "iina"                   # Modern video player
# cask "spotify"                # Music streaming

# ============================================================
# 🗜️ ARCHIVE UTILITIES
# ============================================================
cask "keka"                   # Archive utility

# ============================================================
# 🐹 SYSTEM OPTIMIZATION (Mole)
# ============================================================
# Mole - All-in-one Mac cleanup & optimization tool
# Features: Deep cleaning, smart uninstaller, disk analyzer, live monitoring
# After install, run these commands:
#   mo touchid      # Enable Touch ID for sudo (HIGHLY RECOMMENDED)
#   mo completion   # Setup shell tab completion
#   mo status       # Live system health dashboard
#   mo clean        # Deep cleanup (use --dry-run first!)
#   mo analyze      # Visual disk explorer
brew "mole"                   # Deep clean and optimize your Mac

