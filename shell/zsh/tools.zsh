# Starship prompt
eval "$(starship init zsh)"

# Zellij
export ZELLIJ_CONFIG_DIR="$HOME/.shell/zellij"

# Eternal Terminal
export ET_NO_AUTO_UPDATE=1

# z - directory jumping
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# direnv - environment switching
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# kubectl completion
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# helm completion
if command -v helm &> /dev/null; then
  source <(helm completion zsh)
fi
