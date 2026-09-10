# spider_data__flight_1

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`flight_1`
- Task 数：96
- 表数：4
- 字段数：16
- 总行数：126
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__flight_1/flight_1.sqlite`

## 表：`aircraft`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `aid` | `number(9,0)` | 是 |  |  |
| `name` | `varchar2(30)` | 否 |  |  |
| `distance` | `number(6,0)` | 否 |  |  |

## 表：`certificate`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `eid` | `number(9,0)` | 是 | employee.eid |  |
| `aid` | `number(9,0)` | 是 | aircraft.aid |  |

## 表：`employee`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `eid` | `number(9,0)` | 是 |  |  |
| `name` | `varchar2(30)` | 否 |  |  |
| `salary` | `number(10,2)` | 否 |  |  |

## 表：`flight`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `flno` | `number(4,0)` | 是 |  |  |
| `origin` | `varchar2(20)` | 否 |  |  |
| `destination` | `varchar2(20)` | 否 |  |  |
| `distance` | `number(6,0)` | 否 |  |  |
| `departure_date` | `date` | 否 |  |  |
| `arrival_date` | `date` | 否 |  |  |
| `price` | `number(7,2)` | 否 |  |  |
| `aid` | `number(9,0)` | 否 | aircraft.aid |  |

