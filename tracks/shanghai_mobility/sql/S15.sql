SELECT f.bus_line_id, l.line_name, f.stat_hour AS hour,
       f.passenger_flow
FROM bus_flow_hour AS f
JOIN bus_line AS l USING (bus_line_id)
WHERE f.stat_date = '2026-08-24'
  AND l.line_name = '隧道夜宵线'
ORDER BY f.bus_line_id, f.stat_hour;
