# train__shipping

- 场景：船运物流 (`maritime_shipping_logistics`)
- 来源：`train`
- 原始 db_id：`shipping`
- Task 数：106
- 表数：5
- 字段数：32
- 总行数：1684
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/train__shipping/shipping.sqlite`

## 表：`city`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `city_id` | `INTEGER` | 是 |  | unique identifier for the city |
| `city_name` | `TEXT` | 否 |  | name of the city |
| `state` | `TEXT` | 否 |  | state in which the city is |
| `population` | `INTEGER` | 否 |  | population of the city |
| `area` | `REAL` | 否 |  | square miles the city covers |

## 表：`customer`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `cust_id` | `INTEGER` | 是 |  | Unique identifier for the customer |
| `cust_name` | `TEXT` | 否 |  | Business name of the customer |
| `annual_revenue` | `INTEGER` | 否 |  | Annual revenue of the customer |
| `cust_type` | `TEXT` | 否 |  | Whether the customer is a manufacturer or a wholes |
| `address` | `TEXT` | 否 |  | Physical street address of the customer |
| `city` | `TEXT` | 否 |  | City of the customer's address |
| `state` | `TEXT` | 否 |  | State of the customer's address |
| `zip` | `REAL` | 否 |  | Postal code of the customer's address |
| `phone` | `TEXT` | 否 |  | Telephone number to reach the customer |

## 表：`driver`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `driver_id` | `INTEGER` | 是 |  | Unique identifier for the driver |
| `first_name` | `TEXT` | 否 |  | First given name of the driver |
| `last_name` | `TEXT` | 否 |  | Family name of the driver |
| `address` | `TEXT` | 否 |  | Street address of the driver's home |
| `city` | `TEXT` | 否 |  | City the driver lives in |
| `state` | `TEXT` | 否 |  | State the driver lives in |
| `zip_code` | `INTEGER` | 否 |  | postal code of the driver's address |
| `phone` | `TEXT` | 否 |  | telephone number of the driver |

## 表：`shipment`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `ship_id` | `INTEGER` | 是 |  | Unique identifier of the shipment |
| `cust_id` | `INTEGER` | 否 | customer.cust_id | A reference to the customer table that indicates which customer the shipment is for |
| `weight` | `REAL` | 否 |  | The number of pounds being transported on the shipment |
| `truck_id` | `INTEGER` | 否 | truck.truck_id | A reference to the truck table that indicates which truck is used in the shipment |
| `driver_id` | `INTEGER` | 否 | driver.driver_id | A reference to the driver table that indicates which driver transported the goods in the shipment |
| `city_id` | `INTEGER` | 否 | city.city_id | A reference to the city table that indicates the destination of the shipment |
| `ship_date` | `TEXT` | 否 |  | the date the items were received by the driver |

## 表：`truck`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `truck_id` | `INTEGER` | 是 |  | Unique identifier of the truck table |
| `make` | `TEXT` | 否 |  | The brand of the truck |
| `model_year` | `INTEGER` | 否 |  | The year the truck was manufactured |

