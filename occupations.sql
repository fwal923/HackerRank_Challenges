/*
Task:
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation.
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.

Input Format
The OCCUPATIONS table is described as follows: Columns: Name, Occupation. Both of String type.
Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

Explanation for result:
The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.
*/


-- OPTION 1: subquery in from clause:

select
Doctor, Professor, Singer, Actor
from
(
    select
    row_number() over (partition by Occupation order by Name) as rn, -- row number needs to be added to allow a string pivot as the aggregate used is "max"/ this enables the "max" for each row number rather than the overall max of the string column
    Name,
    Occupation
    from occupations
) as p

pivot (max(Name) for Occupation in ([Doctor], [Professor], [Singer], [Actor])) as pvt -- aggregation of string requires additional column in CTE
order by rn

-- OPTION 2: CTE

WITH p as
(
    select
    row_number() over (partition by Occupation order by Name) as rn,
    Name,
    Occupation
    from occupations
)

select
Doctor, Professor, Singer, Actor
from p

pivot (max(Name) for Occupation in ([Doctor], [Professor], [Singer], [Actor])) as pvt -- aggregation of string requires additional column in CTE
order by rn
