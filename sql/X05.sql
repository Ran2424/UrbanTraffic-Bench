WITH wide AS (
  SELECT m.hour, m.metro_entries, b.bus_flow,
         g.taxi_pickups, g.ridehail_orders, g.bike_locks
  FROM (
    SELECT stat_hour AS hour, SUM(entry_flow) AS metro_entries
    FROM metro_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  ) AS m
  JOIN (
    SELECT stat_hour AS hour, SUM(passenger_flow) AS bus_flow
    FROM bus_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  ) AS b USING (hour)
  JOIN (
    SELECT stat_hour AS hour,
           SUM(taxi_pickups) AS taxi_pickups,
           SUM(ridehail_orders) AS ridehail_orders,
           SUM(bike_locks) AS bike_locks
    FROM grid_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  ) AS g USING (hour)
  WHERE g.taxi_pickups IS NOT NULL
    AND g.ridehail_orders IS NOT NULL
    AND g.bike_locks IS NOT NULL
), long AS (
  SELECT '地铁进站量' AS metric, hour, metro_entries AS total FROM wide
  UNION ALL SELECT '公交客流量', hour, bus_flow FROM wide
  UNION ALL SELECT '出租车上车量', hour, taxi_pickups FROM wide
  UNION ALL SELECT '网约车下单量', hour, ridehail_orders FROM wide
  UNION ALL SELECT '共享单车锁车量', hour, bike_locks FROM wide
), running AS (
  SELECT metric, hour,
         SUM(total) OVER (PARTITION BY metric ORDER BY hour) AS cumulative_total,
         SUM(total) OVER (PARTITION BY metric) AS full_total
  FROM long
)
SELECT metric, MIN(hour) AS half_total_hour
FROM running
WHERE cumulative_total * 2 >= full_total
GROUP BY metric
ORDER BY metric;
