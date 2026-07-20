# ADR-0003: Taxonomy data sources — which we adopt, and on what terms

- **Status:** Accepted
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

**8. Sweden JobTech takes the fifth slot.** It is adopted for exactly one
reason: it restores the capability Lightcast provided that nothing else covers —
**signal from live job postings**. Verified 2026-07-19 at
<https://data.jobtechdev.se/dataset/job-ads>: ~6.9 million job advertisements
since 2006 as bulk download, plus a Job Search API, a historical API from 2016
"enriched with competency data", and **JobStream**, a real-time API with change
notifications. **All distributions are CC0** — the cleanest licence in our
entire set, cleaner than anything Lightcast ever offered.

Its limits, stated plainly: it is **one country**. Swedish labour-market signal
generalises imperfectly, and the graph must not present Swedish demand as global
demand. Reports that its taxonomy carries `esco-occupation` / `esco-skill`
concepts are **not yet verified** — the taxonomy site was unreachable at time of
writing — so the ESCO alignment is a hypothesis to test at ingestion, not an
assumption to build on.

**9. Credentials are ours to build, not to source.** This project sits under
LFDT's Learning Tokens Lab, and the obvious move would be to adopt a credential
taxonomy (Credential Engine's CTDL, or similar) to link skills to
qualifications. **We decline that dependency.** Proof of Learning is designed by
this project, on mechanisms we choose, and the credential layer is our own
output — not something a third-party taxonomy supplies. The taxonomies exist to
answer questions about skills, tasks and occupations; what a learner earns for
traversing them is our design surface, and keeping it unencumbered by an
external vocabulary's licence and modelling assumptions is deliberate.

**Other classifications remain open to explore, none adopted.** Worth a look if
a concrete need appears, in no particular order: the **UK Standard Skills
Classification** (OGL v3.0, published 2026-04-30, reportedly carrying crosswalks
to ESCO, O\*NET and SFIA — though its downloads are sign-in gated and its skill
weights are LLM-generated with a reproducibility failure documented in its own
development report); **Canada's OaSIS** (OGL-Canada, ~222k weighted edges, but a
transform of O\*NET, so it corroborates nothing independent); national
classifications closer to where our contributors live, such as **India's NCO**
and **Mexico's SINCO**; and thematic competence frameworks like the EU's
**DigComp**, **GreenComp** and **EntreComp**, or NIST's **NICE Framework** for
cybersecurity. None of these is on the critical path. Adding an occupation
taxonomy that already crosswalks to SOC or ISCO buys coverage we largely have.

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
- **Drop to four sources and skip the fifth slot.** Nothing in the architecture
  requires five. Rejected because live-postings signal is a real capability
  gap, and Sweden JobTech fills it at zero licensing cost.
- **Adopt a credential taxonomy (CTDL / Credential Registry).** Rejected as a
  dependency — see decision 9. Credentials are this project's own output.
- **Add more occupation classifications for geographic coverage** (India's NCO,
  Mexico's SINCO, national European schemes). Rejected for now: they all
  crosswalk to ISCO or SOC, so they add ingestion and maintenance without
  adding structural reach.

## Consequences

**Easier.** Every adopted source is now redistributable or clearly scoped, so
the published graph is clean by construction. O\*NET's native RDF removes a
parsing layer and drops straight into a triple store or Neo4j via n10s. Pinned
snapshots make ingestion reproducible and CI-testable.

**Harder.** Live market signal is now single-country. Sweden JobTech is
excellent data under an ideal licence, but Swedish demand is not global demand,
and any agent surfacing "what's in demand" must say whose market it is speaking
about. A monthly `schema.org/JobPosting` extraction from Common Crawl is the
only open path to multi-country coverage and nobody has published one — a
possible project contribution, not a dependency.

**Follow-ups.**

- Update `docs/sprints/sprint-01-knowledge-graphs.md`, whose Lightcast section
  describes a data-share model no longer reachable.
- Verify whether the JobTech taxonomy really carries ESCO concept mappings; the
  site was unreachable when this was written. If it does, the Swedish data joins
  the graph almost free; if not, mapping it is real work to scope.
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
