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
 -- Here, we find the list of all flights whose distance is above average for their carrier.
 -- The inner query has to be reexecuted for EACH flight.
SELECT id
FROM flights AS f
WHERE distance > (
  SELECT AVG(distance)
  FROM flights
  WHERE carrier = f.carrier);
 
 
 -- EX 6 correlated subquery (not a good example)
 -- Here, we give flights a SEQUENCE number, based on ID, carrier
 -- We assume flight_id increments with each additional flight
 -- So, all flights with seq no. 1 will be the flight with the lowest ID number of each carrier
 -- Imagine 2 was the lowest flight no., f.id < 2 would be null, so the count would be 0 + 1 = 1.
 SELECT
    carrier,
    id,
    (SELECT COUNT(*) + 1
FROM flights f
WHERE
    f.id < flights.id AND
    f.carrier = flights.carrier) AS flight_sequence_number
FROM flights;

