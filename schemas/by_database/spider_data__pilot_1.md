# spider_data__pilot_1

- 场景：机场航空 (`aviation_airport`)
- 来源：`spider_data`
- 原始 db_id：`pilot_1`
- Task 数：82
- 表数：2
- 字段数：5
- 总行数：17
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__pilot_1/pilot_1.sqlite`

## 表：`Hangar`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `plane_name` | `CHAR(15)` | 是 |  |  |
| `location` | `CHAR(15)` | 否 |  |  |

## 表：`PilotSkills`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `pilot_name` | `CHAR(15)` | 是 |  |  |
| `plane_name` | `CHAR(15)` | 是 | Hangar.plane_name |  |
| `age` | `INTEGER` | 否 |  |  |

