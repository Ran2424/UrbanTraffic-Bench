WITH nearby AS (
  SELECT bus_line_id, COUNT(DISTINCT station_id) AS station_count
  FROM metro_bus_line_distance
  WHERE distance_m <= 500
  GROUP BY bus_line_id
  HAVING COUNT(DISTINCT station_id) >= 3
), daily AS (
  SELECT bus_line_id, SUM(passenger_flow) AS daily_bus_total
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY bus_line_id
)
SELECT n.bus_line_id, l.line_name, n.station_count, d.daily_bus_total
FROM nearby AS n
JOIN bus_line AS l USING (bus_line_id)
LEFT JOIN daily AS d USING (bus_line_id)
ORDER BY n.station_count DESC, n.bus_line_id;
