# 数据库知识说明：spider_data__flight_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__flight_1 |
| source | spider_data |
| db_id | flight_1 |
| database_dir | database_layer/spider_data__flight_1 |
| sqlite_path | database_layer/spider_data__flight_1/flight_1.sqlite |
| table_count | 4 |
| scenario_id | flight_operation |
| scenario_name | 航班、飞机与员工资质 |
| scenario_description | 飞机航程、员工薪资、飞行资质和航班信息。 |

## 2. 业务子场景说明

本库聚焦“航班、飞机与员工资质”子场景，核心对象包括航空器、资质记录、员工、航班/飞行记录等。它适合回答关于飞机航程、员工薪资、飞行资质和航班信息的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `flight_1`
- database_dir: `database_layer/spider_data__flight_1`
- db_path: `database_layer/spider_data__flight_1/flight_1.sqlite`
- original_db_path: `spider_data/spider_data/database/flight_1/flight_1.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| aircraft | 航空器基础信息或飞机性能参数记录。 | 3 | 16 |
| certificate | 员工持有飞机驾驶资格的关系表。 | 2 | 69 |
| employee | 员工及其薪资信息。 | 3 | 31 |
| flight | 航班或飞行测试记录。 | 8 | 10 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| certificate.eid | employee.eid |
| certificate.aid | aircraft.aid |
| flight.aid | aircraft.aid |

## 6. 表与字段说明

### 6.1 `aircraft`

- 表含义：航空器基础信息或飞机性能参数记录。
- 行数：`16`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| aid | number(9,0) | number | PK |  | 飞机编号，关联 aircraft.aid。 样例值：1、2、3。 |
| name | varchar2(30) | text |  |  | 名称。 样例值：Boeing 747-400、Boeing 737-800、Airbus A340-300。 |
| distance | number(6,0) | number |  |  | 航程或飞行距离。 样例值：8430、3383、7120。 |

样例数据（前 5 行）：

| aid | name | distance |
| --- | --- | --- |
| 1 | Boeing 747-400 | 8430 |
| 2 | Boeing 737-800 | 3383 |
| 3 | Airbus A340-300 | 7120 |
| 4 | British Aerospace Jetstream 41 | 1502 |
| 5 | Embraer ERJ-145 | 1530 |

### 6.2 `certificate`

- 表含义：员工持有飞机驾驶资格的关系表。
- 行数：`69`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| eid | number(9,0) | number | PK, FK | employee.eid | 外键，指向 `employee.eid`，表示本记录关联的员工。 |
| aid | number(9,0) | number | PK, FK | aircraft.aid | 外键，指向 `aircraft.aid`，表示本记录关联的航空器。 |

样例数据（前 5 行）：

| eid | aid |
| --- | --- |
| 11564812 | 2 |
| 11564812 | 10 |
| 90873519 | 6 |
| 141582651 | 2 |
| 141582651 | 10 |

### 6.3 `employee`

- 表含义：员工及其薪资信息。
- 行数：`31`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| eid | number(9,0) | number | PK |  | 员工编号，关联 employee.eid。 样例值：242518965、141582651、11564812。 |
| name | varchar2(30) | text |  |  | 名称。 样例值：James Smith、Mary Johnson、John Williams。 |
| salary | number(10,2) | number |  |  | 员工薪资。 样例值：120433、178345、153972。 |

样例数据（前 5 行）：

| eid | name | salary |
| --- | --- | --- |
| 242518965 | James Smith | 120433 |
| 141582651 | Mary Johnson | 178345 |
| 11564812 | John Williams | 153972 |
| 567354612 | Lisa Walker | 256481 |
| 552455318 | Larry West | 101745 |

### 6.4 `flight`

- 表含义：航班或飞行测试记录。
- 行数：`10`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| flno | number(4,0) | number | PK |  | 航班号。 样例值：99、13、346。 |
| origin | varchar2(20) | text |  |  | 产地编号。 样例值：Los Angeles。 |
| destination | varchar2(20) | text |  |  | 到达城市或机场。 样例值：Washington D.C.、Chicago、Dallas。 |
| distance | number(6,0) | number |  |  | 航程或飞行距离。 样例值：2308、1749、1251。 |
| departure_date | date | time |  |  | 计划或实际出发日期时间。 样例值：04/12/2005 09:30、04/12/2005 08:45、04/12/2005 11:50。 |
| arrival_date | date | time |  |  | 计划或实际到达日期时间。 样例值：04/12/2005 09:40、04/12/2005 08:45、04/12/2005 07:05。 |
| price | number(7,2) | number |  |  | 价格或票价。 样例值：235.98、220.98、182。 |
| aid | number(9,0) | number | FK | aircraft.aid | 外键，指向 `aircraft.aid`，表示本记录关联的航空器。 |

样例数据（前 5 行）：

| flno | origin | destination | distance | departure_date | arrival_date | price | aid |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 99 | Los Angeles | Washington D.C. | 2308 | 04/12/2005 09:30 | 04/12/2005 09:40 | 235.98 | 1 |
| 13 | Los Angeles | Chicago | 1749 | 04/12/2005 08:45 | 04/12/2005 08:45 | 220.98 | 3 |
| 346 | Los Angeles | Dallas | 1251 | 04/12/2005 11:50 | 04/12/2005 07:05 | 182 | 2 |
| 387 | Los Angeles | Boston | 2606 | 04/12/2005 07:03 | 04/12/2005 05:03 | 261.56 | 6 |
| 7 | Los Angeles | Sydney | 7487 | 04/12/2005 05:30 | 04/12/2005 11:10 | 278.56 | 3 |

## 7. SQL 生成注意事项

- `certificate` 是员工与飞机资质的多对多表，统计有资质员工或飞机时注意去重。
- `flight.aid` 是执行航班的飞机编号，航班距离 `flight.distance` 与飞机航程 `aircraft.distance` 含义不同。
- 出发和到达时间为文本日期时间，比较前需确认格式。
- 日期/时间多为文本字段：`flight.departure_date`、`flight.arrival_date`；做范围筛选或排序前需确认格式。
- 问“认证人数最少的飞机/least people certified to fly”时，应从 `aircraft` 出发 `LEFT JOIN certificate`，这样没有任何证书记录的飞机也能以 0 计入；不要只从 `certificate` 内连接。
- 输出列顺序要严格跟随题目表述，例如 “salary and name” 输出 `salary, name`，不要改成 `name, salary`。
- 问“most certificates on aircrafts with distance more than X”时，在筛选 `aircraft.distance > X` 后按员工分组统计证书数量。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
