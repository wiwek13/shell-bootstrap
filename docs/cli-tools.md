# CLI Tools Guide 🛠️

[![Homebrew](https://img.shields.io/badge/Homebrew-Available-orange?logo=homebrew)](https://brew.sh/)


> **Essential command-line utilities for developer productivity on macOS.**

Master these modern CLI tools to 10x your terminal efficiency: file navigation, code search, system monitoring, and more.

**Tools covered:** eza, fd, ripgrep, fzf, zoxide, bat, btop, ncdu, dust, duf, procs, jq, httpie, direnv, atuin, nvm, pyenv

---

## 📁 File Navigation & Search

### `eza` - Modern ls Replacement
```bash
# Basic usage
ll                    # Detailed list with icons
la                    # Include hidden files
lt                    # Tree view
lt -L 2               # Tree, 2 levels deep

# What it does: Replaces ls with colors, icons, git status
# When to use: Every time you list files
```

### `fd` - Fast File Finder
```bash
# Find files by name
fd readme             # Find files named "readme"
fd -e py              # Find all Python files
fd -e js -x wc -l     # Count lines in all JS files
fd -H .env            # Include hidden files

# What it does: Fast, user-friendly find replacement
# When to use: Finding files by name/extension
```

### `ripgrep` (rg) - Fast grep
```bash
# Search file contents
rg "TODO"             # Find TODO in all files
rg "function" -t js   # Search only JS files
rg "error" -i         # Case insensitive
rg "pattern" -C 3     # Show 3 lines context
rg "api" --hidden     # Include hidden files

# What it does: 10x faster than grep, respects .gitignore
# When to use: Searching code for patterns
```

### `fzf` - Fuzzy Finder
```bash
# Interactive search
vim $(fzf)            # Open file in vim
cd $(fd -t d | fzf)   # cd into directory
cat file | fzf        # Filter lines interactively

# Keybindings (after setup)
Ctrl+R                # Search command history
Ctrl+T                # Find files
Alt+C                 # cd into directory

# What it does: Fuzzy search for anything
# When to use: When you can't remember exact names
```

### `zoxide` - Smarter cd
```bash
# Jump to directories
z project             # Jump to "project" directory
z doc                 # Jump to most used "doc" path
zi                    # Interactive selection with fzf

# What it does: Learns your habits, jumps to frequent dirs
# When to use: Instead of cd with long paths
```

---

## 📝 File Viewing & Editing

### `bat` - Cat with Syntax Highlighting
```bash
# View files
bat file.py           # View with highlighting
bat -n file.py        # Show line numbers only
bat -A file           # Show invisible characters
bat *.json            # View multiple files

# What it does: Cat with syntax highlighting, line numbers, git diff
# When to use: Reading code files
```

### `tldr` - Simplified Man Pages
```bash
# Quick help
tldr tar              # How to use tar
tldr curl             # Common curl examples
tldr ffmpeg           # ffmpeg examples
tldr -u               # Update local cache

# What it does: Practical examples instead of man pages
# When to use: When you forget command syntax
```

---

## 💾 Disk & System

### `btop` - Beautiful System Monitor
```bash
btop                  # Launch monitor

# Keybindings inside btop:
# h = help
# q = quit
# f = filter processes
# k = kill process

# What it does: CPU, memory, disk, network monitoring
# When to use: Checking system resources
```

### `ncdu` - Disk Usage Analyzer
```bash
ncdu                  # Scan current directory
ncdu /                # Scan entire disk
ncdu --exclude .git   # Exclude directories

# Keybindings:
# d = delete file/folder
# n = sort by name
# s = sort by size
# q = quit

# What it does: Interactive disk usage viewer
# When to use: Finding what's eating disk space
```

### `dust` - Modern du
```bash
dust                  # Show disk usage
dust -n 10            # Top 10 largest
dust -d 2             # 2 levels deep
dust /var/log         # Specific directory

# What it does: Visual, fast disk usage
# When to use: Quick disk usage check
```

### `duf` - Modern df
```bash
duf                   # Show disk space
duf /dev/sda1         # Specific device
duf --only local      # Only local disks

# What it does: Beautiful disk free display
# When to use: Checking available disk space
```

### `procs` - Modern ps
```bash
procs                 # List all processes
procs --tree          # Process tree
procs node            # Filter by name
procs --watch         # Live update

# What it does: Colorful, readable process list
# When to use: Finding running processes
```

---

## 🔧 Development Utilities

### `jq` - JSON Processor
```bash
# Parse JSON
cat data.json | jq '.'                    # Pretty print
cat data.json | jq '.name'                # Get field
cat data.json | jq '.items[]'             # Iterate array
cat data.json | jq '.items | length'      # Count items
curl api | jq '.data.users[0].email'      # Chain selectors

# What it does: Parse, filter, transform JSON
# When to use: Working with APIs, config files
```

### `httpie` - Better curl
```bash
# HTTP requests
http GET api.example.com/users            # GET request
http POST api.example.com/users name=john # POST JSON
http -a user:pass api.example.com         # With auth
http --download example.com/file.zip      # Download

# What it does: Human-friendly HTTP client
# When to use: Testing APIs
```

### `direnv` - Auto-load Environment
```bash
# Setup (in any project)
echo 'export API_KEY=secret' > .envrc
direnv allow

# Now: Entering directory auto-loads vars
# Leaving directory auto-unloads vars

# What it does: Per-directory environment variables
# When to use: Project-specific configs
```

### `atuin` - Shell History Sync
```bash
atuin search docker   # Search history
atuin stats           # Usage statistics
Ctrl+R                # Interactive search (replaces default)

# What it does: Encrypted history sync across machines
# When to use: Finding old commands
```

---

## 📊 Version Managers

### `nvm` - Node Version Manager
```bash
nvm install 20        # Install Node 20
nvm use 20            # Switch to Node 20
nvm list              # List installed versions
nvm alias default 20  # Set default version

# What it does: Manage multiple Node.js versions
# When to use: Projects need different Node versions
```

### `pyenv` - Python Version Manager
```bash
pyenv install 3.12.0  # Install Python 3.12
pyenv global 3.12.0   # Set global version
pyenv local 3.11.0    # Set local (project) version
pyenv versions        # List installed

# What it does: Manage multiple Python versions
# When to use: Projects need different Python versions
```

---

## 🎯 Pro Tips

### Combine Tools
```bash
# Find and edit
vim $(fd -e py | fzf)

# Search and open
rg -l "TODO" | fzf | xargs vim

# Interactive kill
procs | fzf | awk '{print $1}' | xargs kill
```

### Create Aliases
```bash
# Add to aliases.zsh
alias preview="fzf --preview 'bat --color=always {}'"
alias top10="dust -n 10"
alias ports="lsof -i -P -n | grep LISTEN"
```
