WITH station_hour AS (
  SELECT station_id, stat_hour,
         SUM(entry_flow) AS entry_flow,
         SUM(exit_flow) AS exit_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY station_id, stat_hour
), ranked AS (
  SELECT station_id,
         SUM(entry_flow) AS entry_total,
         SUM(exit_flow) AS exit_total,
         SUM(exit_flow) - SUM(entry_flow) AS difference,
         COUNT(*) AS compared_hours
  FROM station_hour
  GROUP BY station_id
  HAVING SUM(exit_flow) > SUM(entry_flow)
)
SELECT r.station_id, s.station_name, r.entry_total, r.exit_total,
       r.difference, r.compared_hours
FROM ranked AS r
JOIN metro_station AS s USING (station_id)
ORDER BY r.difference DESC, r.station_id
LIMIT 10;
