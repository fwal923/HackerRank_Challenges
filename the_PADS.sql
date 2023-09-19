/*
Task:
Generate the following two result sets:
1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses).
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.

where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name.
If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.

Input Format
The OCCUPATIONS table is described as follows: Name (String), Occupation (String)
Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
*/

/*
goal 1: output list with names and initial of profession
goal 2: count number of people in profession and output as a string
    goal 2 requires an aggregate in a table
- needs strings in column rows for both, and is 2 queries
*/
  -- goal 1
WITH
  profession_sub AS (
  SELECT
    name,
    SUBSTRING(occupation, 1, 1) AS profession_initial
  FROM
    occupations)
SELECT
  CONCAT(o.name, '(', p.profession_initial, ')')
FROM
  occupations o
JOIN
  profession_sub p
ON
  o.name = p.name
ORDER BY
  o.name;
  -- goal 2
WITH
  table_occ_count AS (
  SELECT
    rank () OVER (ORDER BY occupation) AS ranking,
    LOWER(occupation) AS lower_occupation,
    COUNT(occupation) AS occupation_count
  FROM
    occupations
  GROUP BY
    occupation),
  final_string AS (
  SELECT
    DISTINCT toc.lower_occupation AS final_occupation,
    toc.occupation_count AS final_count,
    CONCAT('There are a total of ', toc.occupation_count, ' ', toc.lower_occupation, 's.') AS occupation_string
  FROM
    table_occ_count toc
  JOIN
    occupations o
  ON
    toc.lower_occupation = LOWER(o.occupation) )
SELECT
  occupation_string
FROM
  final_string fs
ORDER BY
  fs.final_count,
  fs.final_occupation
