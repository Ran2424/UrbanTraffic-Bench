WITH daily AS (
  SELECT geohash,
         SUM(bike_locks) AS bike_locks,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
), bike AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY bike_locks DESC, geohash) AS bike_rank
  FROM daily WHERE bike_locks IS NOT NULL
), ridehail AS (
  SELECT geohash,
         ROW_NUMBER() OVER (ORDER BY ridehail_dropoffs DESC, geohash) AS ridehail_rank
  FROM daily WHERE ridehail_dropoffs IS NOT NULL
)
SELECT b.geohash, b.bike_locks, b.bike_rank
FROM bike AS b
LEFT JOIN ridehail AS r ON r.geohash = b.geohash AND r.ridehail_rank <= 20
WHERE b.bike_rank <= 20 AND r.geohash IS NULL
ORDER BY b.bike_rank;
