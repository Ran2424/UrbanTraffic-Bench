# spider_data__vehicle_driver

- 场景：道路车辆 (`road_vehicle_business`)
- 来源：`spider_data`
- 原始 db_id：`vehicle_driver`
- Task 数：42
- 表数：3
- 字段数：13
- 总行数：23
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__vehicle_driver/vehicle_driver.sqlite`

## 表：`driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Driver_ID` | `INT` | 是 |  |  |
| `Name` | `TEXT` | 否 |  |  |
| `Citizenship` | `TEXT` | 否 |  |  |
| `Racing_Series` | `TEXT` | 否 |  |  |

## 表：`vehicle`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Vehicle_ID` | `INT` | 是 |  |  |
| `Model` | `TEXT` | 否 |  |  |
| `Build_Year` | `TEXT` | 否 |  |  |
| `Top_Speed` | `INT` | 否 |  |  |
| `Power` | `INT` | 否 |  |  |
| `Builder` | `TEXT` | 否 |  |  |
| `Total_Production` | `TEXT` | 否 |  |  |

## 表：`vehicle_driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Driver_ID` | `INT` | 是 | driver.Driver_ID |  |
| `Vehicle_ID` | `INT` | 是 | vehicle.Vehicle_ID |  |

