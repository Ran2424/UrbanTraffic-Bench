WITH daily AS (
  SELECT geohash,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs,
         SUM(bike_locks) AS bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
  HAVING SUM(taxi_dropoffs) IS NOT NULL
     AND SUM(ridehail_dropoffs) IS NOT NULL
     AND SUM(bike_locks) IS NOT NULL
), ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (ORDER BY taxi_dropoffs DESC, geohash) AS taxi_rank,
         ROW_NUMBER() OVER (ORDER BY ridehail_dropoffs DESC, geohash) AS ridehail_rank,
         ROW_NUMBER() OVER (ORDER BY bike_locks DESC, geohash) AS bike_rank
  FROM daily
)
SELECT geohash, taxi_dropoffs, ridehail_dropoffs, bike_locks,
       taxi_rank, ridehail_rank, bike_rank
FROM ranked
WHERE taxi_rank <= 200 AND ridehail_rank <= 200 AND bike_rank <= 200
ORDER BY taxi_rank, ridehail_rank, bike_rank, geohash;
