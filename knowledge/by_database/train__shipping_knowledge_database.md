# 数据库知识说明：train__shipping

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | train__shipping |
| source | train |
| db_id | shipping |
| database_dir | database_layer/train__shipping |
| sqlite_path | database_layer/train__shipping/shipping.sqlite |
| table_count | 5 |
| scenario_id | freight_shipping |
| scenario_name | 货运物流 |
| scenario_description | 城市、客户、司机、卡车和货运记录。 |

## 2. 业务子场景说明

本库聚焦“货运物流”子场景，核心对象包括城市、客户、货运司机、货运记录、卡车等。它适合回答关于城市、客户、司机、卡车和货运记录的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `train`
- db_id: `shipping`
- database_dir: `database_layer/train__shipping`
- db_path: `database_layer/train__shipping/shipping.sqlite`
- original_db_path: `train/train_databases/shipping/shipping.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| city | 城市基础信息。 | 5 | 601 |
| customer | 货运客户基础信息。 | 9 | 100 |
| driver | 货运司机基础信息。 | 8 | 11 |
| shipment | 货运发运记录。 | 7 | 960 |
| truck | 卡车基础信息。 | 3 | 12 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| shipment.cust_id | customer.cust_id |
| shipment.truck_id | truck.truck_id |
| shipment.driver_id | driver.driver_id |
| shipment.city_id | city.city_id |

## 6. 表与字段说明

### 6.1 `city`

- 表含义：城市基础信息。
- 行数：`601`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| city_id | INTEGER | integer | PK |  | 城市编号，关联 city.city_id。 别名：city id。 样例值：100、101、102。 |
| city_name | TEXT | text |  |  | name of the city 别名：city name。 样例值：Union City、Huntington Park、Passaic。 |
| state | TEXT | text |  |  | 州或省份。 样例值：New Jersey、California、New York。 |
| population | INTEGER | integer |  |  | 城市人口。 样例值：67088、61348、67861。 |
| area | REAL | real |  |  | 城市面积。 取值说明：commonsense evidence: population density (land area per capita) = area / population。 |

样例数据（前 5 行）：

| city_id | city_name | state | population | area |
| --- | --- | --- | --- | --- |
| 100 | Union City | New Jersey | 67088 | 1.3 |
| 101 | Huntington Park | California | 61348 | 3.0 |
| 102 | Passaic | New Jersey | 67861 | 3.1 |
| 103 | Hempstead | New York | 56554 | 3.7 |
| 104 | Berwyn | Illinois | 54016 | 3.9 |

### 6.2 `customer`

- 表含义：货运客户基础信息。
- 行数：`100`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| cust_id | INTEGER | integer | PK |  | 货运客户编号，关联 customer.cust_id。 别名：customer id。 样例值：193、304、314。 |
| cust_name | TEXT | text |  |  | Business name of the customer 别名：customer name。 样例值：Advanced Fabricators、Pard's Trailer Sales、Saar Enterprises, Inc.。 |
| annual_revenue | INTEGER | integer |  |  | 客户年收入或年营业额。 别名：annual revenue。 样例值：39588651、17158109、47403613。 |
| cust_type | TEXT | text |  |  | 客户类型。 别名：customer type。 样例值：manufacturer、wholesaler、retailer。 |
| address | TEXT | text |  |  | 地址。 样例值：5141 Summit Boulevard、5910 South 300 West、11687 192nd Street。 |
| city | TEXT | text |  |  | 城市。 样例值：West Palm Beach、Salt Lake City、Council Bluffs。 |
| state | TEXT | text |  |  | 客户所在州缩写，数据库中存 `FL`、`UT`、`IA` 等两字母代码；题目写完整州名时需映射为缩写。 |
| zip | REAL | real |  |  | 邮政编码。 样例值：33415.0、84107.0、51503.0。 |
| phone | TEXT | text |  |  | 联系电话。 样例值：(561) 683-3535、(801) 262-4864、(712) 366-4929。 |

样例数据（前 5 行）：

| cust_id | cust_name | annual_revenue | cust_type | address | city | state | zip | phone |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 193 | Advanced Fabricators | 39588651 | manufacturer | 5141 Summit Boulevard | West Palm Beach | FL | 33415.0 | (561) 683-3535 |
| 304 | Pard's Trailer Sales | 17158109 | wholesaler | 5910 South 300 West | Salt Lake City | UT | 84107.0 | (801) 262-4864 |
| 314 | Saar Enterprises, Inc. | 47403613 | retailer | 11687 192nd Street | Council Bluffs | IA | 51503.0 | (712) 366-4929 |
| 381 | Autoware Inc | 5583961 | wholesaler | 854 Southwest 12th Avenue | Pompano Beach | FL | 33069.0 | (954) 738-4000 |
| 493 | Harry's Hot Rod Auto & Truck Accessories | 11732302 | retailer | 105 NW 13th St | Grand Prairie | TX | 75050.0 | (972) 263-8080 |

### 6.3 `driver`

- 表含义：货运司机基础信息。
- 行数：`11`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| driver_id | INTEGER | integer | PK |  | 司机编号，关联 driver.driver_id。 别名：driver id。 样例值：20、21、22。 |
| first_name | TEXT | text |  |  | First given name of the driver 别名：first name。 样例值：Sue、Andrea、Roger。 |
| last_name | TEXT | text |  |  | Family name of the driver 别名：last name。 取值说明：commonsense evidence: full name = first_name + last_name。 |
| address | TEXT | text |  |  | 地址。 样例值：268 Richmond Ave、3574 Oak Limb Cv、1839 S Orleans St。 |
| city | TEXT | text |  |  | 城市。 样例值：Memphis。 |
| state | TEXT | text |  |  | 司机所在州缩写，数据库中存 `TN` 等两字母代码；题目写完整州名时需映射为缩写。 |
| zip_code | INTEGER | integer |  |  | 邮政编码。 别名：zip code。 样例值：38106、38135、38118。 |
| phone | TEXT | text |  |  | 联系电话。 样例值：(901) 774-6569、(901) 384-0984、(901) 948-1043。 |

样例数据（前 5 行）：

| driver_id | first_name | last_name | address | city | state | zip_code | phone |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 20 | Sue | Newell | 268 Richmond Ave | Memphis | TN | 38106 | (901) 774-6569 |
| 21 | Andrea | Simons | 3574 Oak Limb Cv | Memphis | TN | 38135 | (901) 384-0984 |
| 22 | Roger | McHaney | 1839 S Orleans St | Memphis | TN | 38106 | (901) 948-1043 |
| 23 | Zachery | Hicks | 3649 Park Lake Dr | Memphis | TN | 38118 | (901) 362-6674 |
| 24 | Adel | Al-Alawi | 749 E Mckellar Ave | Memphis | TN | 38106 | (901) 947-4433 |

### 6.4 `shipment`

- 表含义：货运发运记录。
- 行数：`960`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ship_id | INTEGER | integer | PK |  | 货运记录唯一编号。 别名：ship id。 样例值：1000、1001、1002。 |
| cust_id | INTEGER | integer | FK | customer.cust_id | 外键，指向 `customer.cust_id`，表示本记录关联的客户。 |
| weight | REAL | real |  |  | 单票货运记录的货物重量；只有题目出现 total/sum/按实体累计等语义时才汇总。 样例值：3528.0、11394.0、8712.0。 |
| truck_id | INTEGER | integer | FK | truck.truck_id | 外键，指向 `truck.truck_id`，表示本记录关联的卡车。 |
| driver_id | INTEGER | integer | FK | driver.driver_id | 外键，指向 `driver.driver_id`，表示本记录关联的货运司机。 |
| city_id | INTEGER | integer | FK | city.city_id | 外键，指向 `city.city_id`，表示本记录关联的城市。 |
| ship_date | TEXT | text |  |  | 发货日期。 别名：ship date。 取值说明：yyyy-mm-dd。 样例值：2016-01-08、2016-01-18、2016-01-19。 |

样例数据（前 5 行）：

| ship_id | cust_id | weight | truck_id | driver_id | city_id | ship_date |
| --- | --- | --- | --- | --- | --- | --- |
| 1000 | 3660 | 3528.0 | 1 | 23 | 137 | 2016-01-08 |
| 1001 | 2001 | 11394.0 | 2 | 23 | 186 | 2016-01-18 |
| 1002 | 1669 | 8712.0 | 3 | 27 | 268 | 2016-01-19 |
| 1003 | 989 | 17154.0 | 4 | 23 | 365 | 2016-01-24 |
| 1004 | 2298 | 9279.0 | 5 | 27 | 253 | 2016-01-26 |

### 6.5 `truck`

- 表含义：卡车基础信息。
- 行数：`12`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| truck_id | INTEGER | integer | PK |  | 卡车编号，关联 truck.truck_id。 别名：truck id。 样例值：1、2、3。 |
| make | TEXT | text |  |  | 卡车品牌或制造商。总部映射：`Peterbilt` -> `Texas (TX)`，`Mack` -> `North Carolina (NC)`，`Kenworth` -> `Washington (WA)`；题目问 truck headquarter 时需用 `CASE` 从 `make` 映射。 |
| model_year | INTEGER | integer |  |  | 卡车生产年份。数值越大通常表示越新；问 newest 用 `MAX(model_year)`，问 oldest 用 `MIN(model_year)`。 别名：model year。 |

样例数据（前 5 行）：

| truck_id | make | model_year |
| --- | --- | --- |
| 1 | Peterbilt | 2005 |
| 2 | Mack | 2006 |
| 3 | Peterbilt | 2007 |
| 4 | Kenworth | 2007 |
| 5 | Mack | 2008 |

## 7. SQL 生成注意事项

- `shipment` 是事实表，客户、司机、卡车、城市都需通过编号连接到维表；默认保持 shipment 行粒度，除非题目要求按客户、司机、城市或卡车聚合。
- 地理字段需先判断层级：`shipment.city_id -> city.city_name/state` 表示发运目的地，`customer.city/state/zip` 表示客户地址，`driver.city/state/zip_code` 表示司机住址；不要混作同一地理口径。
- 目的地名称默认按最具体字段匹配。题目说 transported to、bound for、destination city、shipped to 后跟普通地名时，优先匹配 `city.city_name`；只有明确出现 state、belong to、in the state of 等州/省语义时，才使用 `city.state`。
- `city.state` 存完整州名，如 `New York`、`New Jersey`；`customer.state` 和 `driver.state` 存两字母缩写，如 `NY`、`NJ`、`CA`、`SC`。题目问客户或司机所在州时用对应地址表的缩写列，问发运目的城市所属州时用 `city.state`。
- 字符串值必须按数据库原文精确匹配，不要自行改写地名或补标点。例如库中城市为 `New York`，不要改成 `New York City`；客户名 `S K L Enterprises Inc` 在表中没有句点。
- `weight` 是单票 shipment 重量。题目问单票 shipment 的重量、列出 shipment weight、或筛选 “shipment with weight ...” 时直接使用 `shipment.weight`。
- 题目问司机、客户、城市等实体 transported/shipped weight greater than 某阈值时，通常表示实体累计运输重量，应按实体 ID `GROUP BY` 后用 `HAVING SUM(weight) ...`；只有明确说 single shipment、each shipment 或某一条 shipment 时，才用单票 `WHERE weight ...`。
- 日期字段 `shipment.ship_date` 是文本，格式为 `YYYY-MM-DD`。`on DATE`、`shipped by DATE` 在本库通常按发货日期精确匹配；只有题目明确 before、earlier than、no later than、up to 等范围语义时，才使用 `<` 或 `<=`。
- 姓名输出按题面决定：明确问 full name 或单个 driver name 时可用 `first_name || ' ' || last_name`；明确要求 first name and last name 时返回两列；不要因为姓名拆成两个字段就默认改变输出列数。
- 问每个司机平均每月运送多少 shipment 时，分母应是全库不同年月数：`COUNT(DISTINCT STRFTIME('%Y-%m', ship_date))`，并保留没有 shipment 的司机：`driver LEFT JOIN shipment`；不要用不同日期数作分母。
- 百分比的分母应与题目限定后的总体保持同一行粒度。问 shipment 百分比时分母是 shipment 行，问 customer 百分比时分母才是 customer；不要在分子或分母中随意切换到 `DISTINCT customer`。
- `oldest` 对 `model_year` 使用 `MIN(model_year)`，`newest/latest` 使用 `MAX(model_year)`。
- 问 “highest shipments/most shipments” 时按 shipment 数量 `COUNT(ship_id)` 排序，不要按 `SUM(weight)` 排序；问 truck headquarter 时用 `truck.make` 映射总部名称，并保留映射中的州缩写格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
