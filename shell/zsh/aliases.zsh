# ============================================================
# NAVIGATION & FILES
# ============================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# Modern ls (eza) with fallback
if command -v eza &> /dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --group-directories-first --git'
  alias la='eza -a --icons --group-directories-first'
  alias lt='eza -la --icons --sort=modified'
  alias tree='eza --tree --icons --level=3'
else
  alias ll='ls -lAFh'
  alias la='ls -A'
  alias lt='ls -ltrh'
fi
alias l='ls -CF'

alias cat='bat --paging=never'
alias catp='bat'                # With paging
alias ag='ag --nocolor'

alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -iv'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias du='du -h'
alias df='df -h'
alias free='top -l 1 | head -n 10'

# ============================================================
# GIT (extends OMZ git plugin)
# ============================================================
alias g='git'
alias gs='git status --short --branch'
alias gss='git status'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull --rebase'
alias gl='git log --oneline --graph --decorate -15'
alias gla='git log --oneline --graph --decorate --all'
alias glp='git log -p -5'       # Log with patches
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'          # Interactive staging
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gm='git merge'
alias gmn='git merge --no-ff'
alias gr='git rebase'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsts='git stash show -p'
alias gf='git fetch --all --prune'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grhs='git reset HEAD --soft'
alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean -fd'
alias gcleanx='git clean -fdx'  # Also remove ignored files
alias gbl='git blame'
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git log -1 --format="%B" | grep -q "^WIP" && git reset HEAD~1'

# ============================================================
# KUBERNETES
# ============================================================
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'

# Get resources
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgpw='kubectl get pods -o wide'
alias kgpy='kubectl get pods -o yaml'
alias kgs='kubectl get svc'
alias kgsa='kubectl get sa'
alias kgd='kubectl get deploy'
alias kgds='kubectl get ds'
alias kgss='kubectl get sts'
alias kgn='kubectl get nodes'
alias kgno='kubectl get nodes -o wide'
alias kgns='kubectl get ns'
alias kgi='kubectl get ingress'
alias kgcm='kubectl get configmaps'
alias kgsec='kubectl get secrets'
alias kgpvc='kubectl get pvc'
alias kgpv='kubectl get pv'
alias kgj='kubectl get jobs'
alias kgcj='kubectl get cronjobs'
alias kgall='kubectl get all -A'
alias kgev='kubectl get events --sort-by=.lastTimestamp'

# Describe
alias kdesc='kubectl describe'
alias kdp='kubectl describe pod'
alias kds='kubectl describe svc'
alias kdd='kubectl describe deploy'
alias kdn='kubectl describe node'

# Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias klt='kubectl logs --tail=100'
alias klft='kubectl logs -f --tail=100'
alias klp='kubectl logs --previous'

# Exec & Debug
alias kex='kubectl exec -it'
alias krun='kubectl run -it --rm --restart=Never debug --image=busybox -- sh'
alias kdebug='kubectl run -it --rm --restart=Never debug --image=nicolaka/netshoot -- bash'

# Apply & Delete
alias ka='kubectl apply -f'
alias kak='kubectl apply -k'
alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'
alias kdelf='kubectl delete -f'

# Rollout
alias kro='kubectl rollout'
alias kros='kubectl rollout status'
alias kroh='kubectl rollout history'
alias krou='kubectl rollout undo'
alias kror='kubectl rollout restart'

# Top
alias ktop='kubectl top'
alias ktopn='kubectl top nodes'
alias ktopp='kubectl top pods'
alias ktoppc='kubectl top pods --containers'

# Port forward
alias kpf='kubectl port-forward'

# Edit
alias ke='kubectl edit'
alias ked='kubectl edit deploy'
alias kecm='kubectl edit configmap'

# Scale
alias ksc='kubectl scale'

# API Resources
alias kapi='kubectl api-resources'

# ============================================================
# DOCKER
# ============================================================
alias d='docker'
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"'
alias di='docker images'
alias dis='docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"'
alias drmi='docker rmi'
alias drm='docker rm'
alias drmf='docker rm -f'
alias dex='docker exec -it'
alias dl='docker logs'
alias dlf='docker logs -f'
alias dlt='docker logs --tail=100'
alias dlft='docker logs -f --tail=100'
alias dstop='docker stop'
alias dstopa='docker ps -q | xargs docker stop 2>/dev/null || echo "No running containers"'
alias dstart='docker start'
alias drestart='docker restart'
alias dinspect='docker inspect'
alias dip='docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias dprune='docker system prune -af'
alias dvprune='docker volume prune -f'
alias diprune='docker image prune -af'
alias dnprune='docker network prune -f'
alias dcp='docker cp'
alias dstats='docker stats --no-stream'
alias dtop='docker top'

# Docker Compose
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcub='docker compose up -d --build'
alias dcd='docker compose down'
alias dcds='docker compose down --volumes --remove-orphans'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'
alias dclt='docker compose logs -f --tail=100'
alias dcb='docker compose build'
alias dcbn='docker compose build --no-cache'
alias dcps='docker compose ps'
alias dce='docker compose exec'
alias dcpull='docker compose pull'
alias dcconfig='docker compose config'

