
0 SELECT BASICS

TABLE WORLD:

name	      continent	area 	     population	   gdp
Afghanistan	Asia	    652230	   25500100	     20343000000
Albania	    Europe	  28748 	   2831741 	     12960000000
Algeria	    Africa	  2381741 	 37100000 	   188681000000
Andorra	    Europe	  468	       78115         3712000000
Angola	    Africa	  1246700 	 20609294 	   100990000000

1.) Show the population of Germany:

SELECT population
FROM   world
WHERE  name = 'Germany';

2.) Show the name and per capita gdp: gdp/population for each country where the area is over 5,000,000 km2

SELECT name, (gdp/population)
FROM world
WHERE area > 5000000;

3.) Show the name and continent where the area is less than 2000 and the gdp is more than 5000000000

SELECT name , continent
FROM world
WHERE area < 2000
AND gdp > 5000000000;

4.) Show the name and the population for 'Denmark', 'Finland', 'Norway', 'Sweden' 

SELECT name, population 
FROM world
WHERE name IN ('Denmark', 'Finland', 'Norway', 'Sweden');

5.) Show each country that begins with G

SELECT name 
FROM world
WHERE name LIKE 'G%';


1 SELECT name

TABLE WORLD:

names
name	      continent
Afghanistan	Asia
Albania	    Europe
Algeria	    Africa
Andorra	    Europe
Angola	    Africa

1.) Find the country that start with Y

SELECT name 
FROM world
WHERE name LIKE 'Y%';

2.) Find the countries that end with y

SELECT name 
FROM world
WHERE name LIKE '%y';

3.) Find the countries that contain the letter x

SELECT name 
FROM world
WHERE name LIKE '%x%';

4.) Find the countries that end with land

SELECT name 
FROM world
WHERE name LIKE '%land';

5.) Find the countries that start with C and end with ia

SELECT name 
FROM world
WHERE name LIKE 'C%' 
AND name like '%ia';

6.) Find the country that has oo in the name

SELECT name 
FROM world
WHERE name LIKE '%oo%';

7.) Find the countries that have three or more a in the name



8.) Find the countries that have "t" as the second character.

SELECT name 
FROM world
WHERE name LIKE '_t%';


9.) Find the countries that have two "o" characters separated by two others.

SELECT name 
FROM world
WHERE name LIKE '%o__o%';

10.) Find the countries that have exactly four characters.

SELECT name 
FROM world
WHERE name REGEXP '^.{4}$';

11.) Find the country where the name is the capital city.

SELECT name
FROM world
WHERE name = capital;

12.) Find the country where the capital is the country plus "City".

SELECT name
FROM   world
WHERE  capital = concat(name, ' City');

13.) Find the capital and the name where the capital includes the name of the country.






2 SELECT from world



2.) Show the name for the countries that have a population of at least 200 million.

SELECT name 
FROM world
WHERE population > 200000000;

3.) Give the name and the per capita GDP for those countries with a population of at least 200 million. 

SELECT name, (gdp/population)
from world
WHERE population > 200000000;

4.) Show the name and population in millions for the countries of the continent 'South America'

SELECT name, (population/1000000)
from world
WHERE continent = 'South America'; 

5.) Show the name and population for France, Germany, Italy 

SELECT name, population
from world
WHERE name IN ('France', 'Germany', 'Italy');

6.) Show the countries which have a name that includes the word 'United' 

SELECT name
from world
WHERE name LIKE ('%United%');

7.) Show the countries that are big by area or big by population. Show name, population and area.

SELECT name, population, area
from world
WHERE area > 3000000 OR population > 250000000;

8.) Show the countries that are big by area or big by population but not both. Show name, population and area.

SELECT name, population, area
from world
WHERE (area > 3000000 AND population < 250000000) OR (area < 3000000 AND population > 250000000);

9.) For South America show population in millions and GDP in billions to 2 decimal places.

SELECT name, ROUND(population/1000000,2), ROUND(GDP/1000000000,2)
FROM world
WHERE continent = 'South America';

