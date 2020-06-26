-- EX 3
SELECT
    CASE
        WHEN elevation < 500 THEN 'Low'
        WHEN elevation BETWEEN 500 AND 1999 THEN 'Medium'
        WHEN elevation >= 2000 THEN 'High'
        ELSE 'Unknown'
    END AS elevation_tier,
    COUNT(*)
FROM airports
GROUP BY 1;


-- EX 4
SELECT
    state, 
    COUNT(CASE WHEN elevation <= 1000 THEN 1 ELSE NULL END) as count_low_elevation_aiports 
FROM airports 
GROUP BY state;



-- EX 5
SELECT
    origin,
    sum(distance) as total_flight_distance, sum(CASE WHEN carrier = 'DL' THEN distance ELSE 0 END) as total_delta_flight_distance 
FROM flights 
GROUP BY 1;



-- EX 6
SELECT
    origin,
    ROUND((100.0*(sum(CASE WHEN carrier = 'DL' THEN distance ELSE 0 END))/sum(distance)), 2) as percentage_flight_distance_from_delta
 FROM flights 
GROUP BY origin;



-- EX 7
SELECT
    state,
    ROUND((100.0*(SUM(CASE WHEN elevation >= 2000 THEN 1 ELSE 0 END)) / COUNT(*)), 2) AS percentage_high_elevation_airports
FROM airports
GROUP BY state;

