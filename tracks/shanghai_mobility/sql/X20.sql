WITH totals AS (
  SELECT geohash,
         SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN bike_locks END) AS morning_bike,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN ridehail_dropoffs END) AS evening_ridehail
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY geohash
), ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (ORDER BY morning_bike DESC, geohash) AS bike_rank,
         ROW_NUMBER() OVER (ORDER BY evening_ridehail DESC, geohash) AS ridehail_rank
  FROM totals
  WHERE morning_bike IS NOT NULL AND evening_ridehail IS NOT NULL
)
SELECT geohash, morning_bike, evening_ridehail, bike_rank, ridehail_rank
FROM ranked
WHERE bike_rank <= 200 AND ridehail_rank <= 200
ORDER BY bike_rank, ridehail_rank, geohash;
