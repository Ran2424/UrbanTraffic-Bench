WITH presence AS (
  SELECT geohash,
         MAX(taxi_dropoffs IS NOT NULL) AS has_taxi,
         MAX(ridehail_dropoffs IS NOT NULL) AS has_ridehail,
         MAX(bike_locks IS NOT NULL) AS has_bike
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
)
SELECT has_taxi + has_ridehail + has_bike AS observed_metric_count,
       COUNT(*) AS grid_count
FROM presence
WHERE has_taxi + has_ridehail + has_bike > 0
GROUP BY observed_metric_count
ORDER BY observed_metric_count;
