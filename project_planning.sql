/*
Task:
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date.
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
Table Projects: Task_ID (Integer), Start_Date (Date), End_Date (Date)
If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order.
If there is more than one project that have the same number of completion days, then order by the start date of the project.
*/

/*
goal: output start_date and end_date of each project
order by:
1. number of days to completion for each project
2. start_date of project

to find real start dates:
if start date is not in the end date column then this is a real start date
if start date is in the end date column then its not an end date
- make CTE table for first statement to get a list of the real_start_dates in order

to find real end dates:
if the end date is not in start date then its the real end date
if the end date is in start date this is a consecutive date
- make CTE table for first statement to get a list of the real_end_dates in order

combining:
CTE table for each, real_start_date and real_end_date, cross join
this generates a cartesian table (i.e. start_date*end_date results)
add rank in each CTE & include in where clause of concluding select statement to match the correct start_date with correct end_date

*/

WITH real_start_date AS (
  SELECT
    start_date,
    RANK() OVER (ORDER BY start_date) AS start_rank
  FROM
    projects
  WHERE
    start_date NOT IN (
    SELECT
      end_date
    FROM
      projects)),

real_end_date AS (
  SELECT
    end_date,
    RANK() OVER (ORDER BY end_date) AS end_rank
  FROM
    projects
  WHERE
    end_date NOT IN (
    SELECT
      start_date
    FROM
      projects))

SELECT
  start_date,
  end_date
FROM
  real_start_date, real_end_date
WHERE
  start_rank = end_rank
ORDER BY
  datediff(day, start_date, end_date), start_date