10.) Show per-capita GDP for the trillion dollar countries to the nearest $1000.

SELECT name, ROUND(GDP/population,-3)
FROM world
WHERE GDP > 1000000000000;




3 SELECT from NOBEL

nobel(yr, subject, winner)

2.) Show who won the 1962 prize for Literature. 

SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature';

3.) Show the year and subject that won 'Albert Einstein' his prize. 

SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

4.) Give the name of the 'Peace' winners since the year 2000, including 2000. 

SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000;

5.) Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. 

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' 
AND yr BETWEEN 1980 AND 1989;

6.) Show all details of the presidential winners:

    Theodore Roosevelt
    Woodrow Wilson
    Jimmy Carter

SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson','Jimmy Carter');

7.) Show the winners with first name John 

SELECT winner
FROM nobel
WHERE winner LIKE ('John%');

8.) Show the Physics winners for 1980 together with the Chemistry winners for 1984.

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Physics' AND yr = 1980 
OR subject = 'Chemistry' AND yr = 1984;

9.) Show the winners for 1980 excluding the Chemistry and Medicine

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 
AND subject NOT IN ('Chemistry', 'Medicine');

10.) Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) 

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Medicine'
AND yr < 1910
OR subject = 'Literature'
AND yr >= 2004;

12.) Find all details of the prize won by EUGENE O'NEILL 

SELECT * FROM nobel
WHERE winner = 'EUGENE O''(')NEILL'; 

13.) List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE ('Sir%');






04 Select within Select


world(name, continent, area, population, gdp)


1.) List each country name where the population is larger than 'Russia'. 

SELECT name 
FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

2.) Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name
FROM world
WHERE continent = 'Europe' AND (GDP/population) >
      (SELECT GDP/population FROM world
       WHERE name = 'United Kingdom');

3.) List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE continent = 'South America' OR continent = 'Oceania'
ORDER by name;

4.) Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world
                    WHERE name = 'Canada') AND
      population < (SELECT population FROM world
                    WHERE name = 'Poland');

5.) Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, concat(ROUND(population/80000000*100, 0), '%')
FROM world
WHERE continent = 'Europe';

6.) Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values) 

SELECT name
FROM world 
WHERE continent NOT IN ('Europe') AND GDP >= ALL(SELECT GDP
                                           FROM world
                                           WHERE continent = 'Europe' AND GDP > 0

7.) Find the largest country (by area) in each continent, show the continent, the name and the area: 

SELECT continent, name, area 
FROM world x
WHERE area >= ALL
       (SELECT area 
        FROM world y
        WHERE y.continent = x.continent
        AND area > 0);



06 Join 


1.) Show matchid and player name for all goals scored by Germany. teamid = 'GER'

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';


2.) Show id, stadium, team1, team2 for game 1012

SELECT id,stadium,team1,team2
FROM game 
WHERE id = 1012;

3.) Show the player, teamid and mdate and for every German goal. teamid='GER'

SELECT player,teamid, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

4.) Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM game
JOIN goal ON (id = matchid)
WHERE player LIKE 'Mario%';

5.) Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal
goal JOIN eteam ON (teamid = id)
WHERE gtime<=10;

6.) List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game
JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos';

7.) List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM goal
JOIN game ON (id = matchid) 
WHERE stadium = 'National Stadium, Warsaw';




07 More join operations



1.) List the films where the yr is 1962 [Show id, title] 

SELECT id, title
FROM movie
WHERE yr=1962;

2.) Give year of 'Citizen Kane'. 

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

3.) List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 


SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER by yr;

4.) What are the titles of the films with id 11768, 11955, 21191 

SELECT title
FROM movie
WHERE id IN (11768, 11955, 21191);


5.) What id number does the actress 'Glenn Close' have? 


SELECT id
FROM actor
WHERE name = 'Glenn Close';


6.) What is the id of the film 'Casablanca' 

SELECT id
FROM movie
WHERE title = 'Casablanca';


