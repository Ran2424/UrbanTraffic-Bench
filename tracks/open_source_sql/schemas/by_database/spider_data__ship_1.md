# spider_data__ship_1

- 场景：船运物流 (`maritime_shipping_logistics`)
- 来源：`spider_data`
- 原始 db_id：`ship_1`
- Task 数：48
- 表数：2
- 字段数：12
- 总行数：16
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__ship_1/ship_1.sqlite`

## 表：`Ship`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Ship_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Type` | `TEXT` | 否 |  |  |
| `Built_Year` | `REAL` | 否 |  |  |
| `Class` | `TEXT` | 否 |  |  |
| `Flag` | `TEXT` | 否 |  |  |

## 表：`captain`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Captain_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Ship_ID` | `INT` | 否 | Ship.Ship_ID |  |
| `age` | `TEXT` | 否 |  |  |
| `Class` | `TEXT` | 否 |  |  |
| `Rank` | `TEXT` | 否 |  |  |

