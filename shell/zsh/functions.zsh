# ============================================================
# AWS
# ============================================================

# Switch AWS profile (with fzf menu if no arg)
aws-switch() {
  if [[ -z "$1" ]]; then
    local profile=$(aws configure list-profiles | fzf --height 40% --reverse --prompt="AWS Profile: ")
    [[ -z "$profile" ]] && return 1
    export AWS_PROFILE="$profile"
  else
    export AWS_PROFILE="$1"
  fi
  echo "AWS_PROFILE=$AWS_PROFILE"
  aws sts get-caller-identity 2>/dev/null || echo "⚠️  Could not verify identity"
}

# Assume AWS role
aws-assume() {
  if [[ -z "$1" ]]; then
    echo "Usage: aws-assume <role-arn>"
    return 1
  fi
  local creds=$(aws sts assume-role --role-arn "$1" --role-session-name "cli-session" --output json)
  if [[ $? -ne 0 ]]; then
    echo "❌ Failed to assume role"
    return 1
  fi
  export AWS_ACCESS_KEY_ID=$(echo $creds | jq -r '.Credentials.AccessKeyId')
  export AWS_SECRET_ACCESS_KEY=$(echo $creds | jq -r '.Credentials.SecretAccessKey')
  export AWS_SESSION_TOKEN=$(echo $creds | jq -r '.Credentials.SessionToken')
  echo "✔ Assumed role: $1"
}

# Clear assumed role
aws-unassume() {
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
  echo "✔ Cleared AWS credentials"
}

# ============================================================
# KUBERNETES
# ============================================================

# Get shell into a pod (with fzf if no arg)
ksh() {
  local pod="${1:-$(kubectl get pods -o name | fzf --height 40% --reverse | sed 's|pod/||')}"
  [[ -z "$pod" ]] && return 1
  kubectl exec -it "$pod" -- /bin/sh
}

# Get bash into a pod
kbash() {
  local pod="${1:-$(kubectl get pods -o name | fzf --height 40% --reverse | sed 's|pod/||')}"
  [[ -z "$pod" ]] && return 1
  kubectl exec -it "$pod" -- /bin/bash
}

# Watch pods in current namespace
kwatch() {
  watch -n 2 "kubectl get pods $@"
}

# Decode and view a secret
ksecret() {
  if [[ -z "$1" ]]; then
    local secret=$(kubectl get secrets -o name | fzf --height 40% --reverse | sed 's|secret/||')
    [[ -z "$secret" ]] && return 1
    kubectl get secret "$secret" -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d)"'
  elif [[ -z "$2" ]]; then
    kubectl get secret "$1" -o json | jq -r '.data | to_entries[] | "\(.key): \(.value | @base64d)"'
  else
    kubectl get secret "$1" -o jsonpath="{.data.$2}" | base64 --decode
    echo ""
  fi
}

# Get events sorted by time
kevents() {
  kubectl get events --sort-by='.lastTimestamp' "$@"
}

# Quick pod logs with fzf selection
klogs() {
  local pod="${1:-$(kubectl get pods -o name | fzf --height 40% --reverse | sed 's|pod/||')}"
  [[ -z "$pod" ]] && return 1
  if [[ -z "$2" ]]; then
    kubectl logs -f "$pod"
  else
    kubectl logs -f "$pod" | grep --line-buffered "$2"
  fi
}

# Force delete stuck pod
kforcedel() {
  kubectl delete pod "$1" --force --grace-period=0
}

# Get all pods by node
kpodsbynode() {
  kubectl get pods -A -o wide --field-selector spec.nodeName="$1"
}

# Drain node
kdrain() {
  kubectl drain "$1" --ignore-daemonsets --delete-emptydir-data
}

# ============================================================
# DOCKER
# ============================================================

# Remove all stopped containers
docker-clean() {
  docker container prune -f
  docker image prune -f
  docker network prune -f
  echo "✔ Docker cleaned"
}

# Remove everything (nuclear option)
docker-nuke() {
  echo "⚠️  This will remove ALL containers, images, volumes, and networks!"
  read "confirm?Are you sure? (y/N) "
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    docker stop $(docker ps -aq) 2>/dev/null
    docker rm $(docker ps -aq) 2>/dev/null
    docker rmi $(docker images -q) 2>/dev/null
    docker volume prune -f
    docker network prune -f
    echo "✔ Docker nuked"
  fi
}

# Get shell into container (with fzf)
dsh() {
  local container="${1:-$(docker ps --format '{{.Names}}' | fzf --height 40% --reverse)}"
  [[ -z "$container" ]] && return 1
  docker exec -it "$container" /bin/sh
}

