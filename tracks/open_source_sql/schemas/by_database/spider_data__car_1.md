# spider_data__car_1

- 场景：道路车辆 (`road_vehicle_business`)
- 来源：`spider_data`
- 原始 db_id：`car_1`
- Task 数：92
- 表数：6
- 字段数：23
- 总行数：890
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__car_1/car_1.sqlite`

## 表：`car_makers`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Id` | `INTEGER` | 是 |  |  |
| `Maker` | `TEXT` | 否 |  |  |
| `FullName` | `TEXT` | 否 |  |  |
| `Country` | `TEXT` | 否 | countries.CountryId |  |

## 表：`car_names`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `MakeId` | `INTEGER` | 是 |  |  |
| `Model` | `TEXT` | 否 | model_list.Model |  |
| `Make` | `TEXT` | 否 |  |  |

## 表：`cars_data`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Id` | `INTEGER` | 是 | car_names.MakeId |  |
| `MPG` | `TEXT` | 否 |  |  |
| `Cylinders` | `INTEGER` | 否 |  |  |
| `Edispl` | `REAL` | 否 |  |  |
| `Horsepower` | `TEXT` | 否 |  |  |
| `Weight` | `INTEGER` | 否 |  |  |
| `Accelerate` | `REAL` | 否 |  |  |
| `Year` | `INTEGER` | 否 |  |  |

## 表：`continents`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ContId` | `INTEGER` | 是 |  |  |
| `Continent` | `TEXT` | 否 |  |  |

## 表：`countries`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `CountryId` | `INTEGER` | 是 |  |  |
| `CountryName` | `TEXT` | 否 |  |  |
| `Continent` | `INTEGER` | 否 | continents.ContId |  |

## 表：`model_list`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ModelId` | `INTEGER` | 是 |  |  |
| `Maker` | `INTEGER` | 否 | car_makers.Id |  |
| `Model` | `TEXT` | 否 |  |  |

