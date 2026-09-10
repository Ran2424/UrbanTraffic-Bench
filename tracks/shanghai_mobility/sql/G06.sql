WITH covered AS (
  SELECT DISTINCT geohash
  FROM metro_grid_distance
  WHERE distance_m <= 500
), grid_totals AS (
  SELECT f.geohash,
         CASE WHEN c.geohash IS NULL THEN '500米范围外' ELSE '500米范围内' END AS area_type,
         SUM(f.taxi_dropoffs) AS taxi_daily,
         SUM(CASE WHEN f.stat_hour BETWEEN 7 AND 9 THEN f.taxi_dropoffs END) AS taxi_morning,
         SUM(f.ridehail_dropoffs) AS ridehail_daily,
         SUM(CASE WHEN f.stat_hour BETWEEN 7 AND 9 THEN f.ridehail_dropoffs END) AS ridehail_morning
  FROM grid_flow_hour AS f
  LEFT JOIN covered AS c USING (geohash)
  WHERE f.stat_date = '2026-08-24'
  GROUP BY f.geohash, area_type
), area_totals AS (
  SELECT area_type,
         SUM(taxi_daily) AS taxi_daily,
         SUM(taxi_morning) AS taxi_morning,
         SUM(ridehail_daily) AS ridehail_daily,
         SUM(ridehail_morning) AS ridehail_morning
  FROM grid_totals
  WHERE taxi_daily IS NOT NULL OR ridehail_daily IS NOT NULL
  GROUP BY area_type
)
SELECT area_type, '出租车下客' AS metric,
       taxi_morning AS morning_total, taxi_daily AS daily_total,
       ROUND(100.0 * taxi_morning / NULLIF(taxi_daily, 0), 2) AS morning_pct
FROM area_totals
UNION ALL
SELECT area_type, '网约车下客', ridehail_morning, ridehail_daily,
       ROUND(100.0 * ridehail_morning / NULLIF(ridehail_daily, 0), 2)
FROM area_totals
ORDER BY area_type, metric;
