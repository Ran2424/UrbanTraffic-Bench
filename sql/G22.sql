WITH within500 AS (
  SELECT DISTINCT geohash FROM metro_grid_distance WHERE distance_m <= 500
), within800 AS (
  SELECT DISTINCT geohash FROM metro_grid_distance WHERE distance_m <= 800
), added AS (
  SELECT geohash FROM within800
  EXCEPT
  SELECT geohash FROM within500
), totals AS (
  SELECT
    SUM(CASE WHEN a.geohash IS NOT NULL THEN f.taxi_dropoffs END) AS added_taxi,
    SUM(CASE WHEN b.geohash IS NOT NULL THEN f.taxi_dropoffs END) AS base_taxi,
    SUM(CASE WHEN a.geohash IS NOT NULL THEN f.ridehail_dropoffs END) AS added_ridehail,
    SUM(CASE WHEN b.geohash IS NOT NULL THEN f.ridehail_dropoffs END) AS base_ridehail
  FROM grid_flow_hour AS f
  LEFT JOIN added AS a USING (geohash)
  LEFT JOIN within500 AS b USING (geohash)
  WHERE f.stat_date = '2026-08-24'
)
SELECT added_taxi, base_taxi,
       ROUND(100.0 * added_taxi / NULLIF(base_taxi, 0), 2) AS taxi_added_pct,
       added_ridehail, base_ridehail,
       ROUND(100.0 * added_ridehail / NULLIF(base_ridehail, 0), 2) AS ridehail_added_pct
FROM totals;
