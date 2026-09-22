SELECT d.geohash, d.distance_m
FROM metro_grid_distance AS d
JOIN metro_station AS s USING (station_id)
WHERE s.station_name = '徐家汇' AND d.distance_m <= 500
ORDER BY d.distance_m, d.geohash;
