WITH long AS (
  SELECT stat_hour AS hour, geohash, 'ridehail' AS metric, ridehail_dropoffs AS value
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND ridehail_dropoffs IS NOT NULL
  UNION ALL
  SELECT stat_hour, geohash, 'bike', bike_locks
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND bike_locks IS NOT NULL
), ranked AS (
  SELECT *, ROW_NUMBER() OVER (
    PARTITION BY metric, hour ORDER BY value DESC, geohash
  ) AS rank_in_hour
  FROM long
), concentration AS (
  SELECT metric, hour,
         1.0 * SUM(CASE WHEN rank_in_hour <= 10 THEN value END)
         / NULLIF(SUM(value), 0) AS concentration
  FROM ranked
  GROUP BY metric, hour
  HAVING SUM(value) > 0
), wide AS (
  SELECT hour,
         MAX(CASE WHEN metric = 'ridehail' THEN concentration END) AS ridehail_concentration,
         MAX(CASE WHEN metric = 'bike' THEN concentration END) AS bike_concentration
  FROM concentration
  GROUP BY hour
  HAVING ridehail_concentration IS NOT NULL AND bike_concentration IS NOT NULL
), compared AS (
  SELECT *,
         AVG(ridehail_concentration) OVER () AS average_ridehail_concentration,
         AVG(bike_concentration) OVER () AS average_bike_concentration
  FROM wide
)
SELECT hour,
       ROUND(ridehail_concentration, 6) AS ridehail_concentration,
       ROUND(bike_concentration, 6) AS bike_concentration,
       ROUND(average_ridehail_concentration, 6) AS average_ridehail_concentration,
       ROUND(average_bike_concentration, 6) AS average_bike_concentration
FROM compared
WHERE ridehail_concentration > average_ridehail_concentration
  AND bike_concentration > average_bike_concentration
ORDER BY hour;
