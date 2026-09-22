WITH outer_lines AS (
  SELECT station_id, bus_line_id, distance_m
  FROM metro_bus_line_distance
  WHERE distance_m > 500 AND distance_m <= 1000
), bus AS (
  SELECT bus_line_id, SUM(passenger_flow) AS morning_bus_flow,
         COUNT(*) AS observed_hours
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY bus_line_id
)
SELECT s.station_id, s.station_name,
       o.bus_line_id, l.line_name, o.distance_m,
       b.morning_bus_flow, b.observed_hours
FROM metro_station AS s
LEFT JOIN outer_lines AS o USING (station_id)
LEFT JOIN bus_line AS l USING (bus_line_id)
LEFT JOIN bus AS b USING (bus_line_id)
ORDER BY s.station_id, o.bus_line_id;
