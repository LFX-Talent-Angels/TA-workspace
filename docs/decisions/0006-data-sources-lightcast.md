# ADR-0006: Taxonomy data sources — drop Lightcast; fifth slot open

- **Status:** Proposed — Lightcast verdict is evidence-based (see TA-lab #13);
  fifth-slot choice to be confirmed with the team at the next sync
- **Date:** 2026-07-19
- **Deciders:** Mentors, based on the Sprint 1 licensing/access research
- **Mirrors:** `TA-memory/decisions/0006-data-sources-lightcast.md`

## Context

The original proposal names five taxonomies: ESCO, O*NET, SFIA, BLS, and
Lightcast. Sprint 1 explored all five hands-on (one graph slice each). The
Lightcast slice (TA-lab PR #13, merged) turned into documented evidence that
Lightcast cannot be a dependency for this project. Sprint 1 also established
the project-wide licensing rule — **store the pointer, fetch the payload at
runtime** — after SFIA's terms surfaced the same class of problem.

## Decision

1. **Lightcast is dropped** as a taxonomy suite. Three independent reasons,
   any one sufficient:
   - **Price.** Programmatic data access runs ~$41–50k/yr per signed public
     contracts (US ITC $124k/3yr; CareerSource Florida $50k/yr). The published
     $5–12k rate card is the GUI product, not data access.
   - **License (the hard blocker).** The Open Terms exclude commercial use,
     and §2.3 requires a written contract for *"artificial intelligence
     purposes"* — naming our exact use case. Our repos are Apache-2.0, which
     would grant readers rights we do not hold. The 2025 revision also removed
     the former "no-cost contract" path.
   - **Reliability.** The free API tier ended 2026-02-13 with three days'
     notice; §5 allows cancellation at any time, for any reason. A core agent
     cannot depend on that.
   The nonprofit route (LFDT may qualify) is worth *asking* about, but with no
   published criteria or precedent it is not a plan.

2. **Lightcast's capabilities are replaced from open sources** (verified
   against primary sources in TA-lab PR #13):

   | Lightcast capability | Open substitute | Verdict |
   | --- | --- | --- |
   | Job-title normalization (~75k titles) | O*NET Job Titles (57,543, CC BY 4.0) + ESCO altLabels (28 languages) + JobBERT-v3 (MIT) | Covered, arguably better |
   | Skill significance weights | O*NET Essential + Transferable Skills — 62,580 weighted edges with sample sizes and CIs, native RDF | Covered, more rigorous |
   | Monthly freshness from live postings | Sweden JobTech (~6.9M ads, CC0, live API, ESCO-linked) | Covered at one country's scale |

3. **The fifth suite slot stays open.** Candidates: **Sweden JobTech**
   (freshness, CC0, ESCO-linked) vs. the **UK Standard Skills Classification**.
   To be decided with the team; until then the suite set is ESCO · O*NET ·
   SFIA · BLS.

## Alternatives considered

- **Keep Lightcast and seek the nonprofit/written contract.** Blocked on an
  unpublished process with no precedent; even if granted, §5 termination risk
  remains. Ask in parallel; do not build on it.
- **Keep Lightcast in docs as "aspirational".** Rejected — planning around a
  source we cannot legally use misleads every downstream decision.

## Consequences

- Docs and scaffolding say "fifth slot under review" instead of Lightcast;
  `TA-taxonomies` ships four suites until the slot is decided.
- The title-normalization layer — Lightcast's best idea — is replicated from
  open sources inside each suite's alias index (`search_nodes`).
- One deferred item this ADR should be amended with: the fifth-slot choice,
  after team discussion (candidates above).
- Related finding recorded for the Evaluator: ESCO is structurally binary
  (two predicates, no weight field) — any weighting there is our declared
  modeling policy, never source data (see ADR-0003).
