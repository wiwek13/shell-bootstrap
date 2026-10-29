# Ghostty & Warp Carbonfox Integration Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Configure both Ghostty and Warp with the unified Carbonfox theme, advanced productivity features (shaders, split hotkeys, notifications, workflows, launch layouts), add curated DevOps tools to Brewfile/zsh, and integrate installation and sync into bootstrap and agent scripts.

**Architecture:** 
- Ghostty configuration stored in `shell/ghostty/` deploying to `~/.config/ghostty/` with Display-P3 wide gamut, 0.85 opacity, 20px blur, `cursor_warp.glsl` shader, and Carbonfox theme.
- Warp configuration stored in `shell/warp/` deploying to `~/.warp/` with custom `carbonfox.yaml` theme, curated DevOps interactive YAML workflows, multi-pane devops launch config, and updated `settings.toml`.
- Dotfile lifecycle: `bootstrap.sh`, `config.sh`, `uninstall.sh`, and `agent/sync_to_project.sh` upgraded to deploy and bidirectionally sync both Ghostty and Warp assets.

**Tech Stack:** macOS, Zsh, Homebrew, Ghostty (`+validate-config`), Warp (TOML & YAML Workflows/Themes), Python 3 (validation scripts).

---

## Global Constraints

- Preserve all existing comments and structure in `Brewfile`, `bootstrap.sh`, `config.sh`, and `agent/sync_to_project.sh`.
- Do not break existing Warp Dracula users if they switch themes manually; install Carbonfox cleanly into `~/.warp/themes/carbonfox.yaml` and activate it in `settings.toml`.
- All YAML and TOML configurations must be strictly syntax validated before committing or claiming completion.
- Automated verification evidence is required before completing the task.

---

## Review Focus

1. **Ghostty Configuration Syntax**: Ghostty config options must pass `/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config`.
2. **Warp YAML Theme Format**: Must strictly adhere to Warp theme schema (`name`, `accent`, `cursor`, `background`, `foreground`, `details`, `terminal_colors.normal`, `terminal_colors.bright`).
3. **Warp Workflows Schema**: Must validate with `name`, `command`, `description`, `tags`, and optional arguments `{{param}}`.
4. **Shell Script Safety**: `bootstrap.sh`, `config.sh`, `uninstall.sh`, and `agent/sync_to_project.sh` must pass `bash -n` syntax check.
5. **Bidirectional Sync Integrity**: `agent/sync_to_project.sh` must detect and sync new files in `~/.warp/themes`, `~/.warp/workflows`, and `~/.config/ghostty`.

---

### Task 1: Add Curated DevOps & Productivity Tools to Brewfile & Shell

**Files:**
- Modify: `Brewfile`
- Modify: `shell/zsh/tools.zsh`
- Test: `zsh -n shell/zsh/tools.zsh`

- [ ] Add `kubecolor`, `kubeconform`, `sops`, `age`, `act`, `yazi`, `gitleaks`, `trufflehog`, and `just` to `Brewfile` under appropriate categories.
- [ ] Add `kubecolor` aliases (with completion fallback) and `yazi` directory change wrapper `y()` in `shell/zsh/tools.zsh`.
- [ ] Verify shell syntax with `zsh -n shell/zsh/tools.zsh`.

---

### Task 2: Configure Ghostty with Carbonfox Theme & Animated Shaders

**Files:**
- Create: `shell/ghostty/config`
- Create: `shell/ghostty/shaders/cursor_warp.glsl`
- Create: `shell/ghostty/shaders/LICENSE`
- Test: `/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config --config-file=shell/ghostty/config`

- [ ] Create `shell/ghostty/config` configured with `theme = Carbonfox`, Display-P3 colorspace, JetBrainsMono Nerd Font (size 15), blur radius 20, background opacity 0.85, split shortcuts (`⌘+D`, `⌘+Shift+D`), quick dropdown (`⌘+~`), and `notify-on-command-finish = unfocused`.
- [ ] Copy `cursor_warp.glsl` and `LICENSE` to `shell/ghostty/shaders/`.
- [ ] Run `/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config --config-file=shell/ghostty/config` and verify exit status 0.

---

### Task 3: Configure Warp with Carbonfox Theme, Workflows & DevOps Tab Config

**Files:**
- Create: `shell/warp/themes/carbonfox.yaml`
- Create: `shell/warp/workflows/github_actions_act.yaml`
- Create: `shell/warp/workflows/k8s_kubecolor.yaml`
- Create: `shell/warp/workflows/sops_secrets.yaml`
- Create: `shell/warp/workflows/secret_scan_gitleaks.yaml`
- Create: `shell/warp/workflows/shell_sync.yaml`
- Create: `shell/warp/tab_configs/devops_workspace.toml`
- Modify: `shell/warp/settings.toml`
- Test: Python validator script for YAML and TOML syntax

- [ ] Create `shell/warp/themes/carbonfox.yaml` using Carbonfox palette.
- [ ] Create parameterized workflows in `shell/warp/workflows/` for `act`, `kubecolor`, `sops`, `gitleaks`, and `sync_to_project`.
- [ ] Create `shell/warp/tab_configs/devops_workspace.toml` with split terminal and monitoring panes.
- [ ] Update `shell/warp/settings.toml` to activate `theme = "carbonfox"`.
- [ ] Validate all YAML and TOML files using Python `yaml` and `tomllib`.

---

### Task 4: Upgrade Installer, Config, Uninstaller, and Sync Agent

**Files:**
- Modify: `bootstrap.sh`
- Modify: `config.sh`
- Modify: `uninstall.sh`
- Modify: `uninstall_config.sh`
- Modify: `agent/sync_to_project.sh`
- Test: `bash -n` on all 5 shell scripts

- [ ] Update `bootstrap.sh` to install Ghostty config to `~/.config/ghostty/` and symlink `ghostty` CLI into `~/.local/bin/ghostty`.
- [ ] Update `bootstrap.sh` to copy `shell/warp/themes/` and `shell/warp/workflows/` into `~/.warp/`.
- [ ] Update `config.sh` to introduce `INSTALL_GHOSTTY_CONFIG=true`.
- [ ] Update `uninstall.sh` and `uninstall_config.sh` to include Ghostty cleanup options.
- [ ] Update `agent/sync_to_project.sh` to sync `~/.config/ghostty/` and `~/.warp/themes/` / `~/.warp/workflows/`.
- [ ] Verify all bash scripts pass `bash -n`.

---

### Task 5: Live Deployment & End-to-End Verification

**Files:**
- Live directory: `~/.config/ghostty/`
- Live directory: `~/.warp/`
- Test: Full validation suite

- [ ] Deploy Ghostty configuration to `~/.config/ghostty/`.
- [ ] Validate live Ghostty configuration: `/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config`.
- [ ] Deploy Warp configuration (theme, workflows, tab configs, settings) to `~/.warp/`.
- [ ] Run `./agent/sync_to_project.sh --dry-run` to confirm sync agent recognizes both live Ghostty and Warp directories without errors.
- [ ] Verify `git status` and `git diff` across `shell-bootstrap`.
