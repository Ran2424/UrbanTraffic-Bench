SELECT SUM(bike_locks) AS lock_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24';
