SELECT stat_hour AS hour,
       SUM(taxi_dropoffs) AS taxi_dropoffs,
       SUM(ridehail_dropoffs) AS ridehail_dropoffs,
       SUM(bike_locks) AS bike_locks
FROM grid_flow_hour
WHERE stat_date = '2026-08-24'
GROUP BY stat_hour
ORDER BY stat_hour;
