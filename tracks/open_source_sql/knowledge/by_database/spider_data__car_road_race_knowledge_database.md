# 数据库知识说明：spider_data__car_road_race

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__car_road_race |
| source | spider_data |
| db_id | car_road_race |
| database_dir | database_layer/spider_data__car_road_race |
| sqlite_path | database_layer/spider_data__car_road_race/car_road_race.sqlite |
| table_count | 2 |
| scenario_id | racing_competition |
| scenario_name | 赛车、赛道与竞赛 |
| scenario_description | 公路赛、参赛车手、杆位、最快圈和获胜车队。 |

## 2. 业务子场景说明

本库聚焦“赛车、赛道与竞赛”子场景，核心对象包括公路赛车手、赛事等。它适合回答关于公路赛、参赛车手、杆位、最快圈和获胜车队的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `car_road_race`
- database_dir: `database_layer/spider_data__car_road_race`
- db_path: `database_layer/spider_data__car_road_race/car_road_race.sqlite`
- original_db_path: `spider_data/spider_data/test_database/car_road_race/car_road_race.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| driver | 公路赛车手及其参赛车辆配置。 | 7 | 11 |
| race | 比赛或赛事记录。 | 8 | 9 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| race.Driver_ID | driver.Driver_ID |

## 6. 表与字段说明

### 6.1 `driver`

- 表含义：公路赛车手及其参赛车辆配置。
- 行数：`11`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Driver_ID | INT | number | PK |  | 公路赛车手的唯一编号，用于标识一条公路赛车手记录。 样例值：1、2、3。 |
| Driver_Name | TEXT | text |  |  | 车手姓名。 样例值：Ernst-Günther Burggaller、Hermann zu Leiningen、Heinrich-Joachim von Morgen。 |
| Entrant | TEXT | text |  |  | 报名参赛方或车队实体。 样例值：German Bugatti Team、Private entry。 |
| Constructor | TEXT | text |  |  | 赛车制造商或构造商。 样例值：Bugatti、Mercedes-Benz。 |
| Chassis | TEXT | text |  |  | 底盘型号。 样例值：Bugatti T35B、Bugatti T35C、Mercedes-Benz SSK L。 |
| Engine | TEXT | text |  |  | 发动机规格。 样例值：2.3 L8、2.0 L8、7.1 L6。 |
| Age | INT | number |  |  | 年龄。 样例值：18、20、23。 |

样例数据（前 5 行）：

| Driver_ID | Driver_Name | Entrant | Constructor | Chassis | Engine | Age |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | Ernst-Günther Burggaller | German Bugatti Team | Bugatti | Bugatti T35B | 2.3 L8 | 18 |
| 2 | Hermann zu Leiningen | German Bugatti Team | Bugatti | Bugatti T35C | 2.0 L8 | 20 |
| 3 | Heinrich-Joachim von Morgen | German Bugatti Team | Bugatti | Bugatti T35B | 2.3 L8 | 23 |
| 4 | Rudolf Caracciola | Private entry | Mercedes-Benz | Mercedes-Benz SSK L | 7.1 L6 | 24 |
| 5 | Earl Howe | Private entry | Bugatti | Bugatti T51 | 2.3 L8 | 26 |

### 6.2 `race`

- 表含义：比赛或赛事记录。
- 行数：`9`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Road | INT | number | PK |  | 公路赛记录编号或赛道路段编号。 样例值：2、3、4。 |
| Driver_ID | INT | number | FK | driver.Driver_ID | 外键，指向 `driver.Driver_ID`，表示本记录关联的公路赛车手。 |
| Race_Name | TEXT | text |  |  | 赛事名称。 样例值：Monterey Festival of Speed、Sommet des Legends、Rexall Grand Prix of Edmonton - Race 1。 |
| Pole_Position | TEXT | text |  |  | 杆位获得者。 样例值：James Hinchcliffe、Junior Strous、Carl Skerlong。 |
| Fastest_Lap | TEXT | text |  |  | 最快圈速获得者。 样例值：Douglas Soares、Junior Strous、David Garza Pérez。 |
| Winning_driver | TEXT | text |  |  | 获胜车手姓名。 样例值：James Hinchcliffe、Junior Strous、Jonathan Bomarito。 |
| Winning_team | TEXT | text |  |  | 获胜车队名称。 样例值：Forsythe Pettit Racing、Condor Motorsports、Mathiasen Motorsports。 |
| Report | TEXT | text |  |  | 赛事报告链接或报告标记。 样例值：Report。 |

样例数据（前 5 行）：

| Road | Driver_ID | Race_Name | Pole_Position | Fastest_Lap | Winning_driver | Winning_team | Report |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2 | 1 | Monterey Festival of Speed | James Hinchcliffe | Douglas Soares | James Hinchcliffe | Forsythe Pettit Racing | Report |
| 3 | 2 | Sommet des Legends | Junior Strous | Junior Strous | Junior Strous | Condor Motorsports | Report |
| 4 | 1 | Rexall Grand Prix of Edmonton - Race 1 | James Hinchcliffe | David Garza Pérez | Jonathan Bomarito | Mathiasen Motorsports | Report |
| 5 | 3 | Rexall Grand Prix of Edmonton - Race 2 | Carl Skerlong | Carl Skerlong | Jonathan Summerton | Newman Wachs Racing | Report |
| 6 | 4 | Road Race Showcase/Road America - Race 1 | Dane Cameron | Tõnis Kasemets | Jonathan Bomarito | Mathiasen Motorsports | Report |

## 7. SQL 生成注意事项

- `race.Driver_ID` 指向参赛车手表，但 `Winning_driver` 是获胜者姓名文本，不是编号。
- 杆位、最快圈、获胜车手、获胜车队均为文本字段，不能直接作为外键连接。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
