# train__cars

- 场景：道路车辆 (`road_vehicle_business`)
- 来源：`train`
- 原始 db_id：`cars`
- Task 数：84
- 表数：4
- 字段数：16
- 总行数：1491
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/train__cars/cars.sqlite`

## 表：`country`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `origin` | `INTEGER` | 是 |  | the unique identifier for the origin country |
| `country` | `TEXT` | 否 |  | the origin country of the car |

## 表：`data`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ID` | `INTEGER` | 是 | price.ID | unique ID for each car |
| `mpg` | `REAL` | 否 |  | mileage of the car in miles per gallon |
| `cylinders` | `INTEGER` | 否 |  | the number of cylinders present in the car |
| `displacement` | `REAL` | 否 |  | engine displacement in cubic mm |
| `horsepower` | `INTEGER` | 否 |  | horse power associated with the car |
| `weight` | `INTEGER` | 否 |  | weight of the car in lbs |
| `acceleration` | `REAL` | 否 |  | acceleration of the car in miles per squared hour |
| `model` | `INTEGER` | 否 |  | the year when the car model was introduced in the market |
| `car_name` | `TEXT` | 否 |  | name of the car |

## 表：`price`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ID` | `INTEGER` | 是 |  | unique ID for each car |
| `price` | `REAL` | 否 |  | price of the car in USD |

## 表：`production`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ID` | `INTEGER` | 是 | price.ID; data.ID | the id of the car |
| `model_year` | `INTEGER` | 是 |  | year when the car model was introduced in the market |
| `country` | `INTEGER` | 否 | country.origin | country id to which the car belongs |

