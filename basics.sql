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
Revising Aggregations - Averages
TASK:
Query the average population of all cities in CITY where District is California.
Input: CITY Table (can be found on Hackerrank)
*/

select
avg(population)
from city
where district = 'California'
;

/*
Aggregation - Average Population
TASK:
Query the average population of all cities in CITY rounded down to the nearest integer.
Input: CITY Table (can be found on Hackerrank)
*/

select
floor(avg(population))
from city
;

/*
Aggregation - Japan Population
TASK:
Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
Input: CITY Table (can be found on Hackerrank)
*/

select
sum(population)
from city
where countrycode = 'JPN'
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
