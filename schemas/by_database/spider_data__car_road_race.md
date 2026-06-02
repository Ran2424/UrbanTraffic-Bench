# spider_data__car_road_race

- 场景：赛车竞赛 (`racing_competition`)
- 来源：`spider_data`
- 原始 db_id：`car_road_race`
- Task 数：44
- 表数：2
- 字段数：15
- 总行数：20
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__car_road_race/car_road_race.sqlite`

## 表：`driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Driver_ID` | `INT` | 是 |  |  |
| `Driver_Name` | `TEXT` | 否 |  |  |
| `Entrant` | `TEXT` | 否 |  |  |
| `Constructor` | `TEXT` | 否 |  |  |
| `Chassis` | `TEXT` | 否 |  |  |
| `Engine` | `TEXT` | 否 |  |  |
| `Age` | `INT` | 否 |  |  |

## 表：`race`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Road` | `INT` | 是 |  |  |
| `Driver_ID` | `INT` | 否 | driver.Driver_ID |  |
| `Race_Name` | `TEXT` | 否 |  |  |
| `Pole_Position` | `TEXT` | 否 |  |  |
| `Fastest_Lap` | `TEXT` | 否 |  |  |
| `Winning_driver` | `TEXT` | 否 |  |  |
| `Winning_team` | `TEXT` | 否 |  |  |
| `Report` | `TEXT` | 否 |  |  |

