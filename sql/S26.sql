SELECT geohash, SUM(ridehail_orders) AS order_total
FROM grid_flow_hour
WHERE stat_date = '2026-08-24' AND ridehail_orders IS NOT NULL
GROUP BY geohash
ORDER BY order_total DESC, geohash
LIMIT 10;
