#!/usr/bin/env bash
# ============================================================
# Project Sync Agent Launcher
# ============================================================
# Syncs changes from ~/.shell/ back to the shell-bootstrap
# project and updates the Brewfile with new packages.
#
# Usage: ./sync_to_project.sh [options]
#   --dry-run    Show what would be synced without applying
#   --brewfile   Only sync Brewfile changes
#   --shell      Only sync shell config changes
#   --help       Show this help message
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
SHELL_DIR="$HOME/.shell"
PROJECT_SHELL_DIR="$PROJECT_ROOT/shell"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default options
DRY_RUN=false
SYNC_BREWFILE=true
SYNC_SHELL=true

# Parse arguments
for arg in "$@"; do
  case $arg in
    --dry-run)
      DRY_RUN=true
      ;;
    --brewfile)
      SYNC_SHELL=false
      ;;
    --shell)
      SYNC_BREWFILE=false
      ;;
    --help|-h)
      echo "Project Sync Agent"
      echo ""
      echo "Usage: ./sync_to_project.sh [options]"
      echo ""
      echo "Options:"
      echo "  --dry-run    Show what would be synced without applying"
      echo "  --brewfile   Only sync Brewfile changes"
      echo "  --shell      Only sync shell config changes"
      echo "  --help       Show this help message"
      echo ""
      echo "This script syncs:"
      echo "  • Shell configs from ~/.shell/ to ./shell/"
      echo "  • New brew packages to Brewfile"
      exit 0
      ;;
  esac
