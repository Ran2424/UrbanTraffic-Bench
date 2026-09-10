WITH metro AS (
  SELECT station_id, stat_hour AS hour, SUM(exit_flow) AS exit_flow
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY station_id, stat_hour
), ridehail AS (
  SELECT d.station_id, f.stat_hour AS hour,
         SUM(f.ridehail_dropoffs) AS ridehail_dropoffs
  FROM metro_grid_distance AS d
  JOIN grid_flow_hour AS f USING (geohash)
  WHERE d.distance_m <= 500
    AND f.stat_date = '2026-08-24'
    AND f.stat_hour IN (7, 8, 9, 17, 18, 19)
    AND f.ridehail_dropoffs IS NOT NULL
  GROUP BY d.station_id, f.stat_hour
), common AS (
  SELECT m.station_id, m.hour, m.exit_flow, r.ridehail_dropoffs
  FROM metro AS m JOIN ridehail AS r USING (station_id, hour)
), windows AS (
  SELECT station_id,
         SUM(CASE WHEN hour BETWEEN 7 AND 9 THEN exit_flow END) AS morning_exit,
         SUM(CASE WHEN hour BETWEEN 17 AND 19 THEN exit_flow END) AS evening_exit,
         SUM(CASE WHEN hour BETWEEN 7 AND 9 THEN ridehail_dropoffs END) AS morning_ridehail,
         SUM(CASE WHEN hour BETWEEN 17 AND 19 THEN ridehail_dropoffs END) AS evening_ridehail,
         COUNT(*) AS common_hours
  FROM common
  GROUP BY station_id
)
SELECT w.station_id, s.station_name,
       w.morning_exit, w.evening_exit,
       w.morning_ridehail, w.evening_ridehail,
       w.evening_ridehail - w.morning_ridehail AS ridehail_increase
FROM windows AS w
JOIN metro_station AS s USING (station_id)
WHERE w.common_hours = 6
  AND w.evening_exit > w.morning_exit
  AND w.evening_ridehail > w.morning_ridehail
ORDER BY ridehail_increase DESC, w.station_id
LIMIT 10;
