SELECT stat_hour AS hour,
       SUM(passenger_flow) AS bus_total,
       COUNT(*) AS observed_lines
FROM bus_flow_hour
WHERE stat_date = '2026-08-24'
GROUP BY stat_hour
ORDER BY stat_hour;
