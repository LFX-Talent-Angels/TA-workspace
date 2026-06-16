#!/usr/bin/env bash
#
# setup-workspace.sh — clone the Talent Angels subrepos into this meta-repo and
# prepare local environments. Safe to re-run (idempotent).
#
# Usage:
#   bash bin/setup-workspace.sh
#
set -euo pipefail

ORG="LFX-Talent-Angels"
SUBREPOS=("TA-agents" "TA-resources" "TA-memory" "TA-lab")

# Resolve the meta-repo root (parent of this script's bin/ dir).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT"

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }

# Default to HTTPS (works for public repos without an SSH key — best for new
# contributors). Set USE_SSH=1 to use SSH remotes instead.
remote_url() {
  local repo="$1"
  if [ "${USE_SSH:-0}" = "1" ]; then
    echo "git@github.com:$ORG/$repo.git"
  else
    echo "https://github.com/$ORG/$repo.git"
  fi
}

info "Talent Angels workspace setup"
info "Meta-repo: $ROOT"

# 1. Clone / update each subrepo as a first-level folder.
for repo in "${SUBREPOS[@]}"; do
  if [ -d "$repo/.git" ]; then
    if [ "${UPDATE:-0}" = "1" ]; then
      info "$repo already cloned — pulling latest (UPDATE=1)"
      git -C "$repo" pull --ff-only || warn "$repo: could not fast-forward (local changes?)"
    else
      info "$repo already cloned — skipping (set UPDATE=1 to pull latest)"
    fi
  elif [ -d "$repo" ]; then
    warn "$repo exists but is not a git repo — skipping clone"
  else
    info "Cloning $repo"
    git clone "$(remote_url "$repo")" "$repo" \
      || warn "Could not clone $repo (does it exist on the org yet?)"
  fi
done

# 2. Prepare the Python environment for TA-agents (if present).
if [ -f "TA-agents/pyproject.toml" ]; then
  info "Setting up Python env for TA-agents"
  if command -v uv >/dev/null 2>&1; then
    ( cd TA-agents && uv venv && uv pip install -e ".[dev]" ) \
      || warn "uv setup failed — set up TA-agents manually"
  elif command -v python3 >/dev/null 2>&1; then
    ( cd TA-agents \
        && python3 -m venv .venv \
        && ./.venv/bin/pip install --quiet --upgrade pip \
        && ./.venv/bin/pip install -e ".[dev]" ) \
      || warn "pip setup failed — set up TA-agents manually"
  else
    warn "No python3/uv found — skipping TA-agents env"
  fi
fi

# 3. Friendly reminder about DCO.
if ! git config user.email >/dev/null 2>&1; then
  warn "git user.email is not set. Configure it so DCO sign-off works:"
  warn "  git config --global user.name 'Your Name'"
  warn "  git config --global user.email 'you@example.com'"
fi

info "Done. Subrepos: ${SUBREPOS[*]}"
info "Next: read CLAUDE.md and docs/onboarding/README.md"
