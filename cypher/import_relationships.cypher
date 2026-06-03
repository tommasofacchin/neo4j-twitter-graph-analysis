LOAD CSV WITH HEADERS FROM 'file:///follows.csv' AS row
MATCH (u1:User {userId: row.sourceId})
MATCH (u2:User {userId: row.targetId})
MERGE (u1)-[:FOLLOWS]->(u2);

LOAD CSV WITH HEADERS FROM 'file:///retweets.csv' AS row
MATCH (u1:User {userId: row.sourceId})
MATCH (u2:User {userId: row.targetId})
MERGE (u1)-[r:RETWEETS]->(u2)
ON CREATE SET r.weight = toInteger(row.weight)
ON MATCH SET r.weight = toInteger(row.weight);

LOAD CSV WITH HEADERS FROM 'file:///replies.csv' AS row
MATCH (u1:User {userId: row.sourceId})
MATCH (u2:User {userId: row.targetId})
MERGE (u1)-[r:REPLIES_TO]->(u2)
ON CREATE SET r.weight = toInteger(row.weight)
ON MATCH SET r.weight = toInteger(row.weight);

LOAD CSV WITH HEADERS FROM 'file:///mentions.csv' AS row
MATCH (u1:User {userId: row.sourceId})
MATCH (u2:User {userId: row.targetId})
MERGE (u1)-[r:MENTIONS]->(u2)
ON CREATE SET r.weight = toInteger(row.weight)
ON MATCH SET r.weight = toInteger(row.weight);