# neo4j-twitter-graph-analysis

## Project Title
**Graph-Based Analysis of Twitter Social Networks Using Neo4j**

## Purpose of the Project
This project is designed to satisfy the course requirement of investigating one of the proposed DBMSs and using it to solve one or more problems on a selected dataset. The chosen DBMS is Neo4j, and the selected application domain is Twitter social network analysis, which is a natural fit for graph-based modeling because users, tweets, hashtags, and interactions can be represented as nodes and relationships rather than as tables joined through foreign keys.

The project should not be approached as a generic software demo. It should be structured as a course project that demonstrates understanding of both the **DBMS itself** and the **practical use of that DBMS** on a realistic dataset. The oral discussion will evaluate technical implementation and the ability to explain import, scalability, distributed querying, availability, and consistency model choices.

## What the Course Requires
According to the assignment, the project must include two elements:
- an investigation of one DBMS among the proposed systems;
- the use of that DBMS to solve one or more problems on one of the proposed datasets.

The presentation during the oral can take one of three forms depending on complexity:
- a feasibility study;
- a prototype implementation on a subset of the available data;
- a prototype able to work on the full dataset.

For every choice of problem, dataset, and DBMS, the oral must discuss at least:
- data import;
- scalability;
- distributed queries;
- availability;
- consistency model.

For this project, the best positioning is: **prototype implementation on a subset of the available data, with discussion of how the same design could scale to larger data volumes**. This is both realistic and fully aligned with the assignment structure.

## Why Neo4j Is a Good Choice
Neo4j is a graph DBMS, so it is especially suitable for social networks, where the most meaningful information is often found in relationships such as follows, mentions, replies, retweets, and shared hashtags. In a Twitter-like dataset, many useful questions are naturally multi-hop graph traversals, such as identifying influential users, finding communities, detecting common interests, or exploring how a topic connects different groups.

This makes Neo4j a defensible and strong choice for the oral because the project can show both:
- conceptual alignment between the domain and the DBMS model;
- practical benefits of graph queries over more cumbersome join-heavy relational approaches.

## Project Goal
The goal of the project is to build a Neo4j-based prototype capable of importing Twitter social data and answering graph-analysis questions such as:
- Which users are the most central or most mentioned in the network?
- Which hashtags are the most common or the most socially widespread?
- Which users are connected by shared topics or interaction patterns?
- Which sub-communities emerge from the network structure?
- How can the data model support exploratory social network analysis?

The final result should be a reproducible project with:
- a clear graph schema;
- cleaned and structured input files;
- import scripts or Cypher commands;
- a set of analysis queries;
- a discussion of Neo4j architectural characteristics relevant to the course.

## Recommended Scope
A very important success factor is scope control. The project should not try to replicate the full Twitter platform, full tweet ingestion pipelines, or real-time streaming analytics. A university project is stronger when it is technically focused and clearly argued.

A good scope is the following:
- use a manageable subset of Twitter data, not the entire social network;
- model users, tweets, hashtags, and a selected set of interactions;
- implement a complete import and query workflow;
- discuss scalability and distribution at the Neo4j architecture level, even if the prototype itself runs on a single local instance.

This keeps the project feasible while still giving enough material for a strong oral discussion.

## Suggested Dataset Strategy
There are two practical dataset strategies.

### Option A: Use an Existing Neo4j Twitter Example
Neo4j provides a public Twitter graph example that includes a ready-made social network model and example queries, making it a very strong starting point for a course prototype. This is the safest option if the goal is to maximize reliability and reduce the risk of spending too much time on data collection.

Advantages:
- the model is already aligned with Neo4j concepts;
- it is easy to demonstrate queries and graph exploration;
- it provides concrete inspiration for the data structure and analysis tasks.

### Option B: Build a Custom Dataset Subset
Another option is to gather a smaller public dataset or manually prepare CSV files containing users, tweets, hashtags, and interactions. This gives more ownership over the data preparation phase, which can be helpful during the oral when discussing import and preprocessing choices.

Advantages:
- stronger evidence of independent implementation;
- more control over which entities and relations are included;
- easier to explain the full data-cleaning pipeline.

For this course project, **Option B is excellent if enough time is available**, while **Option A is the safest path if time is limited**.

## Recommended Graph Model
A clean graph schema is one of the most important parts of the project. The model should remain simple enough to explain in two minutes, but rich enough to support meaningful queries.

