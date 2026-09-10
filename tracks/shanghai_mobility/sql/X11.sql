SELECT geohash, stat_hour AS hour,
       bike_locks, ridehail_dropoffs
FROM grid_flow_hour
WHERE stat_date = '2026-08-24'
  AND bike_locks IS NOT NULL
  AND ridehail_dropoffs IS NOT NULL
ORDER BY bike_locks DESC, geohash, stat_hour
LIMIT 20;
