# Shell Bootstrap

Opinionated DevOps shell setup for **macOS + zsh + Warp**.

## ✨ Features

- **Modern prompt** with Starship (DevOps-focused theme)
- **200+ productivity aliases** for Git, Kubernetes, Docker, Terraform, AWS
- **Smart plugins** with fzf-tab, autosuggestions, syntax highlighting
- **Configurable** — choose what to install via `config.sh`

## Quick Install

```bash
git clone https://github.com/<your-username>/shell-bootstrap.git
cd shell-bootstrap
./bootstrap.sh
```

### Customize Installation

Edit `config.sh` before running:

```bash
# config.sh - set to true/false
INSTALL_ANTIDOTE=true
INSTALL_STARSHIP=true
INSTALL_K9S=false        # Skip if not using Kubernetes
INSTALL_NERD_FONT=true   # Auto-install font
```

### Install Options

```bash
./bootstrap.sh          # Interactive
./bootstrap.sh --yes    # Non-interactive (CI)
./bootstrap.sh --help   # Show help
```

## Uninstall

```bash
./uninstall.sh
```

## Packages

### Shell Core
| Package | Config Variable |
|---------|-----------------|
| antidote | `INSTALL_ANTIDOTE` |
| starship | `INSTALL_STARSHIP` |
| zellij | `INSTALL_ZELLIJ` |

### CLI Tools
| Package | Config Variable |
|---------|-----------------|
| bat | `INSTALL_BAT` |
| eza | `INSTALL_EZA` |
| fzf | `INSTALL_FZF` |
| fd | `INSTALL_FD` |
| ripgrep | `INSTALL_RIPGREP` |
| jq/yq | `INSTALL_JQ` / `INSTALL_YQ` |
| zoxide | `INSTALL_ZOXIDE` |

### DevOps
| Package | Config Variable |
|---------|-----------------|
| kubectx | `INSTALL_KUBECTX` |
| stern | `INSTALL_STERN` |
| k9s | `INSTALL_K9S` |
| et | `INSTALL_ET` |

## Key Aliases

```bash
# Git
gs/gp/gl     # status/push/log
gco/gcb      # checkout/new branch

# Kubernetes  
k/kx/kn      # kubectl/kubectx/kubens
kgp/kl/kex   # get pods/logs/exec

# Docker
dps/dex/dl   # ps/exec/logs
dc/dcu/dcd   # compose up/down

# Terraform
tf/tfi/tfp   # terraform/init/plan
tfa/tfaa     # apply/auto-approve
```

## Key Functions

```bash
ksh [pod]       # Shell into pod (fzf if no arg)
ksecret [name]  # Decode k8s secret
dsh [container] # Shell into container
aws-switch      # Switch AWS profile
mkcd <dir>      # mkdir + cd
killport <port> # Kill process on port
```

## Files

```
./config.sh        # ← Edit this to customize
./bootstrap.sh     # Installer
./uninstall.sh     # Uninstaller
./shell/           # Config files
```

## Requirements

**Nerd Font** for icons (auto-install available):

```bash
# In config.sh:
INSTALL_NERD_FONT=true
```

Or manually:
```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

## Compatibility

✅ Apple Silicon (M1/M2/M3) • ✅ Intel Mac

## License

MIT
