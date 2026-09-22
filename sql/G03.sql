WITH metro AS (
  SELECT station_id, stat_hour AS hour, SUM(exit_flow) AS exit_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY station_id, stat_hour
), bike AS (
  SELECT d.station_id, f.stat_hour AS hour, SUM(f.bike_locks) AS bike_locks
  FROM metro_grid_distance AS d
  JOIN grid_flow_hour AS f USING (geohash)
  WHERE d.distance_m <= 500
    AND f.stat_date = '2026-08-24'
    AND f.bike_locks IS NOT NULL
  GROUP BY d.station_id, f.stat_hour
), common AS (
  SELECT m.station_id, m.hour, m.exit_flow, b.bike_locks,
         COUNT(*) OVER (PARTITION BY m.station_id) AS common_hours
  FROM metro AS m JOIN bike AS b USING (station_id, hour)
), peaks AS (
  SELECT *,
         MAX(exit_flow) OVER (PARTITION BY station_id) AS max_exit,
         MAX(bike_locks) OVER (PARTITION BY station_id) AS max_bike
  FROM common
  WHERE common_hours >= 6
), classified AS (
  SELECT station_id,
         MAX(exit_flow = max_exit AND bike_locks = max_bike) AS has_common_peak
  FROM peaks
  GROUP BY station_id
)
SELECT CASE WHEN has_common_peak THEN '峰值小时有重合' ELSE '峰值小时无重合' END AS peak_relation,
       COUNT(*) AS station_count
FROM classified
GROUP BY has_common_peak
ORDER BY has_common_peak DESC;
