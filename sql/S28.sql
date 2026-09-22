SELECT COUNT(DISTINCT geohash) AS qualifying_grids
FROM grid_flow_hour
WHERE stat_date = '2026-08-24' AND ridehail_orders >= 100;
