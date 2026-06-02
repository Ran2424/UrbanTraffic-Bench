# spider_data__boat_1

- 场景：船运物流 (`maritime_shipping_logistics`)
- 来源：`spider_data`
- 原始 db_id：`boat_1`
- Task 数：78
- 表数：3
- 字段数：10
- 总行数：10
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__boat_1/boat_1.sqlite`

## 表：`Boats`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `bid` | `INTEGER` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `color` | `TEXT` | 否 |  |  |

## 表：`Reserves`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `sid` | `INTEGER` | 否 | Sailors.sid |  |
| `bid` | `INTEGER` | 否 | Boats.bid |  |
| `day` | `TEXT` | 否 |  |  |

## 表：`Sailors`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `sid` | `INTEGER` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `rating` | `INTEGER` | 否 |  |  |
| `age` | `INTEGER` | 否 |  |  |

