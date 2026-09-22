SELECT geohash, SUM(taxi_dropoffs) AS dropoff_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24' AND taxi_dropoffs IS NOT NULL
GROUP BY geohash
ORDER BY dropoff_total DESC, geohash
LIMIT 10;
