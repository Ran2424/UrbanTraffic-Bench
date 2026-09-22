WITH station_hour AS (
  SELECT station_id, stat_hour, SUM(entry_flow) AS entry_total
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY station_id, stat_hour
), peaks AS (
  SELECT station_id, MAX(entry_total) AS peak_entry
  FROM station_hour
  GROUP BY station_id
)
SELECT h.station_id, s.station_name, h.stat_hour AS peak_hour,
       h.entry_total AS peak_entry
FROM station_hour AS h
JOIN peaks AS p ON p.station_id = h.station_id
               AND p.peak_entry = h.entry_total
JOIN metro_station AS s USING (station_id)
ORDER BY h.station_id, h.stat_hour;
