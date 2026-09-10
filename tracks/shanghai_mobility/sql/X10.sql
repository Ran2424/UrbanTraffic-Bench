WITH presence AS (
  SELECT geohash,
         MAX(taxi_dropoffs IS NOT NULL) AS has_taxi,
         MAX(ridehail_dropoffs IS NOT NULL) AS has_ridehail,
         MAX(bike_locks IS NOT NULL) AS has_bike
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour = 8
  GROUP BY geohash
), pairs AS (
  SELECT '出租车下客' AS metric_a, '网约车下客' AS metric_b,
         SUM(has_taxi AND has_ridehail) AS intersection_count,
         SUM(has_taxi OR has_ridehail) AS union_count
  FROM presence
  UNION ALL
  SELECT '出租车下客', '共享单车锁车',
         SUM(has_taxi AND has_bike), SUM(has_taxi OR has_bike)
  FROM presence
  UNION ALL
  SELECT '网约车下客', '共享单车锁车',
         SUM(has_ridehail AND has_bike), SUM(has_ridehail OR has_bike)
  FROM presence
)
SELECT metric_a, metric_b, intersection_count, union_count,
       ROUND(1.0 * intersection_count / NULLIF(union_count, 0), 6) AS jaccard
FROM pairs
ORDER BY metric_a, metric_b;
