-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with ct1 AS
  (
SELECT DATE(sent_at) AS date,user_id,user_name,
COUNT(sender_id) AS msgs_sent
FROM npn_users AS u JOIN
npn_messages AS m
ON u.user_id =m.sender_id
GROUP BY date,user_id, user_name
), ct2 AS
(
  SELECT user_id,user_name,date,
  DENSE_RANK() OVER(PARTITION BY date ORDER BY msgs_sent DESC) AS rnk
  FROM ct1
)
SELECT * FROM ct2
WHERE rnk=1
ORDER BY date;
