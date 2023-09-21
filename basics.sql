-- all completed in MS SQL server
/*
Revising Aggregations - The Sum Function
TASK:
Query the total population of all cities in CITY where District is California.
Input: CITY Table (can be found on Hackerrank)
*/

select
sum(population)
from city
where district = 'California'
;

/*
African City
TASK
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
Input Format
The CITY and COUNTRY tables are described as follows: (can be found on hackerrank)
*/

SELECT
city.name
FROM
city
JOIN country on city.countrycode = country.code
WHERE
lower(country.continent) LIKE '%africa%' -- this accounts for data entry errors
;
