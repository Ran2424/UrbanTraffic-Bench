WITH windows AS (
  SELECT geohash,
         SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN bike_locks END) AS morning_locks,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN bike_locks END) AS evening_locks,
         COUNT(CASE WHEN stat_hour BETWEEN 7 AND 9 AND bike_locks IS NOT NULL THEN 1 END) AS morning_hours,
         COUNT(CASE WHEN stat_hour BETWEEN 17 AND 19 AND bike_locks IS NOT NULL THEN 1 END) AS evening_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY geohash
)
SELECT geohash, morning_locks, evening_locks,
       evening_locks - morning_locks AS increase,
       morning_hours, evening_hours
FROM windows
WHERE morning_hours > 0 AND evening_hours > 0
  AND evening_locks > morning_locks
ORDER BY increase DESC, geohash
LIMIT 10;
