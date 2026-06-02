# 数据库知识说明：spider_data__flight_company

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__flight_company |
| source | spider_data |
| db_id | flight_company |
| database_dir | database_layer/spider_data__flight_company |
| sqlite_path | database_layer/spider_data__flight_company/flight_company.sqlite |
| table_count | 3 |
| scenario_id | flight_company_operation |
| scenario_name | 航空公司与飞行运营 |
| scenario_description | 机场、运营公司、飞行试验记录、速度和高度。 |

## 2. 业务子场景说明

本库聚焦“航空公司与飞行运营”子场景，核心对象包括机场、航班/飞行记录、运营公司等。它适合回答关于机场、运营公司、飞行试验记录、速度和高度的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `flight_company`
- database_dir: `database_layer/spider_data__flight_company`
- db_path: `database_layer/spider_data__flight_company/flight_company.sqlite`
- original_db_path: `spider_data/spider_data/database/flight_company/flight_company.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| airport | 机场基础信息和客运、货运、起降吞吐指标。 | 6 | 9 |
| flight | 航班或飞行测试记录。 | 8 | 13 |
| operate_company | 运营公司基础信息和股权信息。 | 6 | 14 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| flight.airport_id | airport.id |
| flight.company_id | operate_company.id |

## 6. 表与字段说明

### 6.1 `airport`

- 表含义：机场基础信息和客运、货运、起降吞吐指标。
- 行数：`9`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 机场的唯一编号，用于标识一条机场记录。 样例值：1、2、3。 |
| City | TEXT | text |  |  | 城市。 样例值：Akureyri、Amsterdam、Anchorage。 |
| Country | TEXT | text |  |  | 国家或地区。 样例值：Iceland、Netherlands、United States。 |
| IATA | TEXT | text |  |  | 机场 IATA 三字代码。 样例值：AEY、AMS、ANC。 |
| ICAO | TEXT | text |  |  | 机场 ICAO 四字代码。 样例值：BIAR、EHAM、PANC。 |
| name | TEXT | text |  |  | 名称。 样例值：Akureyri Airport、Schiphol Airport、Ted Stevens Airport。 |

样例数据（前 5 行）：

| id | City | Country | IATA | ICAO | name |
| --- | --- | --- | --- | --- | --- |
| 1 | Akureyri | Iceland | AEY | BIAR | Akureyri Airport |
| 2 | Amsterdam | Netherlands | AMS | EHAM | Schiphol Airport |
| 3 | Anchorage | United States | ANC | PANC | Ted Stevens Airport |
| 4 | Baltimore | United States | BWI | KBWI | Baltimore-Washington Airport |
| 5 | Barcelona | Spain | BCN | LEBL | El Prat Airport |

### 6.2 `flight`

- 表含义：航班或飞行测试记录。
- 行数：`13`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 航班/飞行记录的唯一编号，用于标识一条航班/飞行记录记录。 样例值：1、2、3。 |
| Vehicle_Flight_number | TEXT | text |  |  | 飞行器测试或飞行任务编号。 样例值：M2-F1 #0、M2-F1 #1、M2-F1 #6。 |
| Date | TEXT | text |  |  | 日期。 样例值：March 1, 1963、August 16, 1963、September 3, 1963。 |
| Pilot | TEXT | text |  |  | 飞行员姓名文本。 样例值：Thompson。 |
| Velocity | REAL | number |  |  | 飞行速度。 样例值：135.0、240.0。 |
| Altitude | REAL | number |  |  | 飞行高度。 样例值：0.0、3650.0。 |
| airport_id | INT | number | FK | airport.id | 外键，指向 `airport.id`，表示本记录关联的机场。 |
| company_id | INT | number | FK | operate_company.id | 外键，指向 `operate_company.id`，表示本记录关联的运营公司。 |

样例数据（前 5 行）：

| id | Vehicle_Flight_number | Date | Pilot | Velocity | Altitude | airport_id | company_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | M2-F1 #0 | March 1, 1963 | Thompson | 135.0 | 0.0 | 1 | 2 |
| 2 | M2-F1 #1 | August 16, 1963 | Thompson | 240.0 | 3650.0 | 2 | 3 |
| 3 | M2-F1 #6 | September 3, 1963 | Thompson | 240.0 | 3650.0 | 2 | 4 |
| 4 | M2-F1 #13 | October 25, 1963 | Thompson | 240.0 | 3650.0 | 3 | 4 |
| 5 | M2-F1 #14 | November 8, 1963 | Thompson | 240.0 | 3650.0 | 4 | 5 |

### 6.3 `operate_company`

- 表含义：运营公司基础信息和股权信息。
- 行数：`14`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 运营公司的唯一编号，用于标识一条运营公司记录。 样例值：1、2、3。 |
| name | TEXT | text |  |  | 名称。 样例值：Air China、Air China Cargo、Air Hong Kong。 |
| Type | TEXT | text |  |  | 学校类型，例如公立、私立或私立天主教学校。 样例值：Corporate、Joint Venture、Subsidiary。 |
| Principal_activities | TEXT | text |  |  | 公司主要业务活动。 样例值：Airline、Cargo airline。 |
| Incorporated_in | TEXT | text |  |  | 公司注册地。 样例值：China、Hong Kong。 |
| Group_Equity_Shareholding | REAL | number |  |  | 集团持股比例。 样例值：18.77、49.0、60.0。 |

样例数据（前 5 行）：

| id | name | Type | Principal_activities | Incorporated_in | Group_Equity_Shareholding |
| --- | --- | --- | --- | --- | --- |
| 1 | Air China | Corporate | Airline | China | 18.77 |
| 2 | Air China Cargo | Joint Venture | Cargo airline | China | 49.0 |
| 3 | Air Hong Kong | Joint Venture | Cargo airline | Hong Kong | 60.0 |
| 4 | Dragonair | Subsidiary | Airline | Hong Kong | 100.0 |
| 5 | Cathay Pacific Cargo | Subsidiary | Cargo airline | Hong Kong | 100.0 |

## 7. SQL 生成注意事项

- `flight.Pilot` 是飞行员姓名文本，本库没有独立 pilot 表。
- `Velocity`、`Altitude` 为数值指标，按最大/平均统计时不要与飞行编号混用。
- `operate_company.Group_Equity_Shareholding` 是持股比例数值，不是 0-1 小数。
- 日期/时间多为文本字段：`flight.Date`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
