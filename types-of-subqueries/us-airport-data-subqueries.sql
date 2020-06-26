EX 1
SELECT * 
FROM Flights
LIMIT 10;


-- EX 2 - non-correlated subquery
SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports 
    WHERE elevation < 2000);
	

-- EX 3 - non-correlated subquery
SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports 
    WHERE city = 'LOS ANGELES');
	
	
-- EX 4 - non-correlated subquery
-- Here, we get the AVG total distance flown by day of week AND month, not just day of week
-- The inner query calculates the total distance flown, then groups it by month, day of week then date
-- The outer query uses the inner query’s result set to compute the average by day of week of a given month.
SELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_distance) AS average_distance
  FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               SUM(distance) AS flight_distance
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;
 
 
 -- EX 5 - correlated subquery
 -- In a correlated subquery, the subquery CANNOT be run indepedently of the outer query
 -- 	1) A row is processed in the outer query
 --		2) Then, for that particular row in the outer q, the subquery is executed
 
 