### Core Node Types
| Node label | Meaning | Recommended properties |
|---|---|---|
| `User` | A Twitter user | `userId`, `screenName`, `name`, `followersCount` |
| `Tweet` | A tweet/post | `tweetId`, `text`, `createdAt`, `lang`, `retweetCount`, `likeCount` |
| `Hashtag` | A hashtag/topic | `name` |

### Core Relationship Types
| Relationship | From | To | Meaning |
|---|---|---|---|
| `POSTED` | `User` | `Tweet` | A user published a tweet |
| `MENTIONS` | `Tweet` | `User` | A tweet mentions a user |
| `TAGS` | `Tweet` | `Hashtag` | A tweet contains a hashtag |
| `REPLIES_TO` | `Tweet` | `Tweet` | One tweet replies to another |
| `RETWEETS` | `Tweet` | `Tweet` | One tweet retweets another |
| `FOLLOWS` | `User` | `User` | A user follows another user |

You do not need all relationship types for the first prototype. A very strong minimal version uses only `POSTED`, `MENTIONS`, and `TAGS`, because those already allow non-trivial traversal queries.

## Minimal Viable Project vs Stronger Version
The project can be built in two levels.

### Minimal Viable Version
- `User`, `Tweet`, `Hashtag` nodes;
- `POSTED`, `MENTIONS`, `TAGS` relationships;
- CSV import;
- 4 to 5 Cypher analysis queries;
- screenshots from Neo4j Browser.

### Stronger Version
- add `REPLIES_TO` and `FOLLOWS`;
- include one visual exploration section;
- compare alternative schema choices;
- discuss how clustering would support larger deployments;
- optionally include query profiling or basic performance observations.

The stronger version is ideal if aiming for the upper grade range because it better supports a detailed discussion of Neo4j features and design choices.

## Problems the Project Should Solve
The assignment requires solving one or more problems using the chosen DBMS. The project should therefore define explicit analytical questions rather than only loading data and browsing the graph visually.

Recommended project problems:
1. Identify the most influential or most visible users in the network through mention frequency or interaction degree.
2. Identify the most widely used hashtags and the hashtags that connect many different users.
3. Discover topic-based or interaction-based communities in the network.
4. Find users who are linked through common interests, shared hashtags, or repeated interaction patterns.
5. Explore how a conversation or topic spreads through tweets and user interactions.

These questions are valuable because they naturally exploit graph traversal and relationship-centric modeling.

## Project Architecture
A good project structure should separate the workflow into clear phases.

### Phase 1: Study Neo4j
Before implementing anything, prepare a compact DBMS study section that covers:
- graph model and property graph concepts;
- nodes, relationships, labels, and properties;
- Cypher query language;
- basic indexing and constraints;
- Neo4j deployment modes relevant to the assignment.

### Phase 2: Prepare the Dataset
The data must be transformed into a format suitable for graph import. This often means building normalized CSV files for nodes and relationships separately.

### Phase 3: Import the Data
The graph should be loaded into Neo4j using CSV-based import. A common and recommended approach is to create nodes first and relationships after that, so edges can be created by matching existing identifiers.

### Phase 4: Query and Analyze
Run Cypher queries that answer the selected project questions and capture outputs for the presentation.

### Phase 5: Discuss System Properties
Prepare an oral explanation of import, scalability, distributed queries, availability, and consistency model in Neo4j.

## Folder Structure Recommendation
A practical folder organization could be the following:

```text
project/
├── README.md
├── data/
│   ├── raw/
│   └── processed/
├── cypher/
│   ├── constraints.cypher
│   ├── import_nodes.cypher
│   ├── import_relationships.cypher
│   └── analysis_queries.cypher
├── notebooks/
│   └── preprocessing.ipynb
├── slides/
│   └── presentation.pptx
└── screenshots/
```

This structure makes the work easier to explain and keeps the oral presentation organized.

## Step-by-Step Execution Plan

## Step 1: Define the Exact Scope
The first concrete task is to write a short scope statement. This should answer:
- Which Twitter entities will be modeled?
- Which relationships will be included?
- Which analysis questions will be answered?
- Is the project a feasibility study or a prototype?

Recommended scope statement:

> This project implements a Neo4j prototype for graph-based analysis of Twitter social network data. The prototype models users, tweets, and hashtags, imports data from CSV files, and answers social network analysis questions regarding influence, common topics, and user connectivity.

