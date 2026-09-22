SELECT s.station_id, s.station_name,
       COUNT(DISTINCT d.geohash) AS grid_count
FROM metro_station AS s
LEFT JOIN metro_grid_distance AS d
  ON d.station_id = s.station_id AND d.distance_m <= 500
GROUP BY s.station_id, s.station_name
ORDER BY s.station_id;
