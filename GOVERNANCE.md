# Governance

Talent Angels is a mentorship project under **LF Decentralized Trust (LFDT)** —
Learning Tokens Lab. This document describes roles, responsibilities, and how
decisions get made.

## Roles

### Mentees (Contributors)

Mentees do the bulk of the work: writing code, documentation, and educational
resources. A mentee:

- Picks up issues, opens PRs, and reviews peers' PRs.
- Follows [`CONTRIBUTING.md`](./CONTRIBUTING.md), including DCO sign-off.
- Uses AI coding agents responsibly and remains accountable for submissions.
- Participates in sprints and the three virtual meetups.

### Mentors (Maintainers)

Mentors guide the project, review and merge PRs, and have final say on direction.
They are the points of contact for Code of Conduct matters.

| Mentor             | Role                                                                    | Contact                                                          |
| ------------------ | ----------------------------------------------------------------------- | --------------------------------------------------------------- |
| **Alfonso Govela** | Learning Tokens Lab, LF Decentralized Trust                             | alfonsogovela@me.com · [LinkedIn](https://www.linkedin.com/in/alfonsogovela/) |
| **Enmanuel Amaya** | Director, B.Sc. Computer Science — UCA, El Salvador                     | earaujo@uca.edu.sv · [@enxel](https://github.com/enxel)         |
| **Alberto Ceballos** | Agentic AI Developer & Founder, Danil AI                              | alberto@danil.ai · [@nosoypoot](https://github.com/nosoypoot)   |
| **Noemí Muñiz**    | Project / Product Manager                                               | noemi.muniz.gutierrez@gmail.com                                 |

## Decision-making

- **Day-to-day** (which issue, how to implement): decided by the mentee doing the
  work, with mentor input via PR review.
- **Cross-repo / architectural**: proposed as an **Architecture Decision Record
  (ADR)** in `docs/decisions/` (workspace) and mirrored to `TA-memory`. Mentors
  approve.
- **Project direction & scope**: decided by mentors, informed by the
  [`ROADMAP.md`](./ROADMAP.md) and the original proposal in
  `TA-memory/proposals/`.

We prefer **lazy consensus**: a proposal with no sustained objections after a
reasonable review window is accepted. Mentors break ties.

## Merging

- At least **one mentor approval** is required to merge any PR.
- Mentors merge via **squash**, preserving the DCO sign-off.
- Never push directly to `main`.

## Branch protection (enforced on GitHub)

The merge rules above are not just convention — `main` is **protected on GitHub**
in every repo:

- A **pull request with ≥ 1 approving review** is required to merge; stale
  approvals are dismissed on new pushes.
- **Force-pushes and branch deletion are blocked**; linear history is required.
- `enforce_admins` is **off** so mentors/admins can still merge while the cohort
  is small and there isn't a second reviewer yet.

This is applied (and re-applied) reproducibly by
[`bin/protect-branches.sh`](./bin/protect-branches.sh) via the GitHub API — run
it after creating a new repo. Note: branch protection is free for **public**
repos; a **private** repo would need GitHub Team/Enterprise.

The **DCO check** (`.github/workflows/dco.yml`) runs on every PR. Once it has run
at least once, it can be made a *required status check* so no PR merges without
passing it.

## Meetings & sprints

The project follows Agile sprints. Progress is presented at three virtual
meetups (end of weeks 10, 19, and 26 — see [`ROADMAP.md`](./ROADMAP.md)). Meeting
notes are recorded in `TA-memory/meetings/`.

## Partners

- Universidad Centroamericana José Simeón Cañas (UCA), El Salvador
- A partner university in Mérida, Yucatán, México
- Mentees may also partner with their own universities or workplaces to test
  results.

## Code of Conduct

All participants are bound by the [Code of Conduct](./CODE_OF_CONDUCT.md).
