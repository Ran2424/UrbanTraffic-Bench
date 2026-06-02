# 数据库知识说明：spider_data__race_track

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__race_track |
| source | spider_data |
| db_id | race_track |
| database_dir | database_layer/spider_data__race_track |
| sqlite_path | database_layer/spider_data__race_track/race_track.sqlite |
| table_count | 2 |
| scenario_id | racing_competition |
| scenario_name | 赛车场与赛事 |
| scenario_description | 赛道容量、开业年份、比赛名称、日期和赛事类别。 |

## 2. 业务子场景说明

本库聚焦“赛车场与赛事”子场景，核心对象包括赛事、赛道等。它适合回答关于赛道容量、开业年份、比赛名称、日期和赛事类别的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `race_track`
- database_dir: `database_layer/spider_data__race_track`
- db_path: `database_layer/spider_data__race_track/race_track.sqlite`
- original_db_path: `spider_data/spider_data/database/race_track/race_track.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| race | 比赛或赛事记录。 | 5 | 7 |
| track | 赛车场或赛道基础信息。 | 5 | 9 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| race.Track_ID | track.Track_ID |

## 6. 表与字段说明

### 6.1 `race`

- 表含义：比赛或赛事记录。
- 行数：`7`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Race_ID | INT | number | PK |  | 赛事的唯一编号，用于标识一条赛事记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Rolex 24 At Daytona、Gainsco Grand Prix of Miami、Mexico City 250。 |
| Class | TEXT | text |  |  | 类别、级别或船级，按所在表判断。 样例值：DP/GT、GT。 |
| Date | TEXT | text |  |  | 日期。 样例值：January 26 January 27、March 29、April 19。 |
| Track_ID | TEXT | text | FK | track.Track_ID | 外键，指向 `track.Track_ID`，表示本记录关联的赛道。 |

样例数据（前 5 行）：

| Race_ID | Name | Class | Date | Track_ID |
| --- | --- | --- | --- | --- |
| 1 | Rolex 24 At Daytona | DP/GT | January 26 January 27 | 1 |
| 2 | Gainsco Grand Prix of Miami | DP/GT | March 29 | 2 |
| 3 | Mexico City 250 | DP/GT | April 19 | 2 |
| 4 | Bosch Engineering 250 at VIR | GT | April 27 | 4 |
| 5 | RumBum.com 250 | DP/GT | May 17 | 5 |

### 6.2 `track`

- 表含义：赛车场或赛道基础信息。
- 行数：`9`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Track_ID | INT | number | PK |  | 赛道的唯一编号，用于标识一条赛道记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Auto Club Speedway、Chicagoland Speedway、Darlington Raceway。 |
| Location | TEXT | text |  |  | 地点或城市位置。 样例值：Fontana, CA、Joliet, IL、Darlington, SC。 |
| Seating | REAL | number |  |  | 赛道观众座位容量。 样例值：92000.0、75000.0、63000.0。 |
| Year_Opened | REAL | number |  |  | 赛道开放年份。 样例值：1997.0、2001.0、1950.0。 |

样例数据（前 5 行）：

| Track_ID | Name | Location | Seating | Year_Opened |
| --- | --- | --- | --- | --- |
| 1 | Auto Club Speedway | Fontana, CA | 92000.0 | 1997.0 |
| 2 | Chicagoland Speedway | Joliet, IL | 75000.0 | 2001.0 |
| 3 | Darlington Raceway | Darlington, SC | 63000.0 | 1950.0 |
| 4 | Daytona International Speedway | Daytona Beach, FL | 168000.0 | 1959.0 |
| 5 | Homestead-Miami Speedway | Homestead, FL | 65000.0 | 1995.0 |

## 7. SQL 生成注意事项

- `race.Date` 是文本日期，样例中有跨日表达，无法直接按标准日期排序。
- `race.Track_ID` 连接 `track.Track_ID` 后才能按赛道地点、座位容量或开放年份筛选。
- 日期/时间多为文本字段：`race.Date`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
