# train__trains

- 场景：铁路交通 (`rail_train_station`)
- 来源：`train`
- 原始 db_id：`trains`
- Task 数：40
- 表数：2
- 字段数：12
- 总行数：83
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/train__trains/trains.sqlite`

## 表：`cars`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INTEGER` | 是 |  | the unique id number representing the cars |
| `train_id` | `INTEGER` | 否 | trains.id | the counterpart id for trains that the cars belong to |
| `position` | `INTEGER` | 否 |  | postion id of cars in the trains |
| `shape` | `TEXT` | 否 |  | shape of the cars |
| `len` | `TEXT` | 否 |  | length of the cars |
| `sides` | `TEXT` | 否 |  | sides of the cars |
| `roof` | `TEXT` | 否 |  | roof of the cars |
| `wheels` | `INTEGER` | 否 |  | wheels of the cars |
| `load_shape` | `TEXT` | 否 |  | load shape |
| `load_num` | `INTEGER` | 否 |  | load number |

## 表：`trains`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INTEGER` | 是 |  | the unique id representing the trains |
| `direction` | `TEXT` | 否 |  | the direction of trains that are running |

