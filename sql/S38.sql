WITH morning AS (
  SELECT geohash,
         MAX(CASE WHEN stat_hour = 7 THEN bike_locks END) AS locks_7,
         MAX(CASE WHEN stat_hour = 8 THEN bike_locks END) AS locks_8,
         MAX(CASE WHEN stat_hour = 9 THEN bike_locks END) AS locks_9,
         COUNT(*) AS observed_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour BETWEEN 7 AND 9
    AND bike_locks IS NOT NULL
  GROUP BY geohash
)
SELECT geohash, locks_7, locks_8, locks_9
FROM morning
WHERE observed_hours = 3
  AND locks_7 < locks_8
  AND locks_8 < locks_9
ORDER BY geohash;
