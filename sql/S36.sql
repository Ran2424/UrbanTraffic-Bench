SELECT geohash, SUM(bike_locks) AS lock_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24' AND bike_locks IS NOT NULL
GROUP BY geohash
ORDER BY lock_total DESC, geohash
LIMIT 10;
