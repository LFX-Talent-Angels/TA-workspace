# ADR-0005: Sprint 2 tech stack

- **Status:** Proposed — pending team confirmation at the next sync
- **Date:** 2026-07-19
- **Deciders:** Mentee team (joint Sprint 2 proposal + presentation) + mentors
- **Mirrors:** `TA-memory/decisions/0005-sprint-2-tech-stack.md`

## Context

Sprint 2's goal was the stack/framework definition. The team researched and
presented a joint proposal; Sprint 1 had already validated part of it in
practice — every mentee independently built their taxonomy slice on the same
graph store, which is the strongest kind of validation available.

## Decision

Adopt the team's presented stack:

| Layer | Choice | Rationale |
| ----- | ------ | --------- |
| Language | **Python 3.11+** | One language across orchestration, validation, graph access, ingestion. Pydantic v2 for typed I/O. |
| Graph store | **Neo4j + Cypher** | Validated hands-on by all four Sprint 1 slices; skills/tasks/occupations are property-graph shaped; strongest LLM/GraphRAG tooling. Switching later would discard working Cypher and schemas. |
| Orchestration | **LangGraph** | Built for stateful single-owner loops with explicit state and conditional branching — a direct match for the plan pattern (L / L+C / L+C+P) of ADR-0003. |
| Model | **Anthropic Claude** | Strong structured tool use and Text-to-Cypher performance; provider set via env var so substitution needs no agent-code change. |
| Vector index | **pgvector** *(provisional)* | Semantic fallback for Locate only — never a source of taxonomy facts. |
| API edge | **FastAPI** | Async-native, Pydantic-integrated, thin: all reasoning stays inside the agent loop. |
| Ingestion | **Per-suite Python pipelines** (`TA-taxonomies`) | Each taxonomy publishes a different access method (files, APIs, SPARQL); normalization to the shared vocabulary happens per suite. |
| Config/secrets | **env vars / `python-dotenv`** | `.env` local and gitignored; only `.env.example` committed. |

## Alternatives considered

- **Graph store alternatives** (Neptune, ArangoDB, RDF triple stores): not
  evaluated hands-on; Sprint 1's unanimous, independent Neo4j convergence and
  the working Cypher investment decide this. Revisit only if Neo4j licensing
  or Aura limits bite.
- **LangChain plain / custom loop** instead of LangGraph: would re-implement
  state, branching, and checkpointing that LangGraph provides natively.
- **Vector index inside Neo4j (native) or a dedicated store (Chroma,
  Pinecone):** genuinely open. pgvector is adopted *provisionally*; the
  Locate-fallback workload is small enough to benchmark both. **Follow-up:**
  benchmark pgvector vs. Neo4j native index during Sprint 3–4 and confirm or
  amend this row. A dedicated vector DB is rejected for now (fourth piece of
  infra for a fallback path).

## Consequences

- `TA-agents` and `TA-taxonomies` pin these choices in `pyproject.toml`;
  `.env.example` documents required keys (Anthropic, Neo4j, vector index).
- Embedding model choice (for the Locate fallback) is decided alongside the
  vector-index benchmark, not here.
- The stack is stable enough to build Sprint 3 on; the one provisional row
  (vector index) is isolated behind the suite contract, so amending it later
  does not ripple.
