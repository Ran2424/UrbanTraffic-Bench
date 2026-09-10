# train__car_retails

- 场景：道路车辆 (`road_vehicle_business`)
- 来源：`train`
- 原始 db_id：`car_retails`
- Task 数：126
- 表数：8
- 字段数：59
- 总行数：3864
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/train__car_retails/car_retails.sqlite`

## 表：`customers`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `customerNumber` | `INTEGER` | 是 |  | unique id number of customer |
| `customerName` | `TEXT` | 否 |  | the name when the customer registered |
| `contactLastName` | `TEXT` | 否 |  | contact last name |
| `contactFirstName` | `TEXT` | 否 |  | contact first name |
| `phone` | `TEXT` | 否 |  | phone |
| `addressLine1` | `TEXT` | 否 |  | addressLine1 |
| `addressLine2` | `TEXT` | 否 |  | addressLine2 |
| `city` | `TEXT` | 否 |  | city |
| `state` | `TEXT` | 否 |  | state |
| `postalCode` | `TEXT` | 否 |  | postalCode |
| `country` | `TEXT` | 否 |  | country |
| `salesRepEmployeeNumber` | `INTEGER` | 否 | employees.employeeNumber | sales representative employee number |
| `creditLimit` | `REAL` | 否 |  | credit limit |

## 表：`employees`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `employeeNumber` | `INTEGER` | 是 |  | unique string ID of the employees |
| `lastName` | `TEXT` | 否 |  | last name of employees |
| `firstName` | `TEXT` | 否 |  | first name of employees |
| `extension` | `TEXT` | 否 |  | extension number |
| `email` | `TEXT` | 否 |  | email |
| `officeCode` | `TEXT` | 否 | offices.officeCode | office code of the employees |
| `reportsTo` | `INTEGER` | 否 | employees.employeeNumber | represents for organization structure such as who reports to whom |
| `jobTitle` | `TEXT` | 否 |  | job title |

## 表：`offices`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `officeCode` | `TEXT` | 是 |  | unique ID of the office |
| `city` | `TEXT` | 否 |  |  |
| `phone` | `TEXT` | 否 |  | phone number |
| `addressLine1` | `TEXT` | 否 |  | addressLine1 |
| `addressLine2` | `TEXT` | 否 |  | addressLine2 |
| `state` | `TEXT` | 否 |  |  |
| `country` | `TEXT` | 否 |  | country |
| `postalCode` | `TEXT` | 否 |  | postalCode |
| `territory` | `TEXT` | 否 |  | territory |

## 表：`orderdetails`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `orderNumber` | `INTEGER` | 是 | orders.None | order number |
| `productCode` | `TEXT` | 是 | products.None | product code |
| `quantityOrdered` | `INTEGER` | 否 |  | quantity ordered |
| `priceEach` | `REAL` | 否 |  | price for each |
| `orderLineNumber` | `INTEGER` | 否 |  | order Line Number |

## 表：`orders`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `orderNumber` | `INTEGER` | 是 |  | unique order number |
| `orderDate` | `DATE` | 否 |  | order date |
| `requiredDate` | `DATE` | 否 |  | required Date |
| `shippedDate` | `DATE` | 否 |  | shipped Date |
| `status` | `TEXT` | 否 |  | status |
| `comments` | `TEXT` | 否 |  | comments |
| `customerNumber` | `INTEGER` | 否 | customers.customerNumber | customer number |

## 表：`payments`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `customerNumber` | `INTEGER` | 是 | customers.customerNumber | customer number |
| `checkNumber` | `TEXT` | 是 |  | check Number |
| `paymentDate` | `DATE` | 否 |  | payment Date |
| `amount` | `REAL` | 否 |  | amount |

## 表：`productlines`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `productLine` | `TEXT` | 是 |  | unique product line name |
| `textDescription` | `TEXT` | 否 |  | text description |
| `htmlDescription` | `TEXT` | 否 |  | html description |
| `image` | `BLOB` | 否 |  | image |

## 表：`products`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `productCode` | `TEXT` | 是 |  | unique product code |
| `productName` | `TEXT` | 否 |  | product name |
| `productLine` | `TEXT` | 否 | productlines.productLine | product line name |
| `productScale` | `TEXT` | 否 |  | product scale |
| `productVendor` | `TEXT` | 否 |  | product vendor |
| `productDescription` | `TEXT` | 否 |  | product description |
| `quantityInStock` | `INTEGER` | 否 |  | quantity in stock |
| `buyPrice` | `REAL` | 否 |  | buy price from vendors |
| `MSRP` | `REAL` | 否 |  | Manufacturer Suggested Retail Price |

