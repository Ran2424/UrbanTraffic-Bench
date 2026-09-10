WITH taxi AS (
  SELECT stat_hour AS hour, geohash,
         ROW_NUMBER() OVER (PARTITION BY stat_hour ORDER BY taxi_dropoffs DESC, geohash) AS rank
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND taxi_dropoffs IS NOT NULL
), ridehail AS (
  SELECT stat_hour AS hour, geohash,
         ROW_NUMBER() OVER (PARTITION BY stat_hour ORDER BY ridehail_dropoffs DESC, geohash) AS rank
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND ridehail_dropoffs IS NOT NULL
), bike AS (
  SELECT stat_hour AS hour, geohash,
         ROW_NUMBER() OVER (PARTITION BY stat_hour ORDER BY bike_locks DESC, geohash) AS rank
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND bike_locks IS NOT NULL
), members AS (
  SELECT hour, geohash, '出租车下客' AS metric FROM taxi WHERE rank <= 10
  UNION ALL SELECT hour, geohash, '网约车下客' FROM ridehail WHERE rank <= 10
  UNION ALL SELECT hour, geohash, '共享单车锁车' FROM bike WHERE rank <= 10
), qualified AS (
  SELECT hour, geohash, COUNT(*) AS hotspot_types,
         GROUP_CONCAT(metric, '+') AS included_metrics
  FROM members
  GROUP BY hour, geohash
  HAVING COUNT(*) >= 2
)
SELECT hour, geohash, hotspot_types, included_metrics,
       COUNT(*) OVER (PARTITION BY hour) AS qualifying_grids_in_hour
FROM qualified
ORDER BY hour, geohash;
