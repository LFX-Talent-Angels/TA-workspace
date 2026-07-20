# Roadmap

This is the **living, outcome-based** plan for Talent Angels. Only the next 1–2
sprints are **committed**; everything after is a provisional direction we refine
each sprint. The agent milestones (Locator → Connector → Pathfinder → Evaluator)
are the fixed **north star**.

> **Why outcome-based?** We develop **agent-driven** (see
> [`docs/decisions/0002-agent-driven-outcome-based.md`](./docs/decisions/0002-agent-driven-outcome-based.md)).
> Agent-driven work is fast, so the highest-value early effort is **foundations
> and stack/framework definition**, not a fixed 26-week waterfall.
>
> History: the original 9-deliverable waterfall is archived at
> `TA-memory/roadmap/2026-original-9-deliverable-roadmap.md`; this plan is sourced
> from the PM's roadmap at `TA-memory/roadmap/2026-outcome-based-roadmap.md`.

## Program goal (2026 · 26 weeks)

Ship a working GraphRAG agent suite — Locator, Connector, Pathfinder — validated
in live university courses (UCA El Salvador, Mérida MX), feeding the Learning
Tokens Proof-of-Learning (PoL) layer by Week 26.

## NOW · COMMITTED · Sprints 1–3 · Weeks 1–6

### Sprint 1 · Wk 1–2 — Foundations
Understand knowledge graphs + define purpose & scope. Detailed brief (goal,
dynamic, taxonomy basics, learning resources, KG build example):
[`docs/sprints/sprint-01-knowledge-graphs.md`](./docs/sprints/sprint-01-knowledge-graphs.md).
- Research KGs and **build a small graph of one taxonomy** (the exercise lives in
  [`TA-lab/exercises/sprint-01-taxonomy-graph/`](../TA-lab/exercises/sprint-01-taxonomy-graph)).
  This doubles as **familiarization** (theory + hands-on with graphs) and lets
  mentors see how each mentee works.
- Document use case, user needs, success criteria, constraints.

### Sprint 2 · Wk 3–4 — Stack & agent infrastructure
Choose LLM + Tools & Integration + Memory System — **the stack/framework
definition that accelerates everything after.**
- Base model selected (params, context, cost/latency); taxonomy APIs wired;
  vector + structured memory operational.
- Decisions captured as ADRs in [`docs/decisions/`](./docs/decisions).

*Outcome (delivered): the team's joint architecture — one main assistant +
Locate/Connect/Pathfind as skills — and the stack, ratified as
[ADR-0003](./docs/decisions/0003-agent-plus-skills-architecture.md),
[ADR-0004](./docs/decisions/0004-repo-topology.md), and
[ADR-0005](./docs/decisions/0005-sprint-2-tech-stack.md).*

### Sprint 3 · Wk 5–6 — Suites & the walking-skeleton assistant
Port each Sprint 1 graph into a **suite** in `TA-taxonomies` (one per mentee)
and run a first end-to-end assistant (Locate + Connect over two suites) in
`TA-agents`. Brief:
[`docs/sprints/sprint-03-suites-and-assistant.md`](./docs/sprints/sprint-03-suites-and-assistant.md).

## NEXT · EMERGING · refined sprint by sprint

- **Locator** — pinpoint any skill/task/occupation in the taxonomies via chat.
- **Connector** — list the nodes directly preceding & succeeding a location.
- **Supporting build** — system prompts, orchestration & chat interface, shaped
  around the agents as scope firms up.

*→ Locator & Connector agents live.*

## LATER · DIRECTIONAL · agent north star

- **Pathfinder** — discover learning journeys (all routes) between two nodes.
- **Evaluator** — rank paths by relevance, distance & profile fit. Advanced
  from "future" to candidate: as a *skill* over already-weighted graph data
  (`score_paths` is in the suite contract), it may land earlier than planned
  (see ADR-0003).
- **Deploy & validate** — partner-university courses + feed Learning Tokens PoL.

*→ Pathfinder, then Evaluator.*

## Taxonomies in scope

