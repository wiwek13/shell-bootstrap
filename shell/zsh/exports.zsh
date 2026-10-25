# Homebrew environment (Apple Silicon and Intel Mac compatible)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.antigravity/antigravity/bin:$PATH"

# Starship prompt configuration
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# ============================================================
# EDITOR
# ============================================================
export EDITOR="nano"
export VISUAL="$EDITOR"

# ============================================================
# THEME & COLORS
# ============================================================
export BAT_THEME="TwoDark"
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

# ============================================================
# HISTORY
# ============================================================
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"

# ============================================================
# ZSH OPTIONS (only in interactive shells)
# ============================================================
# Guard: setopt and zstyle only work in interactive shells
[[ $- == *i* ]] && {
setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks from history
setopt HIST_VERIFY             # Don't execute immediately on history expansion
setopt SHARE_HISTORY           # Share history between terminals
setopt INC_APPEND_HISTORY      # Write to history file immediately
setopt EXTENDED_HISTORY        # Record timestamp in history
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first
setopt HIST_IGNORE_SPACE       # Ignore commands that start with space
setopt AUTO_CD                 # cd by just typing directory name
setopt AUTO_PUSHD              # Push dir onto stack on cd
setopt PUSHD_IGNORE_DUPS       # Don't push duplicate dirs
setopt PUSHD_SILENT            # Don't print dir stack after pushd/popd
setopt CORRECT                 # Spell correction for commands
setopt INTERACTIVE_COMMENTS    # Allow comments in interactive shell
setopt NO_BEEP                 # No beeping

# ============================================================
# COMPLETION
# ============================================================
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' menu select                          # Menu selection
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colorize completions
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*' group-name ''                        # Group by category
}  # End of interactive shell guard

# ============================================================
# FZF CONFIGURATION
# ============================================================
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --preview-window=right:50%:wrap
  --bind='ctrl-/:toggle-preview'
  --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
  --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap"

# ============================================================
# FZF-TAB (Interactive Completion Preview)
# ============================================================
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --icons --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:*:*' fzf-preview '[[ -f $realpath ]] && bat --style=numbers --color=always --line-range :300 $realpath 2>/dev/null || eza -1 --icons --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:(kill|killall):*' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w 2>/dev/null'
zstyle ':fzf-tab:complete:(kill|killall):*' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:*' switch-group ',' '.'

# ============================================================
# FORGIT (Interactive Git with fzf & delta)
# ============================================================
export FORGIT_NO_ALIASES=0
export FORGIT_FZF_DEFAULT_OPTS="--exact --border --cycle --reverse --height '75%'"

# ============================================================
# KUBERNETES
# ============================================================
export KUBECONFIG="$HOME/.kube/config"
# Uncomment to add additional kubeconfigs:
# export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/other-config"

# ============================================================
# LANGUAGE/LOCALE
# ============================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ============================================================
# PAGER
# ============================================================
export PAGER="less -RF"
export LESS="-R"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ============================================================
# SHELL AGENT (Shell Config Organizer)
# ============================================================
# Model for shell agent (via OpenRouter)
export SHELL_AGENT_MODEL="${SHELL_AGENT_MODEL:-openrouter/mistralai/devstral-2512:free}"
# OpenRouter API key for shell agent (get free at https://openrouter.ai/keys)
export SHELL_AGENT_OPENROUTER_KEY="${SHELL_AGENT_OPENROUTER_KEY:-$OPENROUTER_API_KEY}"
