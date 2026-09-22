WITH presence AS (
  SELECT geohash,
         MAX(taxi_dropoffs IS NOT NULL) AS has_taxi,
         MAX(ridehail_dropoffs IS NOT NULL) AS has_ridehail,
         MAX(bike_locks IS NOT NULL) AS has_bike
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
)
SELECT SUBSTR(geohash, 1, 5) AS area5,
       SUM(has_taxi) AS taxi_grids,
       SUM(has_ridehail) AS ridehail_grids,
       SUM(has_bike) AS bike_grids,
       SUM(has_taxi AND has_ridehail AND has_bike) AS all_three_grids
FROM presence
GROUP BY SUBSTR(geohash, 1, 5)
ORDER BY area5;
