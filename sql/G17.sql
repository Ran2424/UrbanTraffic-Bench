WITH ranked_neighbors AS (
  SELECT station_id, nearby_station_id, distance_m,
         ROW_NUMBER() OVER (
           PARTITION BY station_id ORDER BY distance_m, nearby_station_id
         ) AS rn
  FROM metro_station_distance
), chosen AS (
  SELECT * FROM ranked_neighbors WHERE rn <= 3
), station_hour AS (
  SELECT station_id, stat_hour, SUM(entry_flow) AS entry_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY station_id, stat_hour
), morning AS (
  SELECT station_id, SUM(entry_flow) AS morning_entry, COUNT(*) AS observed_hours
  FROM station_hour GROUP BY station_id
), neighbor_summary AS (
  SELECT c.station_id,
         COUNT(*) AS selected_neighbor_count,
         SUM(CASE WHEN m.observed_hours = 3 THEN 1 ELSE 0 END) AS valid_neighbor_count,
         SUM(CASE WHEN m.observed_hours = 3 THEN m.morning_entry END) AS available_neighbor_entry
  FROM chosen AS c
  LEFT JOIN morning AS m ON m.station_id = c.nearby_station_id
  GROUP BY c.station_id
)
SELECT s.station_id, s.station_name,
       CASE WHEN own.observed_hours = 3 THEN own.morning_entry END AS station_morning_entry,
       COALESCE(n.selected_neighbor_count, 0) AS selected_neighbor_count,
       COALESCE(n.valid_neighbor_count, 0) AS valid_neighbor_count,
       CASE WHEN n.selected_neighbor_count = n.valid_neighbor_count
            THEN n.available_neighbor_entry END AS neighbor_entry_total
FROM metro_station AS s
LEFT JOIN morning AS own USING (station_id)
LEFT JOIN neighbor_summary AS n USING (station_id)
ORDER BY s.station_id;
