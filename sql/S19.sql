SELECT geohash, SUM(taxi_pickups) AS pickup_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24' AND taxi_pickups IS NOT NULL
GROUP BY geohash
ORDER BY pickup_total DESC, geohash
LIMIT 10;
