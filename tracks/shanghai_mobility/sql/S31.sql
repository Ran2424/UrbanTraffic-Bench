WITH changes AS (
  SELECT geohash, stat_hour,
         LAG(stat_hour) OVER (PARTITION BY geohash ORDER BY stat_hour) AS previous_hour,
         LAG(ridehail_orders) OVER (PARTITION BY geohash ORDER BY stat_hour) AS previous_orders,
         ridehail_orders AS current_orders
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND ridehail_orders IS NOT NULL
)
SELECT geohash, previous_hour, stat_hour AS current_hour,
       previous_orders, current_orders,
       current_orders - previous_orders AS increase
FROM changes
WHERE stat_hour = previous_hour + 1
ORDER BY increase DESC, geohash, stat_hour
LIMIT 10;
