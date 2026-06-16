# Talent Angels — Workspace (`TA-workspace`)

> A suite of **AI Graph Agents** that empower humans to navigate the landscape
> of skills, tasks, and occupations for lifelong learning in the age of AI.
>
> A mentorship project of **LF Decentralized Trust** — Learning Tokens Lab.

`TA-workspace` is the **meta-repo**: the umbrella that ties together the project
repos, documentation, decisions, and onboarding. If you're a mentee, **start
here**.

## Vision

Skills are the currency of talent. In the age of AI, skill demand shifts faster
than any individual, educator, or employer can track. Talent Angels builds a
living, data-driven ontology of talent — queried through AI Graph Agents that
build and traverse knowledge graphs — to bridge human skills development and
AI-driven work.

We reason over five global taxonomies: **ESCO**, **O*NET**, **SFIA**, **BLS**,
and **Lightcast**, via three agents — **Locator**, **Connector**, and
**Pathfinder** — backed by **Graph-RAG**.

## How we build

Talent Angels is **agent-driven**: coding agents (Claude Code, Codex, Cursor,
Antigravity, …) do the bulk of implementation; mentees direct them, review, and
own the result. Because that makes coding cheap, our early effort goes into
**foundations and stack/framework definition**, and our plan is **outcome-based**
(only the next 1–2 sprints are committed). See [`ROADMAP.md`](./ROADMAP.md) and
[ADR-0002](./docs/decisions/0002-agent-driven-outcome-based.md).

## Structure

This workspace is a meta-repo. The subrepos are first-level folders, each with
its own git history (the meta-repo's `.gitignore` excludes them):

```
TA-workspace/                 ← this meta-repo
├── CLAUDE.md                 ← authoritative project policy (agents + humans)
├── AGENTS.md                 ← routing for non-Claude agents (Codex, etc.)
├── CONTRIBUTING.md           ← how to contribute (branch, PR, DCO)
├── CODE_OF_CONDUCT.md
├── GOVERNANCE.md             ← roles, mentors, decision-making
├── ROADMAP.md                ← deliverables timeline + meetups
├── bin/setup-workspace.sh    ← one command to clone + set up everything
├── docs/
│   ├── architecture/SYSTEM.md
│   ├── onboarding/           ← set up your AI coding agent
│   ├── decisions/            ← Architecture Decision Records (ADRs)
│   └── meetups/              ← meetup notes + templates
├── TA-agents/                ← subrepo: the AI Graph Agents (Python)
├── TA-resources/             ← subrepo: shared educational resources
├── TA-memory/                ← subrepo: project memory (proposal, decisions, log)
└── TA-lab/                   ← subrepo: practice & experiments sandbox
```

## Repos in the org

| Repo                                            | What it holds                              |
| ----------------------------------------------- | ------------------------------------------ |
| [`TA-workspace`](.)                             | Meta-repo: docs, decisions, onboarding     |
| [`TA-agents`](../TA-agents)                      | Main project: AI Graph Agents + Graph-RAG  |
| [`TA-resources`](../TA-resources)                | Educational resources for all contributors |
| [`TA-memory`](../TA-memory)                      | Project memory: proposal, ADRs, notes      |
| [`TA-lab`](../TA-lab)                            | Practice & experiments sandbox (exercises) |

## Setup

### Prerequisites

- `git` and `gh` (GitHub CLI)
- Python 3.11+ (for `TA-agents`)
- An AI coding agent of your choice (Claude Code, Codex, Cursor, Antigravity, …)

### First-time setup

```bash
# 1. Clone the meta-repo
git clone https://github.com/LFX-Talent-Angels/TA-workspace.git
cd TA-workspace

# 2. Run the setup script — clones the subrepos and prepares the Python env
bash bin/setup-workspace.sh
```

The subrepos are cloned **into** this folder as siblings of `docs/`. They are
ignored by the meta-repo's git, so each one keeps its own history.

### What `bin/setup-workspace.sh` does

For transparency, the script (≈70 lines, no magic) does exactly this:

1. **Clones the subrepos** `TA-agents`, `TA-resources`, `TA-memory`, and `TA-lab`
   into this folder. Already cloned? It skips them (set `UPDATE=1` to also
   `git pull --ff-only`).
2. **Prepares the Python env** for `TA-agents` if `pyproject.toml` is present —
   uses `uv` if available, otherwise `python3 -m venv` + `pip install -e ".[dev]"`.
3. **Reminds you to set your git identity** if `user.email` is unset, so DCO
   sign-off (`git commit -s`) works.

It is idempotent (safe to re-run) and never touches secrets or the `Mentees/`
folder. Clone protocol defaults to **HTTPS** (no SSH key needed); set `USE_SSH=1`
to use SSH remotes. Read it before running: [`bin/setup-workspace.sh`](./bin/setup-workspace.sh).

## How to use the workspace

- **Project-wide decisions, docs, onboarding** → work from `TA-workspace/`.
- **Writing agent code** → open a terminal in `TA-agents/`.
- **Adding a learning resource** → open `TA-resources/`.
- **Recording a decision, meeting, or learning** → open `TA-memory/`.
- **Doing an exercise or quick experiment** → open `TA-lab/`.

Every subrepo carries its own `CLAUDE.md` + `AGENTS.md` so your coding agent
picks up the local rules automatically.

## Contributing

Read [`CONTRIBUTING.md`](./CONTRIBUTING.md). In short: branch, commit with
`git commit -s` (DCO sign-off), open a PR, and request review from a mentor.

## Meetups

Three virtual meetups mark progress (see [`ROADMAP.md`](./ROADMAP.md)):
end of week 10, week 19, and week 26.

## License

- Code (`TA-workspace`, `TA-agents`): **Apache-2.0**.
- Content (`TA-resources`, `TA-memory`): **CC-BY-4.0**.

`TA-workspace` is mostly coordination docs plus some scripts/CI. Its scripts and
config are **Apache-2.0** (see [`LICENSE`](./LICENSE)); its prose documentation is
also offered under **CC-BY-4.0** so it can be reused freely alongside
`TA-resources`/`TA-memory`.
