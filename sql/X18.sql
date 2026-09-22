WITH totals AS (
  SELECT CASE WHEN stat_hour BETWEEN 7 AND 9 THEN '早高峰' ELSE '晚高峰' END AS period,
         geohash,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND stat_hour IN (7, 8, 9, 17, 18, 19)
  GROUP BY period, geohash
), taxi AS (
  SELECT period, geohash,
         ROW_NUMBER() OVER (PARTITION BY period ORDER BY taxi_dropoffs DESC, geohash) AS rank
  FROM totals WHERE taxi_dropoffs IS NOT NULL
), ridehail AS (
  SELECT period, geohash,
         ROW_NUMBER() OVER (PARTITION BY period ORDER BY ridehail_dropoffs DESC, geohash) AS rank
  FROM totals WHERE ridehail_dropoffs IS NOT NULL
), members AS (
  SELECT period, geohash, 'taxi' AS mode FROM taxi WHERE rank <= 20
  UNION ALL
  SELECT period, geohash, 'ridehail' FROM ridehail WHERE rank <= 20
), counts AS (
  SELECT period, geohash, COUNT(*) AS mode_count
  FROM members GROUP BY period, geohash
)
SELECT period,
       SUM(mode_count = 2) AS intersection_count,
       COUNT(*) AS union_count,
       ROUND(1.0 * SUM(mode_count = 2) / NULLIF(COUNT(*), 0), 6) AS jaccard
FROM counts
GROUP BY period
ORDER BY period;
