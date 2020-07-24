SELECT id, title
 FROM movie
 WHERE yr=1962


SELECT yr FROM movie WHERE title = 'Citizen Kane';


SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%'
ORDER BY yr;

SELECT id FROM actor WHERE name LIKE 'Glenn Close';

SELECT id FROM movie WHERE title LIKE 'Casablanca';


SELECT name FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movieid=movie.id
WHERE title = 'Casablanca';

-- List the films in which 'Harrison Ford' has appeared
SELECT title FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id= casting.actorid
WHERE name = 'Harrison Ford';

