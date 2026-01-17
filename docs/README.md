# Shell Bootstrap Documentation 📚

> **Comprehensive guides for all CLI tools, plugins, and apps in this DevOps shell bootstrap.**

## 🎯 Quick Links

| Guide | Description | Topics |
|-------|-------------|--------|
| [CLI Tools](cli-tools.md) | Essential command-line utilities | eza, fzf, ripgrep, bat, fd, zoxide, btop, ncdu |
| [DevOps Tools](devops-tools.md) | Kubernetes, Docker, Terraform | kubectl, helm, k9s, stern, terraform, docker |
| [ZSH Plugins](zsh-plugins.md) | Shell productivity plugins | autosuggestions, syntax-highlighting, fzf-tab |
| [Git Workflow](git-workflow.md) | Git aliases and tools | lazygit, git-delta, gh, pre-commit |
| [macOS Apps](macos-apps.md) | Desktop applications | Warp, OrbStack, VS Code, Raycast |
| [Productivity Tips](productivity-tips.md) | Workflows and shortcuts | keyboard shortcuts, daily workflows |

## 🚀 Getting Started

After running `bootstrap.sh`, restart your terminal:

```bash
exec zsh
```

## ⌨️ Daily Cheatsheet

### Navigation
```bash
z project          # Jump to project directory (zoxide)
..                 # Go up one directory
...                # Go up two directories
ll                 # List with details (eza)
lt                 # Tree view
```

### Git Workflow
```bash
gs                 # git status
gp                 # git push
gl                 # git log --oneline
gco-fzf            # Checkout branch with fuzzy search
gac "message"      # Add all + commit
```

### Kubernetes Operations
```bash
kx                 # Switch context (kubectx)
kn                 # Switch namespace (kubens)
kgp                # kubectl get pods
kl <pod>           # Follow pod logs
ksh                # Shell into pod (fzf selection)
```

### Docker Commands
```bash
dps                # docker ps
dsh <container>    # Shell into container
dc up              # docker-compose up
```

### File Search
```bash
ff <pattern>       # Find files with fzf
rg <pattern>       # Search file contents
```

## 📖 What Each Guide Covers

Each documentation file includes:
- **What it does** — Tool purpose and description
- **When to use** — Practical use cases
- **Examples** — Real-world command examples
- **Pro tips** — Advanced usage and shortcuts
- **Keybindings** — Keyboard shortcuts reference

## 🔍 SEO Keywords

macOS terminal, zsh configuration, shell productivity, DevOps tools, Kubernetes CLI, kubectl aliases, terraform shortcuts, docker aliases, fzf fuzzy finder, Starship prompt, developer terminal setup, Apple Silicon terminal, M1 Mac development
