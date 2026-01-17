# Shell Bootstrap Documentation

Comprehensive guides for all tools, plugins, and apps in this bootstrap.

## 📚 Quick Links

| Guide | Description |
|-------|-------------|
| [CLI Tools](cli-tools.md) | Essential command-line utilities |
| [DevOps Tools](devops-tools.md) | Kubernetes, Terraform, Docker |
| [ZSH Plugins](zsh-plugins.md) | Productivity plugins |
| [Git Workflow](git-workflow.md) | Git aliases and tools |
| [macOS Apps](macos-apps.md) | Desktop applications |
| [Productivity Tips](productivity-tips.md) | Workflows and shortcuts |

## 🚀 Getting Started

After running `bootstrap.sh`, restart your terminal:

```bash
exec zsh
```

## 🎯 Daily Workflow Cheatsheet

```bash
# Navigation
z project          # Jump to project directory (zoxide)
..                 # Go up one directory
...                # Go up two directories

# Git
gs                 # git status
gp                 # git push
gl                 # git log --oneline
gco-fzf            # Checkout branch with fuzzy search

# Kubernetes
kx                 # Switch context
kn                 # Switch namespace
kgp                # Get pods
kl <pod>           # Follow logs

# Docker
dps                # List containers
dsh <container>    # Shell into container

# Files
ll                 # List with details (eza)
lt                 # Tree view
ff <pattern>       # Find files (fzf)
```

## 📖 Learn More

Each guide contains:
- **What it does** - Tool purpose
- **When to use** - Use cases
- **Examples** - Real commands
- **Pro tips** - Advanced usage
