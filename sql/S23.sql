WITH daily AS (
  SELECT geohash, SUM(taxi_pickups) AS pickup_total
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24' AND taxi_pickups IS NOT NULL
  GROUP BY geohash
), ranked AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY pickup_total DESC, geohash) AS rn
  FROM daily
)
SELECT SUM(CASE WHEN rn <= 10 THEN pickup_total END) AS top10_pickups,
       SUM(pickup_total) AS all_pickups,
       ROUND(100.0 * SUM(CASE WHEN rn <= 10 THEN pickup_total END)
             / NULLIF(SUM(pickup_total), 0), 2) AS top10_pct
FROM ranked;
