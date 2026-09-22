WITH metro AS (
  SELECT stat_hour AS hour, SUM(entry_flow) AS metro_entries
  FROM metro_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
), bus AS (
  SELECT stat_hour AS hour, SUM(passenger_flow) AS bus_flow
  FROM bus_flow_hour WHERE stat_date = '2026-08-24' GROUP BY stat_hour
), common AS (
  SELECT m.hour, m.metro_entries, b.bus_flow
  FROM metro AS m JOIN bus AS b USING (hour)
), ranked AS (
  SELECT *,
         DENSE_RANK() OVER (ORDER BY metro_entries DESC) AS metro_rank,
         DENSE_RANK() OVER (ORDER BY bus_flow DESC) AS bus_rank
  FROM common
), differences AS (
  SELECT *, ABS(metro_rank - bus_rank) AS rank_difference
  FROM ranked
)
SELECT hour, metro_entries, bus_flow, metro_rank, bus_rank, rank_difference
FROM differences
WHERE rank_difference = (SELECT MAX(rank_difference) FROM differences)
ORDER BY hour;
