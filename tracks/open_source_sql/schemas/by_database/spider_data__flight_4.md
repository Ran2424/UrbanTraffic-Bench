# spider_data__flight_4

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`flight_4`
- Task 数：82
- 表数：3
- 字段数：24
- 总行数：80586
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__flight_4/flight_4.sqlite`

## 表：`airlines`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `alid` | `INTEGER` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `iata` | `varchar(2)` | 否 |  |  |
| `icao` | `varchar(3)` | 否 |  |  |
| `callsign` | `TEXT` | 否 |  |  |
| `country` | `TEXT` | 否 |  |  |
| `active` | `varchar(2)` | 否 |  |  |

## 表：`airports`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `apid` | `INTEGER` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `city` | `TEXT` | 否 |  |  |
| `country` | `TEXT` | 否 |  |  |
| `x` | `REAL` | 否 |  |  |
| `y` | `REAL` | 否 |  |  |
| `elevation` | `bigint` | 否 |  |  |
| `iata` | `character varchar(3)` | 否 |  |  |
| `icao` | `character varchar(4)` | 否 |  |  |

## 表：`routes`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `rid` | `INTEGER` | 是 |  |  |
| `dst_apid` | `INTEGER` | 否 | airports.apid |  |
| `dst_ap` | `varchar(4)` | 否 |  |  |
| `src_apid` | `bigint` | 否 | airports.apid |  |
| `src_ap` | `varchar(4)` | 否 |  |  |
| `alid` | `bigint` | 否 | airlines.alid |  |
| `airline` | `varchar(4)` | 否 |  |  |
| `codeshare` | `TEXT` | 否 |  |  |

