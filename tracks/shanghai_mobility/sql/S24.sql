WITH ranked AS (
  SELECT stat_hour AS hour, geohash, taxi_dropoffs,
         ROW_NUMBER() OVER (
           PARTITION BY stat_hour
           ORDER BY taxi_dropoffs DESC, geohash
         ) AS rank_in_hour
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND taxi_dropoffs IS NOT NULL
)
SELECT hour, geohash, taxi_dropoffs AS dropoff_total, rank_in_hour
FROM ranked
WHERE rank_in_hour <= 3
ORDER BY hour, rank_in_hour;
