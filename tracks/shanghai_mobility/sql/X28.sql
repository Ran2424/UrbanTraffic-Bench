WITH totals AS (
  SELECT geohash,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs,
         COUNT(taxi_dropoffs) AS taxi_hours,
         COUNT(ridehail_dropoffs) AS ridehail_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 17 AND 19
  GROUP BY geohash
)
SELECT geohash, taxi_dropoffs, ridehail_dropoffs,
       ABS(taxi_dropoffs - ridehail_dropoffs) AS difference
FROM totals
WHERE taxi_hours > 0 AND ridehail_hours > 0
ORDER BY difference DESC, geohash
LIMIT 10;
