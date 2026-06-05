# Presentation Outline – Neo4j Twitter Graph Analysis

This document defines the slide structure and key talking points for the oral presentation of the Neo4j Twitter graph analysis project.

---

## Slide 1 – Title and Project Positioning

**Title:** Graph-Based Analysis of Twitter Social Networks Using Neo4j

**Bullets:**
- Course project on Neo4j as a graph DBMS.
- Prototype implementation on a subset of Twitter data (Higgs dataset).
- Focus on social network analysis questions about users and interactions.

**Speaker notes:**
Introduce the project as an investigation of Neo4j applied to Twitter social data, with the explicit scope of a prototype on a manageable subset of the dataset. Highlight that the goal is not to rebuild Twitter, but to show how a graph DBMS can model and analyze a social network.

---

## Slide 2 – Why Neo4j for Social Networks

**Title:** Why a Graph DBMS?

**Bullets:**
- Social networks are naturally graphs: users and relationships.
- Many questions are multi-hop traversals (influence, communities, spread).
- Graph queries are often simpler than join-heavy relational queries.

**Speaker notes:**
Explain that Twitter-like data is fundamentally about relationships: follows, mentions, replies, retweets. Emphasize that questions such as “who is influential?”, “who is connected through shared interactions?” or “how does a topic spread?” are more naturally expressed as graph traversals than as combinations of relational joins.

---

## Slide 3 – Graph Schema

**Title:** Graph Schema

**Bullets:**
- `User` nodes with stable `userId` and profile properties.
- Relationships: `FOLLOWS`, `RETWEETS`, `REPLIESTO`, `MENTIONS`.
- Compact model: easy to explain, rich enough for analysis.

**Speaker notes:**
Describe the main node type used in the prototype: `User`, with `userId` as the unique identifier and optional properties such as screen name and other profile information. Explain that the relationships capture both static structure (`FOLLOWS`) and dynamic interactions (`RETWEETS`, `REPLIESTO`, `MENTIONS`). The schema is intentionally minimal so that it can be explained in a couple of minutes while still supporting meaningful graph queries.

---

## Slide 4 – Data Preparation and Import Workflow

**Title:** Data Preparation and Import

**Bullets:**
- Preprocessing of Higgs dataset into normalized CSV files.
- Node-first, relationship-second import with `LOAD CSV`.
- Constraints on `User.userId` for safe and efficient imports.

**Speaker notes:**
Explain that the original Higgs dataset is provided as edge lists and is first converted into normalized CSV files such as `users.csv`, `follows.csv`, `retweets.csv`, `replies.csv`, and `mentions.csv`. Then describe the import pattern in Neo4j: create uniqueness constraints on user identifiers, load all `User` nodes from the CSV, and only afterwards create the relationships using `MATCH` on existing nodes. This makes the import both reliable and easy to reason about.

---

## Slide 5 – Validation of the Imported Graph

**Title:** Validation Steps

**Bullets:**
- Check node and relationship counts after import.
- Run simple queries to verify labels and directions.
- Inspect a small subgraph visually in Neo4j Browser.

**Speaker notes:**
Stress that validation is not optional. Describe how you compared the counts of users and relationships in Neo4j with the expected sizes from the CSV files. Mention that you ran simple `MATCH` queries for each label and relationship type to confirm they were correctly created. Finally, mention that you visually inspected a sample of the graph in Neo4j Browser to verify directions and labels.

---

## Slide 6 – Finding 1: Most Visible Users

**Title:** Finding 1 – Centrality and Visibility

**Bullets:**
- Query for most followed users (in-degree).
- Query for most mentioned users in interactions.
- Interpretation: structural centrality and conversational visibility.

**Speaker notes:**
Show the screenshots for the “most followed” and “most mentioned” queries. Explain that these two metrics provide complementary views of importance: one based on the follower network, the other on conversational activity. Emphasize that the graph model makes it easy to compute these rankings through relationship counts and that a small subset of users emerges as especially central or visible.

---

## Slide 7 – Finding 2: Strong Interaction Patterns

**Title:** Finding 2 – Strong Interaction Pairs

**Bullets:**
- Query for pairs of users with repeated interactions.
- Combine mentions, replies, and retweets.
- Interpretation: localized patterns of strong engagement.

**Speaker notes:**
Use the screenshot of the query that finds strongly interacting user pairs. Explain that here the goal is not just to find popular users, but pairs that interact with each other multiple times across different relationship types. This highlights more intense social ties and shows the advantage of graph queries when exploring multi-step and multi-type relationships.

---

## Slide 8 – Finding 3: Ego-Network Exploration

**Title:** Finding 3 – Ego-Network Around a User

**Bullets:**
- Ego-network query around a selected user.
- Visualization of local neighborhood in Neo4j Browser.
- Intuitive view of local structure and connections.

**Speaker notes:**
Show the graph-view screenshot for the ego-network. Explain that this is a qualitative complement to tabular results: it gives an immediate sense of who is connected to the user, which neighbors are central, and how interactions cluster locally. Emphasize that this type of interactive exploration illustrates why a graph DBMS is useful for social network analysis.

---

## Slide 9 – Neo4j Architecture (High-Level)

**Title:** Neo4j Architecture – Key Points

**Bullets:**
- Prototype runs on a single Neo4j instance.
- Same model can scale using clustering and replicas.
- Focus on causal clustering, availability, and consistency.

**Speaker notes:**
Clarify that although the implementation is local and uses a subset of the data, the same graph model is compatible with larger deployments using Neo4j clustering. Briefly mention that in a cluster, writes are coordinated by core servers, replicas help scale reads, and Neo4j uses causal clustering to offer read-your-write consistency via bookmarks. This satisfies the requirement to discuss scalability, distributed queries, availability, and consistency at a conceptual level.
