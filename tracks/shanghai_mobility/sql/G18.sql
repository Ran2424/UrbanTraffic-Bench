WITH nearest AS (
  SELECT station_id, nearby_station_id, distance_m,
         ROW_NUMBER() OVER (
           PARTITION BY station_id ORDER BY distance_m, nearby_station_id
         ) AS rn
  FROM metro_station_distance
), mutual AS (
  SELECT a.station_id AS station_a_id,
         a.nearby_station_id AS station_b_id,
         a.distance_m
  FROM nearest AS a
  JOIN nearest AS b
    ON b.station_id = a.nearby_station_id
   AND b.nearby_station_id = a.station_id
  WHERE a.rn = 1 AND b.rn = 1 AND a.station_id < a.nearby_station_id
), station_hour AS (
  SELECT station_id, stat_hour, SUM(exit_flow) AS exit_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 17 AND 19
  GROUP BY station_id, stat_hour
), evening AS (
  SELECT station_id, SUM(exit_flow) AS evening_exit, COUNT(*) AS observed_hours
  FROM station_hour GROUP BY station_id HAVING COUNT(*) = 3
)
SELECT m.station_a_id, a.station_name AS station_a_name,
       m.station_b_id, b.station_name AS station_b_name,
       m.distance_m,
       ea.evening_exit AS station_a_exit,
       eb.evening_exit AS station_b_exit,
       ABS(ea.evening_exit - eb.evening_exit) AS exit_difference
FROM mutual AS m
JOIN metro_station AS a ON a.station_id = m.station_a_id
JOIN metro_station AS b ON b.station_id = m.station_b_id
JOIN evening AS ea ON ea.station_id = m.station_a_id
JOIN evening AS eb ON eb.station_id = m.station_b_id
ORDER BY exit_difference DESC, m.station_a_id, m.station_b_id
LIMIT 10;