O*NET · BLS · ESCO · SFIA (structure only) · Sweden JobTech — decided in
[ADR-0006](./docs/decisions/0006-taxonomy-data-sources.md) (Lightcast dropped;
details in [`TAXONOMIES.md`](./docs/architecture/TAXONOMIES.md)).

## Meetups

Three virtual meetups present advances: end of **week 10**, **week 19**, and
**week 26**. Notes in `TA-memory/meetings/`.

## How this roadmap is maintained

The committed sprints are firm; NEXT/LATER are refined each sprint. Significant or
contested changes go through an ADR in [`docs/decisions/`](./docs/decisions) and
are mirrored to `TA-memory/decisions/`.

---

## Deliverables · Version 1

A more granular, week-by-week view of the work planned for the 26-week program.
This sits alongside the outcome-based plan above and is refined as each phase
completes.

### Week 1 — Understand the Knowledge Graph

Get a working mental model of what a Knowledge Graph is, why it matters for this
project, and how the taxonomies fit inside it. Outcome feeds directly into Sprint 1.

### Weeks 2–3 — Taxonomy Deep-Dive & Schema Design

Understand the **differences, pros, and cons** of each taxonomy in scope:
**ESCO · O*NET · BLS · Lightcast · SFIA**.

- Compare coverage, structure, licensing, and update cadence across all five.
- Design the **KG schema** — the better the pre-processing, the less effort agents
  need to reason in coalition later. (This is the same Normalization term Alejandro and Vishwajit put forward).
- Define **success criteria** and **constraints** for the agent suite.
- Choose the **tech stack** (graph DB, LLM framework, memory stores, interfaces).

*Outcome: schema decided, tech stack decided, success criteria documented in ADRs.*

### Week 4 — System Prompt Design

Design and iterate on the system prompts that govern each agent's behaviour,
persona, and tool-use boundaries.

### Days 1–2 of Week 5 — Choose LLM

Select the base model driving the agents:

- **Open-source path** — Gemma is the leading candidate.
- **Closed-source path** — Claude is the leading candidate.

Decision captured as an ADR in [`docs/decisions/`](./docs/decisions).

### Weeks 5–7 — Tools & Integration

- Push all taxonomy data into the **GraphDB** using the schema agreed above;
  handle preprocessing (missing values, deduplication).
- Design and set up the **agentic system** locally using the Tech Stack that we have chosen,
  with each agent clearly defined and wired to the graph.

*Outcome: data pipeline live, agents running locally against the populated graph.*

### Weeks 7–9 — Memory Systems

| Layer | Store | Rationale |
|---|---|---|
| **Conversation memory** | Postgres | Agent turn history |
| **User memory** | Postgres | User data — persistence required |
| **Knowledge memory** | ArangoDB | Graph-native data storage |
| **Workflow memory** | LangGraph state | No separate DB needed |
| **Semantic retrieval** | Vector DB | Embedding-based lookup |

*Outcome: all memory layers wired and tested end-to-end.*

### Weeks 9–13 — Orchestration

- **Routes / Workflows** — define how tasks flow between agents.
- **Triggers** — events that initiate or hand off work.
- **Error handling** — graceful failure, retries, and logging.
- **Agent-to-Agent (A2A)** — inter-agent communication protocol.
- **Message queues** — Kafka is the likely choice for durable async messaging.

*Outcome: full multi-agent orchestration running reliably under test load.*

### Weeks 13–15 — User Interface

- **Chat interface** (frontend) — the primary end-user touchpoint.
- **API endpoint** — for developers integrating programmatically.
- No Discord bot in scope for this version.

*Outcome: usable interface shipped and connected to the agent backend.*

### Weeks 15–20 — Testing

- **Unit tests** for every parameter and every stage of the workflow.
- Iteration and improvements driven by test results and mentor feedback.

*At least 5 weeks allocated; extend into buffer if needed.*

### Weeks 21–26 — Buffer

Reserved for scope extensions, rework from testing, stretch goals, and final
polish before the Week 26 meetup and PoL hand-off.
