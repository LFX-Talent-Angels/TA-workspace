# ADR-0003: Taxonomy data sources — which we adopt, and on what terms

- **Status:** Proposed
- **Date:** 2026-07-19
- **Deciders:** Alberto Ceballos (mentor)
- **Mirrors:** `TA-memory/decisions/0003-taxonomy-data-sources.md` (on acceptance)

## Context

Sprint 1 had each mentee build a knowledge-graph slice of one reference
taxonomy — ESCO, O\*NET, SFIA, BLS, Lightcast — to weigh the complexity of
working with five independently developed classifications. The graphs got
built. What the sprint actually surfaced was different and more consequential:
**two of the five cannot be used the way the project assumed.**

This resolves the `SYSTEM.md` open question *"How taxonomies are licensed,
fetched, and refreshed."* All findings below were verified against primary
sources on 2026-07-19; access terms move, so each carries its check date.

Three forces are in play. **Cost** — we are a volunteer mentorship project with
no data budget. **Licence** — our repos are Apache-2.0 and public, so anything
we bundle must be redistributable under terms at least as permissive as what we
grant readers. **Durability** — a taxonomy that can revoke access on short
notice cannot sit under a core agent.

## Decision

**1. Lightcast is not adopted.** Three independent reasons, any one sufficient:

- *Price.* Programmatic access runs **$41,000–50,000/yr** per signed public
  contracts (US International Trade Commission: $124k/3yr for 3 seats plus bulk
  download; CareerSource Florida: $50k/yr for 12 users). Their published
  $5,000–12,000 rate card is the *Analyst* GUI product, not data access —
  conflating the two understates the cost 5–10×.
