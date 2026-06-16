# Talent Angels skills

Project-owned **workflow skills** for Talent Angels. These are clean-room,
lightweight, and **agent-agnostic** — no telemetry, no phone-home, no commercial.
They encode our common workflows so any contributor (and any coding agent) does
them consistently.

> Inspired by the *ideas* behind tools like a "ship" command and a Socratic
> "definition" command, but written from scratch and scoped to **open-source
> project development** — not to building a company.

## How they work

- Each skill is a folder with a `SKILL.md` (plain markdown + a small YAML header).
- **Claude Code** runs them as slash commands: `/ta-ship`, `/ta-define`, etc.
- **Other agents** (Codex, Cursor, Antigravity, Gemini …) read the `SKILL.md` as
  workflow intent — `AGENTS.md` points them here.
- `bin/setup-workspace.sh` **symlinks** each skill into every repo's
  `.claude/skills/<name>`, so they're available whichever folder you're working
  in. One source of truth here; edits propagate.

## Available skills

| Skill        | What it does                                                        |
| ------------ | ------------------------------------------------------------------- |
| `ta-ship`    | Ship a change the open-source way: test → CHANGELOG → DCO commit → PR |
| `ta-define`  | Socratic definition of a feature/agent (problem, users, criteria)    |
| `ta-skill`   | Guide + template to author your own skill                            |

## Add your own

Mentees are encouraged to write skills. Two paths:

- **Experiment** → put it in `TA-lab/skills/<name>/SKILL.md` (your sandbox).
- **Make it official** → copy `ta-skill/TEMPLATE.md`, write it under
  `TA-workspace/skills/<name>/`, and open a PR. Once merged, the setup script
  links it everywhere.

Keep skills short, transparent, and free of secrets/telemetry.
