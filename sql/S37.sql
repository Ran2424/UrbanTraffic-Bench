WITH daily AS (
  SELECT geohash, SUM(bike_locks) AS lock_total
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND bike_locks IS NOT NULL
  GROUP BY geohash
), ranked AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY lock_total DESC, geohash) AS rn
  FROM daily
)
SELECT SUM(CASE WHEN rn <= 10 THEN lock_total END) AS top10_locks,
       SUM(lock_total) AS all_locks,
       ROUND(100.0 * SUM(CASE WHEN rn <= 10 THEN lock_total END)
             / NULLIF(SUM(lock_total), 0), 2) AS top10_pct
FROM ranked;
