# Onboarding

Welcome to Talent Angels! This gets you from zero to your first PR.

## 1. Accounts & access

- A **GitHub** account, added to the `LFX-Talent-Angels` org (ask a mentor).
- Join the project chat channel and the office-hours calendar.

## 2. Local setup

```bash
# Clone the meta-repo and run the setup script
git clone https://github.com/LFX-Talent-Angels/TA-workspace.git
cd TA-workspace
bash bin/setup-workspace.sh
```

This clones `TA-agents`, `TA-resources`, and `TA-memory` into the workspace and
prepares the Python environment for `TA-agents`.

## 3. Configure git for DCO

Every commit must be signed off (see [`../../CONTRIBUTING.md`](../../CONTRIBUTING.md)):

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
# then always commit with -s
git commit -s -m "feat: ..."
```

## 4. Set up your AI coding agent

Read [`ai-agents.md`](./ai-agents.md). The short version: this project is
agent-driven, and every repo carries `CLAUDE.md` + `AGENTS.md` so your agent
picks up the rules automatically — whichever agent you use.

## 5. Read before you build

1. The meta-repo [`CLAUDE.md`](../../CLAUDE.md) — project policy.
2. [`architecture/SYSTEM.md`](../architecture/SYSTEM.md) — what we're building.
3. The original proposal: `TA-memory/proposals/original-proposal.md`.
4. The target subrepo's `README.md` + `CLAUDE.md`.

## 6. Your first contribution

- Find a `good first issue` in `TA-agents` (or improve docs/resources).
- Branch, make the change, `git commit -s`, push, open a PR.
- Request a mentor review. Iterate. 🎉

## Where things live

| I want to…                          | Go to            |
| ----------------------------------- | ---------------- |
| Write agent code                    | `TA-agents/`     |
| Add a tutorial or reference         | `TA-resources/`  |
| Record a decision / meeting / note  | `TA-memory/`     |
| Change project-wide docs or rules   | `TA-workspace/`  |
