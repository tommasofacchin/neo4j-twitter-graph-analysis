# Neo4j Twitter Graph Analysis (Higgs Dataset)

This repository contains a small Neo4j-based prototype for analysing a Twitter-like social network built from the Higgs dataset. The goal is to show how a graph database can model users and their interactions, and to answer a few concrete social network analysis questions using Cypher.

The project is designed as a **course project**: it focuses on a subset of the data, a clean graph schema, a reproducible import workflow, and a small set of meaningful queries that are easy to explain during the oral exam.

---

## 1. Project scope

This project implements a Neo4j prototype for graph-based analysis of Twitter social network data.

- **DBMS:** Neo4j (graph / property graph).
- **Dataset:** subset of the Higgs Twitter dataset (edge lists).
- **Entities:** users and their interactions.
- **Goal:** identify central/visible users, strong interaction patterns, and local ego-networks.

It is intentionally **not** a full-scale Twitter analytics pipeline. The idea is to have a small but complete workflow that you can load on a laptop, explain in 10–15 minutes, and extend conceptually to larger deployments.

---

## 2. Why use Neo4j here?

Twitter-like data is essentially a graph:

- Nodes are users (and, in richer models, tweets and hashtags).
- Edges are follows, mentions, replies, retweets, etc.
- Interesting questions are about relationships and paths: influence, communities, conversation spread.

In a relational database you can model this with tables and foreign keys, but many questions turn into long chains of joins. In Neo4j, the same questions can often be expressed as simple pattern matches in Cypher.

This prototype uses that advantage in a minimal way: a small schema, a few interaction types, and queries that walk the graph directly.

---

## 3. Graph schema

For this prototype we only model users and their interactions. That is enough to show centrality, visibility, and repeated interaction patterns.

### Node type

- `User`
  - `userId` (string, unique identifier from the dataset)
  - `screenName` (optional)
  - `name` (optional)
  - other optional properties when available (e.g. followers count)

### Relationship types

- `(:User)-[:FOLLOWS]->(:User)`  
  A user follows another user.

- `(:User)-[:RETWEETS]->(:User)`  
  A user retweets another user’s content.

- `(:User)-[:REPLIESTO]->(:User)`  
  A user replies to another user.

- `(:User)-[:MENTIONS]->(:User)`  
  A user mentions another user.

The model is deliberately compact:

- only one node label (`User`),
- a small set of directed relationship types,
- all relationships created using `userId` as the stable key.

It can be extended later (e.g. adding `Tweet` and `Hashtag` nodes), but this minimal version is enough for the exam.

---

## 4. Repository structure

The repository is organised so that each stage of the workflow has a clear place:

```text
project/
  README.md                  # this file
  logs.md                    # implementation log 
  data/
    raw/                     # original Higgs dataset files
    processed/               # CSV files ready for Neo4j import
  scripts/
    build_higgs_csv.py      # Python script to build the CSVs
  cypher/
    constraints.cypher       # uniqueness constraints and indexes
    importnodes.cypher       # LOAD CSV for User nodes
    importrelationships.cypher # LOAD CSV for relationships
    analysisqueries.cypher   # Cypher queries used in the analysis
  screenshots/               # screenshots of query results and graph views
  slides/
    slides.md                # slide outline / speaker notes
    presentation.pptx        # final slide deck 
```

---

## 5. How to reproduce the project

This section describes how to go from the raw dataset to the final graph and analysis results.

### 5.1. Requirements

- Neo4j Desktop or Neo4j Server (4.x or 5.x)
- Python 3.x
- Disk space for the Higgs dataset and processed CSVs

Optional:

- `pip install -r requirements.txt` if you decide to provide one for the preprocessing script.

### 5.2. Get the dataset

1. Download the Higgs Twitter dataset (edge lists).
2. Place the original files into `data/raw/`.

You should have at least the edge lists for follower links and interaction events (retweets, replies, mentions).

### 5.3. Preprocess into CSV

From the project root, run:

```bash
python scripts/preprocess_higgs.py
```