This statement should appear almost unchanged in the presentation introduction.

## Step 2: Choose the Data Source
Choose one of the following and commit early:
- Neo4j Twitter Graph Example dump or model inspiration.
- Public Twitter-like CSV dataset.
- Self-prepared CSV subset from a public source.

Selection criteria:
- clean identifiers available;
- easy conversion to CSV;
- enough relational richness for graph analysis;
- feasible within project time.

If there is any uncertainty, use the Neo4j example as the baseline reference because it is directly aligned with the project topic.

## Step 3: Design the Graph Schema
Before loading any data, define the schema in one diagram or table. At minimum, specify:
- node labels;
- properties for each node;
- relationship types;
- relationship directions;
- unique identifiers.

The key design rule is to give each entity a stable identifier. Neo4j imports become easier and safer when relationships are created using unique IDs rather than ambiguous names.

Recommended unique keys:
- `User.userId`
- `Tweet.tweetId`
- `Hashtag.name`

## Step 4: Prepare the CSV Files
Neo4j CSV import is easier when nodes and relationships are separated. Prepare files such as:

```text
users.csv
tweets.csv
hashtags.csv
posted.csv
mentions.csv
tags.csv
```

Suggested columns:

### `users.csv`
| Column | Meaning |
|---|---|
| `userId` | Unique user identifier |
| `screenName` | Public handle |
| `name` | Display name |
| `followersCount` | Optional profile metric |

### `tweets.csv`
| Column | Meaning |
|---|---|
| `tweetId` | Unique tweet identifier |
| `text` | Tweet text |
| `createdAt` | Timestamp |
| `lang` | Language code |
| `retweetCount` | Optional metric |
| `likeCount` | Optional metric |

### `hashtags.csv`
| Column | Meaning |
|---|---|
| `name` | Hashtag name |

### `posted.csv`
| Column | Meaning |
|---|---|
| `userId` | Source user |
| `tweetId` | Target tweet |

### `mentions.csv`
| Column | Meaning |
|---|---|
| `tweetId` | Source tweet |
| `userId` | Mentioned user |

### `tags.csv`
| Column | Meaning |
|---|---|
| `tweetId` | Source tweet |
| `hashtagName` | Tagged hashtag |

Important preprocessing tasks:
- remove duplicates;
- normalize hashtag text;
- ensure no missing unique IDs;
- clean malformed rows;
- keep the schema consistent across all files.

## Step 5: Create Constraints and Indexes
This is a required quality step, not an optional optimization. Constraints improve data integrity and make it easier to explain the robustness of the import design.

Example Cypher:

```cypher
CREATE CONSTRAINT user_id IF NOT EXISTS
FOR (u:User) REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT tweet_id IF NOT EXISTS
FOR (t:Tweet) REQUIRE t.tweetId IS UNIQUE;

CREATE CONSTRAINT hashtag_name IF NOT EXISTS
FOR (h:Hashtag) REQUIRE h.name IS UNIQUE;
```

Why this matters:
- prevents duplicates;
- supports `MERGE` operations during import;
- improves lookup efficiency for relationship creation.

## Step 6: Import Nodes First
A widely recommended pattern with `LOAD CSV` is to import nodes before relationships. This is essential because relationship creation usually depends on matching already-created nodes by their unique identifiers.

Example:

```cypher
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
MERGE (u:User {userId: row.userId})
SET u.screenName = row.screenName,
    u.name = row.name,
    u.followersCount = toInteger(row.followersCount);
```

```cypher
LOAD CSV WITH HEADERS FROM 'file:///tweets.csv' AS row
MERGE (t:Tweet {tweetId: row.tweetId})
SET t.text = row.text,
    t.createdAt = row.createdAt,
    t.lang = row.lang,
    t.retweetCount = toInteger(row.retweetCount),
    t.likeCount = toInteger(row.likeCount);
```

```cypher
LOAD CSV WITH HEADERS FROM 'file:///hashtags.csv' AS row
MERGE (h:Hashtag {name: row.name});
```

## Step 7: Import Relationships After Nodes
Once nodes exist, relationships can be created by matching source and target entities.

Example:

```cypher
LOAD CSV WITH HEADERS FROM 'file:///posted.csv' AS row
MATCH (u:User {userId: row.userId})
MATCH (t:Tweet {tweetId: row.tweetId})
MERGE (u)-[:POSTED]->(t);
```

