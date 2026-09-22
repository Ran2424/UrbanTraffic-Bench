WITH station_hour AS (
  SELECT d.station_id, f.stat_hour AS hour,
         SUM(f.bike_locks) AS bike_locks,
         SUM(f.taxi_dropoffs) AS taxi_dropoffs
  FROM metro_grid_distance AS d
  JOIN grid_flow_hour AS f USING (geohash)
  WHERE d.distance_m <= 500 AND f.stat_date = '2026-08-24'
  GROUP BY d.station_id, f.stat_hour
), windows AS (
  SELECT a.station_id, a.hour AS start_hour,
         a.bike_locks + b.bike_locks + c.bike_locks AS bike_window,
         a.taxi_dropoffs + b.taxi_dropoffs + c.taxi_dropoffs AS taxi_window
  FROM station_hour AS a
  JOIN station_hour AS b ON b.station_id = a.station_id AND b.hour = a.hour + 1
  JOIN station_hour AS c ON c.station_id = a.station_id AND c.hour = a.hour + 2
  WHERE a.bike_locks IS NOT NULL AND b.bike_locks IS NOT NULL AND c.bike_locks IS NOT NULL
    AND a.taxi_dropoffs IS NOT NULL AND b.taxi_dropoffs IS NOT NULL AND c.taxi_dropoffs IS NOT NULL
), peaks AS (
  SELECT *,
         MAX(bike_window) OVER (PARTITION BY station_id) AS max_bike_window,
         MAX(taxi_window) OVER (PARTITION BY station_id) AS max_taxi_window
  FROM windows
)
SELECT p.station_id, s.station_name, p.start_hour,
       p.bike_window, p.taxi_window
FROM peaks AS p
JOIN metro_station AS s USING (station_id)
WHERE p.bike_window = p.max_bike_window
  AND p.taxi_window = p.max_taxi_window
ORDER BY p.station_id, p.start_hour;