# Get bash into container
dbash() {
  local container="${1:-$(docker ps --format '{{.Names}}' | fzf --height 40% --reverse)}"
  [[ -z "$container" ]] && return 1
  docker exec -it "$container" /bin/bash
}

# ============================================================
# GIT
# ============================================================

# Create a new branch from main/master
gnb() {
  local base=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  base=${base:-main}
  git checkout "$base" && git pull && git checkout -b "$1"
}

# Delete merged branches (except main/master/develop)
gcleanb() {
  git branch --merged | grep -vE "^\*|main|master|develop" | xargs -n 1 git branch -d
}

# Interactive rebase on last n commits
grib() {
  git rebase -i HEAD~${1:-5}
}

# Quick commit with message
gac() {
  git add -A && git commit -m "$*"
}

# Push and set upstream
gpu() {
  git push -u origin $(git branch --show-current)
}

# Show git root
groot() {
  cd "$(git rev-parse --show-toplevel)"
}

# Checkout branch with fzf
gco-fzf() {
  local branch=$(git branch -a | fzf --height 40% --reverse | sed 's/^\* //' | sed 's/remotes\/origin\///' | xargs)
  [[ -n "$branch" ]] && git checkout "$branch"
}

# Show recent branches
gbrecent() {
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | head -20
}

# Interactive git log with fzf
glog-fzf() {
  git log --oneline --graph --all | fzf --preview 'git show --name-status {1}' --height 80%
}

# ============================================================
# UTILITIES
# ============================================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Find file by name (using fd)
ffind() {
  fd -H "$1"
}

# Find directory by name
dfind() {
  fd -Ht d "$1"
}

# Extract any archive
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.tar.zst) tar --zstd -xf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Quick HTTP server
serve() {
  local port="${1:-8000}"
  echo "Serving at http://localhost:$port"
  python3 -m http.server "$port"
}

# JSON pretty print
json() {
  if [[ -t 0 ]]; then
    jq '.' "$@"
  else
    cat | jq '.'
  fi
}

# Weather
weather() {
  curl -s "wttr.in/${1:-}?format=3"
}

# Detailed weather
weatherfull() {
  curl -s "wttr.in/${1:-}"
}

# Cheatsheet
cheat() {
  curl -s "cheat.sh/$1"
}

# Kill process on port
killport() {
  local pid=$(lsof -ti:$1)
  if [[ -n "$pid" ]]; then
    kill -9 $pid
    echo "✔ Killed process $pid on port $1"
  else
    echo "No process found on port $1"
  fi
}

# Quick notes
note() {
  local notes_dir="$HOME/.notes"
  mkdir -p "$notes_dir"
  if [[ -z "$1" ]]; then
    ls -lt "$notes_dir" | head -20
  else
    ${EDITOR:-nano} "$notes_dir/$1.md"
  fi
}

# URL encode/decode
urlencode() {
  python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
  python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}

# Base64 shortcuts
b64e() {
  echo -n "$1" | base64
}

b64d() {
  echo -n "$1" | base64 --decode
  echo ""
}

# Generate random password
genpass() {
  local length="${1:-32}"
  openssl rand -base64 48 | head -c "$length"
  echo ""
}

# Quick timer
timer() {
  local seconds="${1:-60}"
  echo "Timer for $seconds seconds..."
  sleep "$seconds"
  osascript -e 'display notification "Timer finished!" with title "Timer"'
  echo "✔ Done!"
}

# Copy last command to clipboard
copylast() {
  fc -ln -1 | pbcopy
  echo "✔ Last command copied to clipboard"
}

# ============================================================
# TERRAFORM
# ============================================================

# Terraform plan with output
tfplan() {
  terraform plan -out=tfplan "$@"
}

# Terraform apply plan
tfapply() {
  if [[ -f "tfplan" ]]; then
    terraform apply tfplan
  else
    terraform apply "$@"
  fi
}

# Switch terraform workspace (with fzf)
tfsw() {
  if [[ -z "$1" ]]; then
    local ws=$(terraform workspace list | grep -v '^\*' | fzf --height 40% --reverse | xargs)
    [[ -n "$ws" ]] && terraform workspace select "$ws"
  else
    terraform workspace select "$1" 2>/dev/null || terraform workspace new "$1"
  fi
}

# ============================================================
# NETWORK
# ============================================================

# Check if a port is open
portcheck() {
  nc -zv "$1" "$2" 2>&1
}

# Quick curl timing
curltime() {
  curl -o /dev/null -s -w "DNS: %{time_namelookup}s\nConnect: %{time_connect}s\nTLS: %{time_appconnect}s\nStart: %{time_starttransfer}s\nTotal: %{time_total}s\n" "$1"
}
