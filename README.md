# 🚀 Shell Bootstrap

<div align="center">

[![Zsh](https://img.shields.io/badge/Shell-Zsh-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.zsh.org/)
[![Homebrew](https://img.shields.io/badge/Homebrew-FBB040?style=for-the-badge&logo=homebrew&logoColor=black)](https://brew.sh/)

**Production-ready macOS shell configuration for DevOps engineers, SREs, and developers.**

*One-command setup • 200+ aliases • Starship prompt • Kubernetes tools • Fuzzy completion*

[📦 Quick Start](#-quick-start) •
[✨ Features](#-features) •
[📚 Docs](#-documentation) •
[⚙️ Configure](#️-configuration)

</div>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎨 **Starship Prompt** | Ultra-iconic prompt with Apple logo, Git metrics, K8s, AWS, GCP, Azure, Terraform |
| 🖥️ **Warp Terminal** | Mirrored Warp settings (`~/.warp`), themes, font settings, and PS1 integration |
| ⚡ **200+ Aliases** | Shortcuts for Git, kubectl, Terraform, Docker, Lazygit, Lazydocker |
| 🔌 **Smart Plugins** | fzf-tab (with rich previews), forgit, autopair, autosuggestions, fast syntax highlighting |
| 📦 **50+ DevOps Tools** | k9s, stern, helm, argocd, trivy, atuin, uv, orbstack, and more |
| 🚀 **Blazing Fast Startup** | Lazy NVM loading and cached completions (~0.2s shell spawn) |
| 🤖 **Agentic Superpowers** | Integrated obra/superpowers (15 critical-thinking skills) & Agent Reach |
| 🛠️ **Configurable** | Toggle any package on/off via `config.sh` |
| 🔄 **Idempotent** | Safe to re-run, auto-creates backups of ~/.zshrc, ~/.shell, ~/.warp |


---

## � Quick Start

```bash
# Clone
git clone https://github.com/yourusername/shell-bootstrap.git
cd shell-bootstrap

# (Optional) Customize
vim config.sh
vim Brewfile

# Install
./bootstrap.sh
```

### Install Options

| Command | Description |
|---------|-------------|
| `./bootstrap.sh` | Interactive mode |
| `./bootstrap.sh --yes` | Non-interactive (CI/CD) |
| `./bootstrap.sh --help` | Show help |

---

## 🧰 What's Included

### 🐚 Shell Core
| Tool | Description |
|------|-------------|
| [Antidote](https://antidote.sh/) | ⚡ Fast Zsh plugin manager |
| [Starship](https://starship.rs/) | 🚀 Cross-shell prompt |
| [Zellij](https://zellij.dev/) | 📺 Terminal multiplexer |
| [Oh My Zsh](https://ohmyz.sh/) | 🔌 Plugin framework |

### 🛠️ CLI Tools
| Tool | Description |
|------|-------------|
| `eza` | 📁 Modern `ls` with icons |
| `bat` | 🦇 `cat` with syntax highlighting |
| `fzf` | 🔍 Fuzzy finder |
| `ripgrep` | ⚡ Fast grep |
| `fd` | 🔎 Fast find |
| `zoxide` | 📂 Smarter `cd` |
| `btop` | 📊 Beautiful system monitor |
| `mole` | 🐹 Mac cleanup & optimizer |
| `bun` | ⚡ Fast JS runtime (for oh-my-opencode) |

### ☸️ DevOps Tools
| Tool | Description |
|------|-------------|
| `kubectl` | ☸️ Kubernetes CLI |
| `k9s` | 🐶 Kubernetes TUI |
| `helm` | ⎈ K8s package manager |
| `stern` | 📜 Multi-pod log tailing |
| `terraform` | 🏗️ Infrastructure as Code |
| `argocd` | 🔄 GitOps CLI |
| `trivy` | 🔒 Security scanner |
| `opencode` | 🤖 AI terminal coding agent |

### 🖥️ Desktop Apps (via `Brewfile`)
| App | Description |
|-----|-------------|
| Warp | 🤖 AI-powered terminal |
| OrbStack | 🐳 Docker alternative |
| Lens | 👁️ Kubernetes IDE |
| VS Code | 📝 Code editor |

---

## ⚙️ Configuration

Edit `config.sh` before installing:

```bash
# Core packages
INSTALL_ANTIDOTE=true     # 🔌 Plugin manager
INSTALL_STARSHIP=true     # 🚀 Prompt
INSTALL_K9S=true          # 🐶 K8s TUI

# Optional
INSTALL_NERD_FONT=true    # 🔤 Required for icons
INSTALL_APPS=true         # 📦 Install from Brewfile
```

---

## ⌨️ Key Aliases

### 🔀 Git
```bash
gs              # git status
gp              # git push
gl              # git log --oneline
gco-fzf         # checkout with fuzzy search
gac "msg"       # add all + commit
gpush           # push and set upstream
```

### ☸️ Kubernetes
```bash
k               # kubectl
kx / kn         # switch context / namespace
kgp             # kubectl get pods
kl              # kubectl logs
ksh             # shell into pod (fzf)
```

### 🐳 Docker
```bash
dps             # docker ps
dsh             # shell into container
dc              # docker-compose
```

### 🏗️ Terraform
```bash
tf              # terraform
tfi / tfp       # init / plan
tfa             # apply
```

### 🐹 Mole (System Optimizer)
```bash
mo                    # Interactive menu
mo touchid            # Enable Touch ID for sudo (RECOMMENDED!)
mo completion         # Setup shell tab completion
mo status             # Live system health dashboard
mo clean              # Deep cleanup
mo clean --dry-run    # Preview cleanup first
mo analyze            # Visual disk explorer
mo uninstall          # Remove apps + leftovers
mo optimize           # Refresh caches & services
mo purge              # Clean project build artifacts
```

> **💡 Tips:**
> - Always run `mo clean --dry-run` first to preview
> - Use `--debug` for detailed logs
> - Supports Vim bindings (`h/j/k/l`)
> - In `mo status`, press `k` to toggle cat, `q` to quit
> - **Optional:** Install quick launchers for Raycast/Alfred:
>   ```bash
>   curl -fsSL https://raw.githubusercontent.com/tw93/Mole/main/scripts/setup-quick-launchers.sh | bash
>   ```

### 🤖 OpenCode (AI Terminal Agent)
```bash
opencode                      # Start AI coding session
opencode --version            # Check version
```

> **💡 Oh My OpenCode** (Multi-Agent Extension):
> ```bash
> # Requires bun runtime (auto-installed via Brewfile)
> bunx oh-my-opencode install --no-tui --claude=no --chatgpt=no --gemini=no
> ```
> Features: Background agents, Git mastery, multi-model support

### 🧹 Shell Config Agent ⚠️
> **Experimental** - AI-powered shell optimization with privacy protection.

```bash
shell-organize              # Preview only (safe, default)
shell-organize-apply        # Apply changes (creates backup)
shell-sync                  # Sync ~/.shell/ to project
```

> **💡 Configuration** (in `~/.shell/zsh/exports.zsh`):
> ```bash
> export SHELL_AGENT_MODEL="openrouter/mistralai/devstral-2512:free"
> export SHELL_AGENT_OPENROUTER_KEY="your-key"
> ```
> 
> 🪄 **Pro Tip:** Include `ultrawork` or `ulw` in prompts for parallel agents.
> 
> 🔒 **Privacy:** Only analyzes command frequency, never stores secrets.

---

## 📚 Documentation

| Guide | Topics |
|-------|--------|
| [🛠️ CLI Tools](docs/cli-tools.md) | eza, fzf, ripgrep, bat, btop |
| [☸️ DevOps Tools](docs/devops-tools.md) | kubectl, helm, terraform |
| [🔌 ZSH Plugins](docs/zsh-plugins.md) | Plugins explained |
| [🔀 Git Workflow](docs/git-workflow.md) | Aliases, lazygit, gh |
| [🍎 macOS Apps](docs/macos-apps.md) | Warp, OrbStack, Lens |
| [⚡ Productivity](docs/productivity-tips.md) | Workflows & shortcuts |
| [🤖 Shell Agent](docs/shell-agent.md) | OpenCode, OpenRouter setup |

---

## 🗑️ Uninstall

```bash
./uninstall.sh              # Interactive menu
./uninstall.sh --config     # Use uninstall_config.sh
```

---

## 📁 Project Structure

```
shell-bootstrap/
├── 📄 bootstrap.sh          # Main installer
├── 📄 uninstall.sh          # Uninstaller
├── ⚙️ config.sh             # Installation config
├── 🍺 Brewfile              # Desktop apps list
├── 📚 docs/                 # Documentation
├── 🤖 agent/                # Shell Config Agent
│   ├── organize_shell.sh   # Organize shell configs
│   ├── sync_to_project.sh  # Sync to project
│   └── prompts/            # Agent prompts
└── 🐚 shell/
    ├── zsh/
    │   ├── aliases.zsh      # 200+ aliases
    │   ├── functions.zsh    # Utility functions
    │   ├── exports.zsh      # Environment vars
    │   ├── tools.zsh        # Tool init
    │   └── plugins.list     # Antidote plugins
    ├── starship/
    │   └── starship.toml    # Prompt config
    ├── warp/
    │   ├── settings.toml    # Warp preferences & theme
    │   └── tab_configs/     # Startup tabs & panes
    └── zellij/
        └── config.kdl       # Multiplexer config
```

---

## 💻 Compatibility

| Platform | Status |
|----------|--------|
| Apple Silicon (M1/M2/M3/M4) | ✅ Native |
| Intel Mac | ✅ Compatible |

---

## 🤝 Contributing

Contributions welcome! Please open an issue or PR.

---

<div align="center">

**Keywords:** macOS terminal setup, zsh configuration, DevOps shell, Starship prompt, Kubernetes tools, kubectl aliases, terraform shortcuts, docker aliases, productivity shell, developer terminal, Apple Silicon terminal, M1 Mac terminal setup, dotfiles, shell bootstrap

</div>
