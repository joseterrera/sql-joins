SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';


SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012;


SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (game.id=goal.matchid) WHERE teamid = 'GER';

SELECT team1, team2, player FROM game JOIN goal ON (id=matchid) 
  WHERE player LIKE  'Mario %';

SELECT player, teamid, coach, gtime
  FROM goal g JOIN eteam e ON g.teamid = e.id 
 WHERE gtime<=10;

--  To JOIN game with eteam you could use either game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
-- Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate,teamname 
FROM game JOIN eteam ON (team1=eteam.id) WHERE team1 = 
(SELECT eteam.id FROM eteam
WHERE coach = 'Fernando Santos')

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player FROM goal JOIN GAME ON (matchid = id) WHERE stadium = 'National Stadium, Warsaw';


-- The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player FROM game
JOIN goal on matchid = id
WHERE team1 = 'GER' OR team2 = 'GER'
AND teamid <> 'GER';

-- Show teamname and the total number of goals scored.

SELECT teamname, COUNT(matchid) as TotalGoals
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname
  ORDER BY TotalGoals DESC;


-- 10 Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(gtime) AS totalgoals FROM game JOIN goal ON id = matchid
GROUP by Stadium
ORDER BY totalgoals DESC;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(*) as goals
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP by matchid, mdate;

-- 12.For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(*) AS TotalGoals
 FROM game JOIN goal ON id = matchid
 WHERE teamid = 'GER'
 GROUP BY matchid, mdate;

-- 13 hardest one:

-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
-- mdate	team1	score1	team2	score2
-- 1 July 2012	ESP	4	ITA	0
-- 10 June 2012	ESP	1	ITA	1
-- 10 June 2012	IRL	1	CRO	3
-- ...
-- Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.

SELECT mdate, team1,
SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1,
team2,
SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate, matchid, team1, team2
 