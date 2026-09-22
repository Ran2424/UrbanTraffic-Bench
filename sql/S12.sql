WITH windows AS (
  SELECT bus_line_id,
         SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN passenger_flow END) AS morning_total,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN passenger_flow END) AS evening_total,
         COUNT(*) AS observed_hours
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY bus_line_id
)
SELECT w.bus_line_id, l.line_name, w.morning_total, w.evening_total,
       w.evening_total - w.morning_total AS increase
FROM windows AS w
JOIN bus_line AS l USING (bus_line_id)
WHERE w.observed_hours = 6
ORDER BY increase DESC, w.bus_line_id
LIMIT 10;
