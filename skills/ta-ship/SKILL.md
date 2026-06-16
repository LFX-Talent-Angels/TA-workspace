---
name: ta-ship
description: Ship a change the open-source way for Talent Angels — run tests/lint, update the CHANGELOG, make a DCO-signed commit, push a branch, and open a PR for mentor review. Use when the user says "ship", "open a PR", or "this is ready".
---

# /ta-ship

Take a finished change from working tree to a reviewable Pull Request, following
Talent Angels conventions. **No deploys, no version publishing** — this is an
open-source contribution flow, not a release pipeline.

## Before you start

- Confirm there are real changes (`git status`). If the tree is clean, stop.
- Confirm you are **not on `main`**. If you are, create a branch first:
  `git switch -c <type>/<short-desc>` (`feat/`, `fix/`, `docs/`, …).

## Steps

1. **Review the diff.** Read `git diff` (and `git diff --staged`). Summarize what
   changed in one or two sentences. If something looks unintended, flag it and
   stop.
2. **Run the checks that exist in this repo.** Don't invent commands — detect:
   - Python repo (`pyproject.toml`): `ruff check .`, `ruff format --check .`,
     `pytest -q`.
   - JS/TS repo (`package.json`): the repo's `lint` and `test` scripts.
   - Otherwise: run whatever the repo documents. If there are no checks, say so.
   If checks fail, fix them or stop and report — never ship red.
3. **Update the CHANGELOG** if the repo has one (add an entry under "Unreleased").
   Skip if there is none.
4. **Commit with DCO sign-off.** Stage intentional files (not `git add -A` blindly;
   never stage `.env`, secrets, or anything from `Mentees/`). Then:
   `git commit -s -m "<type>: <concise summary>"`. The `-s` is required.
5. **Push the branch.** `git push -u origin <branch>`.
6. **Open the PR.** `gh pr create --fill` (or write a title/body from the diff
   summary). Fill the PR template: what & why, how to test, link the issue.
7. **Request review** from a mentor (see `GOVERNANCE.md`) and report the PR URL.

## Rules

- Every commit DCO-signed (`git commit -s`). Never push to `main`.
- Never commit secrets or personal data.
- Keep the PR to one logical change. If the diff sprawls, suggest splitting it.
- You (the human) own the change: the agent ran the steps, but you confirm the
  diff and the green checks.

## Non-Claude agents

Treat this as workflow intent: run the equivalent steps with your own tooling.
There is no special runtime — it's just git + the repo's test/lint commands + the
GitHub CLI.
