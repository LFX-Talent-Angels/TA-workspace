# System Architecture

> Cross-repo source of truth: what the system is, where each piece lives, and
> the contract between repos. Runtime internals live in `TA-agents/ARCHITECTURE.md`;
> graph/ingestion internals live in `TA-taxonomies/ARCHITECTURE.md`. Significant
> changes go through an ADR (`docs/decisions/`) mirrored to `TA-memory/decisions/`.
>
> Supersedes the earlier three-peer-agents sketch. Decided in
> [ADR-0003](../decisions/0003-agent-plus-skills-architecture.md) (agent model),
> [ADR-0004](../decisions/0004-repo-topology.md) (repo topology), and
> [ADR-0005](../decisions/0005-sprint-2-tech-stack.md) (tech stack), based on the
> team's Sprint 1–2 research and their joint Sprint 2 architecture presentation.

## Goal

A unified reasoning layer over **skills, tasks, and occupations**: an agentic AI
with Graph-based Retrieval-Augmented Generation (**Graph-RAG**) over global
taxonomies, accessed through a natural-language chat interface.

## The shape of the system: one assistant, kinds of map work

The system is **one main assistant** that owns the user's goal, plus specialized
**map-work capabilities** it dispatches. The capabilities are implemented as
**skills + tools** — not as peer agents that answer the user on their own.

| Capability | Leaf | Job | Public name |
| ---------- | ---- | --- | ----------- |
| Locate | **Resolve** | Free text → precise map point(s) + confidence | Locator |
| Connect | **Reveal** | Neighbors, hierarchy, gaps around a point | Connector |
| Pathfind | **Compose** | Routes between two points under stated rules | Pathfinder |
| Evaluate | **Rank** | Score/rank routes by declared, documented policy | Evaluator |

- The **main assistant** interprets intent, builds the plan (L / L+C / L+C+P /
  … +E), calls the capabilities, merges results across taxonomies, and writes
  the one coherent answer. It is the only piece that talks to the user.
- Each capability runs **inline (skill + tool calls) by default**; it is spun
  into a scoped subagent only when context isolation demonstrably pays.
- **Evaluate** was originally deferred as a fourth *agent*. As a *skill* over
  already-weighted graph data it is small enough to advance early — see
  ADR-0003 and the roadmap.

