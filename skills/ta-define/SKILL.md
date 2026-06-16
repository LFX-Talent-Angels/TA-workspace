---
name: ta-define
description: Socratically define a feature, agent, or task for Talent Angels before building — problem, users, success criteria, constraints, alternatives, smallest first step. Use when scope is fuzzy, when starting a new agent/feature, or when the user says "help me define / scope this".
---

# /ta-define

Turn a fuzzy idea into a clear, written definition **before** code is written.
Ask one question at a time, listen, and push for specifics. This is for scoping
an **open-source project deliverable** (a feature, one of the agents, a sprint
task) — it is **not** a startup/business exercise. No pitch decks, no fundraising,
no "go to market". Keep it about the software and its users.

## How to run it

Work through the prompts below conversationally. Ask, wait for the answer, then
go deeper or move on. Don't dump all questions at once. If the user already
answered something (e.g. it's in the proposal or an ADR), don't re-ask — reflect
it back instead.

1. **Problem.** What problem does this solve, in one sentence? Why does it matter
   now for Talent Angels?
2. **Users.** Who uses this — a learner, an educator, an employer, another agent?
   What do they do today without it?
3. **Success criteria.** How will we know it works? Name something observable
   (e.g. "Locator returns the correct ESCO node for 8/10 test queries").
4. **Scope & constraints.** What's explicitly in scope? What's out? Constraints
   on data (taxonomy licenses), tools (graph store, LLM), time (which sprint)?
5. **Alternatives.** What are 2–3 ways to do this? What are the tradeoffs? Is
   there an existing library/standard we should use instead of building?
6. **Smallest first step.** What's the smallest version that proves the idea —
   ideally something that fits in `TA-lab` or one PR?

## Output

Write a short **definition note** (half a page, not a novel) capturing the
answers. Offer to save it where it belongs:
- A new agent/feature spec → the relevant subrepo, or `TA-memory/decisions/` if
  it's a real architectural choice (then it's an ADR).
- A sprint task → link it in `ROADMAP.md` / an issue.

End by restating the **problem, success criteria, and first step** in three
bullets so the user can sanity-check before building.

## Non-Claude agents

This is a conversation pattern, not a runtime. Ask the same questions, write the
same note. Don't skip straight to code — the point is to define first.