- *Licence.* The [Open Terms of Use](https://lightcast.io/open-terms-of-use)
  permit reuse *"excluding commercial or for-profit purposes"*, and §2.3 adds
  that *"commercial, for-profit, **and/or artificial intelligence purposes** may
  be permitted provided the user contacts Lightcast and enters into an
  agreement."* That names our exact use case. Apache-2.0 would also purport to
  grant readers commercial rights we do not hold. The November 2023 terms
  offered commercial use via a *"no-cost contract"*; the July 2025 revision
  removed "no-cost".
- *Durability.* The free API tier ended **2026-02-13 with three days' notice**,
  explicitly breaking open-source projects that depended on it. §5 reserves the
  right to cancel access *"at any time, for any reason."*

Lightcast's nonprofit tier is offered on their site and LFDT plausibly
qualifies, but it has no published criteria, no dedicated application, and no
documented precedent of being granted to an open-source project. **Requesting it
is worthwhile; depending on it is not.**

**2. SFIA is adopted for structure only, never bundled.** SFIA's free licence
covers personal and **internal** use; a fee-bearing licence is required for
*"redistributing SFIA material in electronic or printed form to any other
organisation"*, and *"copying of this material is prohibited unless authorised
in writing or under a valid SFIA licence"*
([licensing page](https://sfia-online.org/en/about-sfia/licensing-sfia)). A
public Apache-2.0 repository is redistribution to everyone.

We therefore store only what is factual and unprotected — **skill codes, skill
names, level numbers, and structure** — and never SFIA's descriptive text.
Descriptions are fetched at runtime by users holding their own access.

**3. ESCO, O\*NET and BLS are adopted as the open core.** O\*NET (CC BY 4.0) is
the **weighted backbone**: 62,580 skill-occupation edges rated on Importance
*and* Level, each with sample size, standard error and 95% confidence bounds,
published as native RDF. BLS/SOC (US public domain) supplies the occupation
spine and employment projections. ESCO (free with attribution) supplies
multilingual labels and the European occupation view.

Recorded so it is not rediscovered later: **ESCO is structurally binary** —
126,051 skill edges across exactly two predicates (`hasEssentialSkill` /
`hasOptionalSkill`), with no field to hold a number. Any weighting we apply to
ESCO is *our modelling decision* and must be labelled as such, never presented
as source data.

**4. Crosswalks are first-class edges, not ETL merge logic.** We do not attempt
semantic fusion of skills across taxonomies — that is a research problem. We
use the official crosswalks that already exist, with **SOC and ISCO as the
spine**: O\*NET-SOC → SOC, BLS native SOC, ESCO → ISCO, ISCO ↔ SOC.

**5. Every node carries `source` and `source_id`.** Five taxonomies coexist in
one graph without ID collisions. This is not cosmetic: SFIA's skill code `ISCO`
(Information systems coordination) is unrelated to the ILO's ISCO occupation
classification used by ESCO. Bare codes collide.

**6. Vendor pinned snapshots; do not depend on live endpoints.** Lightcast cut
access with three days' notice. Nesta's Open Jobs Observatory was genuinely open
and is genuinely dead — it ended October 2025 and its S3 bucket now returns
`NoSuchBucket`. Australia's ASC is being superseded. Every ingested source gets
a pinned, versioned local snapshot with its retrieval date.

**7. Third-party data lives in a separate tree with its own notice.** Licensed
data is **not** relicensed under Apache-2.0; only our code is. Attribution
obligations are recorded per source in
[`TAXONOMIES.md`](../architecture/TAXONOMIES.md).

**8. The fifth slot is deferred to a follow-up ADR.** Lightcast's removal leaves
room for one more source. Two candidates, both open:

- **Sweden JobTech** — ~6.9M job ads since 2006, **CC0**, live API, taxonomy
  already carrying `esco-occupation` / `esco-skill` concepts. This is also our
  only viable answer to the freshness capability Lightcast provided.
- **UK Standard Skills Classification** — Skills England, published 2026-04-30,
  **OGL v3.0**, reportedly shipping crosswalks to ESCO, O\*NET and SFIA in one
  package. Two caveats: its downloads are behind a sign-in we have not passed,
  so coverage claims are unverified; and its skill weights are **LLM-generated
  with a reproducibility failure documented in its own development report** —
  adopt its crosswalks, distrust its scores.

## Alternatives considered

- **Pay for Lightcast.** Rejected on cost alone ($41–50k/yr against no budget),
  and the licence would still require a separate AI-use agreement.
- **Use Lightcast under the nonprofit tier.** Rejected as a *dependency*, not as
  an *ask* — no published criteria, no precedent, and revocable at will. We can
  request it for validation without building on it.
- **Bundle SFIA and seek forgiveness.** Rejected. The terms are explicit, we are
  an LF Decentralized Trust project, and the exposure is avoidable at trivial
  cost by storing structure only.
- **Semantic skill fusion across taxonomies instead of crosswalks.** Deferred,
  not rejected. It is a genuine research problem; official crosswalks are
  sufficient for Locator, Connector and Pathfinder in v1.
- **Drop to three taxonomies and skip the fifth slot.** Viable fallback if
  neither candidate verifies. Nothing in the architecture requires five.

## Consequences

**Easier.** Every adopted source is now redistributable or clearly scoped, so
the published graph is clean by construction. O\*NET's native RDF removes a
parsing layer and drops straight into a triple store or Neo4j via n10s. Pinned
snapshots make ingestion reproducible and CI-testable.

**Harder.** We lose live market freshness — the one capability with no open
global substitute. Sweden JobTech covers it at one country's scale; a monthly
`schema.org/JobPosting` extraction from Common Crawl is the only open path to
multi-country coverage, and nobody has published one. Treat that as a possible
project contribution, not a dependency.

**Follow-ups.**

- Update `docs/sprints/sprint-01-knowledge-graphs.md`, whose Lightcast section
  describes a data-share model no longer reachable.
- Verify the UK SSC crosswalks behind its sign-in, then decide the fifth slot.
- Confirm whether Australia's ASC is superseded by the National Skills Taxonomy
  (`NationalSkillsTaxonomy@jobsandskills.gov.au`); site unreachable from outside
  Australia in two independent attempts.
- Ask the O\*NET Center whether Lightcast remains their job-postings vendor. If
  so, O\*NET's *Hot Technology* / *In Demand* flags are downstream of the
  pipeline that just closed, and our open freshness layer is less independent
  than it appears.
- Request Lightcast nonprofit access under the LFDT umbrella — as a validation
  reference, with nothing depending on the answer.

**Risks.** Access terms move: this ADR is a snapshot dated 2026-07-19 and should
be re-checked at each major ingestion change. The `source`/`source_id`
convention only pays off if applied consistently from the first loader —
retrofitting it across a populated graph is expensive.
