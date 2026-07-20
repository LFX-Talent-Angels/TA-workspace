# System Architecture (high level)

> This is a **skeleton** to be filled in by the team as decisions are made.
> Larger changes should go through an ADR (`docs/decisions/`) and be mirrored to
> `TA-memory/decisions/`.

## Goal

A unified reasoning layer about **skills, tasks, and occupations**: an Agentic AI
with **Graph-based Retrieval-Augmented Generation (Graph-RAG)** over global
taxonomies, accessed through a natural-language chat interface.

## The three agents

```
                 ┌─────────────────────────────────────────┐
   user query →  │            Chat / Orchestration          │
                 └───────────────┬─────────────────────────┘
                                 │
        ┌────────────────────────┼────────────────────────┐
        ▼                        ▼                         ▼
   ┌─────────┐             ┌───────────┐             ┌────────────┐
   │ Locator │             │ Connector │             │ Pathfinder │
   └────┬────┘             └─────┬─────┘             └─────┬──────┘
        │   pinpoint a node      │  neighbors of a node    │  routes A→B
        └────────────────────────┼─────────────────────────┘
                                 ▼
                     ┌───────────────────────┐
                     │   Knowledge Graph      │  (Graph-RAG retrieval)
                     │   + vector index       │
                     └───────────┬───────────┘
                                 ▼
        O*NET · BLS · ESCO · SFIA* · Sweden JobTech (sources)
                  * structure only — see TAXONOMIES.md
```

- **Locator** — identifies and pinpoints the exact position of a skill, task, or
  occupation within the taxonomies.
- **Connector** — lists the nodes directly preceding and succeeding a location
  (related tasks/skills).
- **Pathfinder** — traces and maps all routes connecting two locations through
  combinations of Connector paths (learning journeys).
- **Evaluator** *(future)* — assesses and ranks paths by relevance, distance, and
  alignment with an individual's skill profile.

## Layers (where does this go?)

| Layer            | Responsibility                                                    | Lives in (`TA-agents/src/talent_angels/`) |
| ---------------- | ----------------------------------------------------------------- | ------------------------------------------ |
| **Taxonomies**   | Load & normalize O*NET, BLS, ESCO, SFIA (structure only) and Sweden JobTech into the graph — see [`TAXONOMIES.md`](./TAXONOMIES.md) | `taxonomies/`                              |
| **Graph**        | Knowledge-graph model, ingestion, queries, Graph-RAG retrieval    | `graph/`                                   |
| **Locator**      | Pinpoint a node from natural language                             | `locator/`                                 |
| **Connector**    | Neighbors of a node                                               | `connector/`                               |
| **Pathfinder**   | Routes between two nodes                                          | `pathfinder/`                              |
| **Orchestration**| Route a query to the right agent(s); chat interface              | *(to be designed — see Roadmap #7, #8)*    |

## Two dynamic functions (from the proposal)

- A **skill function** — the minimum skills needed for each task.
- A **task function** — the opportunities unlocked by each skill set.

## Open questions (decide via ADR)

- Graph store: Neo4j vs. alternatives. *(All Sprint 1 slices used Neo4j; O\*NET
  and ESCO both ship native RDF — both are inputs to this decision.)*
- Vector store / backend: Supabase pgvector vs. alternatives.
- LLM provider(s) and framework (LangChain / LangGraph / custom).
- ~~How taxonomies are licensed, fetched, and refreshed.~~ → resolved by
  [ADR-0003](../decisions/0003-taxonomy-data-sources.md); the resulting model is
  in [`TAXONOMIES.md`](./TAXONOMIES.md).

Track these in `docs/decisions/` as they are resolved.
