WITH peaks AS (
  SELECT bus_line_id, MAX(passenger_flow) AS peak_flow
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY bus_line_id
)
SELECT f.bus_line_id, l.line_name, f.stat_hour AS peak_hour,
       f.passenger_flow AS peak_flow
FROM bus_flow_hour AS f
JOIN peaks AS p ON p.bus_line_id = f.bus_line_id
               AND p.peak_flow = f.passenger_flow
JOIN bus_line AS l USING (bus_line_id)
WHERE f.stat_date = '2026-08-24'
ORDER BY f.bus_line_id, f.stat_hour;
