SELECT f.line_id, l.line_name,
       SUM(f.entry_flow) AS entry_total,
       SUM(f.exit_flow) AS exit_total
FROM metro_flow_hour AS f
JOIN metro_line AS l USING (line_id)
WHERE f.stat_date = '2026-08-24'
GROUP BY f.line_id, l.line_name
ORDER BY f.line_id;
