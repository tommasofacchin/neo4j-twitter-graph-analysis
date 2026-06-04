
// Query 1 – Most connected users by degree
MATCH (u:User)
OPTIONAL MATCH (u)-[:FOLLOWS]->(out:User)
OPTIONAL MATCH (in:User)-[:FOLLOWS]->(u)
WITH u,
     count(DISTINCT out) AS outDegree,
     count(DISTINCT in)  AS inDegree
RETURN u.userId        AS userId,
       inDegree        AS followers,
       outDegree       AS following,
       (inDegree + outDegree) AS totalDegree
ORDER BY totalDegree DESC
LIMIT 10;


// Query 2 – Most mentioned users
MATCH (:User)-[:MENTIONS]->(u:User)
RETURN u.userId AS userId,
       count(*) AS mentions
ORDER BY mentions DESC
LIMIT 10;


// Query 3 – Strongly interacting user pairs
MATCH (u1:User)-[r:MENTIONS|REPLIES_TO|RETWEETS]->(u2:User)
WHERE u1 <> u2
RETURN u1.userId AS sourceUser,
       u2.userId AS targetUser,
       type(r)   AS interactionType,
       count(*)  AS interactions
ORDER BY interactions DESC
LIMIT 20;


// Query 4 – Top retweeters per original author
MATCH (retweeter:User)-[:RETWEETS]->(author:User)
RETURN author.userId    AS originalAuthor,
       retweeter.userId AS retweeter,
       count(*)         AS retweetCount
ORDER BY retweetCount DESC
LIMIT 20;


// Query 5 – Ego-network around a given user
// Replace $userId with a real id for the demo
MATCH (u:User {userId: $userId})
OPTIONAL MATCH (u)-[:FOLLOWS]->(f1:User)
OPTIONAL MATCH (f2:User)-[:FOLLOWS]->(u)
RETURN u.userId  AS centerUser,
       collect(DISTINCT f1.userId) AS following,
       collect(DISTINCT f2.userId) AS followers;