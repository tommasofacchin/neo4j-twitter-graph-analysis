
// Query 1 – Most followed users (in-degree)
MATCH (f:User)-[:FOLLOWS]->(u:User)
WITH u, count(DISTINCT f) AS inDegree
RETURN u.userId AS userId,
       inDegree AS followers
ORDER BY followers DESC
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


// Query 4 – Most retweeted authors
MATCH (retweeter:User)-[:RETWEETS]->(author:User)
RETURN author.userId AS originalAuthor,
       count(*)      AS totalRetweets
ORDER BY totalRetweets DESC
LIMIT 10;


// Query 5 – Ego-network around a given user
MATCH (u:User {userId: "88"})
OPTIONAL MATCH (u)-[r1:FOLLOWS]->(f1:User)
OPTIONAL MATCH (f2:User)-[r2:FOLLOWS]->(u)
RETURN u, f1, f2, r1, r2;