The script reads the edge lists in `data/raw/` and produces a set of CSV files in `data/processed/`, for example:

- `users.csv`
- `follows.csv`
- `retweets.csv`
- `replies.csv`
- `mentions.csv`

Each CSV has a stable schema and uses `userId` as the key so that Neo4j can link nodes and relationships consistently.

### 5.4. Prepare Neo4j

1. Create or open a Neo4j database.
2. Copy the CSV files from `data/processed/` into the Neo4j `import` directory (or adjust the paths in the Cypher scripts to match your setup).

### 5.5. Create constraints

Open the Neo4j Browser (or use Cypher shell) and run the contents of:

```text
cypher/constraints.cypher
```

This script typically:

- creates a uniqueness constraint on `User.userId`,
- optionally creates supporting indexes.

These constraints prevent duplicates and make lookups during the import faster and safer.

### 5.6. Import nodes

Run:

```text
cypher/importnodes.cypher
```

This script:

- uses `LOAD CSV WITH HEADERS`,
- creates one `User` node per `userId`,
- sets basic properties from `users.csv`.

At this point the database contains all users but no relationships.

### 5.7. Import relationships

Run:

```text
cypher/importrelationships.cypher
```

This script:

- loads each relationship CSV (`follows.csv`, `retweets.csv`, `replies.csv`, `mentions.csv`),
- matches the corresponding `User` nodes by `userId`,
- creates `FOLLOWS`, `RETWEETS`, `REPLIESTO`, `MENTIONS` relationships.

Some imports may use batching or periodic commits if the files are large.

### 5.8. Validate the graph

Before running any analysis, validate the structure:

- Count nodes and relationships:

  ```cypher
  MATCH (u:User) RETURN count(u) AS users;
  MATCH ()-[r:FOLLOWS]->() RETURN count(r) AS follows;
  MATCH ()-[r:RETWEETS]->() RETURN count(r) AS retweets;
  MATCH ()-[r:REPLIESTO]->() RETURN count(r) AS replies;
  MATCH ()-[r:MENTIONS]->() RETURN count(r) AS mentions;
  ```

- Inspect a small neighbourhood around a sample user in Neo4j Browser to make sure directions and labels look correct.

---

## 6. Analysis queries

The analysis queries used in the project are collected in:

```text
cypher/analysisqueries.cypher
```

They support the oral presentation by answering a few concrete questions.

### 6.1. Most visible users

Two queries focus on visibility and centrality:

- most followed users (in-degree on `FOLLOWS`);
- most mentioned users (incoming `MENTIONS`).

These queries produce rankings that highlight users who are structurally central or frequently referenced in the interaction graph.

### 6.2. Strong interaction pairs

Another query looks for pairs of users who interact repeatedly, combining:

- mentions,
- replies,
- retweets.

The result is a list of user pairs with counts of interactions, which helps identify stronger local ties rather than isolated edges.

### 6.3. Ego-network exploration

A final query explores the ego-network around a chosen user:

- finds the user,
- fetches direct neighbours and relevant relationships,
- returns a subgraph that can be visualised in Neo4j Browser.

This query is used to generate a graph-view screenshot for the presentation and to illustrate how local graph exploration works in Neo4j.

---

## 7. Neo4j architecture

Although the prototype runs on a single Neo4j instance and a subset of the data, the oral exam includes a short discussion of how the same design could scale.

The presentation covers:

- **Scalability**  
  Neo4j can run in a cluster with core servers and read replicas, so the same graph model can handle larger datasets and more read-heavy workloads by adding replicas.

- **Distributed querying**  
  In a cluster, client drivers route queries to appropriate servers. Reads can go to replicas while writes go to cores, but from the application’s point of view there is still a single logical graph.

- **Availability**  
  Causal clustering and replication allow the system to survive node failures, as long as a quorum of core servers is available. Replicas improve read availability.

- **Consistency model**  
  Neo4j provides read-your-write behaviour in a clustered setup using bookmarks, which encode the causal history of transactions.

This part is explained conceptually in the slides rather than implemented in code.