# ============================================================
# TERRAFORM
# ============================================================
alias tf='terraform'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
alias tfir='terraform init -reconfigure'
alias tfp='terraform plan'
alias tfpo='terraform plan -out=tfplan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfap='terraform apply tfplan'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'
alias tfv='terraform validate'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'
alias tffc='terraform fmt -check'
alias tfo='terraform output'
alias tfoj='terraform output -json'
alias tfs='terraform state'
alias tfsl='terraform state list'
alias tfss='terraform state show'
alias tfsm='terraform state mv'
alias tfsr='terraform state rm'
alias tfsp='terraform state pull'
alias tfspu='terraform state push'
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tfwn='terraform workspace new'
alias tfwd='terraform workspace delete'
alias tfg='terraform graph'
alias tfr='terraform refresh'
alias tfc='terraform console'
alias tfim='terraform import'
alias tfpro='terraform providers'
alias tftaint='terraform taint'
alias tfuntaint='terraform untaint'

# ============================================================
# AWS CLI
# ============================================================
alias aws-whoami='aws sts get-caller-identity'
alias aws-regions='aws ec2 describe-regions --output table'
alias aws-azs='aws ec2 describe-availability-zones --output table'

# EC2
alias ec2-ls='aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PrivateIpAddress,Tags[?Key==\`Name\`].Value|[0]]" --output table'
alias ec2-running='aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --output table'
alias ec2-stop='aws ec2 stop-instances --instance-ids'
alias ec2-start='aws ec2 start-instances --instance-ids'

# S3
alias s3-ls='aws s3 ls'
alias s3-mb='aws s3 mb'
alias s3-rb='aws s3 rb'
alias s3-sync='aws s3 sync'
alias s3-cp='aws s3 cp'
alias s3-rm='aws s3 rm'

# EKS
alias eks-ls='aws eks list-clusters'
alias eks-update='aws eks update-kubeconfig --name'

# ECR
alias ecr-login='aws ecr get-login-password | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$(aws configure get region).amazonaws.com'

# SSM
alias ssm-start='aws ssm start-session --target'
alias ssm-ls='aws ssm describe-instance-information --output table'

# Lambda
alias lambda-ls='aws lambda list-functions --query "Functions[*].[FunctionName,Runtime,LastModified]" --output table'

# CloudFormation
alias cfn-ls='aws cloudformation list-stacks --query "StackSummaries[?StackStatus!=\`DELETE_COMPLETE\`].[StackName,StackStatus]" --output table'

# ============================================================
# NETWORKING & DEBUGGING
# ============================================================
alias ip='curl -s ifconfig.me'
alias ipv4='curl -4 -s ifconfig.me'
alias ipv6='curl -6 -s ifconfig.me'
alias localip='ipconfig getifaddr en0'
alias myip='echo "Public: $(curl -s ifconfig.me)" && echo "Local: $(ipconfig getifaddr en0)"'
alias ports='lsof -i -P -n | grep LISTEN'
alias listening='netstat -an | grep LISTEN'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias ping='ping -c 5'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias headers='curl -I'
alias httpdump='sudo tcpdump -i en0 -n -s 0 -w - | strings'

# ============================================================
# SYSTEM
# ============================================================
alias reload='source ~/.zshrc && echo "✔ zshrc reloaded"'
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias path='echo $PATH | tr ":" "\n"'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias timestamp='date +%s'
alias week='date +%V'
alias cal3='cal -3'
alias diskspace='df -h | grep -E "^/dev|^Filesystem"'
alias usage='du -sh * | sort -rh | head -20'
alias top10='du -sh * 2>/dev/null | sort -rh | head -10'
alias psg='ps aux | grep -v grep | grep -i'
# macOS compatible process sorting
alias psmem='ps aux -m | head -10'
alias pscpu='ps aux -r | head -10'

# Cleanup
alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'
alias emptytrash='rm -rf ~/.Trash/*'
alias cleanlogs='sudo rm -rf /private/var/log/asl/*.asl'

# macOS specific
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias lock='pmset displaysleepnow'
alias sleep='pmset sleepnow'

# Update
alias brewup='brew update && brew upgrade && brew cleanup && brew doctor'

# ============================================================
# QUICK EDITS
# ============================================================
alias ea='${EDITOR:-nano} ~/.shell/zsh/aliases.zsh && source ~/.zshrc'
alias ef='${EDITOR:-nano} ~/.shell/zsh/functions.zsh && source ~/.zshrc'
alias ee='${EDITOR:-nano} ~/.shell/zsh/exports.zsh && source ~/.zshrc'
alias ep='${EDITOR:-nano} ~/.shell/zsh/plugins.list'
alias et='${EDITOR:-nano} ~/.shell/zsh/tools.zsh && source ~/.zshrc'
alias es='${EDITOR:-nano} ~/.shell/starship/starship.toml'
alias ez='${EDITOR:-nano} ~/.shell/zellij/config.kdl'

# ============================================================
# SHELL CONFIG AGENT
# ============================================================
# AI-powered shell config maintenance (requires OpenRouter API key)
# Default is preview/dry-run mode. Use --apply to make changes.
SHELL_BOOTSTRAP_DIR="${SHELL_BOOTSTRAP_DIR:-$HOME/Documents/Projects/shell-bootstrap}"
alias shell-organize='$SHELL_BOOTSTRAP_DIR/agent/organize_shell.sh'           # Preview (default)
alias shell-organize-apply='$SHELL_BOOTSTRAP_DIR/agent/organize_shell.sh --apply'  # Apply changes
alias shell-sync='$SHELL_BOOTSTRAP_DIR/agent/sync_to_project.sh'
alias shell-sync-dry='$SHELL_BOOTSTRAP_DIR/agent/sync_to_project.sh --dry-run'

