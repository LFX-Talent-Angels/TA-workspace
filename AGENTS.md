# AGENTS.md

Guidance for non-Claude AI coding agents (Codex, Antigravity, Cursor, Gemini,
Aider, and any other) working in the **Talent Angels** workspace.

This repository (`TA-workspace`) is the **meta-repo** for the Talent Angels
project at LF Decentralized Trust. It coordinates documentation and cross-repo
decisions. Product code lives in the first-level subrepos, each with its own git
history.

## Read first

Before making changes, read the local instructions in this order:

1. `CLAUDE.md` in this repo — **authoritative project policy**.
2. `docs/architecture/SYSTEM.md` — cross-repo architecture and naming.
3. The target subrepo's `AGENTS.md` and `CLAUDE.md`, when present.
4. `CONTRIBUTING.md` before opening any PR.

Treat `CLAUDE.md` files as authoritative. This file adds routing for non-Claude
agents and does not replace the rules in `CLAUDE.md`. **Keep both in sync** — if
you change a rule, change it in both files.

## Meta-repo rules

- Do not write application code in this repo. Root changes should be docs,
  coordination, scripts, or workspace configuration.
- Every first-level folder with `.git/` is a separate repo. Run git from inside
  the subrepo and inspect its status before changing files.
- Never push directly to `main`. Use a branch and PR flow.
- Every commit must be DCO signed-off (`git commit -s`). See `CONTRIBUTING.md`.
- Never commit `.env*` files or secrets (a local, gitignored `.env` is fine).
- The `Mentees/` folder (personal data) is outside this workspace and must never
  be committed.

## Subrepo inventory

- `TA-agents` — main project: AI Graph Agents (Locator, Connector, Pathfinder)
  and the Graph-RAG layer. Python.
- `TA-resources` — shared educational resources (knowledge graphs, AI agents,
  taxonomies, tooling).
- `TA-memory` — project memory: the original proposal, decisions (ADRs), meeting
  notes, and learnings.
- `TA-lab` — practice & experiments sandbox (exercises, per-mentee scratch).

## Project skills

Our workflows live as plain-markdown skills in `skills/<name>/SKILL.md`
(`ta-ship`, `ta-define`, `ta-skill`, …). Claude Code runs them as `/ta-*`. **As a
non-Claude agent, read the relevant `SKILL.md` and follow it as workflow intent** —
there's no special runtime, just the steps. `bin/setup-workspace.sh` links them
into each repo's `.claude/skills/`.

## Agent-agnostic behavior

- Interpret slash-command references (e.g. `/ta-ship`, `/ta-define`) as
  **workflow intent**: read the matching `skills/<name>/SKILL.md` and follow it,
  or perform the steps manually when no equivalent exists.
- Prefer existing repo commands and conventions over inventing new workflows.
- Keep meta-repo docs and subrepo implementation docs in sync when a change
  crosses repo boundaries.
- Record non-obvious decisions and learnings in `TA-memory`.
