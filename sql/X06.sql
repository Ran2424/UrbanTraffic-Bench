WITH metro AS (
  SELECT stat_hour AS hour, SUM(entry_flow) AS metro_entries
  FROM metro_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
), ridehail AS (
  SELECT stat_hour AS hour, SUM(ridehail_orders) AS ridehail_orders
  FROM grid_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
), common AS (
  SELECT m.hour, m.metro_entries, r.ridehail_orders
  FROM metro AS m JOIN ridehail AS r USING (hour)
), shares AS (
  SELECT hour,
         100.0 * metro_entries / SUM(metro_entries) OVER () AS metro_pct,
         100.0 * ridehail_orders / SUM(ridehail_orders) OVER () AS ridehail_pct
  FROM common
), differences AS (
  SELECT *, ABS(metro_pct - ridehail_pct) AS difference_pct
  FROM shares
)
SELECT hour, ROUND(metro_pct, 2) AS metro_pct,
       ROUND(ridehail_pct, 2) AS ridehail_pct,
       ROUND(difference_pct, 2) AS difference_pct
FROM differences
WHERE difference_pct = (SELECT MAX(difference_pct) FROM differences)
ORDER BY hour;
