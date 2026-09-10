WITH hourly AS (
  SELECT '地铁进站量' AS metric, stat_hour AS hour, SUM(entry_flow) AS total
  FROM metro_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  UNION ALL
  SELECT '公交客流', stat_hour, SUM(passenger_flow)
  FROM bus_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  UNION ALL
  SELECT '出租车上车量', stat_hour, SUM(taxi_pickups)
  FROM grid_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  UNION ALL
  SELECT '网约车下单量', stat_hour, SUM(ridehail_orders)
  FROM grid_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  UNION ALL
  SELECT '共享单车锁车量', stat_hour, SUM(bike_locks)
  FROM grid_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
), peak_hours AS (
  SELECT metric, hour
  FROM (
    SELECT *, MAX(total) OVER (PARTITION BY metric) AS peak_total
    FROM hourly
  )
  WHERE total = peak_total
)
SELECT a.metric AS metric_a, b.metric AS metric_b, a.hour AS common_peak_hour
FROM peak_hours AS a
JOIN peak_hours AS b ON b.hour = a.hour AND b.metric > a.metric
ORDER BY a.metric, b.metric, a.hour;
