# spider_data__bike_1

- 场景：共享单车 (`bike_micromobility`)
- 来源：`spider_data`
- 原始 db_id：`bike_1`
- Task 数：104
- 表数：4
- 字段数：46
- 总行数：22181
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__bike_1/bike_1.sqlite`

## 表：`station`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INTEGER` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `lat` | `NUMERIC` | 否 |  |  |
| `long` | `NUMERIC` | 否 |  |  |
| `dock_count` | `INTEGER` | 否 |  |  |
| `city` | `TEXT` | 否 |  |  |
| `installation_date` | `TEXT` | 否 |  |  |

## 表：`status`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `station_id` | `INTEGER` | 否 | station.id |  |
| `bikes_available` | `INTEGER` | 否 |  |  |
| `docks_available` | `INTEGER` | 否 |  |  |
| `time` | `TEXT` | 否 |  |  |

## 表：`trip`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INTEGER` | 是 |  |  |
| `duration` | `INTEGER` | 否 |  |  |
| `start_date` | `TEXT` | 否 |  |  |
| `start_station_name` | `TEXT` | 否 |  |  |
| `start_station_id` | `INTEGER` | 否 |  |  |
| `end_date` | `TEXT` | 否 |  |  |
| `end_station_name` | `TEXT` | 否 |  |  |
| `end_station_id` | `INTEGER` | 否 |  |  |
| `bike_id` | `INTEGER` | 否 |  |  |
| `subscription_type` | `TEXT` | 否 |  |  |
| `zip_code` | `INTEGER` | 否 |  |  |

## 表：`weather`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `date` | `TEXT` | 否 |  |  |
| `max_temperature_f` | `INTEGER` | 否 |  |  |
| `mean_temperature_f` | `INTEGER` | 否 |  |  |
| `min_temperature_f` | `INTEGER` | 否 |  |  |
| `max_dew_point_f` | `INTEGER` | 否 |  |  |
| `mean_dew_point_f` | `INTEGER` | 否 |  |  |
| `min_dew_point_f` | `INTEGER` | 否 |  |  |
| `max_humidity` | `INTEGER` | 否 |  |  |
| `mean_humidity` | `INTEGER` | 否 |  |  |
| `min_humidity` | `INTEGER` | 否 |  |  |
| `max_sea_level_pressure_inches` | `NUMERIC` | 否 |  |  |
| `mean_sea_level_pressure_inches` | `NUMERIC` | 否 |  |  |
| `min_sea_level_pressure_inches` | `NUMERIC` | 否 |  |  |
| `max_visibility_miles` | `INTEGER` | 否 |  |  |
| `mean_visibility_miles` | `INTEGER` | 否 |  |  |
| `min_visibility_miles` | `INTEGER` | 否 |  |  |
| `max_wind_Speed_mph` | `INTEGER` | 否 |  |  |
| `mean_wind_speed_mph` | `INTEGER` | 否 |  |  |
| `max_gust_speed_mph` | `INTEGER` | 否 |  |  |
| `precipitation_inches` | `INTEGER` | 否 |  |  |
| `cloud_cover` | `INTEGER` | 否 |  |  |
| `events` | `TEXT` | 否 |  |  |
| `wind_dir_degrees` | `INTEGER` | 否 |  |  |
| `zip_code` | `INTEGER` | 否 |  |  |

