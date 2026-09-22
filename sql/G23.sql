WITH station_grid AS (
  SELECT station_id, geohash
  FROM metro_grid_distance WHERE distance_m <= 500
), shared AS (
  SELECT a.station_id AS station_a_id,
         b.station_id AS station_b_id,
         a.geohash
  FROM station_grid AS a
  JOIN station_grid AS b
    ON b.geohash = a.geohash AND b.station_id > a.station_id
), morning AS (
  SELECT geohash,
         SUM(bike_locks) AS bike_locks,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY geohash
), pair_totals AS (
  SELECT s.station_a_id, s.station_b_id,
         SUM(m.bike_locks) AS morning_bike,
         SUM(m.ridehail_dropoffs) AS morning_ridehail
  FROM shared AS s
  JOIN morning AS m USING (geohash)
  GROUP BY s.station_a_id, s.station_b_id
)
SELECT p.station_a_id, a.station_name AS station_a_name,
       p.station_b_id, b.station_name AS station_b_name,
       p.morning_bike, p.morning_ridehail
FROM pair_totals AS p
JOIN metro_station AS a ON a.station_id = p.station_a_id
JOIN metro_station AS b ON b.station_id = p.station_b_id
ORDER BY p.morning_bike DESC, p.station_a_id, p.station_b_id
LIMIT 10;
