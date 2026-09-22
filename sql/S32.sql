SELECT geohash, stat_hour AS hour,
       ridehail_orders, ridehail_dropoffs,
       ridehail_orders - ridehail_dropoffs AS difference
FROM grid_flow_hour
WHERE stat_date = '2026-08-24'
  AND ridehail_orders IS NOT NULL
  AND ridehail_dropoffs IS NOT NULL
ORDER BY difference DESC, geohash, stat_hour
LIMIT 10;
