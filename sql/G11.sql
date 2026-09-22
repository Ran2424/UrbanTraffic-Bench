WITH target_lines AS (
  SELECT d.bus_line_id
  FROM metro_bus_line_distance AS d
  JOIN metro_station AS s USING (station_id)
  WHERE d.distance_m <= 500
    AND s.station_name IN ('徐家汇', '上海体育馆')
  GROUP BY d.bus_line_id
  HAVING COUNT(DISTINCT s.station_name) = 2
), windows AS (
  SELECT bus_line_id,
         SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN passenger_flow END) AS morning_total,
         SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN passenger_flow END) AS evening_total,
         COUNT(*) AS observed_hours
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY bus_line_id
)
SELECT t.bus_line_id, l.line_name, w.morning_total, w.evening_total,
       w.evening_total - w.morning_total AS increase
FROM target_lines AS t
JOIN bus_line AS l USING (bus_line_id)
JOIN windows AS w USING (bus_line_id)
WHERE w.observed_hours = 6
ORDER BY t.bus_line_id;
