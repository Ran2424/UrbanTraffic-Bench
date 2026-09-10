PRAGMA foreign_keys = ON;

CREATE TABLE metro_line (
  line_id INTEGER PRIMARY KEY,
  line_name TEXT NOT NULL UNIQUE
) STRICT;

CREATE TABLE metro_station (
  station_id INTEGER PRIMARY KEY,
  station_name TEXT NOT NULL UNIQUE
) STRICT;

CREATE TABLE metro_flow_hour (
  stat_date TEXT NOT NULL,
  stat_hour INTEGER NOT NULL CHECK (stat_hour BETWEEN 0 AND 23),
  line_id INTEGER NOT NULL REFERENCES metro_line(line_id),
  station_id INTEGER NOT NULL REFERENCES metro_station(station_id),
  entry_flow INTEGER NOT NULL CHECK (entry_flow >= 0),
  exit_flow INTEGER NOT NULL CHECK (exit_flow >= 0),
  PRIMARY KEY (stat_date, stat_hour, line_id, station_id)
) STRICT, WITHOUT ROWID;

CREATE INDEX idx_metro_flow_station_hour
  ON metro_flow_hour(station_id, stat_date, stat_hour);

CREATE INDEX idx_metro_flow_line_hour
  ON metro_flow_hour(line_id, stat_date, stat_hour);

CREATE TABLE bus_line (
  bus_line_id INTEGER PRIMARY KEY,
  line_name TEXT NOT NULL
) STRICT;

CREATE TABLE bus_flow_hour (
  stat_date TEXT NOT NULL,
  stat_hour INTEGER NOT NULL CHECK (stat_hour BETWEEN 0 AND 23),
  bus_line_id INTEGER NOT NULL REFERENCES bus_line(bus_line_id),
  passenger_flow INTEGER NOT NULL CHECK (passenger_flow >= 0),
  PRIMARY KEY (stat_date, stat_hour, bus_line_id)
) STRICT, WITHOUT ROWID;

CREATE INDEX idx_bus_flow_line_hour
  ON bus_flow_hour(bus_line_id, stat_date, stat_hour);

CREATE TABLE grid (
  geohash TEXT PRIMARY KEY CHECK (length(geohash) = 7)
) STRICT, WITHOUT ROWID;

CREATE TABLE grid_flow_hour (
  stat_date TEXT NOT NULL,
  stat_hour INTEGER NOT NULL CHECK (stat_hour BETWEEN 0 AND 23),
  geohash TEXT NOT NULL REFERENCES grid(geohash),
  taxi_pickups INTEGER,
  taxi_dropoffs INTEGER,
  ridehail_orders INTEGER,
  ridehail_dropoffs INTEGER,
  bike_locks INTEGER,
  PRIMARY KEY (stat_date, stat_hour, geohash),
  CHECK (taxi_pickups IS NULL OR taxi_pickups >= 0),
  CHECK (taxi_dropoffs IS NULL OR taxi_dropoffs >= 0),
  CHECK (ridehail_orders IS NULL OR ridehail_orders >= 0),
  CHECK (ridehail_dropoffs IS NULL OR ridehail_dropoffs >= 0),
  CHECK (bike_locks IS NULL OR bike_locks >= 0),
  CHECK (
    taxi_pickups IS NOT NULL
    OR taxi_dropoffs IS NOT NULL
    OR ridehail_orders IS NOT NULL
    OR ridehail_dropoffs IS NOT NULL
    OR bike_locks IS NOT NULL
  )
) STRICT, WITHOUT ROWID;

CREATE INDEX idx_grid_flow_geohash_hour
  ON grid_flow_hour(geohash, stat_date, stat_hour);

CREATE TABLE metro_grid_distance (
  station_id INTEGER NOT NULL REFERENCES metro_station(station_id),
  geohash TEXT NOT NULL REFERENCES grid(geohash),
  distance_m REAL NOT NULL CHECK (distance_m >= 0 AND distance_m <= 1000),
  PRIMARY KEY (station_id, geohash)
) STRICT, WITHOUT ROWID;

CREATE INDEX idx_metro_grid_distance_grid
  ON metro_grid_distance(geohash, distance_m, station_id);

CREATE TABLE metro_bus_line_distance (
  station_id INTEGER NOT NULL REFERENCES metro_station(station_id),
  bus_line_id INTEGER NOT NULL REFERENCES bus_line(bus_line_id),
  distance_m REAL NOT NULL CHECK (distance_m >= 0 AND distance_m <= 1000),
  PRIMARY KEY (station_id, bus_line_id)
) STRICT, WITHOUT ROWID;

CREATE INDEX idx_metro_bus_distance_line
  ON metro_bus_line_distance(bus_line_id, distance_m, station_id);

CREATE TABLE metro_station_distance (
  station_id INTEGER NOT NULL REFERENCES metro_station(station_id),
  nearby_station_id INTEGER NOT NULL REFERENCES metro_station(station_id),
  distance_m REAL NOT NULL CHECK (distance_m >= 0 AND distance_m <= 2000),
  PRIMARY KEY (station_id, nearby_station_id),
  CHECK (station_id <> nearby_station_id)
) STRICT, WITHOUT ROWID;

CREATE INDEX idx_metro_station_distance_nearby
  ON metro_station_distance(nearby_station_id, distance_m, station_id);
