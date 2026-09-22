WITH metro AS (
  SELECT stat_hour AS hour, SUM(entry_flow) AS metro_entries
  FROM metro_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY stat_hour
), bus AS (
  SELECT stat_hour AS hour, SUM(passenger_flow) AS bus_flow
  FROM bus_flow_hour
  WHERE stat_date = '2026-08-24' AND stat_hour BETWEEN 7 AND 9
  GROUP BY stat_hour
), common AS (
  SELECT m.hour, m.metro_entries, b.bus_flow
  FROM metro AS m JOIN bus AS b USING (hour)
)
SELECT hour, metro_entries, bus_flow,
       ROUND(100.0 * metro_entries / SUM(metro_entries) OVER (), 2) AS metro_pct,
       ROUND(100.0 * bus_flow / SUM(bus_flow) OVER (), 2) AS bus_pct
FROM common
ORDER BY hour;
