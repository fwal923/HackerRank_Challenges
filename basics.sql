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

/*
Population Census
TASK
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

select
sum(city.population)
from
city
join country on city.countrycode = country.code
where continent = 'Asia'
;

/*
Average Population of Each Continent
TASK
Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
*/

select
country.continent as continent,
floor(avg(city.population)) as average_city_pop
from
city
join country on city.countrycode = country.code
group by continent
;

/*
Weather Observation Station 16
TASK
Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.
(screenshot etc on hackerrrank)
*/

-- approach: hackerrank is not happy with the rounding unless you actually only display the 4 decimal places (the rounding itself results in 8 decimal places still)
-- so a temp table is needed to allow the number to be converted into varchar and display the "substring" of up to 4 decimal places

with temp as
(select top 1
(round(min(lat_n), 4)) as smallest_n_lat
from
station
where lat_n > 38.7780)

select
substring(cast(smallest_n_lat as varchar), 1, 7)
from temp
;
