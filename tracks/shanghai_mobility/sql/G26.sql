WITH ranked AS (
  SELECT station_id, geohash, distance_m,
         ROW_NUMBER() OVER (
           PARTITION BY geohash ORDER BY distance_m, station_id
         ) AS rn
  FROM metro_grid_distance
), owners AS (
  SELECT station_id, geohash,
         CASE
           WHEN distance_m <= 300 THEN '0-300'
           WHEN distance_m <= 500 THEN '300-500'
           ELSE '500-1000'
         END AS ring
  FROM ranked WHERE rn = 1
), evening AS (
  SELECT geohash,
         SUM(bike_locks) AS bike_locks,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 17 AND 19
  GROUP BY geohash
), totals AS (
  SELECT o.station_id, o.ring,
         SUM(e.bike_locks) AS evening_bike,
         SUM(e.ridehail_dropoffs) AS evening_ridehail
  FROM owners AS o
  LEFT JOIN evening AS e USING (geohash)
  GROUP BY o.station_id, o.ring
), rings(ring) AS (
  SELECT '0-300' UNION ALL SELECT '300-500' UNION ALL SELECT '500-1000'
)
SELECT s.station_id, s.station_name, r.ring,
       t.evening_bike, t.evening_ridehail
FROM metro_station AS s CROSS JOIN rings AS r
LEFT JOIN totals AS t USING (station_id, ring)
ORDER BY s.station_id, r.ring;
