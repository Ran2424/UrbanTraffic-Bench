WITH daily AS (
  SELECT geohash,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs,
         SUM(bike_locks) AS bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
), ranked AS (
  SELECT geohash,
         ROW_NUMBER() OVER (ORDER BY taxi_dropoffs DESC, geohash) AS taxi_rank,
         ROW_NUMBER() OVER (ORDER BY ridehail_dropoffs DESC, geohash) AS ridehail_rank,
         ROW_NUMBER() OVER (ORDER BY bike_locks DESC, geohash) AS bike_rank,
         taxi_dropoffs, ridehail_dropoffs, bike_locks
  FROM daily
  WHERE taxi_dropoffs IS NOT NULL
    AND ridehail_dropoffs IS NOT NULL
    AND bike_locks IS NOT NULL
), flagged AS (
  SELECT *, (taxi_rank <= 100) + (ridehail_rank <= 100) + (bike_rank <= 100) AS top_count
  FROM ranked
)
SELECT geohash,
       CASE
         WHEN taxi_rank <= 100 AND ridehail_rank <= 100 THEN '出租车下客+网约车下客'
         WHEN taxi_rank <= 100 AND bike_rank <= 100 THEN '出租车下客+共享单车'
         ELSE '网约车下客+共享单车'
       END AS hotspot_pair,
       taxi_rank, ridehail_rank, bike_rank
FROM flagged
WHERE top_count = 2
ORDER BY hotspot_pair, geohash;
