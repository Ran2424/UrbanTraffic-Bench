# Database Knowledge: train__bike_share_1

- source: `train`
- db_id: `bike_share_1`
- database_dir: `database_layer/train__bike_share_1`
- db_path: `database_layer/train__bike_share_1/bike_share_1.sqlite`
- original_db_path: `train/train_databases/bike_share_1/bike_share_1.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## Table and Column Notes

### station

- `id`: unique ID for each station
- `name`: Station name
- `lat`: latitude | values: commonsense evidence: Can represent the location of the station when combined with longitude.
- `long`: longitude | values: commonsense evidence: Can represent the location of the station when combined with latitude.
- `dock_count`: number of bikes the station can hold
- `city`
- `installation_date`: installation date

### status

- `station_id`: station id
- `bikes_available`: number of available bikes | values: commonsense evidence: 0 means no bike can be borrowed.
- `docks_available`: number of available docks | values: commonsense evidence: 0 means no bike can be returned to this station.
- `time`

### trip

- `id`
- `duration`: The duration of the trip in seconds. | values: commonsense evidence: duration = end_date - start_date
- `start_date`: start date
- `start_station_name`: The name of the start station | values: commonsense evidence: It represents the station name the bike borrowed from.
- `start_station_id`: The ID of the start station
- `end_date`: end date
- `end_station_name`: The name of the end station | values: commonsense evidence: It represents the station name the bike returned to.
- `end_station_id`: The ID of the end station
- `bike_id`: The ID of the bike
- `subscription_type`: subscription type | values: Allowed input: Subscriber, Customer.
- `zip_code`: zip code

### weather

- `date`
- `max_temperature_f`: max temperature in Fahrenheit degree | values: commonsense evidence: It represents the hottest temperature.
- `mean_temperature_f`: mean temperature in Fahrenheit degree
- `min_temperature_f`: min temperature in Fahrenheit degree | values: commonsense evidence: It represents the coldest temperature.
- `max_dew_point_f`: max dew point in Fahrenheit degree
- `mean_dew_point_f`: mean dew point in Fahrenheit degree
- `min_dew_point_f`: min dew point in Fahrenheit degree
- `max_humidity`: max humidity
- `mean_humidity`: mean humidity
- `min_humidity`: min humidity
- `max_sea_level_pressure_inches`: max sea level pressure in inches
- `mean_sea_level_pressure_inches`: mean sea level pressure in inches
- `min_sea_level_pressure_inches`: min sea level pressure in inches
- `max_visibility_miles`: max visibility in miles
- `mean_visibility_miles`: mean visibility in miles
- `min_visibility_miles`: min visibility in miles
- `max_wind_Speed_mph`: max wind Speed in mph
- `mean_wind_speed_mph`: mean wind Speed in mph
- `max_gust_speed_mph`: max gust Speed in mph
- `precipitation_inches`: precipitation in inches
- `cloud_cover`: cloud cover
- `events`: values: Allowed input: [null], Rain, other
- `wind_dir_degrees`: wind direction degrees
- `zip_code`: zip code
