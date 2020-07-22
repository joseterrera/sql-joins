-- write your queries here
-- Join the two tables so that every column and record appears, regardless of if there is not an owner_id. Your output should look like this:
/*
id | first_name | last_name | id |  make  |  model  | year |  price  | owner_id
----+------------+-----------+----+--------+---------+------+---------+----------
  1 | Bob        | Hope      |  1 | Toyota | Corolla | 2002 | 2999.99 |        1
  1 | Bob        | Hope      |  2 | Honda  | Civic   | 2012 |   13000 |        1
  2 | Jane       | Smith     |  3 | Nissan | Altima  | 2016 |   24000 |        2
  2 | Jane       | Smith     |  4 | Subaru | Legacy  | 2006 | 5999.99 |        2
  3 | Melody     | Jones     |  5 | Ford   | F150    | 2012 | 2599.99 |        3
  3 | Melody     | Jones     |  6 | GMC    | Yukon   | 2016 |   13000 |        3
  4 | Sarah      | Palmer    |  7 | GMC    | Yukon   | 2014 |   23000 |        4
  4 | Sarah      | Palmer    |  8 | Toyota | Avalon  | 2009 |   13000 |        4
  4 | Sarah      | Palmer    |  9 | Toyota | Camry   | 2013 |   13000 |        4
  5 | Alex       | Miller    | 10 | Honda  | Civic   | 2001 | 7999.99 |        5
  6 | Shana      | Smith     | 11 | Nissan | Altima  | 1999 | 1899.99 |        6
  6 | Shana      | Smith     | 12 | Lexus  | ES350   | 1998 | 1599.99 |        6
  6 | Shana      | Smith     | 13 | BMW    | 300     | 2012 |   23000 |        6
  6 | Shana      | Smith     | 14 | BMW    | 700     | 2015 |   53000 |        6
  7 | Maya       | Malarkin  |    |        |         |      |         |
(15 rows)
*/

 SELECT * FROM owners FULL OUTER JOIN vehicles ON owners.id = vehicles.owner_id;
--  OR
SELEcT * FROM owners o 
  FULL OUTER JOIN vehicles v
  ON o.id = v.owner_id;

-- 2. Count the number of cars for each owner. Display the owners first_name, last_name and count of vehicles. The first_name should be ordered in ascending order. Your output should look like this:
/*
first_name | last_name | count
------------+-----------+-------
Alex       | Miller    |     1
Bob        | Hope      |     2
Jane       | Smith     |     2
Melody     | Jones     |     2
Sarah      | Palmer    |     3
Shana      | Smith     |     4
(6 rows)
*/ 

  SELECT first_name, last_name, COUNT(owner_id) FROM owners 
    JOIN vehicles ON owners.id = vehicles.owner_id
    GROUP BY (first_name, last_name)
    ORDER BY first_name ASC;

-- OR

  SELECT first_name, last_name, COUNT(*) FROM owners 
    JOIN vehicles ON owners.id = vehicles.owner_id
    GROUP BY (first_name, last_name)
    ORDER BY first_name ASC;
  
-- OR

  SELECT first_name, last_name, COUNT(owner_id) AS number_of_vehicles 
    FROM owners o
    JOIN vehicles v ON o.id = v.owner_id
    GROUP BY (first_name, last_name)
    ORDER BY first_name;