```cypher
LOAD CSV WITH HEADERS FROM 'file:///mentions.csv' AS row
MATCH (t:Tweet {tweetId: row.tweetId})
MATCH (u:User {userId: row.userId})
MERGE (t)-[:MENTIONS]->(u);
```

```cypher
LOAD CSV WITH HEADERS FROM 'file:///tags.csv' AS row
MATCH (t:Tweet {tweetId: row.tweetId})
MATCH (h:Hashtag {name: row.hashtagName})
MERGE (t)-[:TAGS]->(h);
```

This step is where the graph structure truly emerges. It is also one of the easiest points to discuss during the oral because it demonstrates how graph import differs from row-based table loading.

## Step 8: Validate the Imported Graph
Do not move directly from import to analysis. First verify that the graph is structurally correct.

Useful checks:

```cypher
MATCH (u:User) RETURN count(u);
MATCH (t:Tweet) RETURN count(t);
MATCH (h:Hashtag) RETURN count(h);
MATCH ()-[r:POSTED]->() RETURN count(r);
MATCH ()-[r:MENTIONS]->() RETURN count(r);
MATCH ()-[r:TAGS]->() RETURN count(r);
```

Also inspect a sample subgraph visually in Neo4j Browser to ensure directions and labels are correct.

## Step 9: Implement the Analysis Queries
This is the heart of the project. Prepare a small but well-justified set of queries.

### Query 1: Most Mentioned Users
```cypher
MATCH (t:Tweet)-[:MENTIONS]->(u:User)
RETURN u.screenName AS user, count(*) AS mentions
ORDER BY mentions DESC
LIMIT 10;
```
This query helps identify users with high visibility in the conversation graph.

### Query 2: Most Common Hashtags
```cypher
MATCH (:Tweet)-[:TAGS]->(h:Hashtag)
RETURN h.name AS hashtag, count(*) AS frequency
ORDER BY frequency DESC
LIMIT 10;
```
This query reveals the dominant discussion topics in the dataset.

### Query 3: Users Connected by Shared Hashtags
```cypher
MATCH (u1:User)-[:POSTED]->(:Tweet)-[:TAGS]->(h:Hashtag)<-[:TAGS]-(:Tweet)<-[:POSTED]-(u2:User)
WHERE u1 <> u2
RETURN u1.screenName AS user1, u2.screenName AS user2, count(DISTINCT h) AS commonTopics
ORDER BY commonTopics DESC
LIMIT 10;
```
This demonstrates a multi-hop traversal that is much more graph-native than a relational join-heavy equivalent.

### Query 4: Hashtags Used by Many Distinct Users
```cypher
MATCH (u:User)-[:POSTED]->(:Tweet)-[:TAGS]->(h:Hashtag)
RETURN h.name AS hashtag, count(DISTINCT u) AS distinctUsers
ORDER BY distinctUsers DESC
LIMIT 10;
```
This is useful for identifying broad cross-user topics rather than hashtags repeated by only a few active users.

### Query 5: Mentions Around a Specific User
```cypher
MATCH (u:User {screenName: $screenName})<-[r:MENTIONS]-(t:Tweet)-[:TAGS]->(h:Hashtag)
RETURN h.name AS hashtag, count(*) AS frequency
ORDER BY frequency DESC;
```
The Neo4j Twitter example includes similar patterns and can be used as inspiration for focused exploration queries.

## Step 10: Prepare the DBMS Discussion for the Oral
Even if the implementation is local and small, the oral must cover architectural points from the assignment.

### Data Import
Neo4j supports several import approaches, including `LOAD CSV`, Data Importer, and administrative bulk loading workflows. For a course prototype, `LOAD CSV` is usually the most suitable because it is flexible, easy to explain, and directly expresses the mapping from CSV rows to graph entities.

### Scalability
Neo4j can scale read workloads using clustered deployments with replicas, while the logical graph model remains the same. In the project discussion, it is enough to explain that the prototype was tested on a subset, but the same graph model could be scaled by moving to clustered deployment and separating read-heavy analytics from write coordination.

### Distributed Queries
Neo4j is not typically presented like a distributed SQL analytics engine such as Spark or Hive. Instead, its distributed story is centered on clustered architecture, routing, and replication rather than classic shared-nothing MPP query execution. This distinction is important and should be stated clearly in the oral.

