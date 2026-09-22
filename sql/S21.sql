SELECT geohash, stat_hour AS hour,
       taxi_pickups, taxi_dropoffs,
       taxi_dropoffs - taxi_pickups AS difference
FROM grid_flow_hour
WHERE stat_date = '2026-08-24'
  AND taxi_pickups IS NOT NULL
  AND taxi_dropoffs IS NOT NULL
ORDER BY difference DESC, geohash, stat_hour
LIMIT 10;
