# spider_data__race_track

- 场景：赛车竞赛 (`racing_competition`)
- 来源：`spider_data`
- 原始 db_id：`race_track`
- Task 数：42
- 表数：2
- 字段数：10
- 总行数：16
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__race_track/race_track.sqlite`

## 表：`race`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Race_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Class` | `TEXT` | 否 |  |  |
| `Date` | `TEXT` | 否 |  |  |
| `Track_ID` | `TEXT` | 否 | track.Track_ID |  |

## 表：`track`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Track_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Location` | `TEXT` | 否 |  |  |
| `Seating` | `REAL` | 否 |  |  |
| `Year_Opened` | `REAL` | 否 |  |  |

