SELECT f.station_id, s.station_name, f.stat_hour AS hour,
       SUM(f.entry_flow) AS entry_total,
       SUM(f.exit_flow) AS exit_total
FROM metro_flow_hour AS f
JOIN metro_station AS s USING (station_id)
WHERE f.stat_date = '2026-08-24' AND s.station_name = '徐家汇'
GROUP BY f.station_id, s.station_name, f.stat_hour
ORDER BY f.stat_hour;
