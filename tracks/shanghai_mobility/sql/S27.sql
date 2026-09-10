WITH totals AS (
  SELECT SUM(ridehail_orders) AS daily_orders,
         SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN ridehail_orders END) AS morning_orders,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN ridehail_orders END) AS evening_orders
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
)
SELECT morning_orders, evening_orders, daily_orders,
       ROUND(100.0 * morning_orders / NULLIF(daily_orders, 0), 2) AS morning_pct,
       ROUND(100.0 * evening_orders / NULLIF(daily_orders, 0), 2) AS evening_pct
FROM totals;
