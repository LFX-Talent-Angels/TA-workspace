# ADR-0002: Agent-driven development + outcome-based roadmap

- **Status:** Accepted
- **Date:** 2026-06-15
- **Deciders:** Mentors (roadmap proposed by PM Noemí Muñiz)
- **Mirrors:** `TA-memory/decisions/0002-agent-driven-outcome-based.md`

## Context

The original proposal laid out a sequential, week-by-week waterfall of 9
deliverables across 26 weeks. Since then, AI-assisted coding has matured into
**agent-driven** development: coding agents (Claude Code, Codex, Cursor,
Antigravity, …) do the bulk of implementation under human direction and review.

This changes where time goes. Writing code is no longer the bottleneck; **setup,
stack/framework definition, and clear specs for the agents** are. Committing the
full 26-week waterfall up front is both unnecessary and brittle.

## Decision

1. **Development model is agent-driven.** Mentees drive coding agents as their
   primary workflow and remain accountable for what they submit (review + test +
   DCO sign-off). This is documented in `CLAUDE.md`, `README.md`, and the
   onboarding docs as the project's explicit approach (an upgrade from
   "AI-augmented").

2. **Roadmap is outcome-based (NOW / NEXT / LATER).** Only the next 1–2 sprints
   are committed; the rest is provisional and refined each sprint. The agent
   milestones (Locator → Connector → Pathfinder → Evaluator) are the fixed north
   star. Source: PM Noemí Muñiz's roadmap presentation
   (archived in `TA-memory/roadmap/2026-outcome-based-roadmap.md`).

3. **Early sprints prioritize foundations and stack definition.** Sprint 1 =
   research + build a graph of a taxonomy (familiarization, theory + practice,
   and lets mentors see how each mentee works — done in `TA-lab`). Sprint 2 =
   choose LLM + tools + memory (the stack/framework definition that accelerates
   everything after).

## Alternatives considered

- **Keep the 9-deliverable waterfall.** Predictable on paper, but slow to adapt
  and mismatched to how agent-driven teams actually work.
- **No formal roadmap.** Too loose for a 26-week cohort with three public meetups.

## Consequences

- `TA-workspace/ROADMAP.md` becomes the living outcome-based plan; the original
  waterfall is preserved in `TA-memory/roadmap/2026-original-9-deliverable-roadmap.md`.
- The 9 original deliverables are folded in as topics, not as a fixed schedule.
- Project docs frame the work as agent-driven; skill tooling (`TA-workspace/skills/`)
  supports that workflow.