done

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            Project Sync Agent                          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================================
# SHELL CONFIG SYNC
# ============================================================
if [[ "$SYNC_SHELL" == true ]]; then
  echo -e "${YELLOW}▶ Checking shell config changes...${NC}"
  echo ""
  
  CHANGES_FOUND=false
  
  # Compare each shell config file
  for subdir in zsh starship zellij; do
    if [[ -d "$SHELL_DIR/$subdir" ]]; then
      for file in "$SHELL_DIR/$subdir"/*; do
        if [[ -f "$file" ]]; then
          filename=$(basename "$file")
          project_file="$PROJECT_SHELL_DIR/$subdir/$filename"
          
          if [[ -f "$project_file" ]]; then
            # Check if files differ
            if ! diff -q "$file" "$project_file" &>/dev/null; then
              CHANGES_FOUND=true
              echo -e "${CYAN}  Modified: shell/$subdir/$filename${NC}"
              if [[ "$DRY_RUN" == true ]]; then
                echo -e "  ${YELLOW}--- Diff ---${NC}"
                diff -u "$project_file" "$file" | head -30 || true
                echo ""
              fi
            fi
          else
            CHANGES_FOUND=true
            echo -e "${GREEN}  New: shell/$subdir/$filename${NC}"
          fi
        fi
      done
    fi
  done
  
  if [[ "$CHANGES_FOUND" == false ]]; then
    echo -e "  ${GREEN}✔ Shell configs are in sync${NC}"
  elif [[ "$DRY_RUN" != true ]]; then
    echo ""
    echo -e "${YELLOW}  Applying shell config changes...${NC}"
    
    for subdir in zsh starship zellij; do
      if [[ -d "$SHELL_DIR/$subdir" ]]; then
        mkdir -p "$PROJECT_SHELL_DIR/$subdir"
        for file in "$SHELL_DIR/$subdir"/*; do
          if [[ -f "$file" ]]; then
            cp "$file" "$PROJECT_SHELL_DIR/$subdir/"
          fi
        done
      fi
    done
    
    echo -e "  ${GREEN}✔ Shell configs synced to project${NC}"
  fi
  echo ""
fi

# ============================================================
# BREWFILE SYNC
# ============================================================
if [[ "$SYNC_BREWFILE" == true ]]; then
  echo -e "${YELLOW}▶ Checking for new brew packages...${NC}"
  echo ""
  
  BREWFILE="$PROJECT_ROOT/Brewfile"
  
  # Get currently installed packages
  INSTALLED_FORMULAE=$(brew list --formula 2>/dev/null | sort)
  INSTALLED_CASKS=$(brew list --cask 2>/dev/null | sort)
  INSTALLED_TAPS=$(brew tap 2>/dev/null | sort)
  
  # Extract packages from Brewfile
  BREWFILE_FORMULAE=$(grep -E '^brew "' "$BREWFILE" 2>/dev/null | sed 's/brew "\([^"]*\)".*/\1/' | sed 's|.*/||' | sort)
  BREWFILE_CASKS=$(grep -E '^cask "' "$BREWFILE" 2>/dev/null | sed 's/cask "\([^"]*\)".*/\1/' | sort)
  BREWFILE_TAPS=$(grep -E '^tap "' "$BREWFILE" 2>/dev/null | sed 's/tap "\([^"]*\)".*/\1/' | sort)
  
  # Find new packages
  NEW_FORMULAE=$(comm -23 <(echo "$INSTALLED_FORMULAE") <(echo "$BREWFILE_FORMULAE"))
  NEW_CASKS=$(comm -23 <(echo "$INSTALLED_CASKS") <(echo "$BREWFILE_CASKS"))
  NEW_TAPS=$(comm -23 <(echo "$INSTALLED_TAPS") <(echo "$BREWFILE_TAPS"))
  
  HAS_NEW=false
  
  if [[ -n "$NEW_TAPS" ]]; then
    HAS_NEW=true
    echo -e "${CYAN}  New taps:${NC}"
    echo "$NEW_TAPS" | while read -r tap; do
      [[ -n "$tap" ]] && echo -e "    ${GREEN}+ tap \"$tap\"${NC}"
    done
  fi
  
  if [[ -n "$NEW_FORMULAE" ]]; then
    HAS_NEW=true
    echo -e "${CYAN}  New formulae:${NC}"
    echo "$NEW_FORMULAE" | while read -r formula; do
      [[ -n "$formula" ]] && echo -e "    ${GREEN}+ brew \"$formula\"${NC}"
    done
  fi
  
  if [[ -n "$NEW_CASKS" ]]; then
    HAS_NEW=true
    echo -e "${CYAN}  New casks:${NC}"
    echo "$NEW_CASKS" | while read -r cask; do
      [[ -n "$cask" ]] && echo -e "    ${GREEN}+ cask \"$cask\"${NC}"
    done
  fi
  
  if [[ "$HAS_NEW" == false ]]; then
    echo -e "  ${GREEN}✔ Brewfile is up to date${NC}"
  elif [[ "$DRY_RUN" == true ]]; then
    echo ""
    echo -e "${YELLOW}  Run without --dry-run to add these to Brewfile${NC}"
  else
    echo ""
    echo -e "${YELLOW}  To add these packages, use the AI agent:${NC}"
    echo "    opencode --config $SCRIPT_DIR/opencode.json"
    echo ""
    echo "  Or manually add them to: $BREWFILE"
  fi
  echo ""
fi

# ============================================================
# GIT STATUS
# ============================================================
echo -e "${YELLOW}▶ Project git status...${NC}"
echo ""

cd "$PROJECT_ROOT"
if [[ -d ".git" ]]; then
  MODIFIED=$(git status --porcelain 2>/dev/null | grep -c '^.M' 2>/dev/null || true)
  MODIFIED=${MODIFIED:-0}
  ADDED=$(git status --porcelain 2>/dev/null | grep -c '^A' 2>/dev/null || true)
  ADDED=${ADDED:-0}
  UNTRACKED=$(git status --porcelain 2>/dev/null | grep -c '^??' 2>/dev/null || true)
  UNTRACKED=${UNTRACKED:-0}
  
  echo "  Modified: $MODIFIED files"
  echo "  Added: $ADDED files"
  echo "  Untracked: $UNTRACKED files"
  echo ""
  
  TOTAL=$((MODIFIED + ADDED + UNTRACKED))
  if [[ $TOTAL -gt 0 ]]; then
    echo -e "${YELLOW}  To commit changes:${NC}"
    echo "    cd $PROJECT_ROOT"
    echo "    git add -A && git commit -m 'Sync shell configs'"
  else
    echo -e "  ${GREEN}✔ No uncommitted changes${NC}"
  fi
else
  echo -e "  ${YELLOW}⚠ Not a git repository${NC}"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            Sync Complete                               ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
