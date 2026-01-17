# Productivity Tips

Workflows, shortcuts, and habits to maximize efficiency.

---

## ⌨️ Essential Keyboard Shortcuts

### Terminal (Warp/zsh)
```
Navigation:
Ctrl+A          Move to line start
Ctrl+E          Move to line end
Ctrl+U          Clear line before cursor
Ctrl+K          Clear line after cursor
Ctrl+W          Delete word before cursor
Alt+D           Delete word after cursor
Ctrl+L          Clear screen

History:
Ctrl+R          Search history (fzf)
↑/↓             Previous/next command
!!              Repeat last command
!$              Last argument of previous command
!*              All arguments of previous command

FZF (after setup):
Ctrl+R          History search
Ctrl+T          File search
Alt+C           Directory jump
```

### macOS System
```
Cmd+Space       Spotlight (or Raycast)
Cmd+Tab         Switch apps
Cmd+`           Switch windows of same app
Cmd+Q           Quit app
Cmd+W           Close window/tab
Cmd+N           New window
Cmd+T           New tab
Cmd+,           Preferences
Ctrl+↑          Mission Control
Ctrl+←/→        Switch desktops
```

---

## 🔄 Daily Workflows

### Morning Routine
```bash
# 1. Update tools
brew update && brew upgrade

# 2. Check cluster status
kx production
kgp -A | head -20

# 3. Check PRs
gh pr list --author @me

# 4. Review yesterday's commits
git log --since="yesterday" --oneline
```

### Starting a Project
```bash
# Navigate quickly
z myproject              # zoxide jump

# Check status
gs                       # git status
gl                       # recent commits

# Update
gpl                      # pull latest

# Start fresh branch
gnb feature/new-feature
```

### End of Day
```bash
# Commit work in progress
gac "WIP: checkpoint"

# Or stash it
gst

# Check what's pending
gh pr list

# Clean up
docker system prune -f
```

---

## 🎯 Productivity Habits

### 1. Use Fuzzy Search Everywhere
```bash
# Files
vim $(fzf)               # Open any file
fd -t f | fzf            # Find and select

# Git
gco-fzf                  # Branch checkout
glog-fzf                 # Browse commits

# Kubernetes
ksh                      # Shell into pod (fzf selection)
ksecret                  # View secret (fzf)

# History
Ctrl+R                   # Command history
```

### 2. Master Aliases
```bash
# Learn these first (most used):
gs      # git status
gp      # git push
gpl     # git pull
kgp     # kubectl get pods
kl      # kubectl logs
z       # zoxide jump
ll      # eza list

# Check alias definitions:
alias | grep git
alias | grep kube
alias | grep docker
```

### 3. Use Shell History
```bash
# Atuin provides:
# - Sync across machines
# - Better search
# - Statistics

atuin stats              # See your patterns
Ctrl+R                   # Smart search

# Tips:
# - Type partial command → Ctrl+R
# - Use ↑ to recall similar commands
```

### 4. Leverage Tab Completion
```bash
# With fzf-tab, Tab shows fuzzy menu:
kubectl get <Tab>        # Resource types
docker run <Tab>         # Images
git checkout <Tab>       # Branches
cd <Tab>                 # Directories

# Type to filter, Enter to select
```

---

## 🚀 Speed Optimizations

### Shell Startup
```bash
# Check startup time
time zsh -i -c exit      # Target: < 200ms

# If slow:
# 1. Check plugins (disable unused)
# 2. Lazy load heavy tools (nvm, pyenv)
# 3. Use zinit/antidote static loading
```

### Quick Commands
```bash
# Instead of typing full commands:
docker ps                → dps
kubectl get pods         → kgp
terraform plan           → tfp
git status               → gs

# Quick edits (from shell-bootstrap):
ea                       # Edit aliases
ef                       # Edit functions
ez                       # Edit zshrc
```

### Directory Navigation
```bash
# Don't cd with full paths
cd ~/Documents/Projects/mycompany/frontend/src/components

# Use zoxide instead
z components             # Jump directly

# Or use aliases
alias proj="cd ~/Documents/Projects"
alias dotfiles="cd ~/.config"
```

---

## 📋 Clipboard Workflow

### With Maccy
```bash
# Copy → Maccy saves it
# Cmd+Shift+C → Browse history
# Type to search
# Enter to paste

# Pro tips:
# - Pin frequently used snippets
# - Search by content
```

### Shell → Clipboard
```bash
# Copy current directory
copypath

# Copy file contents
copyfile script.sh

# Copy command output
cat file.txt | pbcopy
ls -la | pbcopy

# Paste from clipboard
pbpaste
pbpaste > file.txt
```

---

## 🔧 Custom Workflows

### Create Project Aliases
```bash
# Add to ~/.shell/zsh/aliases.zsh
alias myapi="cd ~/Projects/my-api && code ."
alias myfe="cd ~/Projects/my-frontend && code ."
alias myinfra="cd ~/Projects/infrastructure && code ."
```

### Quick Environment Setup
```bash
# Create function in ~/.shell/zsh/functions.zsh
work-api() {
  cd ~/Projects/my-api
  kx staging
  kn api
  code .
}

work-prod() {
  cd ~/Projects/infrastructure
  kx production
  export TF_WORKSPACE=prod
}
```

### Combine Tools
```bash
# Find and edit TODO comments
rg -l TODO | fzf | xargs code

# Interactive process kill
procs | fzf | awk '{print $1}' | xargs kill

# Find large files
dust -r | head -20

# Docker cleanup
docker ps -aq --filter status=exited | xargs docker rm
```

---

## 📊 Monitoring Dashboard

### Terminal Monitor
```bash
# Split terminal (Warp/Zellij):
# Pane 1: btop (system)
# Pane 2: stern (logs)
# Pane 3: k9s (kubernetes)

# Quick system check
fastfetch                # System info
btop                     # Resource monitor
```

### Quick Health Checks
```bash
# Disk space
duf                      # Beautiful df

# Large files
ncdu                     # Interactive

# Memory hogs
procs --sortd mem | head

# Network
lsof -i -P | grep LISTEN
```

---

## 🎯 Weekly Maintenance

```bash
# Update everything
brew update && brew upgrade
brew cleanup -s

# Clean Docker
docker system prune -af

# Git cleanup
git gc
gcleanb                  # Delete merged branches

# Check disk
ncdu ~                   # Find space hogs

# Verify setup
brew doctor
```

---

## 💡 Pro Tips Summary

1. **Fuzzy search everything** - fzf is your friend
2. **Master 10 aliases** - Learn the ones you use daily
3. **Use zoxide** - Never type full paths again
4. **Tab complete** - fzf-tab makes it fuzzy
5. **Clipboard manager** - Never lose copied text
6. **Shell history** - Atuin remembers everything
7. **Automate** - Create functions for repeated tasks
8. **Clean regularly** - Prune Docker, git, disk weekly
9. **Monitor** - Know your system's state
10. **Document** - Note your custom workflows
