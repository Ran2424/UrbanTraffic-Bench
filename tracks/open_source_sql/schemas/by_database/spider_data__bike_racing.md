# spider_data__bike_racing

- 场景：赛车竞赛 (`racing_competition`)
- 来源：`spider_data`
- 原始 db_id：`bike_racing`
- Task 数：17
- 表数：3
- 字段数：13
- 总行数：28
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__bike_racing/bike_racing.sqlite`

## 表：`bike`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `product_name` | `TEXT` | 否 |  |  |
| `weight` | `INT` | 否 |  |  |
| `price` | `REAL` | 否 |  |  |
| `material` | `TEXT` | 否 |  |  |

## 表：`cyclist`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `heat` | `INT` | 否 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `nation` | `TEXT` | 否 |  |  |
| `result` | `REAL` | 否 |  |  |

## 表：`cyclists_own_bikes`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `cyclist_id` | `INT` | 是 | cyclist.id |  |
| `bike_id` | `INT` | 是 | bike.id |  |
| `purchase_year` | `INT` | 否 |  |  |

