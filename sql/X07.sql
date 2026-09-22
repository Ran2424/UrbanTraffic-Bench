WITH hourly AS (
  SELECT m.hour, m.metro_entries, b.bus_flow
  FROM (
    SELECT stat_hour AS hour, SUM(entry_flow) AS metro_entries
    FROM metro_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  ) AS m
  JOIN (
    SELECT stat_hour AS hour, SUM(passenger_flow) AS bus_flow
    FROM bus_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
  ) AS b USING (hour)
)
SELECT a.hour AS previous_hour, b.hour AS current_hour,
       b.metro_entries - a.metro_entries AS metro_increase,
       b.bus_flow - a.bus_flow AS bus_increase
FROM hourly AS a
JOIN hourly AS b ON b.hour = a.hour + 1
WHERE b.metro_entries > a.metro_entries
  AND b.bus_flow > a.bus_flow
ORDER BY a.hour;
