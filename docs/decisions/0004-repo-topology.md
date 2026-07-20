# ADR-0004: Split taxonomy suites into `TA-taxonomies`, consumed as a library

- **Status:** Accepted
- **Date:** 2026-07-19
- **Deciders:** Mentors, informed by the team's Sprint 2 suite-per-taxonomy design
- **Mirrors:** `TA-memory/decisions/0004-repo-topology.md`

## Context

Sprint 2 produced a clean seam, arrived at independently in more than one of the
team's designs: each taxonomy is a self-contained **suite** (loader + graph
schema + tools) behind a common contract, and the agent runtime is
suite-agnostic. Meanwhile `TA-agents` was still scaffolded to hold everything —
agents, graph, and taxonomy loaders in one package.

Forces:

- **Ownership and cadence.** Each mentee owns one suite; suite work (parsers,
  ingestion, schema fixes) churns on a different rhythm than the assistant
  core. The agentic core shouldn't rebuild its mental model every time a
  loader changes.
- **A frontend is coming** and is clearly a separate repo (different language,
  cadence, contributors).
- **Repo weight is *not* a force**, counter to intuition: per the team's
  licensing findings (SFIA, Lightcast), graphs store pointers, not payloads —
  the heavy artifact is the Neo4j instance (infrastructure), not the repo.
- **The inter-layer contract (ingestion + suite tools) is the least-designed
  part** of the Sprint 2 proposals. Making an undesigned contract a *network*
  boundary is the classic premature-microservice error.
- Process reality: three Sprint 2 PRs sat unreviewed for 1–2 weeks in a single
  repo; synchronized cross-repo PRs would be slower still.

## Decision

1. Create **`TA-taxonomies`**: per-suite ingestion pipelines, graph schemas,
   crosswalks, and the implementation of the suite contract
   (`search_nodes`, `get_neighbors`, `enumerate_paths`, `score_paths`).
   One mentee owns each suite directory.
2. **`TA-agents`** keeps the assistant runtime: plan, skills, typed result
   contract, run log, evals, FastAPI edge. Its `taxonomies/` and `graph/`
   scaffold packages move to `TA-taxonomies`.
3. **Coupling is a versioned Python library**, not HTTP: `TA-agents` depends on
   `ta-taxonomies` as a package. The suite contract (documented in
   `SYSTEM.md`) is the only surface `TA-agents` may import.
4. **`TA-web`** is created later, when frontend work actually starts.
5. **Revisit at end of Sprint 4:** if the suite contract has stabilized and an
   operational need exists (independent scaling/deploy), promoting
   `TA-taxonomies` to a service is a cheap, contained decision.

## Alternatives considered

- **One repo, two internal packages** (`taxonomies/` + `agents/` with
  CODEOWNERS). Least PR friction; but couples the product repo's history and
  releases to loader churn, and the boundary tends to erode without a repo
  wall. Kept as the fallback if cross-repo friction proves too high.
- **Two repos coupled over HTTP from day one.** Maximum separation, but
  freezes the least-designed contract as a network API and adds deploy/infra
  burden mid-mentorship.

## Consequences

- The workspace gains a subrepo: inventory, setup script, and onboarding docs
  updated; `.gitignore` excludes `TA-taxonomies/`.
- The suite contract must be written down **before** code is split — it now
  lives in `SYSTEM.md` and is versioned with `ta-taxonomies` releases.
- Mentee work divides naturally: suites in `TA-taxonomies`, assistant/skills in
  `TA-agents`, both PR-reviewable independently.
- Cross-repo changes (contract changes) require touching two repos — accepted
  cost; contract changes should be rare and ADR-worthy anyway.
