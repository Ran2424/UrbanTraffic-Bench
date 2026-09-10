WITH line_station AS (
  SELECT DISTINCT line_id, station_id FROM metro_flow_hour
), line_grid AS (
  SELECT DISTINCT ls.line_id, d.geohash
  FROM line_station AS ls
  JOIN metro_grid_distance AS d USING (station_id)
  WHERE d.distance_m <= 500
), evening AS (
  SELECT geohash,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs,
         SUM(bike_locks) AS bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 17 AND 19
  GROUP BY geohash
), totals AS (
  SELECT l.line_id, l.line_name,
         SUM(e.ridehail_dropoffs) AS evening_ridehail,
         SUM(e.bike_locks) AS evening_bike
  FROM metro_line AS l
  LEFT JOIN line_grid AS g USING (line_id)
  LEFT JOIN evening AS e USING (geohash)
  GROUP BY l.line_id, l.line_name
), ranked AS (
  SELECT *,
         CASE WHEN evening_ridehail IS NOT NULL THEN
           RANK() OVER (ORDER BY evening_ridehail DESC)
         END AS ridehail_rank,
         CASE WHEN evening_bike IS NOT NULL THEN
           RANK() OVER (ORDER BY evening_bike DESC)
         END AS bike_rank
  FROM totals
)
SELECT line_id, line_name, evening_ridehail, evening_bike,
       ridehail_rank, bike_rank
FROM ranked
ORDER BY line_id;
