# spider_data__railway

- 场景：铁路交通 (`rail_train_station`)
- 来源：`spider_data`
- 原始 db_id：`railway`
- Task 数：21
- 表数：4
- 字段数：22
- 总行数：30
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__railway/railway.sqlite`

## 表：`manager`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Manager_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Country` | `TEXT` | 否 |  |  |
| `Working_year_starts` | `TEXT` | 否 |  |  |
| `Age` | `INT` | 否 |  |  |
| `Level` | `INT` | 否 |  |  |

## 表：`railway`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Railway_ID` | `INT` | 是 |  |  |
| `Railway` | `TEXT` | 否 |  |  |
| `Builder` | `TEXT` | 否 |  |  |
| `Built` | `TEXT` | 否 |  |  |
| `Wheels` | `TEXT` | 否 |  |  |
| `Location` | `TEXT` | 否 |  |  |
| `ObjectNumber` | `TEXT` | 否 |  |  |

## 表：`railway_manage`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Railway_ID` | `INT` | 是 | railway.Railway_ID |  |
| `Manager_ID` | `INT` | 是 | manager.Manager_ID |  |
| `From_Year` | `TEXT` | 否 |  |  |

## 表：`train`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Train_ID` | `INT` | 是 |  |  |
| `Train_Num` | `TEXT` | 否 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `From` | `TEXT` | 否 |  |  |
| `Arrival` | `TEXT` | 否 |  |  |
| `Railway_ID` | `INT` | 否 | railway.Railway_ID |  |

