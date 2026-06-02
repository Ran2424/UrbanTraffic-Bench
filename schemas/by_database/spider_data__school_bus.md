# spider_data__school_bus

- 场景：公共服务 (`public_service_transport`)
- 来源：`spider_data`
- 原始 db_id：`school_bus`
- Task 数：18
- 表数：3
- 字段数：14
- 总行数：24
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__school_bus/school_bus.sqlite`

## 表：`driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Driver_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Party` | `TEXT` | 否 |  |  |
| `Home_city` | `TEXT` | 否 |  |  |
| `Age` | `INT` | 否 |  |  |

## 表：`school`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `School_ID` | `INT` | 是 |  |  |
| `Grade` | `TEXT` | 否 |  |  |
| `School` | `TEXT` | 否 |  |  |
| `Location` | `TEXT` | 否 |  |  |
| `Type` | `TEXT` | 否 |  |  |

## 表：`school_bus`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `School_ID` | `INT` | 是 | school.School_ID |  |
| `Driver_ID` | `INT` | 是 | driver.Driver_ID |  |
| `Years_Working` | `INT` | 否 |  |  |
| `If_full_time` | `bool` | 否 |  |  |

