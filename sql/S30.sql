WITH daily AS (
  SELECT geohash,
         SUM(ridehail_orders) AS daily_orders,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN ridehail_orders END) AS evening_orders
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND ridehail_orders IS NOT NULL
  GROUP BY geohash
)
SELECT geohash, daily_orders, evening_orders,
       ROUND(100.0 * evening_orders / NULLIF(daily_orders, 0), 2) AS evening_pct
FROM daily
WHERE daily_orders >= 100
ORDER BY 1.0 * evening_orders / NULLIF(daily_orders, 0) DESC, geohash
LIMIT 10;