### Availability
Neo4j causal clustering is designed for fault-tolerant transaction processing through core servers, which are intended to keep the system operational under failures as long as quorum conditions are satisfied. This is the main point to present when discussing availability.

### Consistency Model
Neo4j uses causal clustering and supports read-your-write consistency via bookmarks, which is a more precise and technically correct statement than simply calling it eventual consistency. This is a high-value concept for the oral because it shows deeper understanding of the DBMS architecture.

## How to Explain Neo4j Causal Clustering
A concise oral explanation can be structured like this:
- writes are handled by the leader node in the cluster;
- replicas help scale reads and improve resilience;
- bookmarks allow clients to preserve read-your-write behavior;
- because the system tracks causal order, Neo4j refers to this approach as causal clustering.

This short explanation is enough for a course oral unless the professor asks for more detail.

## Feasibility vs Prototype vs Full Dataset
The project should explicitly position itself in one of the assignment categories.

Recommended wording:
- **Primary claim**: this is a prototype implementation on a subset of the available data.
- **Secondary claim**: the design is extensible to larger datasets through the same graph model and a more scalable Neo4j deployment strategy.

This is a balanced position because it avoids overclaiming while still addressing scalability seriously.

## What to Show During the Oral
A strong oral presentation should include:
- the project objective;
- the reason for choosing Neo4j;
- the graph data model;
- the data import process;
- examples of imported nodes and relationships;
- 4 to 5 meaningful Cypher queries;
- screenshots of graph exploration or tabular results;
- a short architectural discussion on scalability, availability, and consistency.

A very effective presentation sequence is:
1. problem statement;
2. why graph DBMS;
3. schema;
4. dataset preparation;
5. import;
6. query results;
7. DBMS characteristics;
8. limits and future work.

## Limits to Acknowledge
Acknowledging limits improves credibility. Good limitations to mention:
- the prototype may use only a subset of Twitter data;
- follower relationships may be incomplete or absent depending on the dataset;
- the analysis is exploratory and not a full production social analytics platform;
- advanced graph algorithms may be left as future work if the core project already satisfies the assignment.

These are reasonable limits and do not weaken the project if the implementation is solid.

## Possible Extensions
If extra time is available, the following extensions can strengthen the project:
- add `FOLLOWS` relationships for a richer social graph;
- add `REPLIES_TO` and `RETWEETS` for conversation analysis;
- compare two alternative schemas;
- use Neo4j Bloom or Browser visualizations in the presentation;
- add a small preprocessing script in Python to make the workflow reproducible.

## Common Mistakes to Avoid
- choosing too large a dataset and never finishing the import;
- skipping data cleaning and then creating duplicate nodes;
- using names instead of stable identifiers when unique IDs are available;
- loading relationships before nodes;
- presenting only screenshots with no clear analytical problem;
- discussing scalability in vague terms without connecting it to Neo4j clustering.

## Suggested Timeline
A realistic timeline for the project is:

| Week | Tasks |
|---|---|
| Week 1 | Study Neo4j basics, choose dataset, define scope and schema |
| Week 2 | Prepare CSV files, clean data, define constraints |
| Week 3 | Import nodes and relationships, validate graph |
| Week 4 | Write analysis queries, collect screenshots and results |
| Week 5 | Prepare scalability/consistency discussion and oral slides |

This schedule is compact but feasible for a university project.

## Deliverables Checklist
Before considering the project complete, verify that all of the following are ready:

- [ ] README with project description and steps
- [ ] clear graph schema diagram or table
- [ ] processed CSV files
- [ ] Cypher script for constraints
- [ ] Cypher scripts for node import
- [ ] Cypher scripts for relationship import
- [ ] Cypher file with analysis queries
- [ ] screenshots of graph structure and query results
- [ ] presentation slides for the oral
- [ ] short section on scalability, distributed queries, availability, and consistency model

## Final Recommended Narrative
The project should be narrated as follows:

> The project investigates Neo4j as a graph DBMS and applies it to Twitter social network analysis. The implementation models users, tweets, and hashtags as a property graph, imports data from CSV files into Neo4j, and answers social-network-oriented analytical questions through Cypher queries. The prototype is implemented on a subset of the data, while the discussion explains how Neo4j clustering, replication, and causal consistency would support larger and more available deployments.

This narrative is technically coherent, aligned with the course requirements, and easy to defend during the oral.
