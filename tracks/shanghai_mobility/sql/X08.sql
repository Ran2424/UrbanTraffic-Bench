WITH hourly AS (
  SELECT stat_hour AS hour,
         SUM(ridehail_orders) AS ridehail_orders,
         SUM(bike_locks) AS bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY stat_hour
)
SELECT a.hour AS previous_hour, b.hour AS current_hour,
       b.ridehail_orders - a.ridehail_orders AS ridehail_change,
       b.bike_locks - a.bike_locks AS bike_change
FROM hourly AS a
JOIN hourly AS b ON b.hour = a.hour + 1
WHERE b.ridehail_orders > a.ridehail_orders
  AND b.bike_locks < a.bike_locks
ORDER BY a.hour;
