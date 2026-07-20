#!/usr/bin/env bash
#
# protect-branches.sh — apply Talent Angels branch protection to `main` on each
# repo via the GitHub API. Idempotent (safe to re-run); use it for new repos too.
#
# What it enforces on `main`:
#   - Pull request required, with >= 1 approving review (stale reviews dismissed)
#   - No force-pushes, no branch deletion, linear history
#   - enforce_admins = false (mentors/admins can merge so they aren't blocked
#     while there's no second reviewer yet)
#
# NOTE: GitHub branch protection is free for PUBLIC repos on any plan. For
# PRIVATE repos it requires GitHub Team/Enterprise — this script will fail on a
# private repo under a Free org.
#
# Usage:
#   bash bin/protect-branches.sh                 # all project repos
#   bash bin/protect-branches.sh TA-agents       # one or more specific repos
#
set -euo pipefail

ORG="LFX-Talent-Angels"
BRANCH="main"
DEFAULT_REPOS=("TA-workspace" "TA-agents" "TA-taxonomies" "TA-app" "TA-resources" "TA-memory" "TA-lab")

REPOS=("$@")
[ "${#REPOS[@]}" -eq 0 ] && REPOS=("${DEFAULT_REPOS[@]}")

command -v gh >/dev/null 2>&1 || { echo "error: gh (GitHub CLI) not found"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "error: gh not authenticated (run: gh auth login)"; exit 1; }

read -r -d '' BODY <<'JSON' || true
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_linear_history": true
}
JSON

for repo in "${REPOS[@]}"; do
  if printf '%s' "$BODY" | gh api -X PUT "repos/$ORG/$repo/branches/$BRANCH/protection" --input - >/dev/null 2>&1; then
    echo "$repo: $BRANCH protected ✓"
  else
    echo "$repo: FAILED (private repo on a Free org? or insufficient permissions)"
  fi
done

echo "Done."
