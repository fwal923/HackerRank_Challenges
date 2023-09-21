/*
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
