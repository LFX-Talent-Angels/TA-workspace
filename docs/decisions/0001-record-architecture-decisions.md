# ADR-0001: Record architecture decisions

- **Status:** Accepted
- **Date:** 2026-06-15
- **Deciders:** Mentors
- **Mirrors:** `TA-memory/decisions/0001-...`

## Context

Talent Angels is built by a rotating set of mentees over a 26-week program.
Decisions about the graph store, LLM, taxonomies, and orchestration will be made
incrementally and need to be discoverable later — by future mentees and by AI
coding agents reading the repo.

## Decision

We record significant, cross-cutting decisions as **Architecture Decision
Records (ADRs)** in `docs/decisions/`, using `0000-adr-template.md`. Accepted
ADRs are **mirrored to `TA-memory/decisions/`** so the project memory holds the
full, permanent record.

Lightweight, reversible choices do not need an ADR — a PR description is enough.

## Alternatives considered

- **No formal record** — faster, but decisions get lost between mentee cohorts.
- **A single design doc** — harder to track *why* and *when* things changed.

## Consequences

- New significant decisions get a numbered ADR.
- The `Mirrors:` field links the workspace ADR to its `TA-memory` copy.
- AI agents are instructed (in `CLAUDE.md` / `AGENTS.md`) to consult ADRs.
