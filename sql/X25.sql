WITH metro AS (
  SELECT SUM(entry_flow) AS metro_entries
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24'
), bus AS (
  SELECT SUM(passenger_flow) AS bus_flow
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24'
)
SELECT metro_entries, bus_flow,
       ROUND(1.0 * bus_flow / NULLIF(metro_entries, 0), 6) AS bus_to_metro_ratio
FROM metro CROSS JOIN bus;
