# ============================================================
# 📦 SHELL BOOTSTRAP APPLICATIONS MANIFEST (BREWFILE)
# ============================================================
# Mirror of the actual configuration & backup setup for macOS
# Install all packages using: brew bundle --file=Brewfile
# ============================================================

# ============================================================
# 🚰 TAPS
# ============================================================
tap "hashicorp/tap"                  # HashiCorp official tools
tap "warrensbox/tap"                 # tfswitch tap
tap "mistertea/et"                   # Eternal Terminal tap
tap "abue-ammar/tinycast"            # Tinycast tap

# ============================================================
# 🚀 LANGUAGES, RUNTIMES & PACKAGE MANAGERS
# ============================================================
brew "node"                          # Node.js JavaScript runtime
brew "nvm"                           # Node Version Manager
brew "python"                        # Python 3
brew "pyenv"                         # Python version manager
brew "uv"                            # Ultra-fast Python package & project manager

# ============================================================
# 🐚 SHELL CORE & PROMPT
# ============================================================
brew "antidote"                      # Fast zsh plugin manager
brew "starship"                      # Cross-shell prompt with rich Nerd Font icons
brew "zellij"                        # Modern terminal workspace & multiplexer
brew "atuin"                         # Magical shell history with SQLite & sync
brew "zoxide"                        # Smarter cd command with frecency
brew "direnv"                        # Per-directory environment variable manager

# ============================================================
# 🛠️ CLI ESSENTIALS & MODERN REPLACEMENTS
# ============================================================
brew "bat"                           # Cat clone with syntax highlighting and git integration
brew "eza"                           # Modern, feature-rich replacement for ls
brew "fd"                            # Simple, fast, and user-friendly alternative to find
brew "ripgrep"                       # Blazingly fast grep replacement
brew "the_silver_searcher"           # Code searching tool (ag)
brew "fzf"                           # Command-line fuzzy finder
brew "jq"                            # Lightweight and flexible command-line JSON processor
brew "yq"                            # Portable command-line YAML, JSON, XML processor
brew "tlrc"                          # Fast tldr client for simplified man pages
brew "tree"                          # Recursive directory listing program
brew "watch"                         # Execute a program periodically
brew "fastfetch"                     # Fast, customizable system information tool
brew "curl"                          # Command line tool for transferring data with URLs
brew "wget"                          # Internet file retriever

# ============================================================
# 🔄 GIT & VERSION CONTROL
# ============================================================
brew "gh"                            # GitHub official command line tool
brew "lazygit"                       # Simple terminal UI for git commands
brew "git-delta"                     # Syntax-highlighting pager for git, diff, and grep
brew "pre-commit"                    # Framework for managing git pre-commit hooks

# ============================================================
# ☁️ CLOUD & INFRASTRUCTURE AS CODE (IaC)
# ============================================================
brew "awscli"                        # Universal Command Line Interface for Amazon Web Services
cask "gcloud-cli"                    # Google Cloud SDK & command-line tools
brew "oci-cli"                       # Oracle Cloud Infrastructure CLI
brew "hashicorp/tap/terraform"       # Terraform IaC tool from official HashiCorp tap
cask "warrensbox/tap/tfswitch"       # Terraform version switcher

# ============================================================
# ☸️ KUBERNETES & CONTAINERS (Platform / DevOps / SRE)
# ============================================================
brew "kubernetes-cli"                # Kubernetes command-line interface (kubectl)
brew "kubecolor"                     # Colorizes kubectl output for improved readability
brew "kubeconform"                   # FAST, schema-validating Kubernetes manifest checker
brew "kubectl-ai"                    # AI assistant plugin for Kubernetes kubectl
brew "kubectx"                       # Fast Kubernetes context and namespace switcher
brew "k9s"                           # Kubernetes CLI management dashboard TUI
brew "stern"                         # Multi-pod and multi-container log tailing
brew "helm"                          # Kubernetes package manager
brew "helmfile"                      # Declarative spec for deploying Helm charts
brew "kustomize"                     # Template-free customization of Kubernetes YAML
brew "argocd"                        # Declarative GitOps continuous delivery tool for Kubernetes
brew "dive"                          # Tool for exploring Docker image layers & contents
brew "trivy"                         # Comprehensive security & vulnerability scanner for containers/IaC
cask "orbstack"                      # Ultra-fast, lightweight Docker Desktop and Linux VM alternative

# ============================================================
# 🔐 SECURITY & SECRETS MANAGEMENT
# ============================================================
brew "sops"                          # Mozilla SOPS: encrypts YAML/JSON/ENV files seamlessly
brew "age"                           # Simple, modern and secure file encryption tool
brew "gitleaks"                      # Blazing fast scanner for secrets, API tokens and keys
brew "trufflehog"                    # Deep credential and secret search engine

# ============================================================
# 🔌 NETWORKING & REMOTE ACCESS
# ============================================================
brew "httpie"                        # User-friendly HTTP client for APIs
brew "grpcurl"                       # Command-line tool for interacting with gRPC servers
brew "mistertea/et/et"               # Eternal Terminal (re-connectable remote shell)

# ============================================================
# 📊 SYSTEM MONITORING & DISK UTILITIES
# ============================================================
brew "btop"                          # Resource monitor with beautiful UI and graphs
brew "htop"                          # Interactive process viewer
brew "procs"                         # Modern replacement for ps with color and tree view
brew "ncdu"                          # NCurses disk usage analyzer
brew "dust"                          # More intuitive du (disk usage) in Rust
brew "duf"                           # Modern Disk Usage/Free utility
brew "mole"                          # Deep Mac cleaner and optimizer
cask "stats"                         # Comprehensive macOS menu bar system monitor
cask "vorssaint"                     # Menu bar toolkit (keep-awake, system monitor, volume)

# ============================================================
# 🔨 BUILD TOOLS & COMPILERS
# ============================================================
brew "cmake"                         # Cross-platform build generator
brew "automake"                      # Tool for generating GNU Standards-compliant Makefiles
brew "libtool"                       # Generic library support script
brew "just"                          # Modern, handy alternative to make for project automation

# ============================================================
# 🖥️ TERMINAL EMULATORS & FONTS
# ============================================================
cask "warp"                          # Modern AI-first terminal emulator
cask "ghostty"                       # Fast, native GPU-accelerated terminal by Mitchell Hashimoto
cask "font-jetbrains-mono-nerd-font" # Developer font patched with high-resolution Nerd Font icons

# ============================================================
# 🤖 AI & DEVELOPER PRODUCTIVITY
# ============================================================
brew "act"                           # Run GitHub Actions pipelines locally inside Docker
brew "yazi"                          # Blazing-fast terminal file manager written in Rust
cask "antigravity-cli"               # Google Antigravity (AGY) agentic coding platform
if Hardware::CPU.arm?
  cask "tinycast"                    # Fast, lightweight native macOS launcher & clipboard history (Apple Silicon)
else
  cask "tinycast-universal"          # Fast, lightweight native macOS launcher & clipboard history (Intel/Universal)
end

# ============================================================
# 🌐 WEB BROWSERS & PRODUCTIVITY CASKS
# ============================================================
cask "google-chrome"                 # Google Chrome web browser
cask "vivaldi"                       # Vivaldi power-user web browser
cask "dbeaver-community"             # Universal database GUI tool
cask "keka"                          # File archiver and extractor for macOS
