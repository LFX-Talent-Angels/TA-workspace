# Sprint 3 — Suites & the walking-skeleton assistant

> Sprint 2 defined the architecture and stack (ADR-0003/0004/0005). Sprint 3
> makes it real: each mentee's Sprint 1 graph becomes a **suite** in
> `TA-taxonomies`, and a first end-to-end assistant runs in `TA-agents`.
> Written brief — unlike Sprint 2, the assignment lives in the repo, not in
> slides.

## Goal

By end of sprint: a user can ask one natural-language question and get one
grounded answer, end to end, through at least **two suites**.

## The work

### 1. Suites (`TA-taxonomies`) — one per mentee, owned by its Sprint 1 author

Port your Sprint 1 slice into a suite package implementing the contract from
`TA-workspace/docs/architecture/SYSTEM.md`:

- `search_nodes` — exact + alias/label match first; vector fallback can stub.
- `get_neighbors` — over the relationship types your suite marks traversable.
- `enumerate_paths` — depth-capped, cycle-free; can be minimal.
- `score_paths` — may raise `NotImplemented` this sprint (Evaluate lands later).

Requirements carried from the team's Sprint 1 findings:

- Suite-scoped IDs (`esco:…`, `onet:…`); `source` + `source_id` on every node.
- **Pointer, not payload** — no licensed source prose in the repo or graph.
- A loader that rebuilds your graph from source + a small committed fixture
  (subset) for tests. Ingestion must be reproducible: `python -m <suite>.load`.
- Tests against the fixture: every contract tool returns typed results.

### 2. Assistant walking skeleton (`TA-agents`) — pair/mob work, mentor-guided

- LangGraph loop: intent → plan (L / L+C) → tool calls → merged answer.
- Locate + Connect skills wired to at least two suites.
- Typed `AgentResult` (`nodes`, `edges`, `evidence`, `warnings`, confidence).
- Run log: one structured record per turn (JSON lines is fine).
- Golden evals: ≥ 10 question/expected-node pairs per wired suite, runnable
  via pytest.

### 3. Measurements (start now, tiny)

- **Tokens per resolved turn** and **Locate accuracy** on the golden set —
  these are the falsifiers named in ADR-0003.

## Acceptance criteria

- [ ] Two suites pass contract tests in `TA-taxonomies` CI.
- [ ] `TA-agents` answers "where is X?" and "what's next to X?" through both,
      with citations and confidence shown.
- [ ] Golden evals runnable with one command; baseline numbers recorded in
      `TA-memory`.
- [ ] All PRs DCO-signed, branched, reviewed — no direct pushes to `main`.

## Out of scope

Pathfind beyond a stub · Evaluate/scoring policies · frontend · the fifth
taxonomy slot (pending data-sources ADR) · cross-taxonomy crosswalk edges.

## Team dynamic

Same as Sprint 2: coordinate on Slack, present jointly. Reviews happen on PRs —
small, focused, one logical change each.
