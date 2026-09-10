SELECT '地铁进站' AS mode,
       SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN entry_flow END) AS morning_total,
       SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN entry_flow END) AS evening_total
FROM metro_flow_hour WHERE stat_date = '2026-08-24'
UNION ALL
SELECT '公交客流',
       SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN passenger_flow END),
       SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN passenger_flow END)
FROM bus_flow_hour WHERE stat_date = '2026-08-24'
UNION ALL
SELECT '出租车下客',
       SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN taxi_dropoffs END),
       SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN taxi_dropoffs END)
FROM grid_flow_hour WHERE stat_date = '2026-08-24'
UNION ALL
SELECT '网约车下客',
       SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN ridehail_dropoffs END),
       SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN ridehail_dropoffs END)
FROM grid_flow_hour WHERE stat_date = '2026-08-24'
UNION ALL
SELECT '共享单车锁车',
       SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN bike_locks END),
       SUM(CASE WHEN stat_hour BETWEEN 17 AND 19 THEN bike_locks END)
FROM grid_flow_hour WHERE stat_date = '2026-08-24'
ORDER BY mode;
