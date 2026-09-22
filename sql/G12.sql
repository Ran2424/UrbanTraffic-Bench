WITH ranked AS (
  SELECT station_id, bus_line_id,
         ROW_NUMBER() OVER (
           PARTITION BY bus_line_id ORDER BY distance_m, station_id
         ) AS rn
  FROM metro_bus_line_distance
  WHERE distance_m <= 500
), assigned AS (
  SELECT station_id, bus_line_id FROM ranked WHERE rn = 1
), bus_daily AS (
  SELECT bus_line_id, SUM(passenger_flow) AS daily_bus_total
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY bus_line_id
), assigned_totals AS (
  SELECT a.station_id,
         COUNT(*) AS assigned_lines,
         SUM(b.daily_bus_total) AS assigned_bus_total
  FROM assigned AS a
  LEFT JOIN bus_daily AS b USING (bus_line_id)
  GROUP BY a.station_id
), metro AS (
  SELECT station_id, SUM(entry_flow) AS metro_entry_total
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY station_id
)
SELECT s.station_id, s.station_name,
       COALESCE(a.assigned_lines, 0) AS assigned_lines,
       a.assigned_bus_total, m.metro_entry_total
FROM metro_station AS s
LEFT JOIN assigned_totals AS a USING (station_id)
LEFT JOIN metro AS m USING (station_id)
ORDER BY s.station_id;
