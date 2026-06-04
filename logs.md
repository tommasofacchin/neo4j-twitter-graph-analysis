# Project Updates

This file tracks the implementation progress of the project **Graph-Based Analysis of Twitter Social Networks Using Neo4j**.

## Current Status

### Implemented so far
- `data/raw/`
- `data/processed/`: Neo4j-ready CSV files generated
- `scripts/`
- `cypher/`: Cypher scripts created for constraints, data import, and analysis queries
- `screenshots/`: Screenshots of key queries and graph views captured from Neo4j Browser

---

## Update Log

### 1. Initial project structure created
- Added `data/raw/` to store the original Higgs Twitter Dataset files.
- Added `data/processed/` to store the CSV files that will be used for Neo4j import.
- Added `scripts/` to store Python scripts for preprocessing and dataset conversion.

### 2. Higgs dataset preprocessing completed
- Added the Python preprocessing script in `scripts/` to convert the Higgs Twitter edge list files into CSV format.
- Executed the preprocessing script successfully.
- Generated `users.csv` from the user IDs appearing in the Higgs network files.
- Generated `follows.csv` from the directed social network file.
- Generated `retweets.csv` from the directed and weighted retweet network file.
- Generated `replies.csv` from the directed and weighted reply network file.
- Generated `mentions.csv` from the directed and weighted mention network file.
- Prepared the processed files so they can be imported into Neo4j using a node-first and relationship-second workflow based on unique identifiers.

### 3. Cypher import scripts created
- Added the `cypher/` folder to store the Cypher scripts used for Neo4j setup and import.
- Created `constraints.cypher` to define the uniqueness constraint on `User.userId`.
- Created `import_nodes.cypher` to import `User` nodes from `users.csv`.
- Created `import_relationships.cypher` to import `FOLLOWS`, `RETWEETS`, `REPLIES_TO`, and `MENTIONS` relationships from the processed CSV files.
- Structured the Cypher files so that nodes are imported before relationships, following the standard Neo4j CSV import workflow.

### 4. Neo4j import executed and first validation completed
- Copied the processed CSV files into the Neo4j import directory.
- Executed `constraints.cypher` in Neo4j.
- Executed `import_nodes.cypher` in Neo4j.
- Executed `import_relationships.cypher` in Neo4j using batched transactions to avoid memory pool errors on large relationship files.
- Validated the imported graph by checking node and relationship counts.
- Tested the first queries in Neo4j Query tab / Browser to verify that the imported graph structure and relationships were accessible.

### 5. Analysis queries defined
- Created `analysis_queries.cypher` in the `cypher/` folder.
- Implemented five analysis queries to support the oral presentation:
  - Most followed users.
  - Most mentioned users in the interaction graph.
  - Strongly interacting user pairs across MENTIONS, REPLIES_TO, and RETWEETS.
  - Most retweeted authors.
  - Ego-network exploration around a specific user.

### 6. Screenshots captured

- Created the `screenshots/` folder in the project root.
- Captured table-view screenshots for:
  - Query 1 – Most followed users (in-degree).
  - Query 2 – Most mentioned users.
  - Query 3 – Strongly interacting user pairs.
  - Query 4 – Most retweeted authors.
- Captured a graph-view screenshot for:
  - Query 5 – Ego-network around a specific user.
- Verified that each screenshot clearly shows both the Cypher query and the corresponding result, so they can be used directly in the oral presentation slides.

---

## Next Planned Steps
- Organize the main findings into a clear structure for the presentation.
- Prepare a short explanation of the graph schema, import workflow, and validation steps.
- Draft the discussion of scalability, distributed querying, availability, and consistency model in Neo4j.
- Refine the repository documentation so the full workflow is easy to reproduce.