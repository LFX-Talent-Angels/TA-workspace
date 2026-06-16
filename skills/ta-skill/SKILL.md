---
name: ta-skill
description: Guide and template for authoring a new Talent Angels skill. Use when a mentee wants to create their own workflow skill or asks "how do I add a skill?".
---

# /ta-skill — author a new skill

Skills are how we capture a repeatable workflow so any contributor (and any
coding agent) does it the same way. They're just markdown. This skill helps you
write a good one.

## What makes a good skill

- **One job.** A skill does one workflow well (ship, define, review a PR…).
- **Concrete steps.** Numbered, in order, with the real commands for this repo.
  Don't invent commands — detect what the repo actually uses.
- **Transparent & safe.** No secrets, no telemetry, no phone-home. A reader can
  see exactly what it does.
- **Agent-agnostic.** Write it so a non-Claude agent can follow it as workflow
  intent, not just Claude Code.
- **Short.** If it's longer than ~1 screen, it's probably doing too much.

## How to create one

1. Copy [`TEMPLATE.md`](./TEMPLATE.md).
2. Decide where it lives:
   - **Experiment / personal** → `TA-lab/skills/<your-skill>/SKILL.md`.
   - **Official project skill** → `TA-workspace/skills/<your-skill>/SKILL.md`,
     then open a PR. Once merged, `bin/setup-workspace.sh` links it into every
     repo.
3. Fill in the frontmatter `name` and `description` (the description is how an
   agent decides when to use it — be specific about the trigger).
4. Write the steps. Test it by actually running through it once.
5. `git commit -s` (DCO), open a PR, request a mentor review.

## Frontmatter format

```yaml
---
name: ta-yourskill          # kebab-case; matches the folder
description: One sentence on what it does AND when to use it (the trigger).
---
```

After the frontmatter, write the workflow as markdown: a short intro, then
numbered steps, then any rules and a note for non-Claude agents.
