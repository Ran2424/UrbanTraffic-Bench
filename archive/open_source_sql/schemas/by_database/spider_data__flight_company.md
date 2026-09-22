# spider_data__flight_company

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`flight_company`
- Task 数：19
- 表数：3
- 字段数：20
- 总行数：36
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__flight_company/flight_company.sqlite`

## 表：`airport`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `City` | `TEXT` | 否 |  |  |
| `Country` | `TEXT` | 否 |  |  |
| `IATA` | `TEXT` | 否 |  |  |
| `ICAO` | `TEXT` | 否 |  |  |
| `name` | `TEXT` | 否 |  |  |

## 表：`flight`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `Vehicle_Flight_number` | `TEXT` | 否 |  |  |
| `Date` | `TEXT` | 否 |  |  |
| `Pilot` | `TEXT` | 否 |  |  |
| `Velocity` | `REAL` | 否 |  |  |
| `Altitude` | `REAL` | 否 |  |  |
| `airport_id` | `INT` | 否 | airport.id |  |
| `company_id` | `INT` | 否 | operate_company.id |  |

## 表：`operate_company`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `Type` | `TEXT` | 否 |  |  |
| `Principal_activities` | `TEXT` | 否 |  |  |
| `Incorporated_in` | `TEXT` | 否 |  |  |
| `Group_Equity_Shareholding` | `REAL` | 否 |  |  |

