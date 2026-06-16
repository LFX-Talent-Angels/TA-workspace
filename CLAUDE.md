# TA-workspace

Authoritative project policy for **Talent Angels**, a mentorship project of
**LF Decentralized Trust (LFDT)** — Learning Tokens Lab.

`TA-workspace` is the **meta-repo**: an umbrella that coordinates documentation,
decisions, onboarding, and cross-repo rules. Product code, educational content,
and project memory live in the first-level subrepos, each with its own git
history. **No application code is written in this repo.**

> This file is the source of truth for AI coding agents and humans alike. The
> companion `AGENTS.md` routes non-Claude agents (Codex, Antigravity, Cursor,
> Gemini, etc.) to the same rules — keep them in sync.

## What we are building

A suite of **AI Graph Agents** that reason over global skill/task/occupation
taxonomies (ESCO, O*NET, SFIA, BLS, Lightcast) through a natural-language chat
interface, backed by Graph-RAG. Three core agents:

- **Locator** — pinpoints skills, tasks, and occupations inside the taxonomies.
- **Connector** — lists the nodes directly preceding/succeeding a location.
- **Pathfinder** — traces all routes connecting two locations (learning journeys).

A future **Evaluator** ranks paths by relevance, distance, and profile fit.

See `docs/architecture/SYSTEM.md` for the high-level architecture.

## Read first

Before making changes, read local instructions in this order:

1. `CLAUDE.md` in this repo (this file).
2. `docs/architecture/SYSTEM.md` — cross-repo architecture and naming.
3. The target subrepo's `CLAUDE.md` and `AGENTS.md`.
4. `CONTRIBUTING.md` before opening any PR.

## Meta-repo rules

- Do **not** write application code here. Root changes are docs, coordination,
  scripts, or workspace configuration.
- Every first-level folder with `.git/` is a **separate repo**. The root git
  repo does not own subrepo changes. The `.gitignore` excludes the subrepos.
- When editing a subrepo, run git from inside that subrepo and check its status
  first.
- The `Mentees/` folder (CVs, cover letters, personal data) lives **outside**
  this workspace and must **never** be committed to any repo.

## Subrepo inventory

| Folder         | Repo            | Purpose                                            | License      |
| -------------- | --------------- | -------------------------------------------------- | ------------ |
| `TA-agents`    | `TA-agents`     | Main project: the AI Graph Agents + Graph-RAG code | Apache-2.0   |
| `TA-resources` | `TA-resources`  | Shared educational resources for all contributors  | CC-BY-4.0    |
| `TA-memory`    | `TA-memory`     | Project memory: proposal, decisions, notes, log    | CC-BY-4.0    |
| `TA-lab`       | `TA-lab`        | Practice & experiments sandbox (exercises, spikes) | Apache-2.0   |

The original project proposal lives in `TA-memory/proposals/original-proposal.md`.

## Git rules (apply to this repo and every subrepo)

- Never push directly to `main`. Always branch, then open a Pull Request.
- Branch naming: `feature/<short-desc>`, `fix/<short-desc>`, `docs/<short-desc>`.
- **Every commit must be signed off (DCO)** with `git commit -s`, adding a
  `Signed-off-by: Name <email>` line. PRs without DCO are blocked. See
  `CONTRIBUTING.md`.
- If the user asks for a local commit, commit locally only. Push or open a PR
  only when explicitly requested.
- Keep PRs small and focused; one logical change per PR.

## Secrets

- Never **commit** `.env*` files or secrets. A local `.env` (gitignored) is fine
  for running things; only `.env.example`, with placeholder values, is committed.
- API keys (LLM providers, Neo4j, Supabase, taxonomy APIs) are configured
  locally and via repo/org secrets in CI — never in source.

## Agent-driven development

This project is **agent-driven**, not just AI-assisted. Coding agents (Claude
Code, Codex, Cursor, Antigravity, or any other) do the bulk of implementation;
mentees direct them, review the output, and own what they submit. See
[ADR-0002](docs/decisions/0002-agent-driven-outcome-based.md).

Because agents make writing code cheap, the bottleneck moves upstream. **The
high-value work is setup, stack/framework definition, and clear specs** — which
is why the early sprints prioritize foundations and choosing the stack (see
`ROADMAP.md`).

- The agent must read this `CLAUDE.md` and the relevant `AGENTS.md` before
  acting. Any agent that respects `CLAUDE.md`/`AGENTS.md` conventions picks up
  the same project rules.
- You are accountable for what you submit: review it, test it, and sign off the
  commit yourself (`git commit -s`). An agent wrote it ≠ you're off the hook.
- Document non-obvious decisions and learnings in `TA-memory`.
- Project skills in `skills/` (run as `/ta-*`) encode our common workflows; add
  your own (see `skills/ta-skill/`).

## gstack (optional, Claude Code skills)

If a mentee has gstack installed, workflow skills (`/review`, `/ship`, `/qa`,
`/browse`, `/investigate`, …) are available. gstack is **optional** — the
project does not depend on it. Slash-command references in docs are workflow
*intent*; agents without gstack should fall back to the equivalent manual steps.
