# 数据库知识说明：spider_data__flight_4

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__flight_4 |
| source | spider_data |
| db_id | flight_4 |
| database_dir | database_layer/spider_data__flight_4 |
| sqlite_path | database_layer/spider_data__flight_4/flight_4.sqlite |
| table_count | 3 |
| scenario_id | flight_network |
| scenario_name | 航空公司、机场与航线 |
| scenario_description | 航空公司、机场、航线、IATA/ICAO 代码和是否代码共享。 |

## 2. 业务子场景说明

本库聚焦“航空公司、机场与航线”子场景，核心对象包括航空公司、机场、航线等。它适合回答关于航空公司、机场、航线、IATA/ICAO 代码和是否代码共享的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `flight_4`
- database_dir: `database_layer/spider_data__flight_4`
- db_path: `database_layer/spider_data__flight_4/flight_4.sqlite`
- original_db_path: `spider_data/spider_data/database/flight_4/flight_4.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| airlines | 航空公司基础信息。 | 7 | 6162 |
| airports | 机场基础信息。 | 9 | 7184 |
| routes | 航空公司运营的机场间航线记录。 | 8 | 67240 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| routes.dst_apid | airports.apid |
| routes.src_apid | airports.apid |
| routes.alid | airlines.alid |

## 6. 表与字段说明

### 6.1 `airlines`

- 表含义：航空公司基础信息。
- 行数：`6162`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| alid | INTEGER | number | PK |  | 航空公司唯一编号。 样例值：-1、1、2。 |
| name | TEXT | text |  |  | 名称。 样例值：Unknown、Private flight、135 Airways。 |
| iata | varchar(2) | text |  |  | IATA 两字母/三字母代码。 样例值：-、1T。 |
| icao | varchar(3) | text |  |  | ICAO 代码。 样例值：N/A、GNL、RNX。 |
| callsign | TEXT | text |  |  | 航空公司无线电呼号。 样例值：GENERAL、NEXTIME。 |
| country | TEXT | text |  |  | 国家或地区。 样例值：United States、South Africa、United Kingdom。 |
| active | varchar(2) | text |  |  | 航空公司是否仍在运营，Y 表示活跃，N 表示非活跃。 |

样例数据（前 5 行）：

| alid | name | iata | icao | callsign | country | active |
| --- | --- | --- | --- | --- | --- | --- |
| -1 | Unknown | - | N/A |  |  | Y |
| 1 | Private flight | - | N/A |  |  | Y |
| 2 | 135 Airways |  | GNL | GENERAL | United States | N |
| 3 | 1Time Airline | 1T | RNX | NEXTIME | South Africa | Y |
| 4 | 2 Sqn No 1 Elementary Flying Training School |  | WYT |  | United Kingdom | N |

### 6.2 `airports`

- 表含义：机场基础信息。
- 行数：`7184`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| apid | INTEGER | number | PK |  | 机场唯一编号。 样例值：1、2、3。 |
| name | TEXT | text | NOT NULL |  | 名称。 样例值：Goroka Airport、Madang Airport、Mount Hagen Kagamuga Airport。 |
| city | TEXT | text |  |  | 城市。 样例值：Goroka、Madang、Mount Hagen。 |
| country | TEXT | text |  |  | 国家或地区。 样例值：Papua New Guinea。 |
| x | REAL | number |  |  | 机场经度坐标。 样例值：145.391998291、145.789001465、144.29600524902344。 |
| y | REAL | number |  |  | 机场纬度坐标。 样例值：-6.081689834590001、-5.20707988739、-5.826789855957031。 |
| elevation | bigint | number |  |  | 机场海拔高度。 样例值：5282、20、5388。 |
| iata | character varchar(3) | text |  |  | IATA 两字母/三字母代码。 样例值：GKA、MAG、HGU。 |
| icao | character varchar(4) | text |  |  | ICAO 代码。 样例值：AYGA、AYMD、AYMH。 |

样例数据（前 5 行）：

| apid | name | city | country | x | y | elevation | iata | icao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Goroka Airport | Goroka | Papua New Guinea | 145.391998291 | -6.081689834590001 | 5282 | GKA | AYGA |
| 2 | Madang Airport | Madang | Papua New Guinea | 145.789001465 | -5.20707988739 | 20 | MAG | AYMD |
| 3 | Mount Hagen Kagamuga Airport | Mount Hagen | Papua New Guinea | 144.29600524902344 | -5.826789855957031 | 5388 | HGU | AYMH |
| 4 | Nadzab Airport | Nadzab | Papua New Guinea | 146.725977 | -6.569803 | 239 | LAE | AYNZ |
| 5 | Port Moresby Jacksons International Airport | Port Moresby | Papua New Guinea | 147.22000122070312 | -9.443380355834961 | 146 | POM | AYPY |

### 6.3 `routes`

- 表含义：航空公司运营的机场间航线记录。
- 行数：`67240`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| rid | INTEGER | number | PK |  | 航线记录唯一编号。 样例值：37、38、39。 |
| dst_apid | INTEGER | number | FK | airports.apid | 外键，指向 `airports.apid`，表示本记录关联的机场。 |
| dst_ap | varchar(4) | text |  |  | 目的机场 IATA/简码。 样例值：KZ、MRV、OVB。 |
| src_apid | bigint | number | FK | airports.apid | 外键，指向 `airports.apid`，表示本记录关联的机场。 |
| src_ap | varchar(4) | text |  |  | 起飞机场 IATA/简码。 样例值：AER、ASF、CEK。 |
| alid | bigint | number | FK | airlines.alid | 外键，指向 `airlines.alid`，表示本记录关联的航空公司。 |
| airline | varchar(4) | text |  |  | 运营该航线的航空公司代码。 样例值：2B。 |
| codeshare | TEXT | text |  |  | 是否为代码共享航线或代码共享标记。 |

样例数据（前 5 行）：

| rid | dst_apid | dst_ap | src_apid | src_ap | alid | airline | codeshare |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 37 | 2990 | KZ | 2965 | AER | 410 | 2B |  |
| 38 | 2990 | KZ | 2966 | ASF | 410 | 2B |  |
| 39 | 2962 | MRV | 2966 | ASF | 410 | 2B |  |
| 40 | 2990 | KZ | 2968 | CEK | 410 | 2B |  |
| 41 | 4078 | OVB | 2968 | CEK | 410 | 2B |  |

## 7. SQL 生成注意事项

- `routes` 中同时保存机场编号和机场代码，连接机场表优先用 `src_apid/dst_apid`。
- `airlines.active` 是 Y/N 文本；只有题目明确说 active/current/active status/operating status is Y 时才筛选 `active = 'Y'`。普通的 “How many airlines operate out of each country” 在本库正式 Gold 口径是按 `airlines.country` 统计所有航空公司，不筛选 `active = 'Y'`。
- `airports.x/y` 分别为经度/纬度，不要和常见 lat/lng 顺序混淆。
- 不要主动排除 `airports.city` 为空或空字符串的记录，除非题目明确要求“有效城市/非空城市”。正式任务中的 Gold SQL 通常直接按 `city` 分组或计数，额外加 `city IS NOT NULL`、`TRIM(city) <> ''` 会改变结果。
- 问“每个源机场/目的机场的航线数量”时，通常用 `airports` 与 `routes` 的 INNER JOIN，按 `routes.src_apid` 或 `routes.dst_apid` 连接并按机场名称分组；不要使用 LEFT JOIN 纳入 0 条航线的机场，除非题目明确要求包含没有航线的机场。
- “each source airport / each destination airport” 且返回机场名称时，优先按机场实体粒度分组：`GROUP BY airports.apid, airports.name` 或 `GROUP BY routes.src_apid/dst_apid, airports.name`。只有题目明确说 “for each airport name” 时才可只按 `airports.name` 分组。
- 题目问 “different airports” 时必须使用 `COUNT(DISTINCT routes.src_apid)` 或 `COUNT(DISTINCT routes.dst_apid)`，不要用普通 `COUNT()`。
- 问 “for each country and airline name / airline in that country, how many routes” 时，country 指 `airlines.country`，不是起点或终点机场所在国家；除非题目明确说 source/destination airport country，否则不要额外连接 `airports` 来取国家。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
