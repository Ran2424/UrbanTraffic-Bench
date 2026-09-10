SELECT stat_hour AS hour,
       SUM(taxi_pickups) AS pickup_total,
       SUM(taxi_dropoffs) AS dropoff_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24'
GROUP BY stat_hour
ORDER BY stat_hour;
