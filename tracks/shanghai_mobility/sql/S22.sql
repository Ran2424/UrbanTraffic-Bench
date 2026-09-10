WITH windows AS (
  SELECT geohash,
         SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN taxi_dropoffs END) AS morning_dropoffs,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN taxi_dropoffs END) AS evening_dropoffs,
         COUNT(CASE WHEN stat_hour BETWEEN 7 AND 9 AND taxi_dropoffs IS NOT NULL THEN 1 END) AS morning_hours,
         COUNT(CASE WHEN stat_hour BETWEEN 17 AND 19 AND taxi_dropoffs IS NOT NULL THEN 1 END) AS evening_hours
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY geohash
)
SELECT geohash, morning_dropoffs, evening_dropoffs,
       morning_hours, evening_hours
FROM windows
WHERE morning_hours > 0 AND evening_hours > 0
  AND evening_dropoffs > morning_dropoffs
ORDER BY evening_dropoffs - morning_dropoffs DESC, geohash;
