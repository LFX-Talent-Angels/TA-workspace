# Setting up your AI coding agent

Talent Angels is **AI-augmented by design**. You're expected to use a coding
agent as part of your daily workflow. You can use **any** agent — the project is
agent-agnostic.

## How agent-agnostic works here

Every repo carries two files at its root:

- **`CLAUDE.md`** — the authoritative project rules (read by Claude Code and by
  humans).
- **`AGENTS.md`** — the same rules, routed for non-Claude agents.

Most modern coding agents automatically read one or both of these. So whichever
agent you pick, point it at the repo and it will follow the same conventions:
branch + PR flow, DCO sign-off, no secrets, no `Mentees/` data, and record
learnings in `TA-memory`.

## Supported agents (use whichever you like)

| Agent             | Reads automatically        | Notes                                              |
| ----------------- | -------------------------- | -------------------------------------------------- |
| **Claude Code**   | `CLAUDE.md`                | Optional `gstack` skills (`/review`, `/ship`, …)   |
| **OpenAI Codex**  | `AGENTS.md`                | Treats `CLAUDE.md` slash-commands as workflow intent |
| **Cursor**        | `AGENTS.md` / rules files  | Add repo rules pointing to `CLAUDE.md`             |
| **Antigravity**   | `AGENTS.md`                | Same routing as Codex                              |
| **Gemini / Aider**| `AGENTS.md`                | Point it at the repo root first                    |

## Ground rules for any agent

1. **Read first.** Have the agent read `CLAUDE.md` + `AGENTS.md` before acting.
2. **You are accountable.** Review and test everything the agent produces. Sign
   off the commit yourself (`git commit -s`).
3. **No secrets in prompts.** Never paste API keys, `.env` contents, or anything
   from `Mentees/` into an agent.
4. **Small, reviewable changes.** Don't let an agent open giant, unfocused PRs.
5. **Capture learnings.** When the agent (or you) discover something non-obvious,
   write it down in `TA-memory/learnings/`.

## gstack (optional)

If you use Claude Code with gstack, workflow skills like `/review`, `/qa`,
`/ship`, `/browse`, and `/investigate` are available. gstack is **optional** —
nothing in the project requires it. Agents without gstack should perform the
equivalent steps manually.