Why this shape (evidence from the team's Sprint 1–2 research):

1. **Resolution is a hard prerequisite, not a routing branch.** Stable IDs are
   machine keys; people use job titles. Locate runs before nearly every Connect
   or Pathfind, so the real artifact is a *plan*, not a route-to-one-agent.
2. **Connect and Pathfind are mostly deterministic graph queries.** Listing
   neighbors is a Cypher query; enumerating routes with depth caps is an
   algorithm. They don't need their own reasoning loops — the reasoning
   (intent, ambiguity, merging, honesty) belongs to one context.
3. **Confidence and provenance must survive the whole chain.** Locate's
   confidence and every node's source citation cross every later step as typed
   data, which peer-agent prose handoffs lose.
4. **Cross-taxonomy merging needs a single owner** that can say "these two
   nodes are not the same thing" — no invented identity between taxonomies.

## Suites: one graph package per taxonomy

Each taxonomy is a self-contained **suite**: loader + graph schema + tools for
one source. Capabilities are suite-agnostic and take `suite` as a parameter; the
assistant picks which suites a plan runs against (no fan-out to all by default).

### The suite contract

Every suite exposes the same tool surface (typed I/O, Pydantic):

| Tool | Does |
| ---- | ---- |
| `search_nodes(text, kind?) → candidates + confidence` | resolution (exact, alias/label, then vector fallback) |
| `get_neighbors(node_id, rel_types?) → nodes + edges` | single-hop traversal over relationship types the suite marks traversable |
| `enumerate_paths(from_id, to_id, limits) → paths` | multi-hop route enumeration (depth-capped, cycle-free) |
| `score_paths(paths, policy) → ranked paths` | scoring under an explicit, named policy |

Contract rules (these do not bend):

- **Node IDs are suite-scoped** (`esco:…`, `onet:…`) — never compared across
  suites except through explicit crosswalk edges.
- Every node carries **`source` + `source_id`** and a provenance pointer.
- **Pointer, not payload:** graphs store identifiers and our own metadata;
  licensed source text is fetched at runtime, never committed or re-served.
- Only graph data is cited as taxonomy fact; model inference is labeled.
- Results are typed (`nodes`, `edges`, `evidence`, `warnings`, confidence) —
  never free prose between components.

## Repo topology (where does this go?)

| Repo | Owns | Notes |
| ---- | ---- | ----- |
| **`TA-agents`** | The assistant runtime: plan, skills (Locate/Connect/Pathfind/Evaluate), typed result contract, run log, evals, FastAPI edge | Main product repo |
| **`TA-taxonomies`** | The suites: per-taxonomy ingestion pipelines, graph schemas, crosswalks, and the suite-contract implementation | One mentee owns each suite |
| **`TA-workspace`** | This meta-repo: cross-repo docs, ADRs, onboarding | You are here |
| **`TA-lab`** | Exercises, spikes, per-mentee scratch | Sprint work starts here |
| **`TA-resources`** / **`TA-memory`** | Educational resources / project memory | Content repos |
| *`TA-web` (future)* | Chat frontend | Created when frontend work starts |

**Coupling rule:** `TA-agents` consumes `TA-taxonomies` as a **versioned Python
library**, not over the network. The suite contract is the boundary. Promotion
of `TA-taxonomies` to a standalone service is a later, cheap decision *if* the
contract has stabilized (revisit end of Sprint 4 — see ADR-0004).

```
        user ── chat ──▶ TA-web (future)
                            │
                            ▼  HTTP (FastAPI edge)
                     ┌─────────────────┐
                     │    TA-agents     │  main assistant + skills + evals
                     └────────┬────────┘
                              │  suite contract (Python library)
                     ┌────────▼────────┐
                     │  TA-taxonomies   │  suites: ingestion + schema + tools
                     └────────┬────────┘
                              ▼
                    Neo4j (one graph per suite) + vector index
                              ▲
            ESCO · O*NET · SFIA · BLS · (5th slot under review)
```

## Tech stack

Ratified from the team's Sprint 2 proposal — see
[ADR-0005](../decisions/0005-sprint-2-tech-stack.md).

| Layer | Choice |
| ----- | ------ |
| Language | Python 3.11+ (Pydantic v2 for typed I/O) |
| Graph store | Neo4j (+ Cypher) |
| Orchestration | LangGraph (stateful single-owner loop) |
| Model | Anthropic Claude (provider via env var) |
| Vector index | pgvector *(provisional — revisit vs. Neo4j native index, ADR-0005)* |
| API edge | FastAPI (thin; reasoning stays in the agent loop) |
| Ingestion | Per-suite Python pipelines in `TA-taxonomies` |

## Taxonomies in scope

ESCO · O*NET · SFIA · BLS. The **fifth slot** (originally Lightcast) is under
licensing/cost review — resolved by the pending data-sources ADR. Each suite
covers a different gap (economic signal, competency levels, weighted skill
edges, multilingual scale); the assistant's plan picks suites per question.

## Two dynamic functions (from the proposal)

- A **skill function** — the minimum skills needed for each task.
- A **task function** — the opportunities unlocked by each skill set.

## Open questions (decide via ADR)

- Vector index: pgvector vs. Neo4j native (benchmark during Sprint 3–4).
- Fifth taxonomy slot (data-sources ADR).
- Cross-taxonomy crosswalk design (SOC/ISCO hub; SFIA bridges skill-to-skill).
- Run-log / session persistence technology.
- When (if ever) `TA-taxonomies` becomes a service — revisit end of Sprint 4.
