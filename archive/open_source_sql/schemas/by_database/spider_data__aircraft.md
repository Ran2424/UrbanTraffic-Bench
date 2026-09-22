# spider_data__aircraft

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`aircraft`
- Task 数：46
- 表数：5
- 字段数：28
- 总行数：38
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__aircraft/aircraft.sqlite`

## 表：`aircraft`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Aircraft_ID` | `int(11)` | 是 |  |  |
| `Aircraft` | `varchar(50)` | 否 |  |  |
| `Description` | `varchar(50)` | 否 |  |  |
| `Max_Gross_Weight` | `varchar(50)` | 否 |  |  |
| `Total_disk_area` | `varchar(50)` | 否 |  |  |
| `Max_disk_Loading` | `varchar(50)` | 否 |  |  |

## 表：`airport`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Airport_ID` | `INT` | 是 |  |  |
| `Airport_Name` | `TEXT` | 否 |  |  |
| `Total_Passengers` | `REAL` | 否 |  |  |
| `%_Change_2007` | `TEXT` | 否 |  |  |
| `International_Passengers` | `REAL` | 否 |  |  |
| `Domestic_Passengers` | `REAL` | 否 |  |  |
| `Transit_Passengers` | `REAL` | 否 |  |  |
| `Aircraft_Movements` | `REAL` | 否 |  |  |
| `Freight_Metric_Tonnes` | `REAL` | 否 |  |  |

## 表：`airport_aircraft`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ID` | `INT` | 否 |  |  |
| `Airport_ID` | `INT` | 是 | airport.Airport_ID |  |
| `Aircraft_ID` | `INT` | 是 | aircraft.Aircraft_ID |  |

## 表：`match`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Round` | `REAL` | 是 |  |  |
| `Location` | `TEXT` | 否 |  |  |
| `Country` | `TEXT` | 否 |  |  |
| `Date` | `TEXT` | 否 |  |  |
| `Fastest_Qualifying` | `TEXT` | 否 |  |  |
| `Winning_Pilot` | `TEXT` | 否 | pilot.Pilot_Id |  |
| `Winning_Aircraft` | `TEXT` | 否 | aircraft.Aircraft_ID |  |

## 表：`pilot`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Pilot_Id` | `int(11)` | 是 |  |  |
| `Name` | `varchar(50)` | 否 |  |  |
| `Age` | `int(11)` | 否 |  |  |

