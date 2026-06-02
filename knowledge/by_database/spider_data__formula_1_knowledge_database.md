# 数据库知识说明：spider_data__formula_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__formula_1 |
| source | spider_data |
| db_id | formula_1 |
| database_dir | database_layer/spider_data__formula_1 |
| sqlite_path | database_layer/spider_data__formula_1/formula_1.sqlite |
| table_count | 13 |
| scenario_id | racing_competition |
| scenario_name | F1 赛车赛事 |
| scenario_description | F1 赛季、赛事、赛道、车手、车队、排位赛、正赛结果和积分榜。 |

## 2. 业务子场景说明

本库聚焦“F1 赛车赛事”子场景，核心对象包括赛道、车队单站结果、车队积分榜、车队/制造商、车手积分榜、车手、单圈计时、进站记录等。它适合回答关于F1 赛季、赛事、赛道、车手、车队、排位赛、正赛结果和积分榜的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `formula_1`
- database_dir: `database_layer/spider_data__formula_1`
- db_path: `database_layer/spider_data__formula_1/formula_1.sqlite`
- original_db_path: `spider_data/spider_data/database/formula_1/formula_1.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| circuits | F1 赛道基础信息。 | 9 | 73 |
| constructorResults | F1 单站赛事中车队获得的积分结果。 | 5 | 11142 |
| constructorStandings | F1 某站赛后车队积分榜。 | 7 | 11896 |
| constructors | F1 车队或制造商基础信息。 | 5 | 208 |
| driverStandings | F1 某站赛后车手积分榜。 | 7 | 31726 |
| drivers | F1 车手基础信息。 | 9 | 842 |
| lapTimes | F1 单圈计时记录。 | 6 | 0 |
| pitStops | F1 进站记录。 | 7 | 0 |
| qualifying | F1 排位赛成绩记录。 | 9 | 7516 |
| races | F1 分站比赛记录。 | 8 | 997 |
| results | F1 正赛结果记录。 | 18 | 23777 |
| seasons | F1 赛季维表。 | 2 | 69 |
| status | F1 完赛、退赛、事故、取消资格等比赛状态维表。 | 2 | 134 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| constructorResults.raceId | races.raceId |
| constructorResults.constructorId | constructors.constructorId |
| constructorStandings.raceId | races.raceId |
| constructorStandings.constructorId | constructors.constructorId |
| driverStandings.raceId | races.raceId |
| driverStandings.driverId | drivers.driverId |
| lapTimes.raceId | races.raceId |
| lapTimes.driverId | drivers.driverId |
| pitStops.raceId | races.raceId |
| pitStops.driverId | drivers.driverId |
| qualifying.raceId | races.raceId |
| qualifying.driverId | drivers.driverId |
| qualifying.constructorId | constructors.constructorId |
| races.circuitId | circuits.circuitId |
| results.raceId | races.raceId |
| results.driverId | drivers.driverId |
| results.constructorId | constructors.constructorId |

## 6. 表与字段说明

### 6.1 `circuits`

- 表含义：F1 赛道基础信息。
- 行数：`73`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| circuitId | INTEGER | number | PK |  | 赛道的唯一编号，用于标识一条赛道记录。 样例值：1、2、3。 |
| circuitRef | TEXT | text |  |  | 赛道英文短引用名。 样例值：albert_park、sepang、bahrain。 |
| name | TEXT | text |  |  | 名称。 样例值：Albert Park Grand Prix Circuit、Sepang International Circuit、Bahrain International Circuit。 |
| location | TEXT | text |  |  | 地点或城市位置。 样例值：Melbourne、Kuala Lumpur、Sakhir。 |
| country | TEXT | text |  |  | 国家或地区。 样例值：Australia、Malaysia、Bahrain。 |
| lat | REAL | number |  |  | 纬度坐标。 样例值：-37.8497、2.76083、26.0325。 |
| lng | REAL | number |  |  | 经度坐标。 样例值：144.968、101.738、50.5106。 |
| alt | TEXT | number |  |  | 海拔高度。 样例值：10。 |
| url | TEXT | text |  |  | 参考网页 URL。 样例值：http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit、http://en.wikipedia.org/wiki/Sepang_International_Circuit、http://en.wikipedia.org/wiki/Bahrain_International_Circuit。 |

样例数据（前 5 行）：

| circuitId | circuitRef | name | location | country | lat | lng | alt | url |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | albert_park | Albert Park Grand Prix Circuit | Melbourne | Australia | -37.8497 | 144.968 | 10 | http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit |
| 2 | sepang | Sepang International Circuit | Kuala Lumpur | Malaysia | 2.76083 | 101.738 |  | http://en.wikipedia.org/wiki/Sepang_International_Circuit |
| 3 | bahrain | Bahrain International Circuit | Sakhir | Bahrain | 26.0325 | 50.5106 |  | http://en.wikipedia.org/wiki/Bahrain_International_Circuit |
| 4 | catalunya | Circuit de Barcelona-Catalunya | Montmel_ | Spain | 41.57 | 2.26111 |  | http://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya |
| 5 | istanbul | Istanbul Park | Istanbul | Turkey | 40.9517 | 29.405 |  | http://en.wikipedia.org/wiki/Istanbul_Park |

### 6.2 `constructorResults`

- 表含义：F1 单站赛事中车队获得的积分结果。
- 行数：`11142`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| constructorResultsId | INTEGER | number | PK |  | 车队单站结果记录唯一编号。 样例值：1、2、3。 |
| raceId | INTEGER | number | FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| constructorId | INTEGER | number | FK | constructors.constructorId | 外键，指向 `constructors.constructorId`，表示本记录关联的车队/制造商。 |
| points | REAL | number |  |  | 积分或得分数值。 样例值：14.0、8.0、9.0。 |
| status | TEXT | number |  |  | 状态。 样例值：NULL。 |

样例数据（前 5 行）：

| constructorResultsId | raceId | constructorId | points | status |
| --- | --- | --- | --- | --- |
| 1 | 18 | 1 | 14.0 | NULL |
| 2 | 18 | 2 | 8.0 | NULL |
| 3 | 18 | 3 | 9.0 | NULL |
| 4 | 18 | 4 | 5.0 | NULL |
| 5 | 18 | 5 | 2.0 | NULL |

### 6.3 `constructorStandings`

- 表含义：F1 某站赛后车队积分榜。
- 行数：`11896`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| constructorStandingsId | INTEGER | number | PK |  | 车队积分榜记录唯一编号。 样例值：1、2、3。 |
| raceId | INTEGER | number | FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| constructorId | INTEGER | number | FK | constructors.constructorId | 外键，指向 `constructors.constructorId`，表示本记录关联的车队/制造商。 |
| points | REAL | number |  |  | 积分或得分数值。 样例值：14.0、8.0、9.0。 |
| position | INTEGER | number |  |  | 车队在该站赛后的积分榜名次。 样例值：1、3、2。 |
| positionText | TEXT | text |  |  | 名次文本表示，可能含 R、D、E 等非数字状态。 样例值：1、3、2。 |
| wins | INTEGER | number |  |  | 截至该站车队累计获胜场次数。 样例值：1、0。 |

样例数据（前 5 行）：

| constructorStandingsId | raceId | constructorId | points | position | positionText | wins |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 18 | 1 | 14.0 | 1 | 1 | 1 |
| 2 | 18 | 2 | 8.0 | 3 | 3 | 0 |
| 3 | 18 | 3 | 9.0 | 2 | 2 | 0 |
| 4 | 18 | 4 | 5.0 | 4 | 4 | 0 |
| 5 | 18 | 5 | 2.0 | 5 | 5 | 0 |

### 6.4 `constructors`

- 表含义：F1 车队或制造商基础信息。
- 行数：`208`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| constructorId | INTEGER | number | PK |  | 车队/制造商的唯一编号，用于标识一条车队/制造商记录。 样例值：1、2、3。 |
| constructorRef | TEXT | text |  |  | 车队或制造商英文短引用名。 样例值：mclaren、bmw_sauber、williams。 |
| name | TEXT | text |  |  | 名称。 样例值：McLaren、BMW Sauber、Williams。 |
| nationality | TEXT | text |  |  | 国籍。 样例值：British、German、French。 |
| url | TEXT | text |  |  | 参考网页 URL。 样例值：http://en.wikipedia.org/wiki/McLaren、http://en.wikipedia.org/wiki/BMW_Sauber、http://en.wikipedia.org/wiki/Williams_Grand_Prix_Engineering。 |

样例数据（前 5 行）：

| constructorId | constructorRef | name | nationality | url |
| --- | --- | --- | --- | --- |
| 1 | mclaren | McLaren | British | http://en.wikipedia.org/wiki/McLaren |
| 2 | bmw_sauber | BMW Sauber | German | http://en.wikipedia.org/wiki/BMW_Sauber |
| 3 | williams | Williams | British | http://en.wikipedia.org/wiki/Williams_Grand_Prix_Engineering |
| 4 | renault | Renault | French | http://en.wikipedia.org/wiki/Renault_F1 |
| 5 | toro_rosso | Toro Rosso | Italian | http://en.wikipedia.org/wiki/Scuderia_Toro_Rosso |

### 6.5 `driverStandings`

- 表含义：F1 某站赛后车手积分榜。
- 行数：`31726`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| driverStandingsId | INTEGER | number | PK |  | 车手积分榜记录唯一编号。 样例值：1、2、3。 |
| raceId | INTEGER | number | FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| driverId | INTEGER | number | FK | drivers.driverId | 外键，指向 `drivers.driverId`，表示本记录关联的车手。 |
| points | REAL | number |  |  | 积分或得分数值。 样例值：10.0、8.0、6.0。 |
| position | INTEGER | number |  |  | 车手在该站赛后的积分榜名次。 样例值：1、2、3。 |
| positionText | TEXT | text |  |  | 名次文本表示，可能含 R、D、E 等非数字状态。 样例值：1、2、3。 |
| wins | INTEGER | number |  |  | 截至该站车手累计获胜场次数。 样例值：1、0。 |

样例数据（前 5 行）：

| driverStandingsId | raceId | driverId | points | position | positionText | wins |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 18 | 1 | 10.0 | 1 | 1 | 1 |
| 2 | 18 | 2 | 8.0 | 2 | 2 | 0 |
| 3 | 18 | 3 | 6.0 | 3 | 3 | 0 |
| 4 | 18 | 4 | 5.0 | 4 | 4 | 0 |
| 5 | 18 | 5 | 4.0 | 5 | 5 | 0 |

### 6.6 `drivers`

- 表含义：F1 车手基础信息。
- 行数：`842`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| driverId | INTEGER | number | PK |  | 车手的唯一编号，用于标识一条车手记录。 样例值：1、2、3。 |
| driverRef | TEXT | text |  |  | 车手英文短引用名。 样例值：hamilton、heidfeld、rosberg。 |
| number | TEXT | number |  |  | 赛车号码或参赛号码。 样例值：44、6、14。 |
| code | TEXT | text |  |  | 车手三字母代码。 样例值：HAM、HEI、ROS。 |
| forename | TEXT | text |  |  | 车手名。 样例值：Lewis、Nick、Nico。 |
| surname | TEXT | text |  |  | 车手姓。 样例值：Hamilton、Heidfeld、Rosberg。 |
| dob | TEXT | text |  |  | 出生日期。 样例值：07/01/1985、10/05/1977、27/06/1985。 |
| nationality | TEXT | text |  |  | 国籍。 样例值：British、German、Spanish。 |
| url | TEXT | text |  |  | 参考网页 URL。 样例值：http://en.wikipedia.org/wiki/Lewis_Hamilton、http://en.wikipedia.org/wiki/Nick_Heidfeld、http://en.wikipedia.org/wiki/Nico_Rosberg。 |

样例数据（前 5 行）：

| driverId | driverRef | number | code | forename | surname | dob | nationality | url |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | hamilton | 44 | HAM | Lewis | Hamilton | 07/01/1985 | British | http://en.wikipedia.org/wiki/Lewis_Hamilton |
| 2 | heidfeld |  | HEI | Nick | Heidfeld | 10/05/1977 | German | http://en.wikipedia.org/wiki/Nick_Heidfeld |
| 3 | rosberg | 6 | ROS | Nico | Rosberg | 27/06/1985 | German | http://en.wikipedia.org/wiki/Nico_Rosberg |
| 4 | alonso | 14 | ALO | Fernando | Alonso | 29/07/1981 | Spanish | http://en.wikipedia.org/wiki/Fernando_Alonso |
| 5 | kovalainen |  | KOV | Heikki | Kovalainen | 19/10/1981 | Finnish | http://en.wikipedia.org/wiki/Heikki_Kovalainen |

### 6.7 `lapTimes`

- 表含义：F1 单圈计时记录。
- 行数：`0`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| raceId | INTEGER | number | PK, FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| driverId | INTEGER | number | PK, FK | drivers.driverId | 外键，指向 `drivers.driverId`，表示本记录关联的车手。 |
| lap | INTEGER | number | PK |  | 比赛第几圈。 |
| position | INTEGER | number |  |  | 该圈结束时车手所处名次。 |
| time | TEXT | text |  |  | 时间戳或时间。 |
| milliseconds | INTEGER | number |  |  | 用时毫秒数。 |

样例数据（前 5 行）：

| raceId | driverId | lap | position | time | milliseconds |
| --- | --- | --- | --- | --- | --- |

（该表当前没有样例行。）

### 6.8 `pitStops`

- 表含义：F1 进站记录。
- 行数：`0`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| raceId | INTEGER | number | PK, FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| driverId | INTEGER | number | PK, FK | drivers.driverId | 外键，指向 `drivers.driverId`，表示本记录关联的车手。 |
| stop | INTEGER | number | PK |  | 第几次进站。 |
| lap | INTEGER | number |  |  | 发生进站的比赛圈数。 |
| time | TEXT | text |  |  | 时间戳或时间。 |
| duration | TEXT | text |  |  | 进站耗时文本。 |
| milliseconds | INTEGER | number |  |  | 用时毫秒数。 |

样例数据（前 5 行）：

| raceId | driverId | stop | lap | time | duration | milliseconds |
| --- | --- | --- | --- | --- | --- | --- |

（该表当前没有样例行。）

### 6.9 `qualifying`

- 表含义：F1 排位赛成绩记录。
- 行数：`7516`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| qualifyId | INTEGER | number | PK |  | 排位赛记录的唯一编号，用于标识一条排位赛记录记录。 样例值：1、2、3。 |
| raceId | INTEGER | number | FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| driverId | INTEGER | number | FK | drivers.driverId | 外键，指向 `drivers.driverId`，表示本记录关联的车手。 |
| constructorId | INTEGER | number | FK | constructors.constructorId | 外键，指向 `constructors.constructorId`，表示本记录关联的车队/制造商。 |
| number | INTEGER | number |  |  | 赛车号码或参赛号码。 样例值：22、4、23。 |
| position | INTEGER | number |  |  | 排位赛名次。 样例值：1、2、3。 |
| q1 | TEXT | text |  |  | 排位赛 Q1 阶段成绩时间。 样例值：1:26.572、1:26.103、1:25.664。 |
| q2 | TEXT | text |  |  | 排位赛 Q2 阶段成绩时间。 样例值：1:25.187、1:25.315、1:25.452。 |
| q3 | TEXT | text |  |  | 排位赛 Q3 阶段成绩时间。 样例值：1:26.714、1:26.869、1:27.079。 |

样例数据（前 5 行）：

| qualifyId | raceId | driverId | constructorId | number | position | q1 | q2 | q3 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 18 | 1 | 1 | 22 | 1 | 1:26.572 | 1:25.187 | 1:26.714 |
| 2 | 18 | 9 | 2 | 4 | 2 | 1:26.103 | 1:25.315 | 1:26.869 |
| 3 | 18 | 5 | 1 | 23 | 3 | 1:25.664 | 1:25.452 | 1:27.079 |
| 4 | 18 | 13 | 6 | 2 | 4 | 1:25.994 | 1:25.691 | 1:27.178 |
| 5 | 18 | 2 | 2 | 3 | 5 | 1:25.960 | 1:25.518 | 1:27.236 |

### 6.10 `races`

- 表含义：F1 分站比赛记录。
- 行数：`997`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| raceId | INTEGER | number | PK |  | F1 比赛的唯一编号，用于标识一条F1 比赛记录。 |
| year | INTEGER | number |  |  | 年份。 样例值：2009。 |
| round | INTEGER | number |  |  | 赛季内分站轮次。 样例值：1、2、3。 |
| circuitId | INTEGER | number | FK | circuits.circuitId | 外键，指向 `circuits.circuitId`，表示本记录关联的赛道。 |
| name | TEXT | text |  |  | 名称。 样例值：Australian Grand Prix、Malaysian Grand Prix、Chinese Grand Prix。 |
| date | TEXT | text |  |  | 日期。 样例值：2009-03-29、2009-04-05、2009-04-19。 |
| time | TEXT | text |  |  | 时间戳或时间。 样例值：06:00:00、09:00:00、07:00:00。 |
| url | TEXT | text |  |  | 参考网页 URL。 样例值：http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix、http://en.wikipedia.org/wiki/2009_Malaysian_Grand_Prix、http://en.wikipedia.org/wiki/2009_Chinese_Grand_Prix。 |

样例数据（前 5 行）：

| raceId | year | round | circuitId | name | date | time | url |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 2009 | 1 | 1 | Australian Grand Prix | 2009-03-29 | 06:00:00 | http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix |
| 2 | 2009 | 2 | 2 | Malaysian Grand Prix | 2009-04-05 | 09:00:00 | http://en.wikipedia.org/wiki/2009_Malaysian_Grand_Prix |
| 3 | 2009 | 3 | 17 | Chinese Grand Prix | 2009-04-19 | 07:00:00 | http://en.wikipedia.org/wiki/2009_Chinese_Grand_Prix |
| 4 | 2009 | 4 | 3 | Bahrain Grand Prix | 2009-04-26 | 12:00:00 | http://en.wikipedia.org/wiki/2009_Bahrain_Grand_Prix |
| 5 | 2009 | 5 | 4 | Spanish Grand Prix | 2009-05-10 | 12:00:00 | http://en.wikipedia.org/wiki/2009_Spanish_Grand_Prix |

### 6.11 `results`

- 表含义：F1 正赛结果记录。
- 行数：`23777`
- 字段数：`18`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| resultId | INTEGER | number | PK |  | 正赛结果的唯一编号，用于标识一条正赛结果记录。 样例值：1、2、3。 |
| raceId | INTEGER | number | FK | races.raceId | 外键，指向 `races.raceId`，表示本记录关联的F1 比赛。 |
| driverId | INTEGER | number | FK | drivers.driverId | 外键，指向 `drivers.driverId`，表示本记录关联的车手。 |
| constructorId | INTEGER | number | FK | constructors.constructorId | 外键，指向 `constructors.constructorId`，表示本记录关联的车队/制造商。 |
| number | INTEGER | number |  |  | 赛车号码或参赛号码。 样例值：22、3、7。 |
| grid | INTEGER | number |  |  | 正赛发车排位。 样例值：1、5、7。 |
| position | TEXT | number |  |  | 正赛完赛名次文本或编号。 样例值：1、2、3。 |
| positionText | TEXT | text |  |  | 名次文本表示，可能含 R、D、E 等非数字状态。 样例值：1、2、3。 |
| positionOrder | INTEGER | number |  |  | 用于排序的完赛名次数值。 样例值：1、2、3。 |
| points | REAL | number |  |  | 积分或得分数值。 样例值：10.0、8.0、6.0。 |
| laps | TEXT | number |  |  | 正赛完成圈数。 样例值：58。 |
| time | TEXT | text |  |  | 时间戳或时间。 样例值：34:50.6、5.478、8.163。 |
| milliseconds | TEXT | number |  |  | 用时毫秒数。 样例值：5690616、5696094、5698779。 |
| fastestLap | TEXT | number |  |  | 最快圈发生的圈数。 样例值：39、41、58。 |
| rank | TEXT | number |  |  | 最快圈速度排名。 样例值：2、3、5。 |
| fastestLapTime | TEXT | text |  |  | 最快圈用时。 样例值：01:27.5、01:27.7、01:28.1。 |
| fastestLapSpeed | TEXT | text |  |  | 最快圈平均速度。 样例值：218.3、217.586、216.719。 |
| statusId | INTEGER | number |  |  | 完赛状态编号，可与 status.statusId 按语义连接。 样例值：1。 |

样例数据（前 5 行）：

| resultId | raceId | driverId | constructorId | number | grid | position | positionText | positionOrder | points | laps | time | milliseconds | fastestLap | rank | fastestLapTime | fastestLapSpeed | statusId |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 18 | 1 | 1 | 22 | 1 | 1 | 1 | 1 | 10.0 | 58 | 34:50.6 | 5690616 | 39 | 2 | 01:27.5 | 218.3 | 1 |
| 2 | 18 | 2 | 2 | 3 | 5 | 2 | 2 | 2 | 8.0 | 58 | 5.478 | 5696094 | 41 | 3 | 01:27.7 | 217.586 | 1 |
| 3 | 18 | 3 | 3 | 7 | 7 | 3 | 3 | 3 | 6.0 | 58 | 8.163 | 5698779 | 41 | 5 | 01:28.1 | 216.719 | 1 |
| 4 | 18 | 4 | 4 | 5 | 11 | 4 | 4 | 4 | 5.0 | 58 | 17.181 | 5707797 | 58 | 7 | 01:28.6 | 215.464 | 1 |
| 5 | 18 | 5 | 1 | 23 | 3 | 5 | 5 | 5 | 4.0 | 58 | 18.014 | 5708630 | 43 | 1 | 01:27.4 | 218.385 | 1 |

### 6.12 `seasons`

- 表含义：F1 赛季维表。
- 行数：`69`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| year | INTEGER | number | PK |  | 年份。 样例值：1950、1951、1952。 |
| url | TEXT | text |  |  | 参考网页 URL。 样例值：http://en.wikipedia.org/wiki/1950_Formula_One_season、http://en.wikipedia.org/wiki/1951_Formula_One_season、http://en.wikipedia.org/wiki/1952_Formula_One_season。 |

样例数据（前 5 行）：

| year | url |
| --- | --- |
| 1950 | http://en.wikipedia.org/wiki/1950_Formula_One_season |
| 1951 | http://en.wikipedia.org/wiki/1951_Formula_One_season |
| 1952 | http://en.wikipedia.org/wiki/1952_Formula_One_season |
| 1953 | http://en.wikipedia.org/wiki/1953_Formula_One_season |
| 1954 | http://en.wikipedia.org/wiki/1954_Formula_One_season |

### 6.13 `status`

- 表含义：F1 完赛、退赛、事故、取消资格等比赛状态维表。
- 行数：`134`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| statusId | INTEGER | number | PK |  | 完赛状态编号，可与 status.statusId 按语义连接。 样例值：1、2、3。 |
| status | TEXT | text |  |  | 状态。 样例值：Finished、Disqualified、Accident。 |

样例数据（前 5 行）：

| statusId | status |
| --- | --- |
| 1 | Finished |
| 2 | Disqualified |
| 3 | Accident |
| 4 | Collision |
| 5 | Engine |

## 7. SQL 生成注意事项

- `lapTimes` 和 `pitStops` 当前行数为 0，涉及单圈或进站的问题可能查不到结果。
- `results.statusId` 未在 schema 中显式标为外键，但按含义可连接 `status.statusId`。
- `positionText` 可能包含非数字状态；排序名次优先用 `positionOrder` 或 `position` 数值字段。
- `time`、`duration`、`fastestLapTime` 等多为文本时间，做大小比较时优先使用对应 `milliseconds` 字段。
- 空表：`lapTimes`、`pitStops`；查询这些表会返回空结果。
- 日期/时间多为文本字段：`lapTimes.time`、`pitStops.time`、`races.date`、`races.time`、`results.time`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
