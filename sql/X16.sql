WITH daily AS (
  SELECT geohash,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
  HAVING SUM(taxi_dropoffs) IS NOT NULL AND SUM(ridehail_dropoffs) IS NOT NULL
), ranked AS (
  SELECT *,
         DENSE_RANK() OVER (ORDER BY taxi_dropoffs DESC) AS taxi_rank,
         DENSE_RANK() OVER (ORDER BY ridehail_dropoffs DESC) AS ridehail_rank
  FROM daily
)
SELECT geohash, taxi_dropoffs, ridehail_dropoffs, taxi_rank, ridehail_rank,
       ABS(taxi_rank - ridehail_rank) AS rank_difference
FROM ranked
ORDER BY rank_difference DESC, geohash
LIMIT 10;
