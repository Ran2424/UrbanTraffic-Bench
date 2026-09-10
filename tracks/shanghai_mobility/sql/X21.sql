WITH morning AS (
  SELECT geohash,
         MAX(CASE WHEN stat_hour = 7 THEN ridehail_dropoffs END) AS ridehail_7,
         MAX(CASE WHEN stat_hour = 8 THEN ridehail_dropoffs END) AS ridehail_8,
         MAX(CASE WHEN stat_hour = 9 THEN ridehail_dropoffs END) AS ridehail_9,
         MAX(CASE WHEN stat_hour = 7 THEN bike_locks END) AS bike_7,
         MAX(CASE WHEN stat_hour = 8 THEN bike_locks END) AS bike_8,
         MAX(CASE WHEN stat_hour = 9 THEN bike_locks END) AS bike_9,
         COUNT(CASE WHEN ridehail_dropoffs IS NOT NULL AND bike_locks IS NOT NULL THEN 1 END) AS common_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY geohash
)
SELECT geohash, ridehail_7, ridehail_8, ridehail_9,
       bike_7, bike_8, bike_9
FROM morning
WHERE common_hours = 3
  AND ridehail_7 < ridehail_8 AND ridehail_8 < ridehail_9
  AND bike_7 < bike_8 AND bike_8 < bike_9
ORDER BY geohash;
