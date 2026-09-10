WITH bus AS (
  SELECT stat_hour AS hour, SUM(passenger_flow) AS bus_flow
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY stat_hour
), ridehail AS (
  SELECT stat_hour AS hour, SUM(ridehail_orders) AS ridehail_orders
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY stat_hour
), common AS (
  SELECT b.hour, b.bus_flow, r.ridehail_orders
  FROM bus AS b JOIN ridehail AS r USING (hour)
), windows AS (
  SELECT a.hour AS start_hour, c.hour AS end_hour,
         a.bus_flow + b.bus_flow + c.bus_flow AS bus_total,
         a.ridehail_orders + b.ridehail_orders + c.ridehail_orders AS ridehail_total
  FROM common AS a
  JOIN common AS b ON b.hour = a.hour + 1
  JOIN common AS c ON c.hour = a.hour + 2
), answers AS (
  SELECT '公交客流' AS metric, start_hour, end_hour, bus_total AS window_total
  FROM windows WHERE bus_total = (SELECT MAX(bus_total) FROM windows)
  UNION ALL
  SELECT '网约车下单量', start_hour, end_hour, ridehail_total
  FROM windows WHERE ridehail_total = (SELECT MAX(ridehail_total) FROM windows)
)
SELECT metric, start_hour, end_hour, window_total
FROM answers
ORDER BY metric, start_hour;
