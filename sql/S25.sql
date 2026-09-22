WITH hourly AS (
  SELECT stat_hour AS hour,
         SUM(ridehail_orders) AS orders,
         SUM(ridehail_dropoffs) AS dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY stat_hour
), totals AS (
  SELECT SUM(orders) AS all_orders, SUM(dropoffs) AS all_dropoffs
  FROM hourly
)
SELECT h.hour, h.orders, h.dropoffs,
       ROUND(100.0 * h.orders / NULLIF(t.all_orders, 0), 2) AS order_pct,
       ROUND(100.0 * h.dropoffs / NULLIF(t.all_dropoffs, 0), 2) AS dropoff_pct
FROM hourly AS h CROSS JOIN totals AS t
ORDER BY h.hour;
