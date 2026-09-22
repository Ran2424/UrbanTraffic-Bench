WITH metro_hour AS (
  SELECT station_id, stat_hour, SUM(entry_flow) AS entry_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY station_id, stat_hour
), metro AS (
  SELECT station_id, SUM(entry_flow) AS morning_entry,
         COUNT(*) AS metro_observed_hours
  FROM metro_hour GROUP BY station_id
), bus AS (
  SELECT bus_line_id, SUM(passenger_flow) AS morning_bus_flow,
         COUNT(*) AS bus_observed_hours
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY bus_line_id
), nearby AS (
  SELECT station_id, bus_line_id
  FROM metro_bus_line_distance
  WHERE distance_m <= 500
)
SELECT s.station_id, s.station_name,
       n.bus_line_id, l.line_name,
       b.morning_bus_flow, b.bus_observed_hours,
       m.morning_entry, m.metro_observed_hours
FROM metro_station AS s
LEFT JOIN nearby AS n USING (station_id)
LEFT JOIN bus_line AS l USING (bus_line_id)
LEFT JOIN bus AS b USING (bus_line_id)
LEFT JOIN metro AS m USING (station_id)
ORDER BY s.station_id, n.bus_line_id;
