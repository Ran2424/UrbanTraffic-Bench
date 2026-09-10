WITH line_station AS (
  SELECT DISTINCT line_id, station_id FROM metro_flow_hour
), station_grid AS (
  SELECT ls.line_id, ls.station_id, d.geohash
  FROM line_station AS ls
  JOIN metro_grid_distance AS d USING (station_id)
  WHERE d.distance_m <= 500
), bike AS (
  SELECT geohash, SUM(bike_locks) AS bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND bike_locks IS NOT NULL
  GROUP BY geohash
), station_totals AS (
  SELECT g.line_id, g.station_id, SUM(b.bike_locks) AS station_bike
  FROM station_grid AS g JOIN bike AS b USING (geohash)
  GROUP BY g.line_id, g.station_id
), station_sum AS (
  SELECT line_id, SUM(station_bike) AS station_sum_locks
  FROM station_totals GROUP BY line_id
), union_sum AS (
  SELECT line_id, SUM(b.bike_locks) AS union_locks
  FROM (SELECT DISTINCT line_id, geohash FROM station_grid) AS g
  JOIN bike AS b USING (geohash)
  GROUP BY line_id
)
SELECT l.line_id, l.line_name,
       s.station_sum_locks, u.union_locks,
       s.station_sum_locks - u.union_locks AS repeated_locks,
       ROUND(100.0 * (s.station_sum_locks - u.union_locks)
             / NULLIF(s.station_sum_locks, 0), 2) AS repeated_pct
FROM metro_line AS l
LEFT JOIN station_sum AS s USING (line_id)
LEFT JOIN union_sum AS u USING (line_id)
ORDER BY l.line_id;
