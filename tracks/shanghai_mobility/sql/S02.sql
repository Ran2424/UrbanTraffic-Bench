SELECT stat_hour AS hour,
       SUM(entry_flow) AS entry_total,
       SUM(exit_flow) AS exit_total
FROM metro_flow_hour
WHERE stat_date = '2026-08-24'
GROUP BY stat_hour
ORDER BY stat_hour;
