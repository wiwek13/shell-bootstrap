# 🤖 Shell Config Agent

> ⚠️ **EXPERIMENTAL** - This agent is under active development.

AI-powered shell workflow analysis and optimization using OpenCode + Devstral via OpenRouter.

## Features

| Feature | Description |
|---------|-------------|
| 🔍 **Workflow Analysis** | Reviews your command patterns and tool usage |
| 💪 **Strengths/Weaknesses** | Critical assessment of your shell setup |
| 🎯 **Opportunities** | Suggests tools to learn, workflows to automate |
| 📊 **Scoring** | Rates efficiency, automation, tool currency |
| 🔄 **Deprecated Detection** | Flags old tools, suggests modern alternatives |
| 🔒 **Privacy First** | Only analyzes patterns, never stores secrets |

---

## 🔒 Privacy Boundaries

### ✅ What It CAN Access
- Shell config files
- Command **frequency counts** only
- Installed packages

### ❌ What It CANNOT Access
- Actual command arguments
- SSH keys, API tokens, passwords
- Any credential files

---

## Quick Setup

```bash
# 1. Get free API key at openrouter.ai/keys
export SHELL_AGENT_OPENROUTER_KEY="your-key"

# 2. Run analysis
shell-organize
```

---

## Usage

| Command | Description |
|---------|-------------|
| `shell-organize` | **Full analysis** (preview, safe) |
| `shell-organize-apply` | Apply changes |
| `shell-sync` | Sync to project |

---

## What You Get

### 🔍 Workflow Analysis
- Which tools you use most
- Commands typed repeatedly
- Time wasted on manual typing

### 💪 Strengths
- What you're doing well
- Good patterns in your config

### ⚠️ Weaknesses
- Inefficient patterns
- Missing automations
- Outdated tools

### 🎯 Opportunities
- Tools to learn
- Workflows to automate
- Skills to develop

### 💡 Suggested Aliases
Based on your frequency:
```
| alias | command      | times/day |
|-------|--------------|-----------|
| gs    | git status   | 47        |
```

### 🚨 Wasted Installs (Critical!)
Detects modern tools you have installed but aren't using:
```
| Installed | You Use | Times/Day | Switch To |
|-----------|---------|-----------|-----------|
| eza       | ls      | 47        | eza       |
| zoxide    | cd      | 89        | z         |
| bat       | cat     | 23        | bat       |
```

### 📊 Scores
- Workflow efficiency: X/10
- Automation level: X/10
- Tool currency: X/10
- Overall: X/10

---

## 💡 Pro Tips

### Ultrawork Mode
Include `ultrawork` or `ulw` in prompts for parallel agents:
```
ulw: analyze my shell and give critical feedback
```

---

## Safety

1. **Preview by default** - No changes without `--apply`
2. **Auto-backup** - `~/.shell-backup-YYYYMMDD-HHMMSS/`
3. **Syntax validation** - `zsh -n` after changes
4. **Honest feedback** - Real assessment, not just positives

---

## Troubleshooting

### Shell breaks after organize
```bash
cp -R ~/.shell-backup-*/* ~/
source ~/.zshrc
```
