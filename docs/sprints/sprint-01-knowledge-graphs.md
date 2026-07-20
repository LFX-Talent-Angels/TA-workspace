# Sprint 1 — Knowledge Graphs

> Sprint brief for **Talent Angels** (LFDT — Learning Tokens Lab).
> Learn about Knowledge Graphs and Agentic AI by building a basic Knowledge
> Graph for each of our 5 reference taxonomies.
>
> This complements the committed **Sprint 1 · Foundations** entry in
> [`ROADMAP.md`](../../ROADMAP.md).

## Overview

Learn about Knowledge Graphs (KGs) and Agentic AI by building a basic Knowledge
Graph for each of our 5 taxonomies of reference (ESCO, O\*NET, SFIA, BLS,
Lightcast).

**Goal.** A simple, first approach to help you understand Knowledge Graphs — in
case you are not familiar with them — and to weigh the complexity of working
with 5 independently developed taxonomies.

**Dynamic.**

- Organize yourselves to work individually, **one taxonomy per mentee**.
- Support each other.
- Communicate your requests via Slack.
- Coordinate a collective presentation of the individual results.

**Duration.** Two weeks, from **2026-06-16** to **2026-06-30**.

**Review.** We have a review at our 3rd Mentee Sync Meeting on **2026-06-23**.

---

> The following text is a compilation of AI Overview answers for basic
> information, learning resources, and an example of building a KG. Treat it as a
> starting point and verify against the primary sources linked throughout.

## 1. Basic information

### ESCO

The **ESCO** (European Skills, Competences, Qualifications and Occupations)
database does not use a traditional relational database with a single fixed
schema. Instead, it is built as a **semantic graph database** structured on
Linked Open Data (LOD) principles.

The database uses standard semantic web schemas: **RDF** (Resource Description
Framework), **OWL** (Web Ontology Language), and **SKOS** (Simple Knowledge
Organization System).

**The 3-pillar data model.** At a conceptual level, the ESCO schema is organized
into three interrelated domains:

- **Occupations pillar** — represents occupations relevant to the European labor
  market. Builds upon the **ISCO-08** (International Standard Classification of
  Occupations) taxonomy. Key concepts: occupational profiles, essential/optional
  skills, and licenses/qualifications.
- **Skills and Competences pillar** — around 13,500 concepts detailing
  knowledge, language skills, and transversal skills. Acts as a mono-hierarchy
  where skills are grouped logically.
- **Qualifications pillar** — certifications and qualifications provided by
  member states, linked to the European Qualifications Framework (EQF).

**Core data structures.** Because ESCO operates as a graph, its schema maps
interconnected "concepts" (occupations, skills, qualifications) to one another.
The core structures rely on the following SKOS properties:

- `skos:Concept` — base class for all ESCO objects (occupations, skills, or
  qualification groups).
- `skos:prefLabel` & `skos:altLabel` — preferred and non-preferred (alternative)
  terms for the item, in up to 27 languages.
- `skos:broader` & `skos:narrower` — hierarchical relationships (e.g. placing a
  specific occupation under a broader ISCO code).
- `skos:member` — groups specific ESCO concepts into collections.
- **Custom ESCO properties** — define the relationship between a skill and an
  occupation (e.g. whether a skill is *essential* or *optional* for a job
  profile).

**Accessing the schema.** To build a local version of ESCO in a graph database
like **Neo4j**, or integrate it into a relational system, you can download the
complete model:

- **RDF/SKOS datasets** — download the complete semantic model (RDF/XML) from the
  [ESCO Download Portal](https://esco.ec.europa.eu/en/use-esco/download).
- **Visual representation** — the
  [ESCO Ontology Model](https://data.europa.eu/esco/model) from the European
  Commission shows how classes and properties relate.

Sources: [ESCO API](https://esco.ec.europa.eu/en/about-esco/escopedia/escopedia/esco-api) ·
[CEUR-WS paper](https://ceur-ws.org/Vol-1409/paper-10.pdf) ·
[ESCO in Neo4j](https://blog.bruggen.com/2018/08/esco-database-in-neo4j-skills.html) ·
[ESCO data model](https://data.europa.eu/esco/model) ·
[Downloadable datasets](https://esco.ec.europa.eu/en/structure-esco-downloadable-datasets)

### O\*NET

The O\*NET database structure maps directly to the **O\*NET Content Model**, an
organizational framework that evaluates the U.S. workforce across 6 main domains
and hundreds of granular descriptors. It is structured as a **relational
database**, with individual data tables for each classification variable.

The schema is heavily interconnected, using **O\*NET-SOC codes** (aligned with
the Standard Occupational Classification system) and **Element IDs** to link
worker requirements to job characteristics.

**Key domains and representative tables:**

- **Worker Characteristics** — Abilities, Occupational Interests, Work Styles.
- **Worker Requirements** — Skills, Knowledge, Education, Basic Interests.
- **Occupational Requirements** — Work Activities, Work Context, Detailed Work
  Activities (DWAs), Task Ratings.
- **Experience Requirements** — Experience and Training, Licensing.
- **Occupation-Specific Information** — Job Zones, Alternate Titles, Task
  Statements, Tools and Technology.
- **Workforce Characteristics** — Labor Market Information, Occupational Outlook.

**How the data links.** At the center of the schema is the **Occupation Data**
table (containing O\*NET-SOC codes), which acts as the primary key. To query, for
example, which *Skills* an Accountant needs, you join the Occupation Data table
to the Skills table on the O\*NET-SOC code, then target individual variables via
the Element ID and Scale ID (which dictates whether the rating measures
*Importance* or *Level*).

**File formats & documentation.** The O\*NET Center provides the complete schema
and data for download in **MySQL**, **SQL Server**, and **Oracle** formats:

- Complete downloads — [O\*NET Database Page](https://www.onetcenter.org/database.html).
- Column-by-column schemas — [O\*NET Data Dictionary](https://www.onetcenter.org/dictionary/24.1/excel/).

### SFIA

SFIA (Skills Framework for the Information Age) is a globally recognized skills
and competency framework — **not** a single proprietary software with a
universal database schema. Organizations and developers implement their own
databases using SFIA's taxonomy. Typical relational/API schemas (e.g.
PostgreSQL) generally include the following core tables:

1. **Skills** — the core catalog of professional SFIA skills.
   - `skill_code` (PK) — unique 4-letter identifier (e.g. `PROG`, `DESN`, `DBAD`).
   - `title` — official name of the skill.
   - `description` — high-level summary of what the skill entails.
   - `subcategory_id` (FK) — links to the skill's subcategory.
2. **Skill_Levels** — how each skill is practiced at different proficiency levels.
   - `skill_level_id` (PK), `skill_code` (FK).
   - `level_number` — 1 (Follow) to 7 (Set strategy).
   - `level_description` — behavioral/competency statement for the skill at that level.
3. **Levels_of_Responsibility** — universal attributes expected at each of the 7
   levels, regardless of skill: `responsibility_level` (PK), `autonomy`,
   `influence`, `complexity`, `knowledge`, `business_skills`.
4. **Categories & Subcategories** — organize the 100+ SFIA skills into navigable
   groupings (e.g. *Strategy and Architecture*, *Delivery and Operation*):
   `category_id` (PK), `category_name`.
5. **Roles & Job_Profiles** (custom context) — map the framework to internal HR
   needs: `role_id` (PK), `required_skill` (FK), `target_level`.

For resources, reference guides, and licensing, see the
[SFIA Online site](https://sfia-online.org/).

### BLS — Occupational Outlook Handbook

The Occupational Outlook Handbook (OOH) does not use a single relational or
flat-file schema. The U.S. Bureau of Labor Statistics (BLS) compiles and
publishes occupational data through the **Standard Occupational Classification
(SOC)** framework, available via flat files, API, and OOH profiles.

1. **Occupational Profiles (OOH web schema)** — for each of the ~600 covered
   occupations: Occupation Title, SOC Code (6-digit), Summary (What They Do, Work
   Environment, How to Become One, Pay, Job Outlook), State and Area Data, Similar
   Occupations, Additional Information.
2. **Employment Projections data (matrix schema)** — the tabular, numerical
   database underpinning the OOH: Occupation Code (6/8-digit SOC), Occupation
   Title, Base Year Employment, Projected Year Employment, Numeric Change, Percent
   Change, Occupational Openings, Education and Training, Skills Data.
3. **Occupational Employment and Wage Statistics (OEWS)** — wage data: Area Code,
   Annual/Hourly Wages (median, top/bottom 10% & 25%), Employment Concentration.

**Access and download:**

- **Bulk files** — Employment Projections publishes `.xlsx` tables; see
  [Data for Occupations Not Covered in Detail](https://www.bls.gov/ooh/about/data-for-occupations-not-covered-in-detail.htm).
- **Public Data API** — the [BLS Data API](https://www.bls.gov/bls/api_features.htm)
  retrieves historical time-series data in JSON or Excel via series IDs.
- **Methodology & definitions** —
  [Employment Projections Data Overview](https://www.bls.gov/emp/documentation/data-overview.htm).

### Lightcast

Lightcast (formerly Emsi Burning Glass) maintains a massive labor-market
database, but **does not have a single, static, publicly available schema**.
Because the data is highly relational, it is typically delivered to clients via
**Data Shares** in modern data warehouses (**Snowflake, Databricks, Google
BigQuery**) or as direct cloud-storage files. Core data models include:

1. **Job Postings** — real-time and historical postings from online platforms.
   - `POSTINGS` — core info per advertisement (ID, Title, Body, URL, Active
     status, Dates).
   - `POSTINGS_META` — metadata (Company, City/State/Country, source).
   - `POSTINGS_SKILLS` — maps extracted skills to each posting ID.
2. **Global Core Labor Market Information (LMI)** — researched historical,
   demographic, and projected data.
   - `INDUSTRIES` — based on NAICS or NACE codes (industry growth, staffing).
   - `OCCUPATIONS` — projected employment, openings, median earnings, mapped to
     SOC or LOT (Lightcast Occupation Taxonomy).
   - `DEMOGRAPHICS` — population, age, gender, ethnicity, educational attainment.
   - `COMPLETERS` — graduates by institution, program, and education level.
3. **Worker Profiles & Resumes** — career trajectories from millions of profiles.
   - `WORK_HISTORY` — past titles, company sizes, employment durations.
   - `EDUCATION_HISTORY` — degrees, fields of study, universities.
4. **Taxonomies and Ontologies** — normalize unstructured text.
   - `SKILLS_TAXONOMY` — 33,000+ standardized skills (e.g. equating "ML Engineer"
     and "Machine Learning").
   - `JOB_TITLES` — normalizes raw titles into ~75,000 distinct standardized
     titles.

Full schemas (thousands of columns) are provided to authenticated clients via
the [Introduction to Lightcast API](https://docs.lightcast.io/lightcast-api/docs/introduction)
and [Data Methodology Documentation](https://kb.lightcast.io/en/collections/3904183-data-methodology).

## 2. Learning materials and development resources

Applying Knowledge Graphs to AI agents gives them long-term memory, reasoning,
and the ability to understand complex entity relationships that standard vector
databases miss.

### Recommended courses & learning materials

- **[Knowledge Graphs for AI Agent API Discovery](https://learn.deeplearning.ai/courses/knowledge-graphs-for-ai-agent-api-discovery/lesson/i1ahou/introduction)**
  (DeepLearning.AI) — foundational short course on building and integrating KGs so
  agents understand business processes and discover the right APIs in sequence.
- **[Agentic Knowledge Graphs](https://www.pluralsight.com/courses/agentic-knowledge-graphs)**
  (Pluralsight) — designing agent-driven KGs for structured reasoning, contextual
  understanding, and explainable decision-making.
- **[The Power of Knowledge Graphs](https://www.linkedin.com/learning/hands-on-ai-knowledge-graphs-for-generative-ai-use-cases/the-power-of-knowledge-graphs)**
  (LinkedIn Learning, Dr. Ashleigh Faith) — introductory guide focused on
  fact-verification and grounding LLMs.

### Developer frameworks & technologies

- **[LlamaIndex](https://developers.llamaindex.ai/python/examples/property_graph/agentic_graph_rag_vertex/)** —
  agent framework for integrating KGs; use its *Property Graph* abstractions to
  construct a graph from text and enable agentic GraphRAG.
- **[LangGraph](https://www.freecodecamp.org/news/how-to-develop-ai-agents-using-langgraph-a-practical-guide/)** —
  extension of LangChain for stateful AI agents; pairs with KGs to model
  workflows as nodes and edges while traversing memory states.

### Graph databases & query integration

- **[Neo4j](https://neo4j.com/blog/knowledge-graph/knowledge-graph-agents-llamaindex/)** —
  industry standard for graph storage; store reasoning results and link vectors
  with deterministic graph relationships.
- **[Memgraph](https://memgraph.com/docs/data-modeling/modeling-guides/model-a-knowledge-graph)** —
  high-performance, in-memory graph database that integrates natively with
  LlamaIndex for natural-language queries.

### GraphRAG strategy & thought leadership

- [Neo4j — AI Systems](https://neo4j.com/use-cases/ai-systems/) — combining
  semantic similarity with inferential reasoning for search and long-term memory.
- [Stardog — Use Cases](https://www.stardog.com/use-cases/) — enterprise data
  fabric implementations using knowledge graphs.
- [Capgemini — Knowledge graphs improve GenAI](https://www.capgemini.com/mx-es/insights/expert-perspectives/knowledge-graphs-improve-gen-ai/) —
  KGs as a bridge translating user intent into actionable queries.
- [AWS — Generative AI Use Cases](https://aws.amazon.com/ai/generative-ai/use-cases/) —
  natural-language search tools over complex structured data.

## 3. Build a basic Knowledge Graph for the taxonomies

Building a basic knowledge graph for the **ESCO** taxonomy involves modeling its
three core pillars (Occupations, Skills, Qualifications) using standard Semantic
Web frameworks. The foundation relies on **SKOS**.

### 3.1 Core data model & node types

In a graph database (e.g. Neo4j or GraphDB), the KG represents data as **nodes**
(entities), **edges** (relationships), and **properties** (attributes), using
ESCO and W3C terminology:

- **Skill/Competence** — a specific capability applied to a task (node label:
  `Skill`).
- **Knowledge** — theoretical information or understanding (node label:
  `Knowledge`).
- **Skill Group** — hierarchical collections clustering skills logically (node
  label: `SkillGroup`).
- **Occupation** — labor-market job roles mapped to required/optional skills
  (node label: `Occupation`).

### 3.2 Defining edges (relationships)

The relationships form the "graph" aspect, using SKOS semantics to connect nodes:

- `[:SKOS_BROADER]` / `[:SKOS_NARROWER]` — hierarchical, tree-like structure of
  the skill groups.
- `[:SKOS_RELATED]` — associated but non-hierarchical skills.
- `[:REQUIRES_SKILL {relation: 'essential|optional'}]` — connects an `Occupation`
  to a `Skill`, defining whether the skill is required or just beneficial.
- `[:SKOS_MEMBER]` — assigns a skill or knowledge concept to its `SkillGroup`
  collection.

### 3.3 Basic Neo4j (Cypher) example

To build a basic sub-graph of a skill group (e.g. "Web Development"):

```cypher
// Create Skill Group
CREATE (sg:SkillGroup {uri: 'http://europa.eu', name: 'Web Development'});

// Create Individual Skill
CREATE (sk1:Skill {uri: 'http://europa.eu', name: 'JavaScript Programming'});

// Create Occupation
CREATE (oc1:Occupation {uri: 'http://europa.eu', name: 'Front-end Developer'});

// Create Relationships
CREATE (sk1)-[:SKOS_BROADER]->(sg);
CREATE (oc1)-[:REQUIRES_SKILL {type: 'essential'}]->(sk1);
```

### 3.4 Implementation steps

1. **Extract** — download the latest ESCO taxonomy datasets (RDF-Turtle) from the
   [ESCO Downloadable Datasets](https://esco.ec.europa.eu/en/structure-esco-downloadable-datasets)
   portal.
2. **Transform** — parse the SKOS/RDF files and map them into
   subject–predicate–object triples.
3. **Load** — ingest the parsed records into a graph database (Neo4j) or a
   semantic triple store (GraphDB/Blazegraph).
4. **Query & integrate** — use the
   [ESCO REST API](https://ec.europa.eu/esco/api/doc/esco_api_doc.html) or the
   ESCO SPARQL endpoint to enrich and align real-world job postings with your
   graph.

### Reference video

- [Create a Knowledge Graph: A Simple ML Approach](https://www.youtube.com/watch?v=nYQLp7itZx8)
  (Neo4j, YouTube · Nov 30, 2021) — structuring a large taxonomy in a graph
  database and mapping nodes intuitively.

---

## Outcomes

Sprint 1 is closed. All five taxonomies were explored, each slice lives in
[`TA-lab/mentees/<handle>/sprint-01/`](https://github.com/LFX-Talent-Angels/TA-lab/tree/main/mentees),
and all five folders share a common shape: a `NOTES.md`, a `graph.cypher` with
the `source`/`source_id` convention, and a `queries.cypher` framed as previews
of Locator, Connector and Pathfinder.

| Taxonomy | Built by | Contributed |
| --- | --- | --- |
| O\*NET | Aman Kumar Sarraf | The reproducible-pipeline standard: loader, self-verifying checks, containerised Neo4j, correct CC BY 4.0 attribution |
| ESCO | Alejandro Kantun | Full-scale load then a scoped slice; documented its own bugs and the n10s/AuraDB incompatibility; raised the missing-edge-weights gap |
| SFIA | Shubhang Sinha | Modelled responsibility levels as first-class nodes; **flagged SFIA's restrictive licensing** — the finding that triggered ADR-0006 |
| BLS | Vishwajit | The deepest taxonomy research, including the digit-by-digit SOC hierarchy and the first cross-taxonomy comparison |
| Lightcast | mentor | The evidence for *not* adopting it |

**What the sprint actually produced** was not five graphs — it was the
realisation that two of the five taxonomies cannot be used as the project
assumed. Lightcast is priced out and licence-blocked for AI use; SFIA cannot be
redistributed in a public repository. Both are recorded in
[ADR-0006](../decisions/0006-taxonomy-data-sources.md).

**Read next:** [`docs/architecture/TAXONOMIES.md`](../architecture/TAXONOMIES.md)
— the five explorations synthesised into one design contract: per-taxonomy
profiles, the unified model, and the ingestion rules TA-agents implements.

> ⚠️ **The Lightcast section above is out of date.** It describes a data-share
> and free-API model that no longer exists — Lightcast ended free API access on
> 2026-02-13. Kept unedited as a record of what we believed when the sprint was
> briefed. See ADR-0006 for what is true now.

---

*Source: compiled from the "LFX TA — Sprint 1, Knowledge Graphs" brief. This is
a learning compilation of AI-generated overviews; verify specifics against the
primary sources linked above.*
