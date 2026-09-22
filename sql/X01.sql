WITH metro AS (
  SELECT stat_hour AS hour, SUM(entry_flow) AS metro_entries
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY stat_hour
), bus AS (
  SELECT stat_hour AS hour, SUM(passenger_flow) AS bus_flow
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY stat_hour
), common AS (
  SELECT m.hour, m.metro_entries, b.bus_flow
  FROM metro AS m JOIN bus AS b USING (hour)
)
SELECT hour, metro_entries, bus_flow,
       SUM(metro_entries) OVER (ORDER BY hour) AS cumulative_metro_entries,
       SUM(bus_flow) OVER (ORDER BY hour) AS cumulative_bus_flow
FROM common
ORDER BY hour;
