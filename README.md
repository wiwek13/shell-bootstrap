# Shell Bootstrap

Opinionated DevOps shell setup for **macOS + zsh + Warp**.

## ✨ Features

- **Modern prompt** with Starship (DevOps-focused theme)
- **200+ productivity aliases** for Git, Kubernetes, Docker, Terraform, AWS
- **Smart plugins** with fzf-tab, autosuggestions, syntax highlighting
- **FZF integration** in functions for interactive selection
- **DevOps tools** pre-configured: kubectl, helm, stern, k9s, kubectx

## Quick Install

```bash
git clone https://github.com/<your-username>/shell-bootstrap.git
cd shell-bootstrap
./bootstrap.sh
```

> ⚠️ The script automatically backs up existing configs before overwriting.

## What Gets Installed

### Via Homebrew

| Package | Description |
|---------|-------------|
| `antidote` | Fast zsh plugin manager |
| `starship` | Cross-shell prompt |
| `zellij` | Terminal multiplexer |
| `bat` | Cat with syntax highlighting |
| `eza` | Modern ls replacement |
| `fzf` | Fuzzy finder |
| `fd` | Fast file finder |
| `ripgrep` | Fast grep |
| `jq` / `yq` | JSON/YAML processors |
| `zoxide` | Smarter cd command |
| `kubectx` | Kubernetes context switcher |
| `stern` | Multi-pod log tailing |
| `k9s` | Kubernetes TUI |
| `et` | Eternal Terminal |

### Directory Structure

```
~/.shell/
├── zsh/
│   ├── exports.zsh      # PATH, env vars, zsh options
│   ├── aliases.zsh      # 200+ productivity aliases
│   ├── functions.zsh    # AWS, k8s, docker, git functions
│   ├── tools.zsh        # Tool initialization
│   └── plugins.list     # Antidote plugins
├── starship/
│   └── starship.toml    # DevOps-themed prompt
└── zellij/
    └── config.kdl       # Terminal multiplexer config
```

## Plugins

| Plugin | Purpose |
|--------|---------|
| `zsh-autosuggestions` | Fish-like suggestions |
| `fast-syntax-highlighting` | Real-time command highlighting |
| `zsh-history-substring-search` | Search history by substring |
| `fzf-tab` | Replace completion with fzf |
| `alias-tips` | Reminds you of existing aliases |
| `zsh-you-should-use` | Suggests aliases for commands |
| `z` | Directory jumping |
| OMZ: `sudo`, `extract`, `macos` | Quick utilities |
| OMZ: `kubectl`, `docker`, `terraform`, `aws`, `gcloud`, `helm` | Completions |

## Key Aliases

<details>
<summary><strong>Navigation & Files</strong></summary>

```bash
../.../....  # cd up directories
ll/la/lt     # eza with icons (or ls fallback)
cat          # bat with syntax highlighting
```
</details>

<details>
<summary><strong>Git</strong></summary>

```bash
g/gs/gss     # git / status / status full
gp/gpf/gpl   # push / force-with-lease / pull rebase
gl/gla       # log graph / all branches
gd/gds       # diff / staged
ga/gaa/gap   # add / all / patch
gc/gcm/gca   # commit / message / amend
gco/gcb      # checkout / new branch
gst/gstp     # stash / pop
gf           # fetch all --prune
gwip         # quick WIP commit
```
</details>

<details>
<summary><strong>Kubernetes</strong></summary>

```bash
k/kx/kn      # kubectl / kubectx / kubens
kg/kgp/kgpa  # get / pods / pods -A
kgall/kgev   # get all / events sorted
kl/klf       # logs / follow
kex/kdebug   # exec / netshoot container
kdesc        # describe
kror/kros    # rollout restart / status
```
</details>

<details>
<summary><strong>Docker</strong></summary>

```bash
d/dps/dpsa   # docker / ps / ps -a
di/dex       # images / exec -it
dl/dlf       # logs / follow
dprune       # system prune -af
dc/dcu/dcd   # compose / up -d / down
dcub/dcl     # up --build / logs -f
```
</details>

<details>
<summary><strong>Terraform</strong></summary>

```bash
tf/tfi/tfiu  # terraform / init / init -upgrade
tfp/tfpo     # plan / plan -out
tfa/tfaa     # apply / auto-approve
tfd/tfda     # destroy / auto-approve
tfv/tff      # validate / fmt
tfw/tfwl     # workspace / list
tfsl/tfss    # state list / show
```
</details>

<details>
<summary><strong>AWS</strong></summary>

```bash
aws-whoami   # sts get-caller-identity
ecr-login    # Docker login to ECR
ssm-start    # Start SSM session
eks-update   # Update kubeconfig
```
</details>

## Key Functions

```bash
# Kubernetes (fzf selection if no arg)
ksh/kbash [pod]   # Shell into pod
ksecret [name]    # Decode secret
klogs [pod]       # Follow logs
kevents           # Events sorted

# Git
gnb <branch>      # New branch from main
gco-fzf           # Checkout with fzf
gac <msg>         # Add all + commit
gbrecent          # Recent branches

# Docker (fzf if no arg)
dsh/dbash [name]  # Shell into container
docker-clean      # Prune all
docker-nuke       # Remove everything

# Utilities
mkcd <dir>        # mkdir + cd
serve [port]      # Python HTTP server
killport <port>   # Kill process on port
genpass [len]     # Random password
b64e/b64d         # Base64 encode/decode
weather [city]    # Quick weather
cheat <cmd>       # Cheatsheet
curltime <url>    # Curl timing
```

## Quick Edits

```bash
ea/ef/ee   # Edit aliases/functions/exports
ep/et      # Edit plugins/tools
es/ez      # Edit starship/zellij
```

## Zellij Keybindings

| Key | Action |
|-----|--------|
| `Alt h/j/k/l` | Move focus |
| `Alt H/J/K/L` | Resize pane |
| `Alt -` / `Alt \` | Split down/right |
| `Alt t` | New tab |
| `Alt 1-9` | Go to tab |

## Requirements

**Nerd Font** for prompt icons:

```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

Set in Warp → Settings → Appearance → Font.

## License

MIT
