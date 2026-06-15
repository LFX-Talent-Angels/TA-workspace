# Roadmap

Talent Angels follows Agile sprints. The plan below mirrors the deliverables in
the original proposal (`TA-memory/proposals/original-proposal.md`). Weeks are
relative to the program start; convert to calendar dates at kickoff.

## Deliverables

| #  | Deliverable                | Weeks | Focus                                                         |
| -- | -------------------------- | ----- | ------------------------------------------------------------ |
| 1  | Understand Knowledge Graphs | 2    | Foundations of KGs                                           |
| 2  | Define purpose & scope      | 4    | Use case, user needs, success criteria, constraints         |
| 3  | System Prompt Design        | 2    | Goals, role/persona, instructions, guardrails               |
| 4  | Choose LLM                  | 2    | Base model, parameters, context window, cost/latency        |
| 5  | Tools & Integrations        | 3    | Local tools, APIs, agent-as-tool, custom functions          |
| 6  | Memory System               | 3    | Episodic, working, vector DB, SQL, file storage             |
| 7  | Orchestration               | 3    | Routes/workflows, triggers, queues, A2A, error handling     |
| 8  | User Interface              | 3    | Chat UI, web app, API endpoint, Slack/Discord bot           |
| 9  | Testing & Events            | 3    | Unit tests, latency, quality metrics, iterate               |

## Meetups

Three virtual meetups present progress:

- **Meetup 1** — end of **week 10**
- **Meetup 2** — end of **week 19**
- **Meetup 3** — end of **week 26**

Notes and slides go in `TA-memory/meetings/`.

## Agents we are building

- **Locator** — pinpoints skills, tasks, occupations in the taxonomies.
- **Connector** — lists nodes directly preceding/succeeding a location.
- **Pathfinder** — traces all routes between two locations (learning journeys).
- **Evaluator** *(future)* — ranks paths by relevance, distance, profile fit.

## Taxonomies in scope

ESCO · O*NET · SFIA · BLS (Occupational Outlook Handbook) · Lightcast.

## How this roadmap is maintained

This file is the lightweight, living plan. Larger or contested changes go through
an ADR in `docs/decisions/` and are mirrored to `TA-memory/decisions/`.
