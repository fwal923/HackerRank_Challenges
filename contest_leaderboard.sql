/*
Task:
You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges.
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score.
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id.
Exclude all hackers with a total score of 0 from your result.

The following tables contain contest data:

Hackers: The hacker_id (integer) is the id of the hacker, and name (string) is the name of the hacker. 

Submissions (all integers): The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission,
challenge_id is the id of the challenge for which the submission belongs to, and score is the score of the submission. 
*/

/*
goal: output hacker_id, name, total score of hacker (with conditions)

double aggregate: total score of hacker, is maximum score for all of the challenges
        needs condition that only selects the highest score for each challenge
        table should be: hacker_id, challenge_id, max(score)
condition: exclude hackers with score of 0

order by: total score of hacker desc, hacker_id asc
*/

-- building top to bottom:
-- step 1: table of hackers with only max scores for each challenge
WITH table_max_score as
(SELECT
hacker_id,
challenge_id,
max(score) as max_score
FROM submissions
GROUP BY hacker_id, challenge_id)

-- step 2: table with aggregate (sum) of max scores via join onto temp table
SELECT
h.hacker_id,
h.name,
sum(tms.max_score) as total_score
FROM
hackers h
JOIN table_max_score tms ON h.hacker_id = tms.hacker_id
GROUP BY
h.hacker_id, h.name
HAVING sum(tms.max_score) > 0
ORDER BY
total_score desc, h.hacker_id
