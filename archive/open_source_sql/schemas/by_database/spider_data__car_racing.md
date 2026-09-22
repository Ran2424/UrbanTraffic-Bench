# spider_data__car_racing

- 场景：赛车竞赛 (`racing_competition`)
- 来源：`spider_data`
- 原始 db_id：`car_racing`
- Task 数：50
- 表数：4
- 字段数：22
- 总行数：38
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__car_racing/car_racing.sqlite`

## 表：`country`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Country_Id` | `INT` | 是 |  |  |
| `Country` | `TEXT` | 否 |  |  |
| `Capital` | `TEXT` | 否 |  |  |
| `Official_native_language` | `TEXT` | 否 |  |  |
| `Regoin` | `TEXT` | 否 |  |  |

## 表：`driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Driver_ID` | `INT` | 是 |  |  |
| `Driver` | `TEXT` | 否 |  |  |
| `Country` | `INT` | 否 | country.Country_ID |  |
| `Age` | `INT` | 否 |  |  |
| `Car_#` | `REAL` | 否 |  |  |
| `Make` | `TEXT` | 否 |  |  |
| `Points` | `TEXT` | 否 |  |  |
| `Laps` | `REAL` | 否 |  |  |
| `Winnings` | `TEXT` | 否 |  |  |

## 表：`team`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Team_ID` | `INT` | 是 |  |  |
| `Team` | `TEXT` | 否 |  |  |
| `Make` | `TEXT` | 否 |  |  |
| `Manager` | `TEXT` | 否 |  |  |
| `Sponsor` | `TEXT` | 否 |  |  |
| `Car_Owner` | `TEXT` | 否 |  |  |

## 表：`team_driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Team_ID` | `INT` | 是 | team.Team_ID |  |
| `Driver_ID` | `INT` | 是 | driver.Driver_ID |  |

