WITH target AS (
  SELECT station_id, station_name
  FROM metro_station
  WHERE station_name IN ('徐家汇', '上海体育馆')
), membership AS (
  SELECT d.geohash,
         MAX(t.station_name = '徐家汇') AS near_xujiahui,
         MAX(t.station_name = '上海体育馆') AS near_stadium
  FROM metro_grid_distance AS d
  JOIN target AS t USING (station_id)
  WHERE d.distance_m <= 800
  GROUP BY d.geohash
), classified AS (
  SELECT geohash,
         CASE
           WHEN near_xujiahui AND near_stadium THEN '两站都覆盖'
           WHEN near_xujiahui THEN '只靠近徐家汇'
           ELSE '只靠近上海体育馆'
         END AS area_type
  FROM membership
), totals AS (
  SELECT c.area_type,
         SUM(f.taxi_dropoffs) AS evening_taxi,
         SUM(f.ridehail_dropoffs) AS evening_ridehail,
         SUM(f.bike_locks) AS evening_bike
  FROM classified AS c
  LEFT JOIN grid_flow_hour AS f
    ON f.geohash = c.geohash
   AND f.stat_date = '2026-08-24'
   AND f.stat_hour BETWEEN 17 AND 19
  GROUP BY c.area_type
), axis(area_type) AS (
  SELECT '只靠近徐家汇'
  UNION ALL SELECT '只靠近上海体育馆'
  UNION ALL SELECT '两站都覆盖'
)
SELECT a.area_type, t.evening_taxi, t.evening_ridehail, t.evening_bike
FROM axis AS a LEFT JOIN totals AS t USING (area_type)
ORDER BY a.area_type;
