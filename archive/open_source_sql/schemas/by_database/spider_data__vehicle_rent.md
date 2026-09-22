# spider_data__vehicle_rent

- 场景：道路车辆 (`road_vehicle_business`)
- 来源：`spider_data`
- 原始 db_id：`vehicle_rent`
- Task 数：44
- 表数：4
- 字段数：22
- 总行数：24
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__vehicle_rent/vehicle_rent.sqlite`

## 表：`Customers`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `age` | `INT` | 否 |  |  |
| `membership_credit` | `INT` | 否 |  |  |

## 表：`Discount`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `membership_credit` | `INT` | 否 |  |  |

## 表：`Renting_history`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `customer_id` | `INT` | 否 | Customers.id |  |
| `discount_id` | `INT` | 否 | Discount.id |  |
| `vehicles_id` | `INT` | 否 | Vehicles.id |  |
| `total_hours` | `INT` | 否 |  |  |

## 表：`Vehicles`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `id` | `INT` | 是 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `Model_year` | `INT` | 否 |  |  |
| `Type_of_powertrain` | `TEXT` | 否 |  |  |
| `Combined_fuel_economy_rate` | `INT` | 否 |  |  |
| `City_fuel_economy_rate` | `INT` | 否 |  |  |
| `Highway_fuel_economy_rate` | `INT` | 否 |  |  |
| `Cost_per_25_miles` | `REAL` | 否 |  |  |
| `Annual_fuel_cost` | `REAL` | 否 |  |  |
| `Notes` | `TEXT` | 否 |  |  |

