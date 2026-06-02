# 数据库知识说明：spider_data__train_station

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__train_station |
| source | spider_data |
| db_id | train_station |
| database_dir | database_layer/spider_data__train_station |
| sqlite_path | database_layer/spider_data__train_station/train_station.sqlite |
| table_count | 3 |
| scenario_id | rail_transport |
| scenario_name | 铁路车站与列车服务 |
| scenario_description | 车站客流、站台数、列车服务、时刻和停靠关系。 |

## 2. 业务子场景说明

本库聚焦“铁路车站与列车服务”子场景，核心对象包括铁路车站、列车、列车-车站关系等。它适合回答关于车站客流、站台数、列车服务、时刻和停靠关系的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `train_station`
- database_dir: `database_layer/spider_data__train_station`
- db_path: `database_layer/spider_data__train_station/train_station.sqlite`
- original_db_path: `spider_data/spider_data/database/train_station/train_station.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| station | 铁路车站基础信息和年度客流指标。 | 8 | 12 |
| train | 列车班次或列车服务基础信息。 | 4 | 11 |
| train_station | 列车与车站停靠关系。 | 2 | 11 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| train_station.Train_ID | train.Train_ID |
| train_station.Station_ID | station.Station_ID |

## 6. 表与字段说明

### 6.1 `station`

- 表含义：铁路车站基础信息和年度客流指标。
- 行数：`12`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Station_ID | INT | number | PK |  | 铁路车站的唯一编号，用于标识一条铁路车站记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：London Waterloo、London Victoria、London Bridge。 |
| Annual_entry_exit | REAL | number |  |  | 年度进出站客流量。 样例值：94.046、76.231、52.634。 |
| Annual_interchanges | REAL | number |  |  | 年度换乘客流量。 样例值：9.489、9.157、8.742。 |
| Total_Passengers | REAL | number |  |  | 总旅客量。 样例值：103.534、85.38、61.376。 |
| Location | TEXT | text |  |  | 地点或城市位置。 样例值：London。 |
| Main_Services | TEXT | text |  |  | 主要铁路服务或线路。 样例值：South Western Main Line West of England Main Line、Brighton Main Line Chatham Main Line、South Eastern Main Line Thameslink。 |
| Number_of_Platforms | INT | number |  |  | 站台数量。 样例值：19、12、18。 |

样例数据（前 5 行）：

| Station_ID | Name | Annual_entry_exit | Annual_interchanges | Total_Passengers | Location | Main_Services | Number_of_Platforms |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | London Waterloo | 94.046 | 9.489 | 103.534 | London | South Western Main Line West of England Main Line | 19 |
| 2 | London Victoria | 76.231 | 9.157 | 85.38 | London | Brighton Main Line Chatham Main Line | 19 |
| 3 | London Bridge | 52.634 | 8.742 | 61.376 | London | South Eastern Main Line Thameslink | 12 |
| 4 | London Liverpool Street | 57.107 | 2.353 | 59.46 | London | Great Eastern Main Line West Anglia Main Line | 18 |
| 5 | London Euston | 36.609 | 3.832 | 40.44 | London | West Coast Main Line | 18 |

### 6.2 `train`

- 表含义：列车班次或列车服务基础信息。
- 行数：`11`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Train_ID | INT | number | PK |  | 列车的唯一编号，用于标识一条列车记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Ananthapuri Express、Guruvayur Express、Jayanthi Janatha Express。 |
| Time | TEXT | text |  |  | 时间。 样例值：17:15、22:10、4:49。 |
| Service | TEXT | text |  |  | 列车服务频率或服务类型。 样例值：Daily。 |

样例数据（前 5 行）：

| Train_ID | Name | Time | Service |
| --- | --- | --- | --- |
| 1 | Ananthapuri Express | 17:15 | Daily |
| 2 | Guruvayur Express | 22:10 | Daily |
| 3 | Guruvayur Express | 4:49 | Daily |
| 4 | Ananthapuri Express | 11:35 | Daily |
| 5 | Jayanthi Janatha Express | 06:30 | Daily |

### 6.3 `train_station`

- 表含义：列车与车站停靠关系。
- 行数：`11`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Train_ID | INT | number | PK, FK | train.Train_ID | 外键，指向 `train.Train_ID`，表示本记录关联的列车。 |
| Station_ID | INT | number | PK, FK | station.Station_ID | 外键，指向 `station.Station_ID`，表示本记录关联的铁路车站。 |

样例数据（前 5 行）：

| Train_ID | Station_ID |
| --- | --- |
| 1 | 1 |
| 2 | 1 |
| 3 | 1 |
| 4 | 2 |
| 5 | 3 |

## 7. SQL 生成注意事项

- `train_station` 是列车和车站关系表，统计列车或车站数量时注意去重。
- `station` 的客流字段看起来是百万级数值，使用时要保持原单位口径。
- `train.Time` 是文本时间，排序时可能需要统一为时间格式。
- 日期/时间多为文本字段：`train.Time`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
