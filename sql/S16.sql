WITH coverage AS (
  SELECT bus_line_id,
         COUNT(*) AS observed_hours,
         SUM(passenger_flow) AS daily_total,
         AVG(passenger_flow) AS average_hourly_flow
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY bus_line_id
  HAVING COUNT(*) < 18
)
SELECT c.bus_line_id, l.line_name, c.observed_hours, c.daily_total,
       ROUND(c.average_hourly_flow, 2) AS average_hourly_flow
FROM coverage AS c
JOIN bus_line AS l USING (bus_line_id)
ORDER BY c.average_hourly_flow DESC, c.bus_line_id
LIMIT 10;
