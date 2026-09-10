# spider_data__pilot_record

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`pilot_record`
- Task 数：15
- 表数：3
- 字段数：19
- 总行数：18
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__pilot_record/pilot_record.sqlite`

## 表：`aircraft`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Aircraft_ID` | `INT` | 是 |  |  |
| `Order_Year` | `INT` | 否 |  |  |
| `Manufacturer` | `TEXT` | 否 |  |  |
| `Model` | `TEXT` | 否 |  |  |
| `Fleet_Series` | `TEXT` | 否 |  |  |
| `Powertrain` | `TEXT` | 否 |  |  |
| `Fuel_Propulsion` | `TEXT` | 否 |  |  |

## 表：`pilot`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Pilot_ID` | `INT` | 是 |  |  |
| `Pilot_name` | `TEXT` | 否 |  |  |
| `Rank` | `INT` | 否 |  |  |
| `Age` | `INT` | 否 |  |  |
| `Nationality` | `TEXT` | 否 |  |  |
| `Position` | `TEXT` | 否 |  |  |
| `Join_Year` | `INT` | 否 |  |  |
| `Team` | `TEXT` | 否 |  |  |

## 表：`pilot_record`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Record_ID` | `INT` | 否 |  |  |
| `Pilot_ID` | `INT` | 是 | pilot.Pilot_ID |  |
| `Aircraft_ID` | `INT` | 是 | aircraft.Aircraft_ID |  |
| `Date` | `TEXT` | 是 |  |  |

