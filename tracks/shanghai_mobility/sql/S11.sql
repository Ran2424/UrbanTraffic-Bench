WITH daily AS (
  SELECT bus_line_id, SUM(passenger_flow) AS bus_total
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY bus_line_id
)
SELECT d.bus_line_id, l.line_name, d.bus_total
FROM daily AS d
JOIN bus_line AS l USING (bus_line_id)
ORDER BY d.bus_total DESC, d.bus_line_id
LIMIT 10;
