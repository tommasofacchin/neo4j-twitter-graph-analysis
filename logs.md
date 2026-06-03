# Project Updates

This file tracks the implementation progress of the project **Graph-Based Analysis of Twitter Social Networks Using Neo4j**.

## Current Status

### Implemented so far
- `data/raw/`
- `data/processed/`: Neo4j-ready CSV files generated
- `scripts/`
- `cypher/`: Cypher scripts created for constraints and data import


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

## Next Planned Steps
- Copy the processed CSV files into the Neo4j import directory.
- Execute `constraints.cypher` in Neo4j.
- Execute `import_nodes.cypher` in Neo4j.
- Execute `import_relationships.cypher` in Neo4j.
- Validate the imported graph by checking node and relationship counts.
- Test the first queries in Neo4j Browser.
- Define the first analysis queries for the oral presentation.
