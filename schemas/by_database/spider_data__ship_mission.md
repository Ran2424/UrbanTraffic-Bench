# spider_data__ship_mission

- 场景：船运物流 (`maritime_shipping_logistics`)
- 来源：`spider_data`
- 原始 db_id：`ship_mission`
- Task 数：30
- 表数：2
- 字段数：12
- 总行数：15
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__ship_mission/ship_mission.sqlite`

## 表：`mission`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Mission_ID` | `INT` | 是 |  |  |
| `Ship_ID` | `INT` | 否 | ship.Ship_ID |  |
| `Code` | `TEXT` | 否 |  |  |
| `Launched_Year` | `INT` | 否 |  |  |
| `Location` | `TEXT` | 否 |  |  |
| `Speed_knots` | `INT` | 否 |  |  |
| `Fate` | `TEXT` | 否 |  |  |

## 表：`ship`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Ship_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Type` | `TEXT` | 否 |  |  |
| `Nationality` | `TEXT` | 否 |  |  |
| `Tonnage` | `INT` | 否 |  |  |

