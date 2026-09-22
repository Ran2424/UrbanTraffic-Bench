SELECT stat_hour AS hour, SUM(bike_locks) AS lock_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24' AND bike_locks IS NOT NULL
GROUP BY stat_hour
ORDER BY stat_hour;
