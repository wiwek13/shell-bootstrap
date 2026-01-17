# Git Workflow Guide 🔀

[![Git](https://img.shields.io/badge/Git-Version%20Control-orange?logo=git)](https://git-scm.com/)
[![GitHub](https://img.shields.io/badge/GitHub-CLI-black?logo=github)](https://cli.github.com/)

> **Master Git with 50+ aliases, lazygit, GitHub CLI, and proven workflows.**

Speed up your Git workflow with shortcuts, fuzzy branch switching, and automation.

**Tools covered:** git aliases, lazygit, git-delta, gh CLI, pre-commit, gco-fzf, gac, gnb

---

## 🚀 Quick Reference

```bash
# Status & Info
gs              # git status
gss             # git status -s (short)
gl              # git log --oneline --graph
gla             # git log --all --oneline --graph

# Staging & Committing
ga file         # git add file
gaa             # git add --all
gap             # git add --patch (interactive)
gc              # git commit
gcm "msg"       # git commit -m "msg"
gca             # git commit --amend

# Branches
gb              # git branch
gba             # git branch -a
gcb name        # git checkout -b name
gco branch      # git checkout branch
gco-fzf         # checkout with fuzzy search

# Push & Pull
gp              # git push
gpf             # git push --force-with-lease (safe force)
gpl             # git pull --rebase

# Stash
gst             # git stash
gstp            # git stash pop
gstl            # git stash list
```

---

## 🔧 Git Tools

### `lazygit` - Git TUI
```bash
lazygit         # Launch TUI

# Keybindings:
# ? = help
# j/k = navigate
# Space = stage/unstage
# c = commit
# p = push
# P = pull
# b = branches panel
# s = stash panel
# q = quit

# What it does: Full Git UI in terminal
# When to use: Complex rebases, visual commits
```

### `git-delta` - Better Diff
```bash
# Automatically used with git diff
git diff        # Shows colored, side-by-side
git show        # Better commit view
git log -p      # Better patch view

# Features:
# - Syntax highlighting
# - Line numbers
# - Side-by-side view
# - Word-level diff highlighting
```

### `gh` - GitHub CLI
```bash
# Repos
gh repo clone owner/repo
gh repo create myrepo
gh repo view --web        # Open in browser

# Pull Requests
gh pr create
gh pr list
gh pr checkout 123
gh pr merge 123
gh pr view 123 --web

# Issues
gh issue create
gh issue list
gh issue view 123

# Actions
gh run list
gh run view
gh run watch

# What it does: GitHub from terminal
# When to use: PRs, issues, Actions without browser
```

### `pre-commit` - Git Hooks
```bash
# Setup
pre-commit install        # Install hooks
pre-commit run --all-files # Run all hooks

# Example .pre-commit-config.yaml:
# repos:
#   - repo: https://github.com/pre-commit/pre-commit-hooks
#     rev: v4.4.0
#     hooks:
#       - id: trailing-whitespace
#       - id: end-of-file-fixer
#       - id: check-yaml

# What it does: Auto-run formatters/linters on commit
# When to use: Enforce code quality
```

---

## 📋 Shell-Bootstrap Functions

### `gnb` - New Branch from Main
```bash
gnb feature/login
# Equivalent to:
# git checkout main
# git pull
# git checkout -b feature/login

# What it does: Clean branch from updated main
```

### `gac` - Add All & Commit
```bash
gac "Fix login bug"
# Equivalent to:
# git add -A
# git commit -m "Fix login bug"

# What it does: Quick commit all changes
```

### `gpu` - Push & Set Upstream
```bash
gpu
# Equivalent to:
# git push -u origin $(current_branch)

# What it does: Push new branch, set tracking
```

### `gco-fzf` - Fuzzy Checkout
```bash
gco-fzf
# Interactive branch selection with fzf
# Type to filter, enter to checkout
```

### `glog-fzf` - Fuzzy Log
```bash
glog-fzf
# Browse commits with fzf
# Enter shows commit details
```

### `gcleanb` - Clean Merged Branches
```bash
gcleanb
# Deletes local branches merged into main
# Keeps: main, master, develop
```

### `grib` - Interactive Rebase
```bash
grib 5
# Equivalent to:
# git rebase -i HEAD~5

# What it does: Rebase last 5 commits
```

---

## 🔄 Common Workflows

### Feature Development
```bash
# Start feature
gnb feature/user-auth       # New branch from main

# Work on feature
# ... make changes ...
gaa && gcm "Add login form"
gaa && gcm "Add validation"
gaa && gcm "Add tests"

# Push for review
gpu                         # Push with upstream

# Create PR
gh pr create --fill

# After approval
gco main && gpl            # Update main
gco feature/user-auth
grib main                  # Rebase on main
gpf                        # Force push
gh pr merge --squash       # Merge PR
```

### Hotfix
```bash
# Start hotfix
gnb hotfix/login-crash

# Quick fix
gac "Fix null pointer in login"
gpu

# Fast PR
gh pr create --title "Hotfix: login crash" --body "Emergency fix"
gh pr merge --merge
```

### Stash Workflow
```bash
# Save work in progress
gst                        # Stash changes

# Switch to urgent task
gco main && gnb hotfix/urgent
# ... fix ...
gac "Fix urgent issue"
gp

# Return to original work
gco feature/original
gstp                       # Pop stash
```

### Squash Commits
```bash
# Before PR, squash messy commits
grib 5                     # Rebase last 5

# In editor:
# pick abc1234 First commit
# squash def5678 WIP
# squash ghi9012 More WIP
# squash jkl3456 Done

# Save → Edit combined message
gpf                        # Force push
```

### Undo Mistakes
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Undo pushed commit (creates revert commit)
git revert HEAD

# Recover deleted branch
git reflog                 # Find commit
git checkout -b recovered <commit>
```

---

## 📊 Useful Git Commands

### Log Variations
```bash
gl                         # Short log
gla                        # All branches
git log --since="1 week"   # Recent
git log --author="john"    # By author
git log -- file.txt        # File history
git log -p                 # With patches
```

### Diff Variations
```bash
gd                         # Unstaged changes
gds                        # Staged changes
git diff main..feature     # Between branches
git diff HEAD~3            # Last 3 commits
```

### Search
```bash
git log -S "function_name"      # Find when added
git log --grep="bug"            # Search messages
git blame file.txt              # Who wrote each line
git bisect start                # Binary search for bug
```

---

## 🎯 Pro Tips

### Aliases I Use Daily
```bash
gs              # Check status (100x/day)
gl              # Quick log check
gp              # Push changes
gpl             # Pull updates
gco-fzf         # Switch branches
gac "msg"       # Quick commits
```

### Speed Up Git
```bash
# Use SSH, not HTTPS
git remote set-url origin git@github.com:user/repo.git

# Enable parallel fetch
git config --global fetch.parallel 4

# Use delta for faster diffs
git config --global core.pager delta
```

### Clean Up Regularly
```bash
git gc                     # Garbage collect
git prune                  # Remove unreachable
gcleanb                    # Delete merged branches
git remote prune origin    # Clean stale remotes
```
