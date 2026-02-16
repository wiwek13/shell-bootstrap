# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

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

# atuin - shell history sync
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# nvm - Node version manager
export NVM_DIR="$HOME/.nvm"
if [[ -s "$(brew --prefix 2>/dev/null)/opt/nvm/nvm.sh" ]]; then
  source "$(brew --prefix)/opt/nvm/nvm.sh"
  source "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
fi

# pyenv - Python version manager
if command -v pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi

# kubectl completion
if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

# helm completion
if command -v helm &> /dev/null; then
  source <(helm completion zsh)
fi
