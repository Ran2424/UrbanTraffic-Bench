# 数据库知识说明：spider_data__ship_mission

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__ship_mission |
| source | spider_data |
| db_id | ship_mission |
| database_dir | database_layer/spider_data__ship_mission |
| sqlite_path | database_layer/spider_data__ship_mission/ship_mission.sqlite |
| table_count | 2 |
| scenario_id | marine_ship_mission |
| scenario_name | 船舶任务 |
| scenario_description | 船舶、任务代号、下水年份、航速、地点和最终命运。 |

## 2. 业务子场景说明

本库聚焦“船舶任务”子场景，核心对象包括任务、船舶等。它适合回答关于船舶、任务代号、下水年份、航速、地点和最终命运的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `ship_mission`
- database_dir: `database_layer/spider_data__ship_mission`
- db_path: `database_layer/spider_data__ship_mission/ship_mission.sqlite`
- original_db_path: `spider_data/spider_data/database/ship_mission/ship_mission.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| mission | 船舶任务或服役记录。 | 7 | 7 |
| ship | 船舶基础信息。 | 5 | 8 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| mission.Ship_ID | ship.Ship_ID |

## 6. 表与字段说明

### 6.1 `mission`

- 表含义：船舶任务或服役记录。
- 行数：`7`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Mission_ID | INT | number | PK |  | 任务的唯一编号，用于标识一条任务记录。 样例值：1、2、3。 |
| Ship_ID | INT | number | FK | ship.Ship_ID | 外键，指向 `ship.Ship_ID`，表示本记录关联的船舶。 |
| Code | TEXT | text |  |  | 业务代码；在承运人表中为航空公司代码，在任务表中为任务代号。 样例值：VMV-1、VMV-2、VMV-3。 |
| Launched_Year | INT | number |  |  | 年份字段。 样例值：1930、1916、1931。 |
| Location | TEXT | text |  |  | 地点或城市位置。 样例值：Germany、Helsinki , Finland、Norway。 |
| Speed_knots | INT | number |  |  | 速度，单位为节。 样例值：25、23、16。 |
| Fate | TEXT | text |  |  | 船舶或任务最终命运。 样例值：Decommissioned 1950、Lost (burned) 1931、Retired 1939。 |

样例数据（前 5 行）：

| Mission_ID | Ship_ID | Code | Launched_Year | Location | Speed_knots | Fate |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 1 | VMV-1 | 1930 | Germany | 25 | Decommissioned 1950 |
| 2 | 2 | VMV-2 | 1930 | Germany | 25 | Decommissioned 1950 |
| 3 | 3 | VMV-3 | 1930 | Helsinki , Finland | 23 | Lost (burned) 1931 |
| 4 | 5 | VMV-4 Former: Sterling | 1916 | Norway | 16 | Retired 1939 |
| 5 | 6 | VMV-5 | 1931 | Uusikaupunki , Finland | 23 | Decommissioned 1959 |

### 6.2 `ship`

- 表含义：船舶基础信息。
- 行数：`8`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Ship_ID | INT | number | PK |  | 船舶唯一编号。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Corbridge、Farringford、Dromonby。 |
| Type | TEXT | text |  |  | 学校类型，例如公立、私立或私立天主教学校。 样例值：Cargo ship、Battle ship。 |
| Nationality | TEXT | text |  |  | 国籍。 样例值：United Kingdom、United States。 |
| Tonnage | INT | number |  |  | 船舶吨位。 样例值：3687、3146、3627。 |

样例数据（前 5 行）：

| Ship_ID | Name | Type | Nationality | Tonnage |
| --- | --- | --- | --- | --- |
| 1 | Corbridge | Cargo ship | United Kingdom | 3687 |
| 2 | Farringford | Battle ship | United States | 3146 |
| 3 | Dromonby | Cargo ship | United Kingdom | 3627 |
| 4 | Author | Cargo ship | United Kingdom | 3496 |
| 5 | Trader | Battle ship | United Kingdom | 3608 |

## 7. SQL 生成注意事项

- `mission.Speed_knots` 单位是节，不要与公里/小时直接混用。
- `Fate` 是文本结局说明，筛选沉没、退役等状态需用文本匹配。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
