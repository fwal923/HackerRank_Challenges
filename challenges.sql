/*
Task:
Julia asked her students to create some coding challenges.
Write a query to print the hacker_id, name, and the total number of challenges created by each student.
Sort your results by the total number of challenges in descending order.
If more than one student created the same number of challenges, then sort the result by hacker_id.
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

The following tables contain challenge data:
Hackers: The hacker_id (integer) is the id of the hacker, and name (string) is the name of the hacker.
Challenges: The challenge_id (integer) is the id of the challenge, and hacker_id (integer) is the id of the student who created the challenge.
*/

/*
goal: query returning hacker_id, name, total number of challenges created (aggregate)

order by: total number of challenges (desc), hacker_id

conditions: if more than 1 student with same number
            then
                count is less than maximum count number of challenges
                    then
                        exclude students
    conditions mean that there needs to be one table that:
        counts the number of challenges per student and
        counts the number of students per challenge counts
        so in the final table a where statement can be added to conclude the if-statement

*/

  -- built from top to bottom
  -- this task is quite complicated because of the different countings that are needed
  -- step 1: make temp table of hacker_id, name, and count of challenges per hacker
WITH
  table_number_challenges AS (
  SELECT
    h.hacker_id,
    h.name,
    COUNT(c.challenge_id) AS total_challenges
  FROM
    hackers h
  JOIN
    challenges c
  ON
    h.hacker_id = c.hacker_id
  GROUP BY
    h.hacker_id,
    h.name ),
  -- step 2: make temp table for the number of students for each total_challenge count (determined in table above)
  -- in the final query this will enable excluding counts of challenges where there is more than one student per challenge_count
  table_challenge_count AS (
  SELECT
    total_challenges,
    count (total_challenges) AS challenge_count
  FROM
    table_number_challenges
  GROUP BY
    total_challenges)
  -- step 3: make final query where first temp table is used to select columns and second temp table for the if-statements
SELECT
  tnc.hacker_id,
  tnc.name,
  tnc.total_challenges
  --tcc.challenge_count
FROM
  table_number_challenges tnc
JOIN
  table_challenge_count tcc
ON
  tnc.total_challenges = tcc.total_challenges
WHERE
  tcc.challenge_count <= 1
  OR tnc.total_challenges = (
  SELECT
    MAX(total_challenges)
  FROM
    table_number_challenges)
ORDER BY
  tnc.total_challenges DESC,
  hacker_id
