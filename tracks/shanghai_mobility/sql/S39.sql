SELECT SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN bike_locks END) AS morning_locks,
       SUM(bike_locks) AS daily_locks,
       ROUND(100.0 * SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN bike_locks END)
             / NULLIF(SUM(bike_locks), 0), 2) AS morning_pct
FROM grid_flow_hour
WHERE stat_date = '2026-08-24';
