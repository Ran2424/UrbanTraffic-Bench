WITH daily AS (
  SELECT geohash, SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
)
SELECT s.station_id, s.station_name,
       SUM(daily.ridehail_dropoffs) AS ridehail_dropoffs,
       COUNT(daily.ridehail_dropoffs) AS observed_grids
FROM metro_station AS s
LEFT JOIN metro_grid_distance AS d
  ON d.station_id = s.station_id AND d.distance_m <= 800
LEFT JOIN daily USING (geohash)
GROUP BY s.station_id, s.station_name
ORDER BY s.station_id;
