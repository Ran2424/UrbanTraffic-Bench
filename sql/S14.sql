SELECT f.bus_line_id, l.line_name,
       SUM(f.passenger_flow) AS night_total,
       COUNT(*) AS positive_hours
FROM bus_flow_hour AS f
JOIN bus_line AS l USING (bus_line_id)
WHERE f.stat_date = '2026-08-24'
  AND f.stat_hour BETWEEN 0 AND 5
  AND f.passenger_flow > 0
GROUP BY f.bus_line_id, l.line_name
ORDER BY night_total DESC, f.bus_line_id;
