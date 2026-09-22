WITH ranked_distance AS (
  SELECT station_id, bus_line_id, distance_m,
         ROW_NUMBER() OVER (
           PARTITION BY station_id ORDER BY distance_m, bus_line_id
         ) AS near_rank
  FROM metro_bus_line_distance
  WHERE distance_m <= 800
), nearest_five AS (
  SELECT * FROM ranked_distance WHERE near_rank <= 5
), daily AS (
  SELECT bus_line_id, SUM(passenger_flow) AS daily_bus_total
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY bus_line_id
), choices AS (
  SELECT n.*, d.daily_bus_total,
         ROW_NUMBER() OVER (
           PARTITION BY n.station_id
           ORDER BY d.daily_bus_total DESC, n.bus_line_id
         ) AS flow_rank
  FROM nearest_five AS n
  LEFT JOIN daily AS d USING (bus_line_id)
)
SELECT s.station_id, s.station_name,
       c.bus_line_id, l.line_name,
       c.daily_bus_total, c.distance_m, c.near_rank
FROM metro_station AS s
LEFT JOIN choices AS c ON c.station_id = s.station_id AND c.flow_rank = 1
LEFT JOIN bus_line AS l USING (bus_line_id)
ORDER BY s.station_id;
