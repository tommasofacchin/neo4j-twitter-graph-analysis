LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
CALL (row) {
  MERGE (u:User {userId: row.userId})
} IN TRANSACTIONS OF 1000 ROWS;