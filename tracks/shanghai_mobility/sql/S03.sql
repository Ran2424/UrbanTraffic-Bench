WITH daily AS (
  SELECT station_id, SUM(entry_flow) AS entry_total
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY station_id
)
SELECT d.station_id, s.station_name, d.entry_total
FROM daily AS d
JOIN metro_station AS s USING (station_id)
ORDER BY d.entry_total DESC, d.station_id
LIMIT 10;
