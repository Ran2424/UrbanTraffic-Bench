WITH coverage AS (
  SELECT geohash, COUNT(DISTINCT station_id) AS nearby_stations
  FROM metro_grid_distance
  WHERE distance_m <= 800
  GROUP BY geohash
), totals AS (
  SELECT
         CASE
           WHEN COALESCE(c.nearby_stations, 0) = 0 THEN '0'
           WHEN c.nearby_stations = 1 THEN '1'
           WHEN c.nearby_stations = 2 THEN '2'
           ELSE '3+'
         END AS station_count_group,
         SUM(f.ridehail_dropoffs) AS ridehail_dropoffs,
         SUM(f.bike_locks) AS bike_locks
  FROM grid_flow_hour AS f
  LEFT JOIN coverage AS c USING (geohash)
  WHERE f.stat_date = '2026-08-24'
  GROUP BY station_count_group
), all_totals AS (
  SELECT SUM(ridehail_dropoffs) AS all_ridehail,
         SUM(bike_locks) AS all_bike
  FROM grid_flow_hour WHERE stat_date = '2026-08-24'
)
SELECT t.station_count_group, t.ridehail_dropoffs, t.bike_locks,
       ROUND(100.0 * t.ridehail_dropoffs / NULLIF(a.all_ridehail, 0), 2) AS ridehail_pct,
       ROUND(100.0 * t.bike_locks / NULLIF(a.all_bike, 0), 2) AS bike_pct
FROM totals AS t CROSS JOIN all_totals AS a
ORDER BY CASE t.station_count_group WHEN '0' THEN 0 WHEN '1' THEN 1 WHEN '2' THEN 2 ELSE 3 END;
