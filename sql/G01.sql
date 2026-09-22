WITH metro AS (
  SELECT station_id, SUM(exit_flow) AS morning_exit
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY station_id
), bike_grid AS (
  SELECT geohash, SUM(bike_locks) AS morning_bike
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour BETWEEN 7 AND 9
    AND bike_locks IS NOT NULL
  GROUP BY geohash
), bike_station AS (
  SELECT d.station_id, SUM(b.morning_bike) AS morning_bike
  FROM metro_grid_distance AS d
  JOIN bike_grid AS b USING (geohash)
  WHERE d.distance_m <= 500
  GROUP BY d.station_id
), common AS (
  SELECT m.station_id, m.morning_exit, b.morning_bike
  FROM metro AS m JOIN bike_station AS b USING (station_id)
), ranked AS (
  SELECT *,
         RANK() OVER (ORDER BY morning_exit DESC) AS metro_rank,
         RANK() OVER (ORDER BY morning_bike DESC) AS bike_rank
  FROM common
), differences AS (
  SELECT *, ABS(metro_rank - bike_rank) AS rank_difference
  FROM ranked
)
SELECT d.station_id, s.station_name, d.morning_exit, d.morning_bike,
       d.metro_rank, d.bike_rank, d.rank_difference
FROM differences AS d
JOIN metro_station AS s USING (station_id)
ORDER BY d.rank_difference DESC, d.station_id
LIMIT 10;
