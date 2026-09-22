WITH station_exit AS (
  SELECT station_id, SUM(exit_flow) AS morning_exit
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY station_id
), top_stations AS (
  SELECT station_id FROM station_exit
  ORDER BY morning_exit DESC, station_id LIMIT 10
), selected_grids AS (
  SELECT DISTINCT geohash
  FROM metro_grid_distance JOIN top_stations USING (station_id)
  WHERE distance_m <= 500
), all_station_grids AS (
  SELECT DISTINCT geohash
  FROM metro_grid_distance WHERE distance_m <= 500
), totals AS (
  SELECT
    SUM(CASE WHEN s.geohash IS NOT NULL THEN f.taxi_dropoffs END) AS selected_taxi,
    SUM(CASE WHEN a.geohash IS NOT NULL THEN f.taxi_dropoffs END) AS all_taxi,
    SUM(CASE WHEN s.geohash IS NOT NULL THEN f.ridehail_dropoffs END) AS selected_ridehail,
    SUM(CASE WHEN a.geohash IS NOT NULL THEN f.ridehail_dropoffs END) AS all_ridehail,
    SUM(CASE WHEN s.geohash IS NOT NULL THEN f.bike_locks END) AS selected_bike,
    SUM(CASE WHEN a.geohash IS NOT NULL THEN f.bike_locks END) AS all_bike
  FROM grid_flow_hour AS f
  LEFT JOIN selected_grids AS s USING (geohash)
  LEFT JOIN all_station_grids AS a USING (geohash)
  WHERE f.stat_date = '2026-08-24'
)
SELECT '出租车下客' AS metric, selected_taxi AS selected_total,
       all_taxi AS all_station_total,
       ROUND(100.0 * selected_taxi / NULLIF(all_taxi, 0), 2) AS selected_pct
FROM totals
UNION ALL
SELECT '网约车下客', selected_ridehail, all_ridehail,
       ROUND(100.0 * selected_ridehail / NULLIF(all_ridehail, 0), 2)
FROM totals
UNION ALL
SELECT '共享单车锁车', selected_bike, all_bike,
       ROUND(100.0 * selected_bike / NULLIF(all_bike, 0), 2)
FROM totals;
