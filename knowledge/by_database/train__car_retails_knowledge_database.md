# 数据库知识说明：train__car_retails

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | train__car_retails |
| source | train |
| db_id | car_retails |
| database_dir | database_layer/train__car_retails |
| sqlite_path | database_layer/train__car_retails/car_retails.sqlite |
| table_count | 8 |
| scenario_id | vehicle_retail_sales |
| scenario_name | 汽车模型零售 |
| scenario_description | 客户、员工、办公室、订单、付款、产品线和产品库存。 |

## 2. 业务子场景说明

本库聚焦“汽车模型零售”子场景，核心对象包括客户、员工、办公室、订单明细、订单、付款、产品线、产品等。它适合回答关于客户、员工、办公室、订单、付款、产品线和产品库存的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `train`
- db_id: `car_retails`
- database_dir: `database_layer/train__car_retails`
- db_path: `database_layer/train__car_retails/car_retails.sqlite`
- original_db_path: `train/train_databases/car_retails/car_retails.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| customers | 零售客户基础信息。 | 13 | 122 |
| employees | 员工基础信息、办公室归属和上级关系。 | 8 | 23 |
| offices | 销售办公室地址和区域信息。 | 9 | 7 |
| orderdetails | 订单中的产品明细行。 | 5 | 2996 |
| orders | 客户订单主表。 | 7 | 326 |
| payments | 客户付款记录。 | 4 | 273 |
| productlines | 产品线分类和说明。 | 4 | 7 |
| products | 产品基础信息、库存和价格。 | 9 | 110 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| customers.salesRepEmployeeNumber | employees.employeeNumber |
| employees.officeCode | offices.officeCode |
| employees.reportsTo | employees.employeeNumber |
| orderdetails.orderNumber | orders.orderNumber |
| orderdetails.productCode | products.productCode |
| orders.customerNumber | customers.customerNumber |
| payments.customerNumber | customers.customerNumber |
| products.productLine | productlines.productLine |

## 6. 表与字段说明

### 6.1 `customers`

- 表含义：零售客户基础信息。
- 行数：`122`
- 字段数：`13`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| customerNumber | INTEGER | integer | PK, NOT NULL |  | 客户唯一编号。 别名：customer number。 样例值：103、112、114。 |
| customerName | TEXT | text | NOT NULL |  | 客户公司或客户名称。 别名：customer name。 样例值：Atelier graphique、Signal Gift Stores、Australian Collectors, Co.。 |
| contactLastName | TEXT | text | NOT NULL |  | 客户联系人姓氏。 别名：contact last name。 样例值：Schmitt、King、Ferguson。 |
| contactFirstName | TEXT | text | NOT NULL |  | 客户联系人名字。 别名：contact first name。 样例值：Carine 、Jean、Peter。 |
| phone | TEXT | text | NOT NULL |  | 联系电话。 样例值：40.32.2555、7025551838、03 9520 4555。 |
| addressLine1 | TEXT | text | NOT NULL |  | 客户地址第一行。 样例值：54, rue Royale、8489 Strong St.、636 St Kilda Road。 |
| addressLine2 | TEXT | text |  |  | 客户地址第二行；与 addressLine1 合并为完整地址。 取值说明：commonsense evidence: addressLine1 + addressLine2 = entire address。 |
| city | TEXT | text | NOT NULL |  | 城市。 样例值：Nantes、Las Vegas、Melbourne。 |
| state | TEXT | text |  |  | 州或省份。 样例值：NV、Victoria。 |
| postalCode | TEXT | text |  |  | 邮政编码。 样例值：44000、83030、3004。 |
| country | TEXT | text | NOT NULL |  | 国家或地区。 样例值：France、USA、Australia。 |
| salesRepEmployeeNumber | INTEGER | integer | FK | employees.employeeNumber | 外键，指向 `employees.employeeNumber`，表示本记录关联的员工。 |
| creditLimit | REAL | real |  |  | 客户信用额度。 别名：credit limit。 样例值：21000.0、71800.0、117300.0。 |

样例数据（前 5 行）：

| customerNumber | customerName | contactLastName | contactFirstName | phone | addressLine1 | addressLine2 | city | state | postalCode | country | salesRepEmployeeNumber | creditLimit |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 103 | Atelier graphique | Schmitt | Carine  | 40.32.2555 | 54, rue Royale |  | Nantes |  | 44000 | France | 1370 | 21000.0 |
| 112 | Signal Gift Stores | King | Jean | 7025551838 | 8489 Strong St. |  | Las Vegas | NV | 83030 | USA | 1166 | 71800.0 |
| 114 | Australian Collectors, Co. | Ferguson | Peter | 03 9520 4555 | 636 St Kilda Road | Level 3 | Melbourne | Victoria | 3004 | Australia | 1611 | 117300.0 |
| 119 | La Rochelle Gifts | Labrune | Janine  | 40.67.8555 | 67, rue des Cinquante Otages |  | Nantes |  | 44000 | France | 1370 | 118200.0 |
| 121 | Baane Mini Imports | Bergulfsen | Jonas  | 07-98 9555 | Erling Skakkes gate 78 |  | Stavern |  | 4110 | Norway | 1504 | 81700.0 |

### 6.2 `employees`

- 表含义：员工基础信息、办公室归属和上级关系。
- 行数：`23`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| employeeNumber | INTEGER | integer | PK, NOT NULL |  | 员工唯一编号。 别名：Employee Number。 样例值：1002、1056、1076。 |
| lastName | TEXT | text | NOT NULL |  | 员工姓氏。 别名：last name。 样例值：Murphy、Patterson、Firrelli。 |
| firstName | TEXT | text | NOT NULL |  | 员工名字。 别名：first name。 样例值：Diane、Mary、Jeff。 |
| extension | TEXT | text | NOT NULL |  | 办公室电话分机号。 样例值：x5800、x4611、x9273。 |
| email | TEXT | text | NOT NULL |  | 员工邮箱。 样例值：dmurphy@classicmodelcars.com、mpatterso@classicmodelcars.com、jfirrelli@classicmodelcars.com。 |
| officeCode | TEXT | text | NOT NULL, FK | offices.officeCode | 外键，指向 `offices.officeCode`，表示本记录关联的办公室。 |
| reportsTo | INTEGER | integer | FK | employees.employeeNumber | 外键，指向 `employees.employeeNumber`，表示本记录关联的员工。 |
| jobTitle | TEXT | text | NOT NULL |  | 职位名称。 别名：job title。 样例值：President、VP Sales、VP Marketing。 |

样例数据（前 5 行）：

| employeeNumber | lastName | firstName | extension | email | officeCode | reportsTo | jobTitle |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1002 | Murphy | Diane | x5800 | dmurphy@classicmodelcars.com | 1 |  | President |
| 1056 | Patterson | Mary | x4611 | mpatterso@classicmodelcars.com | 1 | 1002 | VP Sales |
| 1076 | Firrelli | Jeff | x9273 | jfirrelli@classicmodelcars.com | 1 | 1002 | VP Marketing |
| 1088 | Patterson | William | x4871 | wpatterson@classicmodelcars.com | 6 | 1056 | Sales Manager (APAC) |
| 1102 | Bondur | Gerard | x5408 | gbondur@classicmodelcars.com | 4 | 1056 | Sale Manager (EMEA) |

### 6.3 `offices`

- 表含义：销售办公室地址和区域信息。
- 行数：`7`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| officeCode | TEXT | text | PK, NOT NULL |  | 办公室唯一编号。 别名：office code。 取值说明：unique ID of the office。 样例值：1、2、3。 |
| city | TEXT | text | NOT NULL |  | 城市。 别名：city。 样例值：San Francisco、Boston、NYC。 |
| phone | TEXT | text | NOT NULL |  | 联系电话。 样例值：+1 650 219 4782、+1 215 837 0825、+1 212 555 3000。 |
| addressLine1 | TEXT | text | NOT NULL |  | 办公室地址第一行。 样例值：100 Market Street、1550 Court Place、523 East 53rd Street。 |
| addressLine2 | TEXT | text |  |  | 办公室地址第二行；与 addressLine1 合并为完整地址。 取值说明：commonsense evidence: addressLine1 + addressLine2 = entire address。 |
| state | TEXT | text |  |  | 州或省份。 样例值：CA、MA、NY。 |
| country | TEXT | text | NOT NULL |  | 国家或地区。 样例值：USA、France、Japan。 |
| postalCode | TEXT | text | NOT NULL |  | 邮政编码。 样例值：94080、02107、10022。 |
| territory | TEXT | text | NOT NULL |  | 办公室负责的销售区域。 样例值：NA、EMEA、Japan。 |

样例数据（前 5 行）：

| officeCode | city | phone | addressLine1 | addressLine2 | state | country | postalCode | territory |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | San Francisco | +1 650 219 4782 | 100 Market Street | Suite 300 | CA | USA | 94080 | NA |
| 2 | Boston | +1 215 837 0825 | 1550 Court Place | Suite 102 | MA | USA | 02107 | NA |
| 3 | NYC | +1 212 555 3000 | 523 East 53rd Street | apt. 5A | NY | USA | 10022 | NA |
| 4 | Paris | +33 14 723 4404 | 43 Rue Jouffroy D'abbans |  |  | France | 75017 | EMEA |
| 5 | Tokyo | +81 33 224 5000 | 4-1 Kioicho |  | Chiyoda-Ku | Japan | 102-8578 | Japan |

### 6.4 `orderdetails`

- 表含义：订单中的产品明细行。
- 行数：`2996`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| orderNumber | INTEGER | integer | PK, NOT NULL, FK | orders.orderNumber | 外键，指向 `orders.orderNumber`，表示本记录关联的订单。 |
| productCode | TEXT | text | PK, NOT NULL, FK | products.productCode | 外键，指向 `products.productCode`，表示本记录关联的产品。 |
| quantityOrdered | INTEGER | integer | NOT NULL |  | 订购数量。 别名：quantity ordered。 样例值：30、50、22。 |
| priceEach | REAL | real | NOT NULL |  | 订单明细中的单件成交价。 别名：price for each。 取值说明：commonsense evidence: total price = quantityOrdered x priceEach。 |
| orderLineNumber | INTEGER | integer | NOT NULL |  | 订单内行号。 别名：order Line Number。 样例值：3、2、4。 |

样例数据（前 5 行）：

| orderNumber | productCode | quantityOrdered | priceEach | orderLineNumber |
| --- | --- | --- | --- | --- |
| 10100 | S18_1749 | 30 | 136.0 | 3 |
| 10100 | S18_2248 | 50 | 55.09 | 2 |
| 10100 | S18_4409 | 22 | 75.46 | 4 |
| 10100 | S24_3969 | 49 | 35.29 | 1 |
| 10101 | S18_2325 | 25 | 108.06 | 4 |

### 6.5 `orders`

- 表含义：客户订单主表。
- 行数：`326`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| orderNumber | INTEGER | integer | PK, NOT NULL |  | 订单编号。 别名：order number。 取值说明：unique order number。 样例值：10100、10101、10102。 |
| orderDate | DATE | date | NOT NULL |  | 下单日期。 别名：order date。 样例值：2003-01-06、2003-01-09、2003-01-10。 |
| requiredDate | DATE | date | NOT NULL |  | 客户要求到货日期。 别名：required Date。 样例值：2003-01-13、2003-01-18、2003-02-07。 |
| shippedDate | DATE | date |  |  | 发货日期。 别名：shipped date。 样例值：2003-01-10、2003-01-11、2003-01-14。 |
| status | TEXT | text | NOT NULL |  | 订单状态，例如 Shipped。 |
| comments | TEXT | text |  |  | 订单备注。 样例值：Check on availability.。 |
| customerNumber | INTEGER | integer | NOT NULL, FK | customers.customerNumber | 外键，指向 `customers.customerNumber`，表示本记录关联的客户。 |

样例数据（前 5 行）：

| orderNumber | orderDate | requiredDate | shippedDate | status | comments | customerNumber |
| --- | --- | --- | --- | --- | --- | --- |
| 10100 | 2003-01-06 | 2003-01-13 | 2003-01-10 | Shipped |  | 363 |
| 10101 | 2003-01-09 | 2003-01-18 | 2003-01-11 | Shipped | Check on availability. | 128 |
| 10102 | 2003-01-10 | 2003-01-18 | 2003-01-14 | Shipped |  | 181 |
| 10103 | 2003-01-29 | 2003-02-07 | 2003-02-02 | Shipped |  | 121 |
| 10104 | 2003-01-31 | 2003-02-09 | 2003-02-01 | Shipped |  | 141 |

### 6.6 `payments`

- 表含义：客户付款记录。
- 行数：`273`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| customerNumber | INTEGER | integer | PK, NOT NULL, FK | customers.customerNumber | 外键，指向 `customers.customerNumber`，表示本记录关联的客户。 |
| checkNumber | TEXT | text | PK, NOT NULL |  | 付款支票编号。 别名：check Number。 样例值：HQ336336、JM555205、OM314933。 |
| paymentDate | DATE | date | NOT NULL |  | 付款日期。 别名：payment Date。 样例值：2004-10-19、2003-06-05、2004-12-18。 |
| amount | REAL | real | NOT NULL |  | 付款金额。 样例值：6066.78、14571.44、1676.14。 |

样例数据（前 5 行）：

| customerNumber | checkNumber | paymentDate | amount |
| --- | --- | --- | --- |
| 103 | HQ336336 | 2004-10-19 | 6066.78 |
| 103 | JM555205 | 2003-06-05 | 14571.44 |
| 103 | OM314933 | 2004-12-18 | 1676.14 |
| 112 | BO864823 | 2004-12-17 | 14191.12 |
| 112 | HQ55022 | 2003-06-06 | 32641.98 |

### 6.7 `productlines`

- 表含义：产品线分类和说明。
- 行数：`7`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| productLine | TEXT | text | PK, NOT NULL |  | 产品线名称。 别名：product line。 样例值：Classic Cars、Motorcycles、Planes。 |
| textDescription | TEXT | text |  |  | 产品线纯文本描述。 别名：text description。 样例值：Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb atten、Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, ge、Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and。 |
| htmlDescription | TEXT | text |  |  | 产品线 HTML 描述。 别名：html description。 |
| image | BLOB | blob |  |  | 产品线图片字段。 |

样例数据（前 5 行）：

| productLine | textDescription | htmlDescription | image |
| --- | --- | --- | --- |
| Classic Cars | Attention car enthusiasts: Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category. These replicas feature superb atten |  |  |
| Motorcycles | Our motorcycles are state of the art replicas of classic as well as contemporary motorcycle legends such as Harley Davidson, Ducati and Vespa. Models contain stunning details such as official logos, rotating wheels, working kickstand, front suspension, ge |  |  |
| Planes | Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations. Models contain stunning details such as official logos and insignias, rotating jet engines and propellers, retractable wheels, and |  |  |
| Ships | The perfect holiday or anniversary gift for executives, clients, friends, and family. These handcrafted model ships are unique, stunning works of art that will be treasured for generations! They come fully assembled and ready for display in the home or of |  |  |
| Trains | Model trains are a rewarding hobby for enthusiasts of all ages. Whether you're looking for collectible wooden trains, electric streetcars or locomotives, you'll find a number of great choices for any budget within this category. The interactive aspect of  |  |  |

### 6.8 `products`

- 表含义：产品基础信息、库存和价格。
- 行数：`110`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| productCode | TEXT | text | PK, NOT NULL |  | 产品代码。 别名：product code。 样例值：S10_1678、S10_1949、S10_2016。 |
| productName | TEXT | text | NOT NULL |  | 产品名称。 别名：product name。 样例值：1969 Harley Davidson Ultimate Chopper、1952 Alpine Renault 1300、1996 Moto Guzzi 1100i。 |
| productLine | TEXT | text | NOT NULL, FK | productlines.productLine | 外键，指向 `productlines.productLine`，表示本记录关联的产品线。 |
| productScale | TEXT | text | NOT NULL |  | 产品比例尺。 别名：product scale。 样例值：1:10。 |
| productVendor | TEXT | text | NOT NULL |  | 产品供应商。 别名：product vendor。 样例值：Min Lin Diecast、Classic Metal Creations、Highway 66 Mini Classics。 |
| productDescription | TEXT | text | NOT NULL |  | 产品详细描述。 别名：product description。 样例值：This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.、Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.、Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.。 |
| quantityInStock | INTEGER | integer | NOT NULL |  | 库存数量。 别名：quantity in stock。 样例值：7933、7305、6625。 |
| buyPrice | REAL | real | NOT NULL |  | 采购价。 别名：buy price。 样例值：48.81、98.58、68.99。 |
| MSRP | REAL | real | NOT NULL |  | 建议零售价。 别名：Manufacturer Suggested Retail Price。 取值说明：commonsense evidence: expected profits: msrp - buyPrice。 |

样例数据（前 5 行）：

| productCode | productName | productLine | productScale | productVendor | productDescription | quantityInStock | buyPrice | MSRP |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S10_1678 | 1969 Harley Davidson Ultimate Chopper | Motorcycles | 1:10 | Min Lin Diecast | This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention. | 7933 | 48.81 | 95.7 |
| S10_1949 | 1952 Alpine Renault 1300 | Classic Cars | 1:10 | Classic Metal Creations | Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis. | 7305 | 98.58 | 214.3 |
| S10_2016 | 1996 Moto Guzzi 1100i | Motorcycles | 1:10 | Highway 66 Mini Classics | Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish. | 6625 | 68.99 | 118.94 |
| S10_4698 | 2003 Harley-Davidson Eagle Drag Bike | Motorcycles | 1:10 | Red Start Diecast | Model features, official Harley Davidson logos and insignias, detachable rear wheelie bar, heavy diecast metal with resin parts, authentic multi-color tampo-printed graphics, separate engine drive belts, free-turning front fork, rotating tires and rear racing slick, certificate of authenticity, detailed engine, display stand , precision diecast replica, baked enamel finish, 1:10 scale model, removable fender, seat and tank cover piece for displaying the superior detail of the v-twin engine | 5582 | 91.02 | 193.66 |
| S10_4757 | 1972 Alfa Romeo GTA | Classic Cars | 1:10 | Motor City Art Classics | Features include: Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis. | 3252 | 85.68 | 136.0 |

## 7. SQL 生成注意事项

- `orderdetails` 是订单明细，一笔订单可有多行产品；计算订单总额需 `quantityOrdered * priceEach` 后按订单汇总。
- `payments` 是付款记录，不等同于订单金额；客户销售额和客户付款额是不同口径。
- 问 annual payments 的 average/highest/lowest 时，先按年份汇总 `SUM(payments.amount)`，再对年度总额整体求 `AVG/MAX/MIN`；外层不要再按年份 `GROUP BY`，结果应是一行。
- `products.MSRP - products.buyPrice` 表示单件 expected profit。题目只问 expected profits greater than X 时按单件差值判断并计订单明细行/产品码，不要默认乘 `quantityOrdered` 或统计订单数。只有明确问订单总利润/总销售利润时才乘 `orderdetails.quantityOrdered`。
- actual profit 使用成交价：单行利润为 `orderdetails.priceEach - products.buyPrice`，订单/总实际利润为 `(priceEach - buyPrice) * quantityOrdered` 后求和。不要用 `MSRP - buyPrice` 计算 actual profit。
- 折扣 discount 是折扣率：`(products.MSRP - orderdetails.priceEach) / products.MSRP`，不是单纯折扣金额 `MSRP - priceEach`。
- “total price for each product in terms of the largest quantity that was ordered” 使用最大订购数量那一行的 `quantityOrdered * priceEach`，不是 `expected_profit * max_quantity`。
- “highest amount of order” 在 Boston sales rep 题中指订单明细行金额 `quantityOrdered * priceEach` 最大的产品行，不是先汇总整张订单再取其中产品。`COUNT(*)`。
- 题目中的 employee Code/Code of employee 指 `employees.employeeNumber`，不是 `employees.officeCode`。
- 订单状态需按库中枚举精确匹配：正在处理/processing 对应 `orders.status = 'In Process'`，不要写 `Processing`；取消为 `Cancelled`，有争议为 `Disputed`。
- `productLine` 通常区分大小写，常见值包括 `Motorcycles`、`Classic Cars`、`Vintage Cars`。
- 产品名中的年份是产品名称的一部分。例如 `2001 Ferrari Enzo` 应匹配 `products.productName = '2001 Ferrari Enzo'`。
- Sales Rep 要精确匹配 `employees.jobTitle = 'Sales Rep'`，不要用 `LIKE '%Sales%'` 或 `LIKE 'Sales Rep%'` 扩到 Sales Manager 等职位。
- 题目问 full name 时通常拼接 `firstName || ' ' || lastName`；问 contact full name 可用 `TRIM(contactFirstName || ' ' || contactLastName)`，因为部分联系人名字含尾随空格。
- 题目问 sales representative 的 superior/leader/reports to 时，要从销售代表 `employees.reportsTo` 自连接到上级员工；若问 superior 的 email，应返回上级员工邮箱，不是销售代表本人邮箱。
- UK/French/American customers 指 `customers.country`，不要误用办公室国家；employees/offices in USA/Japan/Boston/NYC 才使用 `offices.country/city`。
- 百分比题除非题目要求四舍五入，不要主动 `ROUND`；
- 部分外键在 metadata 中显示 `None`，但业务上 `orderdetails.orderNumber` 对应 `orders.orderNumber`，`orderdetails.productCode` 对应 `products.productCode`。
- `employees.reportsTo` 是自关联上级员工编号。
- 日期/时间多为文本字段：`orders.orderDate`、`orders.requiredDate`、`orders.shippedDate`、`payments.paymentDate`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
