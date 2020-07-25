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


-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND ord <> 1; 



-- List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE yr = 1962 AND ord = 1;

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1


-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- watch video on this one, it explains the nested SELECT, basically the output of
-- that nested select will be a list of movieids
SELECT title, name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting
JOIN actor ON actorid = actor.id
WHERE name = 'Julie Andrews' );


-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name FROM actor 
JOIN casting ON actorid = actor.id
WHERE ord = 1
GROUP BY actor.name
HAVING COUNT(ord) >= 15;


-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) as cast FROM movie
JOIN casting ON movieid=id
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC, title ASC;


-- Hardest: List all the people who have worked with 'Art Garfunkel'.

SELECT name FROM actor
  JOIN casting ON actorid=actor.id
  JOIN movie ON movieid=movie.id
    WHERE movie.id IN (
      SELECT movieid FROM casting
        WHERE actorid IN (
          SELECT id FROM actor 
            WHERE name = 'Art Garkunkel'
        ) AND actor.name <> 'Art Garkunkel'
    )
-- or

    select name from actor, 
     (select actorid from casting, 
           (select distinct movieid from casting where actorid in (
               select id from actor where name = 'Art Garfunkel'
             )
           ) movies_he_is_in 
         where casting.movieid = movies_he_is_in.movieid
           and actorid not in (select id from actor where name = 'Art Garfunkel')
  ) actors_with_him 
  where  actor.id = actors_with_him.actorid;