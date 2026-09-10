WITH RECURSIVE hours(hour) AS (
  SELECT 0 UNION ALL SELECT hour + 1 FROM hours WHERE hour < 23
), target AS (
  SELECT station_id FROM metro_station WHERE station_name = '徐家汇'
), ring_grid AS (
  SELECT d.geohash,
         CASE WHEN d.distance_m <= 300 THEN '0-300' ELSE '300-800' END AS ring
  FROM metro_grid_distance AS d
  JOIN target AS t USING (station_id)
  WHERE d.distance_m <= 800
), totals AS (
  SELECT r.ring, f.stat_hour AS hour,
         SUM(f.taxi_dropoffs) AS taxi_dropoffs,
         SUM(f.ridehail_dropoffs) AS ridehail_dropoffs,
         SUM(f.bike_locks) AS bike_locks
  FROM ring_grid AS r
  JOIN grid_flow_hour AS f USING (geohash)
  WHERE f.stat_date = '2026-08-24'
  GROUP BY r.ring, f.stat_hour
), rings(ring) AS (
  SELECT '0-300' UNION ALL SELECT '300-800'
)
SELECT r.ring, h.hour, t.taxi_dropoffs, t.ridehail_dropoffs, t.bike_locks
FROM rings AS r CROSS JOIN hours AS h
LEFT JOIN totals AS t USING (ring, hour)
ORDER BY r.ring, h.hour;
