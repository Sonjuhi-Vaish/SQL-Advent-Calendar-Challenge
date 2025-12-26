-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH ct AS
(
  SELECT subject, score,
  DENSE_RANK() OVER(PARTITION BY subject ORDER BY quiz_date ASC) AS min_rank,
  DENSE_RANK() OVER(PARTITION BY subject ORDER BY quiz_date DESC) AS max_rank
  FROM daily_quiz_scores
)
  SELECT subject, 
  MIN(CASE WHEN min_rank=1 THEN score END )AS min_score,
  MIN(CASE WHEN max_rank=1 THEN score END) AS max_score
  FROM ct
  GROUP BY subject;
