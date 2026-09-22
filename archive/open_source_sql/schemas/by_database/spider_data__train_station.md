# spider_data__train_station

- 场景：铁路交通 (`rail_train_station`)
- 来源：`spider_data`
- 原始 db_id：`train_station`
- Task 数：23
- 表数：3
- 字段数：14
- 总行数：34
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__train_station/train_station.sqlite`

## 表：`station`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Station_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Annual_entry_exit` | `REAL` | 否 |  |  |
| `Annual_interchanges` | `REAL` | 否 |  |  |
| `Total_Passengers` | `REAL` | 否 |  |  |
| `Location` | `TEXT` | 否 |  |  |
| `Main_Services` | `TEXT` | 否 |  |  |
| `Number_of_Platforms` | `INT` | 否 |  |  |

## 表：`train`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Train_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Time` | `TEXT` | 否 |  |  |
| `Service` | `TEXT` | 否 |  |  |

## 表：`train_station`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Train_ID` | `INT` | 是 | train.Train_ID |  |
| `Station_ID` | `INT` | 是 | station.Station_ID |  |

