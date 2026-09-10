WITH qualifying AS (
  SELECT geohash, stat_hour AS hour, ridehail_orders
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
    AND ridehail_orders > 0
    AND ridehail_dropoffs = 0
), counted AS (
  SELECT *, COUNT(*) OVER () AS qualifying_grid_hours
  FROM qualifying
)
SELECT geohash, hour, ridehail_orders, qualifying_grid_hours
FROM counted
ORDER BY ridehail_orders DESC, geohash, hour
LIMIT 10;
