WITH common AS (
  SELECT geohash, stat_hour,
         ridehail_dropoffs, bike_locks,
         COUNT(*) OVER (PARTITION BY geohash) AS common_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND ridehail_dropoffs IS NOT NULL
    AND bike_locks IS NOT NULL
), stats AS (
  SELECT geohash, common_hours,
         MAX(ridehail_dropoffs) AS ridehail_peak,
         AVG(ridehail_dropoffs) AS ridehail_mean,
         MAX(bike_locks) AS bike_peak,
         AVG(bike_locks) AS bike_mean
  FROM common
  GROUP BY geohash, common_hours
  HAVING common_hours >= 6
     AND AVG(ridehail_dropoffs) > 0
     AND AVG(bike_locks) > 0
)
SELECT geohash, common_hours,
       ROUND(1.0 * ridehail_peak / ridehail_mean, 6) AS ridehail_peak_ratio,
       ROUND(1.0 * bike_peak / bike_mean, 6) AS bike_peak_ratio,
       ROUND(ABS(1.0 * ridehail_peak / ridehail_mean
               - 1.0 * bike_peak / bike_mean), 6) AS ratio_difference
FROM stats
ORDER BY ratio_difference DESC, geohash
LIMIT 10;
