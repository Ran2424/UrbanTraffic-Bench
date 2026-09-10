WITH daily AS (
  SELECT geohash,
         SUM(taxi_dropoffs) AS taxi_dropoffs,
         SUM(ridehail_dropoffs) AS ridehail_dropoffs
  FROM grid_flow_hour
  WHERE stat_date = '2026-08-24'
  GROUP BY geohash
), taxi AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY taxi_dropoffs DESC, geohash) AS taxi_rank
  FROM daily WHERE taxi_dropoffs IS NOT NULL
), ridehail AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY ridehail_dropoffs DESC, geohash) AS ridehail_rank
  FROM daily WHERE ridehail_dropoffs IS NOT NULL
)
SELECT t.geohash, t.taxi_dropoffs, r.ridehail_dropoffs,
       t.taxi_rank, r.ridehail_rank
FROM taxi AS t
JOIN ridehail AS r USING (geohash)
WHERE t.taxi_rank <= 100 AND r.ridehail_rank <= 100
ORDER BY t.taxi_rank, r.ridehail_rank, t.geohash;
