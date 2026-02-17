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

# gcloud - Google Cloud SDK (installed via cask)
if [[ -d "$(brew --prefix 2>/dev/null)/share/google-cloud-sdk" ]]; then
  export PATH="$(brew --prefix)/share/google-cloud-sdk/bin:$PATH"
  source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

# oci - Oracle Cloud Infrastructure CLI completion
if command -v oci &> /dev/null; then
  eval "$(oci setup autocomplete 2>/dev/null || true)"
fi

# argocd completion
if command -v argocd &> /dev/null; then
  source <(argocd completion zsh)
fi

# terraform completion
if command -v terraform &> /dev/null; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C terraform terraform
fi

# aws completion
if command -v aws_completer &> /dev/null; then
  autoload -U +X bashcompinit 2>/dev/null
  complete -C aws_completer aws
fi

# gh (GitHub CLI) completion
if command -v gh &> /dev/null; then
  source <(gh completion -s zsh)
fi

# kustomize completion
if command -v kustomize &> /dev/null; then
  source <(kustomize completion zsh)
fi

# helmfile completion
if command -v helmfile &> /dev/null; then
  source <(helmfile completion zsh 2>/dev/null || true)
fi

# trivy completion
if command -v trivy &> /dev/null; then
  source <(trivy completion zsh 2>/dev/null || true)
fi

# git-delta (use as default git pager)
if command -v delta &> /dev/null; then
  export GIT_PAGER="delta"
fi
