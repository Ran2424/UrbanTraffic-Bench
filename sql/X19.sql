WITH common AS (
  SELECT geohash, stat_hour AS hour, taxi_dropoffs, ridehail_dropoffs,
         COUNT(*) OVER (PARTITION BY geohash) AS common_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND taxi_dropoffs IS NOT NULL
    AND ridehail_dropoffs IS NOT NULL
), peaks AS (
  SELECT *,
         MAX(taxi_dropoffs) OVER (PARTITION BY geohash) AS max_taxi,
         MAX(ridehail_dropoffs) OVER (PARTITION BY geohash) AS max_ridehail
  FROM common
), classified AS (
  SELECT geohash,
         MAX(taxi_dropoffs = max_taxi AND ridehail_dropoffs = max_ridehail) AS has_common_peak
  FROM peaks
  GROUP BY geohash
)
SELECT CASE WHEN has_common_peak THEN '峰值小时有重合' ELSE '峰值小时无重合' END AS peak_relation,
       COUNT(*) AS grid_count
FROM classified
GROUP BY has_common_peak
ORDER BY has_common_peak DESC;
