WITH daily AS (
  SELECT geohash,
         SUM(bike_locks) AS bike_locks,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
), weighted AS (
  SELECT d.station_id,
         SUM(d.distance_m * g.bike_locks) / NULLIF(SUM(g.bike_locks), 0) AS bike_average_distance,
         SUM(d.distance_m * g.ridehail_dropoffs) / NULLIF(SUM(g.ridehail_dropoffs), 0) AS ridehail_average_distance,
         SUM(g.bike_locks) AS bike_total,
         SUM(g.ridehail_dropoffs) AS ridehail_total
  FROM metro_grid_distance AS d
  JOIN daily AS g USING (geohash)
  WHERE d.distance_m <= 800
  GROUP BY d.station_id
)
SELECT w.station_id, s.station_name,
       w.bike_average_distance, w.ridehail_average_distance,
       ABS(w.bike_average_distance - w.ridehail_average_distance) AS distance_difference
FROM weighted AS w
JOIN metro_station AS s USING (station_id)
WHERE w.bike_total > 0 AND w.ridehail_total > 0
ORDER BY distance_difference DESC, w.station_id
LIMIT 10;
