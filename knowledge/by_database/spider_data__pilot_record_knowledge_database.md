# 数据库知识说明：spider_data__pilot_record

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__pilot_record |
| source | spider_data |
| db_id | pilot_record |
| database_dir | database_layer/spider_data__pilot_record |
| sqlite_path | database_layer/spider_data__pilot_record/pilot_record.sqlite |
| table_count | 3 |
| scenario_id | pilot_aircraft_record |
| scenario_name | 飞行员与航空器记录 |
| scenario_description | 航空器配置、飞行员资料和飞行员驾驶航空器记录。 |

## 2. 业务子场景说明

本库聚焦“飞行员与航空器记录”子场景，核心对象包括航空器、飞行员、飞行员驾驶记录等。它适合回答关于航空器配置、飞行员资料和飞行员驾驶航空器记录的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `pilot_record`
- database_dir: `database_layer/spider_data__pilot_record`
- db_path: `database_layer/spider_data__pilot_record/pilot_record.sqlite`
- original_db_path: `spider_data/spider_data/database/pilot_record/pilot_record.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| aircraft | 航空器基础信息或飞机性能参数记录。 | 7 | 7 |
| pilot | 飞行员或驾驶员基础信息。 | 8 | 5 |
| pilot_record | 飞行员与航空器在日期上的记录关系。 | 4 | 6 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| pilot_record.Pilot_ID | pilot.Pilot_ID |
| pilot_record.Aircraft_ID | aircraft.Aircraft_ID |

## 6. 表与字段说明

### 6.1 `aircraft`

- 表含义：航空器基础信息或飞机性能参数记录。
- 行数：`7`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Aircraft_ID | INT | number | PK |  | 航空器/机队车辆的唯一编号，用于标识一条记录。虽然表名为 aircraft，但样例值更像公交车队车辆；SQL 仍按字段名 `aircraft` 使用。 样例值：1、2、3。 |
| Order_Year | INT | number |  |  | 航空器/车辆订购年份。 样例值：1992、1996、1998。 |
| Manufacturer | TEXT | text |  |  | 制造商名称。 样例值：Gillig、NFI。 |
| Model | TEXT | text |  |  | 型号名称。 样例值：Phantom (High Floor)、Advantage (Low Floor)、GE40LFR。 |
| Fleet_Series | TEXT | text |  |  | 机队/车队序列范围及数量。 样例值：444-464 (21)、465-467 (3)、468-473 (6)。 |
| Powertrain | TEXT | text |  |  | 动力传动系统配置。 样例值：DD S50EGR Allison WB-400R、DD S50 Allison WB-400R、Cummins ISC Allison WB-400R。 |
| Fuel_Propulsion | TEXT | text |  |  | 燃料或推进类型。 样例值：Diesel、Hybrid、CNG。 |

样例数据（前 5 行）：

| Aircraft_ID | Order_Year | Manufacturer | Model | Fleet_Series | Powertrain | Fuel_Propulsion |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | 1992 | Gillig | Phantom (High Floor) | 444-464 (21) | DD S50EGR Allison WB-400R | Diesel |
| 2 | 1996 | Gillig | Phantom (High Floor) | 465-467 (3) | DD S50 Allison WB-400R | Diesel |
| 3 | 1998 | Gillig | Phantom (High Floor) | 468-473 (6) | DD S50 Allison WB-400R | Diesel |
| 4 | 2000 | Gillig | Advantage (Low Floor) | 474-481 (8) | Cummins ISC Allison WB-400R | Diesel |
| 5 | 2002 | Gillig | Advantage (Low Floor) | 482-492 (11) | Cummins ISL Allison WB-400R | Diesel |

### 6.2 `pilot`

- 表含义：飞行员或驾驶员基础信息。
- 行数：`5`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Pilot_ID | INT | number | PK |  | 飞行员的唯一编号，用于标识一条飞行员记录。 样例值：1、2、3。 |
| Pilot_name | TEXT | text |  |  | 飞行员姓名。 样例值：Patrick O'Bryant、Jermaine O'Neal、Dan O'Sullivan。 |
| Rank | INT | number |  |  | 飞行员排名；数值越小表示排名越高，问 highest rank 时按 `Rank ASC LIMIT 1`。 样例值：13、6、45。 |
| Age | INT | number |  |  | 年龄。 样例值：33、40、37。 |
| Nationality | TEXT | text |  |  | 国籍。 样例值：United States、United Kindom、Nigeria。 |
| Position | TEXT | text |  |  | 岗位、位置或场上位置描述。 样例值：Center Team、Forward-Center Team、Forward Team。 |
| Join_Year | INT | number |  |  | 加入年份。 样例值：2009、2008、1999。 |
| Team | TEXT | text |  |  | 所属团队或学校。 样例值：Bradley、Eau Claire High School、Fordham。 |

样例数据（前 5 行）：

| Pilot_ID | Pilot_name | Rank | Age | Nationality | Position | Join_Year | Team |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Patrick O'Bryant | 13 | 33 | United States | Center Team | 2009 | Bradley |
| 2 | Jermaine O'Neal | 6 | 40 | United States | Forward-Center Team | 2008 | Eau Claire High School |
| 3 | Dan O'Sullivan | 45 | 37 | United States | Center Team | 1999 | Fordham |
| 4 | Charles Oakley | 34 | 22 | United Kindom | Forward Team | 2001 | Virginia Union |
| 5 | Hakeem Olajuwon | 34 | 32 | Nigeria | Center Team | 2010 | Houston |

### 6.3 `pilot_record`

- 表含义：飞行员与航空器在日期上的记录关系。
- 行数：`6`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Record_ID | INT | number |  |  | 飞行员驾驶记录唯一编号。 样例值：1、2、3。 |
| Pilot_ID | INT | number | PK, FK | pilot.Pilot_ID | 外键，指向 `pilot.Pilot_ID`，表示本记录关联的飞行员。 |
| Aircraft_ID | INT | number | PK, FK | aircraft.Aircraft_ID | 外键，指向 `aircraft.Aircraft_ID`，表示本记录关联的航空器。 |
| Date | TEXT | text | PK |  | 日期。 样例值：2003/01/04、2004/01/04、2005/01/04。 |

样例数据（前 5 行）：

| Record_ID | Pilot_ID | Aircraft_ID | Date |
| --- | --- | --- | --- |
| 1 | 1 | 1 | 2003/01/04 |
| 2 | 2 | 1 | 2004/01/04 |
| 3 | 1 | 4 | 2005/01/04 |
| 4 | 3 | 6 | 2006/01/04 |
| 5 | 4 | 2 | 2007/01/04 |

## 7. SQL 生成注意事项

- `pilot_record` 是飞行员与航空器的事实表，统计飞行员或航空器时注意同一实体可能出现多条日期记录。
- 问 “positions and teams of pilots” 只返回 `Position, Team` 两列；不要额外返回 `Pilot_name`，除非题目明确要求姓名。
- `Rank`、`Position`、`Team` 字段来自人员资料，含义偏人物属性，不是飞行记录结果；highest rank 指最小 `Rank`。
- 日期/时间多为文本字段：`pilot_record.Date`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
