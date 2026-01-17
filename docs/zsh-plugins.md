# ZSH Plugins Guide 🔌

[![Zsh](https://img.shields.io/badge/Shell-Zsh-green?logo=gnu-bash)](https://www.zsh.org/)
[![Antidote](https://img.shields.io/badge/Plugin%20Manager-Antidote-blue)](https://antidote.sh/)
[![Oh My Zsh](https://img.shields.io/badge/Framework-Oh%20My%20Zsh-red)](https://ohmyz.sh/)

> **Complete guide to Zsh plugins for shell productivity and DevOps workflows.**

Boost your terminal productivity with autosuggestions, syntax highlighting, fuzzy completion, and 50+ plugins.

**Plugins covered:** zsh-autosuggestions, fast-syntax-highlighting, fzf-tab, zsh-completions, alias-tips, kubectl, docker, terraform, aws, git

---

## 🔌 Core Plugins (Must Have)

### `zsh-autosuggestions`
```bash
# What it does: Fish-like suggestions as you type
# Shows gray text of predicted command

# Usage: Just type, suggestions appear automatically
# Accept suggestion: → (right arrow) or End key
# Accept word: Ctrl+→

# Example:
# Type: git p
# Shows: git push origin main (gray, from history)
# Press → to accept

# Pro tip: Type partial, then → to complete
```

### `fast-syntax-highlighting`
```bash
# What it does: Colors your commands as you type
# - Green = valid command
# - Red = invalid/not found
# - Blue = built-in
# - Yellow = alias

# Benefits:
# - Catch typos before running
# - See if command exists
# - Highlight strings, paths, flags
```

### `zsh-completions`
```bash
# What it does: Adds completions for 250+ commands
# Tab completion for tools like:
# - docker, kubectl, terraform
# - git, npm, pip
# - aws, gcloud, az

# Usage: Type command + Tab
# Example: docker r<Tab> → shows run, rm, rmi, etc.
```

### `zsh-history-substring-search`
```bash
# What it does: Search history by substring

# Usage:
# 1. Type partial command: git
# 2. Press ↑ (up arrow)
# 3. Cycles through history containing "git"

# Keybindings:
# ↑ = search backward
# ↓ = search forward
```

---

## 🚀 Productivity Plugins

### `fzf-tab`
```bash
# What it does: Replaces Tab completion with fzf

# Before: Tab shows list, type to filter
# After: Tab opens fuzzy search

# Usage: Any command + Tab
# git checkout <Tab>  → fuzzy branch search
# cd <Tab>            → fuzzy directory search
# kill <Tab>          → fuzzy process search

# Pro tip: Type any part of the name to filter
```

### `alias-tips`
```bash
# What it does: Reminds you of aliases

# When you type: git status
# It shows: Alias tip: gs

# Helps you learn and use your aliases
# Gradually converts commands to shortcuts
```

### `zsh-you-should-use`
```bash
# What it does: Suggests aliases for commands

# Similar to alias-tips but more aggressive
# Shows: Found existing alias for "git status": gs

# Helps reinforce using shortcuts
```

### `z` / `zoxide`
```bash
# What it does: Smart directory jumping

# Traditional cd:
cd ~/Documents/Projects/myapp/src/components

# With z/zoxide:
z components     # Jumps to most used "components" dir
z myapp          # Jumps to myapp
z doc pro        # Matches "Documents/Projects"

# zoxide (newer, faster):
z <partial>      # Jump to match
zi               # Interactive with fzf
```

---

## ⚡ Quick Commands (OMZ Plugins)

### `sudo` Plugin
```bash
# What it does: Prefix last command with sudo

# Usage: Double-tap ESC
# Last command: apt update
# Double ESC: sudo apt update

# Also works on current line:
# Type: vim /etc/hosts
# Double ESC: sudo vim /etc/hosts
```

### `extract` Plugin
```bash
# What it does: Universal archive extractor

# Usage:
extract file.tar.gz
extract file.zip
extract file.7z
extract file.rar

# Automatically detects format
# No need to remember tar flags!
```

### `copypath` Plugin
```bash
# What it does: Copy current directory to clipboard

copypath          # Copy current path
copypath file.txt # Copy file's full path

# Pairs well with: paste in Finder/Explorer
```

### `copyfile` Plugin
```bash
# What it does: Copy file contents to clipboard

copyfile script.sh    # Copy contents
copyfile config.json  # Ready to paste

# Useful for sharing configs, scripts
```

### `web-search` Plugin
```bash
# What it does: Search from terminal

google what is kubernetes
ddg how to use terraform
github zsh-autosuggestions
stackoverflow python list comprehension

# Opens browser with search results
```

---

## 🛠️ DevOps Plugins

### `git` Plugin
```bash
# Aliases provided:
g       # git
ga      # git add
gaa     # git add --all
gb      # git branch
gba     # git branch -a
gc      # git commit
gcmsg   # git commit -m
gco     # git checkout
gd      # git diff
gf      # git fetch
gl      # git pull
gp      # git push
gst     # git status
glog    # git log --oneline --graph

# Full list: alias | grep git
```

### `kubectl` Plugin
```bash
# Aliases provided:
k       # kubectl
kg      # kubectl get
kgp     # kubectl get pods
kgs     # kubectl get services
kgd     # kubectl get deployments
kd      # kubectl describe
kdp     # kubectl describe pod
kl      # kubectl logs
ke      # kubectl exec
kaf     # kubectl apply -f
kdf     # kubectl delete -f

# Completions: k <Tab>
```

### `docker` Plugin
```bash
# Aliases provided:
dk      # docker
dki     # docker images
dkps    # docker ps
dkpsa   # docker ps -a
dkrm    # docker rm
dkrmi   # docker rmi
dklogs  # docker logs

# Completions for containers, images
```

### `terraform` Plugin
```bash
# Aliases provided:
tf      # terraform
tfa     # terraform apply
tfc     # terraform console
tfd     # terraform destroy
tff     # terraform fmt
tfi     # terraform init
tfo     # terraform output
tfp     # terraform plan
tfv     # terraform validate

# Completions for commands, flags
```

### `aws` Plugin
```bash
# Provides:
# - Command completions
# - Profile switching helpers
# - Region helpers

# Usage:
aws <Tab><Tab>    # Show all commands
aws s3 <Tab>      # S3 subcommands
```

### `gcloud` Plugin
```bash
# Provides:
# - Command completions
# - Project switching
# - Config helpers

gcloud <Tab>      # Show commands
```

---

## 🍎 macOS Plugin

### `macos` Plugin
```bash
# Commands provided:
tab           # Open current dir in new Finder tab
ofd           # Open current dir in Finder
cdf           # cd to frontmost Finder directory
pfd           # Print frontmost Finder directory
quick-look    # Quick Look a file
man-preview   # Open man page in Preview
spotify       # Control Spotify

# Examples:
cdf           # Jump to what Finder is showing
ofd           # Open Finder here
quick-look image.png
```

---

## 📊 Plugin Performance Tips

### Load Order Matters
```bash
# In plugins.list, order affects speed:
# 1. Completions first (zsh-completions)
# 2. Then syntax highlighting  
# 3. Then autosuggestions
# 4. Then other plugins
```

### Measure Startup Time
```bash
# Check shell startup time
time zsh -i -c exit

# Target: < 200ms
# If slow: Disable heavy plugins
```

### Lazy Load Heavy Plugins
```bash
# For rarely used plugins, load on demand
# Example: nvm is slow, load when needed
```

---

## 🎯 My Plugin Stack (Recommended)

Essential (keep always):
1. `zsh-autosuggestions`
2. `fast-syntax-highlighting` 
3. `fzf-tab`
4. `zsh-completions`
5. `alias-tips`

DevOps (if you use these tools):
- `kubectl`
- `docker`
- `terraform`
- `aws`

Convenience:
- `sudo`
- `extract`
- `z` / zoxide
- `copypath`
