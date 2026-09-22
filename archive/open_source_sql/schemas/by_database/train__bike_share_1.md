# train__bike_share_1

- 场景：共享单车 (`bike_micromobility`)
- 来源：`train`
- 原始 db_id：`bike_share_1`
- Task 数：113
- 表数：4
- 字段数：46
- 总行数：72647070
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/train__bike_share_1/bike_share_1.sqlite`

## 表：`station`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INTEGER` | 是 |  | unique ID for each station |
| `name` | `TEXT` | 否 |  | Station name |
| `lat` | `REAL` | 否 |  | latitude |
| `long` | `REAL` | 否 |  | longitude |
| `dock_count` | `INTEGER` | 否 |  | number of bikes the station can hold |
| `city` | `TEXT` | 否 |  |  |
| `installation_date` | `TEXT` | 否 |  | installation date |

## 表：`status`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `station_id` | `INTEGER` | 否 |  | station id |
| `bikes_available` | `INTEGER` | 否 |  | number of available bikes |
| `docks_available` | `INTEGER` | 否 |  | number of available docks |
| `time` | `TEXT` | 否 |  |  |

## 表：`trip`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INTEGER` | 是 |  |  |
| `duration` | `INTEGER` | 否 |  | The duration of the trip in seconds. |
| `start_date` | `TEXT` | 否 |  | start date |
| `start_station_name` | `TEXT` | 否 |  | The name of the start station |
| `start_station_id` | `INTEGER` | 否 |  | The ID of the start station |
| `end_date` | `TEXT` | 否 |  | end date |
| `end_station_name` | `TEXT` | 否 |  | The name of the end station |
| `end_station_id` | `INTEGER` | 否 |  | The ID of the end station |
| `bike_id` | `INTEGER` | 否 |  | The ID of the bike |
| `subscription_type` | `TEXT` | 否 |  | subscription type |
| `zip_code` | `INTEGER` | 否 |  | zip code |

## 表：`weather`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `date` | `TEXT` | 否 |  |  |
| `max_temperature_f` | `INTEGER` | 否 |  | max temperature in Fahrenheit degree |
| `mean_temperature_f` | `INTEGER` | 否 |  | mean temperature in Fahrenheit degree |
| `min_temperature_f` | `INTEGER` | 否 |  | min temperature in Fahrenheit degree |
| `max_dew_point_f` | `INTEGER` | 否 |  | max dew point in Fahrenheit degree |
| `mean_dew_point_f` | `INTEGER` | 否 |  | mean dew point in Fahrenheit degree |
| `min_dew_point_f` | `INTEGER` | 否 |  | min dew point in Fahrenheit degree |
| `max_humidity` | `INTEGER` | 否 |  | max humidity |
| `mean_humidity` | `INTEGER` | 否 |  | mean humidity |
| `min_humidity` | `INTEGER` | 否 |  | min humidity |
| `max_sea_level_pressure_inches` | `REAL` | 否 |  | max sea level pressure in inches |
| `mean_sea_level_pressure_inches` | `REAL` | 否 |  | mean sea level pressure in inches |
| `min_sea_level_pressure_inches` | `REAL` | 否 |  | min sea level pressure in inches |
| `max_visibility_miles` | `INTEGER` | 否 |  | max visibility in miles |
| `mean_visibility_miles` | `INTEGER` | 否 |  | mean visibility in miles |
| `min_visibility_miles` | `INTEGER` | 否 |  | min visibility in miles |
| `max_wind_Speed_mph` | `INTEGER` | 否 |  | max wind Speed in mph |
| `mean_wind_speed_mph` | `INTEGER` | 否 |  | mean wind Speed in mph |
| `max_gust_speed_mph` | `INTEGER` | 否 |  | max gust Speed in mph |
| `precipitation_inches` | `TEXT` | 否 |  | precipitation in inches |
| `cloud_cover` | `INTEGER` | 否 |  | cloud cover |
| `events` | `TEXT` | 否 |  | Allowed input: [null], Rain, other |
| `wind_dir_degrees` | `INTEGER` | 否 |  | wind direction degrees |
| `zip_code` | `TEXT` | 否 |  | zip code |

