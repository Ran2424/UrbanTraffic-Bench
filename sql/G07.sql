WITH candidates AS (
  SELECT geohash
  FROM metro_grid_distance
  WHERE distance_m <= 500
  GROUP BY geohash
  HAVING COUNT(DISTINCT station_id) >= 2
), ranked AS (
  SELECT d.station_id, d.geohash, d.distance_m,
         ROW_NUMBER() OVER (
           PARTITION BY d.geohash ORDER BY d.distance_m, d.station_id
         ) AS rn
  FROM metro_grid_distance AS d
  JOIN candidates AS c USING (geohash)
  WHERE d.distance_m <= 500
), owners AS (
  SELECT station_id, geohash FROM ranked WHERE rn = 1
), assigned_stations AS (
  SELECT DISTINCT station_id FROM owners
), totals AS (
  SELECT o.station_id,
         SUM(f.bike_locks) AS evening_bike,
         SUM(f.ridehail_dropoffs) AS evening_ridehail
  FROM owners AS o
  LEFT JOIN grid_flow_hour AS f
    ON f.geohash = o.geohash
   AND f.stat_date = '2026-08-24'
   AND f.stat_hour BETWEEN 17 AND 19
  GROUP BY o.station_id
)
SELECT a.station_id, s.station_name, t.evening_bike, t.evening_ridehail
FROM assigned_stations AS a
JOIN metro_station AS s USING (station_id)
LEFT JOIN totals AS t USING (station_id)
ORDER BY a.station_id;
