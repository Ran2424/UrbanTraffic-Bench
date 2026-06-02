# 数据库知识说明：spider_data__vehicle_rent

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__vehicle_rent |
| source | spider_data |
| db_id | vehicle_rent |
| database_dir | database_layer/spider_data__vehicle_rent |
| sqlite_path | database_layer/spider_data__vehicle_rent/vehicle_rent.sqlite |
| table_count | 4 |
| scenario_id | vehicle_rental |
| scenario_name | 车辆租赁 |
| scenario_description | 客户会员积分、折扣规则、车辆燃油经济性和租赁历史。 |

## 2. 业务子场景说明

本库聚焦“车辆租赁”子场景，核心对象包括客户、折扣、租赁历史、车辆等。它适合回答关于客户会员积分、折扣规则、车辆燃油经济性和租赁历史的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `vehicle_rent`
- database_dir: `database_layer/spider_data__vehicle_rent`
- db_path: `database_layer/spider_data__vehicle_rent/vehicle_rent.sqlite`
- original_db_path: `spider_data/spider_data/test_database/vehicle_rent/vehicle_rent.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| Customers | 租车客户基础信息和会员积分。 | 4 | 5 |
| Discount | 会员积分对应的折扣规则。 | 3 | 5 |
| Renting_history | 客户租用车辆的历史记录。 | 5 | 7 |
| Vehicles | 可租车辆的车型、动力和燃油成本指标。 | 10 | 7 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| Renting_history.customer_id | Customers.id |
| Renting_history.discount_id | Discount.id |
| Renting_history.vehicles_id | Vehicles.id |

## 6. 表与字段说明

### 6.1 `Customers`

- 表含义：租车客户基础信息和会员积分。
- 行数：`5`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 客户的唯一编号，用于标识一条客户记录。 样例值：1、2、3。 |
| name | TEXT | text |  |  | 名称。 样例值：Griffiths、Silluzio、Woodman。 |
| age | INT | number |  |  | 年龄。 样例值：26、34、35。 |
| membership_credit | INT | number |  |  | 会员积分或达到该折扣所需积分。 样例值：100、1200、2000。 |

样例数据（前 5 行）：

| id | name | age | membership_credit |
| --- | --- | --- | --- |
| 1 | Griffiths | 26 | 100 |
| 2 | Silluzio | 34 | 1200 |
| 3 | Woodman | 35 | 2000 |
| 4 | Poulter | 63 | 43500 |
| 5 | Smith | 45 | 5399 |

### 6.2 `Discount`

- 表含义：会员积分对应的折扣规则。
- 行数：`5`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 折扣的唯一编号，用于标识一条折扣记录。 样例值：1、2、3。 |
| name | TEXT | text |  |  | 名称。 样例值：no discount、20% off、40% off for over $6000。 |
| membership_credit | INT | number |  |  | 会员积分或达到该折扣所需积分。 样例值：0、1000、2000。 |

样例数据（前 5 行）：

| id | name | membership_credit |
| --- | --- | --- |
| 1 | no discount | 0 |
| 2 | 20% off | 1000 |
| 3 | 40% off for over $6000 | 2000 |
| 4 | 50% off | 4000 |
| 5 | 70% off | 400000 |

### 6.3 `Renting_history`

- 表含义：客户租用车辆的历史记录。
- 行数：`7`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 租赁历史的唯一编号，用于标识一条租赁历史记录。 样例值：1、2、3。 |
| customer_id | INT | number | FK | Customers.id | 外键，指向 `Customers.id`，表示本记录关联的客户。 |
| discount_id | INT | number | FK | Discount.id | 外键，指向 `Discount.id`，表示本记录关联的折扣。 |
| vehicles_id | INT | number | FK | Vehicles.id | 外键，指向 `Vehicles.id`，表示本记录关联的车辆。 |
| total_hours | INT | number |  |  | 本次租赁总小时数。 样例值：1、10、24。 |

样例数据（前 5 行）：

| id | customer_id | discount_id | vehicles_id | total_hours |
| --- | --- | --- | --- | --- |
| 1 | 1 | 1 | 2 | 1 |
| 2 | 2 | 2 | 5 | 10 |
| 3 | 3 | 3 | 7 | 24 |
| 4 | 4 | 4 | 3 | 24 |
| 5 | 1 | 1 | 5 | 36 |

### 6.4 `Vehicles`

- 表含义：可租车辆的车型、动力和燃油成本指标。
- 行数：`7`
- 字段数：`10`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 车辆的唯一编号，用于标识一条车辆记录。 样例值：1、2、3。 |
| name | TEXT | text |  |  | 名称。 样例值：Chevrolet Spark EV、Honda Fit EV、Fiat 500e。 |
| Model_year | INT | number |  |  | 车型年份。 样例值：2014、2013、2012。 |
| Type_of_powertrain | TEXT | text |  |  | 动力系统类型。 样例值：Electric、hybrid。 |
| Combined_fuel_economy_rate | INT | number |  |  | 综合燃油经济性评分。 样例值：119、118、116。 |
| City_fuel_economy_rate | INT | number |  |  | 城市工况燃油经济性评分。 样例值：128、132、122。 |
| Highway_fuel_economy_rate | INT | number |  |  | 高速工况燃油经济性评分。 样例值：109、105、108。 |
| Cost_per_25_miles | REAL | number |  |  | 每 25 英里使用成本。 样例值：0.87、0.9。 |
| Annual_fuel_cost | REAL | number |  |  | 年度燃料成本。 样例值：500.0、550.0。 |
| Notes | TEXT | text |  |  | 车辆补充说明。 样例值：See (1)、best selling of the year。 |

样例数据（前 5 行）：

| id | name | Model_year | Type_of_powertrain | Combined_fuel_economy_rate | City_fuel_economy_rate | Highway_fuel_economy_rate | Cost_per_25_miles | Annual_fuel_cost | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Chevrolet Spark EV | 2014 | Electric | 119 | 128 | 109 | 0.87 | 500.0 | See (1) |
| 2 | Honda Fit EV | 2013 | hybrid | 118 | 132 | 105 | 0.87 | 500.0 | See (1) |
| 3 | Fiat 500e | 2013 | Electric | 116 | 122 | 108 | 0.87 | 500.0 | See (1) |
| 4 | Nissan Leaf | 2013 | Electric | 115 | 129 | 102 | 0.87 | 500.0 | See (1) |
| 5 | Mitsubishi i | 2012 | hybrid | 112 | 126 | 99 | 0.9 | 550.0 | best selling of the year |

## 7. SQL 生成注意事项

- `Renting_history` 是租赁事实表，客户、折扣、车辆都需要通过编号连接。
- `Discount.membership_credit` 表示折扣门槛积分，`Customers.membership_credit` 表示客户已有积分，二者含义不同。
- 查询每个车辆、客户或折扣的租赁统计时，先确定是否要保留没有租赁记录的实体：题目说 each/every/all vehicle/customer/discount 时，通常从实体表出发 `LEFT JOIN Renting_history`。
- `LEFT JOIN` 后做 `SUM(total_hours)`、`COUNT` 等聚合时要处理空值。未发生租赁的车辆总小时数应返回 0，可用 `COALESCE(SUM(Renting_history.total_hours), 0)`；不要让总和结果为 `NULL`。
- 问 “most rental history records / most records / most times rented” 时，按 `Renting_history` 事实记录条数 `COUNT(*)` 排序，不要按 `SUM(total_hours)` 或折扣额度、积分门槛排序。
- 统计某个维度对应的租赁记录数时，以 `Renting_history` 为事实表，按事实表外键或对应维表主键分组后再取维表名称；不要加入不必要的额外分组列或二级排序，以免并列时改变返回口径。
- 若多个实体的 `COUNT(*)` 并列且题目未指定并列规则，保持简单的 `GROUP BY 目标ID ORDER BY COUNT(*) DESC LIMIT 1`；不要额外按名称、ID、折扣比例等字段排序。
- 车辆燃油经济性和成本指标单位不同，比较前需确认题目要求的是评分、美元成本还是年成本。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
