SELECT SUM(entry_flow) AS entry_total,
       SUM(exit_flow) AS exit_total
FROM metro_flow_hour
WHERE stat_date = '2026-08-24';
