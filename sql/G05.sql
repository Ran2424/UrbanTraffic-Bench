WITH covered AS (
  SELECT DISTINCT geohash
  FROM metro_grid_distance
  WHERE distance_m <= 500
), totals AS (
  SELECT
    SUM(CASE WHEN c.geohash IS NOT NULL THEN f.taxi_dropoffs END) AS covered_taxi,
    SUM(f.taxi_dropoffs) AS all_taxi,
    SUM(CASE WHEN c.geohash IS NOT NULL THEN f.ridehail_dropoffs END) AS covered_ridehail,
    SUM(f.ridehail_dropoffs) AS all_ridehail,
    SUM(CASE WHEN c.geohash IS NOT NULL THEN f.bike_locks END) AS covered_bike,
    SUM(f.bike_locks) AS all_bike
  FROM grid_flow_hour AS f
  LEFT JOIN covered AS c USING (geohash)
  WHERE f.stat_date = '2026-08-24'
)
SELECT '出租车下客' AS metric, covered_taxi AS covered_total,
       all_taxi AS all_grid_total,
       ROUND(100.0 * covered_taxi / NULLIF(all_taxi, 0), 2) AS covered_pct
FROM totals
UNION ALL
SELECT '网约车下客', covered_ridehail, all_ridehail,
       ROUND(100.0 * covered_ridehail / NULLIF(all_ridehail, 0), 2)
FROM totals
UNION ALL
SELECT '共享单车锁车', covered_bike, all_bike,
       ROUND(100.0 * covered_bike / NULLIF(all_bike, 0), 2)
FROM totals;
