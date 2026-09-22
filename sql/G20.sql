WITH candidate_stations AS (
  SELECT s.station_id
  FROM metro_station AS s
  WHERE NOT EXISTS (
    SELECT 1 FROM metro_bus_line_distance AS d
    WHERE d.station_id = s.station_id AND d.distance_m <= 300
  )
), peripheral AS (
  SELECT d.station_id, d.bus_line_id
  FROM metro_bus_line_distance AS d
  JOIN candidate_stations AS s USING (station_id)
  WHERE d.distance_m > 300 AND d.distance_m <= 800
), qualified AS (
  SELECT station_id
  FROM peripheral
  GROUP BY station_id
  HAVING COUNT(DISTINCT bus_line_id) >= 3
), bus AS (
  SELECT bus_line_id, SUM(passenger_flow) AS morning_bus_flow,
         COUNT(*) AS observed_hours
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY bus_line_id
), bus_summary AS (
  SELECT p.station_id,
         COUNT(DISTINCT p.bus_line_id) AS nearby_lines,
         SUM(b.observed_hours = 3) AS complete_lines,
         SUM(b.morning_bus_flow) AS morning_bus_total
  FROM peripheral AS p
  JOIN qualified AS q USING (station_id)
  LEFT JOIN bus AS b USING (bus_line_id)
  GROUP BY p.station_id
), metro_hour AS (
  SELECT station_id, stat_hour, SUM(exit_flow) AS exit_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY station_id, stat_hour
), metro AS (
  SELECT station_id, SUM(exit_flow) AS morning_exit, COUNT(*) AS observed_hours
  FROM metro_hour GROUP BY station_id
)
SELECT q.station_id, s.station_name,
       b.nearby_lines, b.complete_lines, b.morning_bus_total,
       m.morning_exit, m.observed_hours AS metro_observed_hours
FROM qualified AS q
JOIN metro_station AS s USING (station_id)
JOIN bus_summary AS b USING (station_id)
LEFT JOIN metro AS m USING (station_id)
ORDER BY q.station_id;