7.) Obtain the cast list for 'Casablanca'. 

SELECT name FROM casting 
JOIN actor ON casting.actorid = actor.id
WHERE casting.movieid = 11768;

8.) Obtain the cast list for the film 'Alien' 

SELECT name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE movie.title = 'Alien';

9.) List the films in which 'Harrison Ford' has appeared 

SELECT title FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE actor.name = 'Harrison Ford';

10.) List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 

SELECT title FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND ORD != 1;


11.) List the films together with the leading star for all 1962 films. 


SELECT title, name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE yr = 1962 AND ord = 1;




08 using NULL


1.) List the teachers who have NULL for their department. 

SELECT name 
FROM teacher
WHERE dept IS NULL; 

2.) Note the INNER JOIN misses the teachers with no department and the departments with no teacher. 

SELECT teacher.name, dept.name
FROM teacher 
INNER JOIN dept ON (teacher.dept = dept.id);


3.) Use a different JOIN so that all teachers are listed. 


SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id);

4.) Use a different JOIN so that all departments are listed. 

SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept ON (teacher.dept = dept.id);

5.) Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266' 


SELECT name,
COALESCE(mobile, '07986 444 2266') AS aff
FROM teacher;

6.) Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department. 

SELECT teacher.name,
COALESCE(dept.name, 'None') AS aff
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id);

7.) Use COUNT to show the number of teachers and the number of mobile phones. 

SELECT COUNT(name), COUNT(mobile)
FROM teacher;

8.) Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed. 


SELECT dept.name, COUNT(teacher.name)
FROM teacher
RIGHT JOIN dept ON (dept.id = teacher.dept)
GROUP BY dept.name;

9.) Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise. 

SELECT name,
  CASE WHEN teacher.dept = 1
       THEN 'Sci'
       WHEN teacher.dept = 2
       THEN 'Sci' 
       ELSE 'Art'
       END
FROM teacher;

10.) Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teachers dept is 3 and 'None' otherwise. 

SELECT name,
  CASE WHEN teacher.dept = 1
       THEN 'Sci'
       WHEN teacher.dept = 2
       THEN 'Sci' 
       WHEN teacher.dept = 3
       THEN 'Art'
       ELSE 'None'
       END
FROM teacher;




+ Numeric Examples


1.) Show the the percentage who STRONGLY AGREE


SELECT A_STRONGLY_AGREE
FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science';


2.) Show the institution and subject where the score is at least 100 for question 15. 


SELECT institution, subject
FROM nss
WHERE score >= 100 AND question = 'Q15';

3.) Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15' 


SELECT institution,score
FROM nss
WHERE question='Q15' AND subject='(8) Computer Science' 
AND score < 50;

4.) Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. 

SELECT subject, SUM(response)
FROM nss
WHERE question='Q22' AND (subject='(8) Computer Science'
OR subject = '(H) Creative Arts and Design')
GROUP BY subject;

5.) Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. 


SELECT subject, SUM(A_STRONGLY_AGREE * response/100)
FROM nss
WHERE question='Q22' AND (subject='(8) Computer Science'
OR subject = '(H) Creative Arts and Design')
GROUP BY subject;

6.) Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'. 







09 Self join



1.) How many stops are in the database. 


SELECT COUNT(name)
FROM stops;


2.) Find the id value for the stop 'Craiglockhart' 


SELECT id
FROM stops
WHERE name = 'Craiglockhart';

3.) Give the id and the name for the stops on the '4' 'LRT' service. 


SELECT id, name
FROM stops
JOIN route ON (stops.id = route.stop)
WHERE route.company = 'LRT' AND route.num = '4';

4.) The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes. 

SELECT company, num, COUNT(*)
FROM route WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING num = 45 OR num = 4;

5.) Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road. 

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop= 53 AND b.stop = 149;

6.) The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' 


SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';

7.) Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') 

SELECT a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop = 115 AND b.stop = 137
GROUP BY company, num;

8.) Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' 

SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross';

9.) Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services. 


SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND a.company = 'LRT';









