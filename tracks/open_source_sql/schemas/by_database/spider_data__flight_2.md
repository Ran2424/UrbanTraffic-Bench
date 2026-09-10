# spider_data__flight_2

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`flight_2`
- Task 数：80
- 表数：3
- 字段数：13
- 总行数：1312
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__flight_2/flight_2.sqlite`

## 表：`airlines`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `uid` | `INTEGER` | 是 |  |  |
| `Airline` | `TEXT` | 否 |  |  |
| `Abbreviation` | `TEXT` | 否 |  |  |
| `Country` | `TEXT` | 否 |  |  |

## 表：`airports`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `City` | `TEXT` | 否 |  |  |
| `AirportCode` | `TEXT` | 是 |  |  |
| `AirportName` | `TEXT` | 否 |  |  |
| `Country` | `TEXT` | 否 |  |  |
| `CountryAbbrev` | `TEXT` | 否 |  |  |

## 表：`flights`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Airline` | `INTEGER` | 是 |  |  |
| `FlightNo` | `INTEGER` | 是 |  |  |
| `SourceAirport` | `TEXT` | 否 | airports.AirportCode |  |
| `DestAirport` | `TEXT` | 否 | airports.AirportCode |  |

