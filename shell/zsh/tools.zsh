# Starship prompt
if [[ "$TERM" != "dumb" ]] && command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Zellij
export ZELLIJ_CONFIG_DIR="$HOME/.shell/zellij"

# Eternal Terminal
export ET_NO_AUTO_UPDATE=1

# Homebrew prefix resolution helper (avoids repeated slow `brew --prefix` subprocesses)
BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"

# z - directory jumping
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# direnv - environment switching
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# atuin - shell history sync (SQLite-backed, magical search)
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# uv - fast python package manager completions
if command -v uv &> /dev/null; then
  eval "$(uv generate-shell-completion zsh 2>/dev/null)"
fi

# nvm - Node version manager (Lazy-loaded for instant shell startup)
export NVM_DIR="$HOME/.nvm"
if [[ -n "$BREW_PREFIX" && -s "$BREW_PREFIX/opt/nvm/nvm.sh" ]]; then
  _load_nvm() {
    unset -f nvm node npm npx yarn 2>/dev/null
    source "$BREW_PREFIX/opt/nvm/nvm.sh"
    [[ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]] && source "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
  }
  nvm() { _load_nvm; nvm "$@"; }
  node() { _load_nvm; node "$@"; }
  npm() { _load_nvm; npm "$@"; }
  npx() { _load_nvm; npx "$@"; }
  yarn() { _load_nvm; yarn "$@"; }
fi

# pyenv - Python version manager
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init --no-rehash - 2>/dev/null)"
fi

# ============================================================
# CLOUD & DEVOPS COMPLETIONS (with High-Speed Caching)
# ============================================================
ZSH_COMPLETION_CACHE="$HOME/.shell/zsh/cache/completions"
[[ ! -d "$ZSH_COMPLETION_CACHE" ]] && mkdir -p "$ZSH_COMPLETION_CACHE"
fpath=("$ZSH_COMPLETION_CACHE" $fpath)

_load_or_cache_completion() {
  local cmd="$1"
  local comp_file="$ZSH_COMPLETION_CACHE/_$cmd"
  shift
  if command -v "$cmd" &>/dev/null; then
    if [[ ! -s "$comp_file" ]]; then
      "$@" > "$comp_file" 2>/dev/null &!
    fi
    [[ -s "$comp_file" ]] && source "$comp_file"
  fi
}

# Kubernetes ecosystem cached completions
_load_or_cache_completion kubectl kubectl completion zsh
_load_or_cache_completion helm helm completion zsh
_load_or_cache_completion argocd argocd completion zsh
_load_or_cache_completion gh gh completion -s zsh
_load_or_cache_completion kustomize kustomize completion zsh
_load_or_cache_completion helmfile helmfile completion zsh
_load_or_cache_completion trivy trivy completion zsh

# gcloud - Google Cloud SDK (installed via cask)
if [[ -n "$BREW_PREFIX" && -d "$BREW_PREFIX/share/google-cloud-sdk" ]]; then
  export PATH="$BREW_PREFIX/share/google-cloud-sdk/bin:$PATH"
  source "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
  source "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
fi

# oci - Oracle Cloud Infrastructure CLI completion
if [[ -f "$HOME/.oci/oci_autocomplete.sh" ]]; then
  source "$HOME/.oci/oci_autocomplete.sh"
fi

# terraform completion
if command -v terraform &> /dev/null; then
  autoload -U +X bashcompinit && bashcompinit 2>/dev/null
  complete -o nospace -C terraform terraform
fi

# aws completion
if command -v aws_completer &> /dev/null; then
  autoload -U +X bashcompinit && bashcompinit 2>/dev/null
  complete -C aws_completer aws
fi

# git-delta (use as default git pager)
if command -v delta &> /dev/null; then
  export GIT_PAGER="delta"
fi
