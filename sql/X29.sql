WITH areas AS (
  SELECT SUBSTR(geohash, 1, 5) AS area5,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs,
         SUM(bike_locks) AS bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY SUBSTR(geohash, 1, 5)
)
SELECT area5, taxi_dropoffs, ridehail_dropoffs, bike_locks,
       COALESCE(taxi_dropoffs, 0)
       + COALESCE(ridehail_dropoffs, 0)
       + COALESCE(bike_locks, 0) AS combined_total
FROM areas
ORDER BY combined_total DESC, area5
LIMIT 10;
