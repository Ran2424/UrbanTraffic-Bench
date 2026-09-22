WITH ranked AS (
  SELECT d.bus_line_id, d.station_id, d.distance_m,
         ROW_NUMBER() OVER (
           PARTITION BY d.bus_line_id
           ORDER BY d.distance_m, d.station_id
         ) AS distance_rank
  FROM metro_bus_line_distance AS d
  WHERE d.distance_m <= 1000
)
SELECT r.bus_line_id, b.line_name,
       r.station_id, s.station_name, r.distance_m
FROM ranked AS r
JOIN bus_line AS b USING (bus_line_id)
JOIN metro_station AS s USING (station_id)
WHERE r.distance_rank = 1
ORDER BY r.bus_line_id;
