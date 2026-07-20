# ADR-0003: One main assistant + capabilities as skills (not peer agents)

- **Status:** Accepted
- **Date:** 2026-07-19
- **Deciders:** Mentee team (joint Sprint 2 architecture) + mentors
- **Mirrors:** `TA-memory/decisions/0003-agent-plus-skills-architecture.md`

## Context

The project's north star names four agents: Locator, Connector, Pathfinder, and
a future Evaluator. The original `SYSTEM.md` sketch drew them as three peer
agents behind an orchestration layer. In Sprint 2 the team designed the agent
architecture and presented it jointly: **one main assistant** that owns the
user's goal, with Locate (Resolve), Connect (Reveal), and Pathfind (Compose) as
kinds of map work the assistant dispatches — implemented as skills + tools, with
subagents only where context isolation pays.

The team's Sprint 1–2 taxonomy research is what forces the choice:

- **Resolution is a hard prerequisite.** Stable identifiers are machine keys;
  people use job titles (57k+ O*NET titles, ESCO altLabels in 28 languages).
  Locate precedes nearly every other step, so "route the query to one of three
  agents" models a choice that rarely exists; what's needed is a *plan*
  (L / L+C / L+C+P).
- **Connect and Pathfind are mostly deterministic.** Neighbor listing is a
  Cypher query; route enumeration is an algorithm with depth caps. Wrapping
  each in its own LLM loop adds model round-trips without adding reasoning.
- **Confidence and provenance must cross the whole chain** as typed data.
  Peer-agent handoffs in prose lose both; a single owner with typed results
  (`nodes`, `edges`, `evidence`, `warnings`, confidence) preserves them.
- **Cross-taxonomy merging needs one accountable owner** — no silent identity
  between suites; disagreements between taxonomies are surfaced, not averaged.

Token economics point the same way: delegation pays only when a component
generates many intermediate tokens and returns few (high compression). Locate
and Connect have compression ≈ 1 — inlining them is both cheaper and better. A
single assistant also keeps one large stable prompt prefix (system + tool
schemas), maximizing prompt-cache hits, versus fragmenting the cacheable prefix
across four agents.

## Decision

1. **One main assistant owns the goal.** It interprets intent, builds the plan,
   dispatches capabilities, merges across suites, and writes the final answer.
2. **Locate, Connect, Pathfind are skills + tools**, suite-agnostic, invoked
   per the plan. Inline by default; a scoped subagent only when measured
   context pollution justifies it (Pathfind on large graphs is the candidate).
3. **Evaluate (Rank) is advanced from "future agent" to "candidate skill".**
   What made Evaluator big was agent scaffolding; scoring itself is largely
   deterministic. O*NET already provides 62k+ weighted skill edges to score
   against; where a source is unweighted (ESCO is structurally binary — two
   predicates, no weight field), weights are **our modeling policy, declared
   and documented, never presented as source data**. `score_paths(paths,
   policy)` enters the suite contract now so Evaluate can land as a skill.
4. **Determinism is pushed down.** Traversal, cycle avoidance, depth caps,
   top-K cuts, and scoring live in tools/code. The model decides *what to ask*
   and *how to answer* — not how to walk the graph.

## Alternatives considered

- **Three peer agents + thin orchestrator/router.** Matches the original
  sketch. Rejected: models routing instead of planning, duplicates context,
  loses typed confidence/provenance at each handoff, fragments the prompt
  cache, and gives cross-taxonomy merging no owner.
- **Orchestrator as a fourth full agent.** Same costs as above with an extra
  hop; the "router" question (locate vs. relate vs. path) is a plan the main
  assistant already makes.
- **Everything inline forever (no subagents at all).** Simplest, but large
  Pathfind explorations could genuinely pollute context. We keep the subagent
  escape hatch behind a measurement, not a default.

## Consequences

- `TA-agents` is structured around one assistant + `skills/` — not four agent
  packages. Public naming (Locator/Connector/Pathfinder/Evaluator) is kept for
  continuity with the proposal; they name capabilities, not processes.
- The falsifier is explicit and measured from Sprint 3: **tokens per resolved
  turn** and **Locate accuracy**, comparing inline vs. subagent variants. If a
  single context measurably fails, that capability graduates to a subagent —
  this ADR does not need to be reversed for that.
- Agent-count and path-length are explicitly **not** success metrics.
- The Evaluator milestone in the roadmap can be pulled earlier as a skill;
  scoring policies must be named, versioned, and cited in answers.
