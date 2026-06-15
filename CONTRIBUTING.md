# Contributing to Talent Angels

Welcome! Talent Angels is an open-source mentorship project under
**LF Decentralized Trust**. This guide applies to **all repos** in the
`LFX-Talent-Angels` org. By contributing you agree to the
[Code of Conduct](./CODE_OF_CONDUCT.md).

## TL;DR

```bash
git switch -c feature/my-change      # 1. branch
# ... make changes (with your AI coding agent if you like) ...
git add -A
git commit -s -m "feat: add my change"   # 2. commit WITH -s (DCO sign-off)
git push -u origin feature/my-change      # 3. push the branch
gh pr create --fill                       # 4. open a PR, request a mentor review
```

## 1. Set up

1. Read the meta-repo [`README.md`](./README.md) and run
   `bin/setup-workspace.sh`.
2. Read [`CLAUDE.md`](./CLAUDE.md) — the project policy that AI agents and humans
   both follow.
3. Set up your AI coding agent: see [`docs/onboarding/`](./docs/onboarding/).

## 2. Pick up work

- Browse open issues in the relevant repo. Comment to claim one before starting.
- For new ideas, open an issue first so a mentor can scope it with you.
- Keep each PR to **one logical change**. Small PRs get reviewed faster.

## 3. Branch & commit

- Branch from `main`: `feature/<desc>`, `fix/<desc>`, or `docs/<desc>`.
- Conventional commit subjects are encouraged: `feat:`, `fix:`, `docs:`,
  `test:`, `refactor:`, `chore:`.
- **Never push to `main`.** Always open a PR.

### Developer Certificate of Origin (DCO) — required

Every commit must be **signed off**. This certifies you wrote the code or have
the right to submit it under the repo's license (see https://developercertificate.org).

```bash
git commit -s -m "your message"
```

This appends a line like:

```
Signed-off-by: Your Name <your.email@example.com>
```

Set your identity once so `-s` works:

```bash
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

Forgot to sign off? Fix the last commit with `git commit --amend -s --no-edit`,
or a range with `git rebase --signoff main`.

## 4. Using AI coding agents

This project is **AI-augmented by design** — using agents (Claude Code, Codex,
Cursor, Antigravity, …) is part of the expected workflow.

- Your agent should read `CLAUDE.md` + `AGENTS.md` before acting. They carry the
  project rules so any compliant agent behaves consistently.
- **You are accountable** for what you submit. Review and test agent output;
  sign off the commit yourself.
- Don't paste secrets or personal data (e.g. anything from `Mentees/`) into a
  prompt or a commit.
- Capture non-obvious decisions and learnings in `TA-memory`.

## 5. Open a PR

- Fill in the PR template. Link the issue it closes.
- Make sure CI is green and your commits are DCO-signed.
- Request review from a mentor (see [`GOVERNANCE.md`](./GOVERNANCE.md)).
- Address review comments by pushing new commits (don't force-push during
  review unless asked).

## 6. Review & merge

- At least one mentor approval is required to merge.
- Mentors merge via **squash** to keep history clean; the squashed commit keeps
  a DCO sign-off.

## Questions

Open a discussion or issue, or raise it in office hours / the project channel.
Thank you for contributing! 🚀
