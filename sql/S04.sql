SELECT SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN entry_flow END) AS morning_entry,
       SUM(entry_flow) AS daily_entry,
       ROUND(100.0 * SUM(CASE WHEN stat_hour BETWEEN 7 AND 9 THEN entry_flow END)
             / NULLIF(SUM(entry_flow), 0), 2) AS morning_pct
FROM metro_flow_hour
WHERE stat_date = '2026-08-24';
