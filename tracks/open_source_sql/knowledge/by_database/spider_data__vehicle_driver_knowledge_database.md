# 数据库知识说明：spider_data__vehicle_driver

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__vehicle_driver |
| source | spider_data |
| db_id | vehicle_driver |
| database_dir | database_layer/spider_data__vehicle_driver |
| sqlite_path | database_layer/spider_data__vehicle_driver/vehicle_driver.sqlite |
| table_count | 3 |
| scenario_id | vehicle_driver_assignment |
| scenario_name | 车辆与驾驶员 |
| scenario_description | 车辆型号、制造年份、动力性能、驾驶员和驾驶员可驾驶车辆。 |

## 2. 业务子场景说明

本库聚焦“车辆与驾驶员”子场景，核心对象包括驾驶员、车辆、驾驶员-车辆关系等。它适合回答关于车辆型号、制造年份、动力性能、驾驶员和驾驶员可驾驶车辆的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `vehicle_driver`
- database_dir: `database_layer/spider_data__vehicle_driver`
- db_path: `database_layer/spider_data__vehicle_driver/vehicle_driver.sqlite`
- original_db_path: `spider_data/spider_data/test_database/vehicle_driver/vehicle_driver.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| driver | 车辆驾驶员基础信息。 | 4 | 4 |
| vehicle | 车辆型号和性能信息。 | 7 | 8 |
| vehicle_driver | 驾驶员与车辆的对应关系。 | 2 | 11 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| vehicle_driver.Driver_ID | driver.Driver_ID |
| vehicle_driver.Vehicle_ID | vehicle.Vehicle_ID |

## 6. 表与字段说明

### 6.1 `driver`

- 表含义：车辆驾驶员基础信息。
- 行数：`4`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Driver_ID | INT | number | PK |  | 驾驶员的唯一编号，用于标识一条驾驶员记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Jeff Gordon、Jimmie Johnson、Tony Stewart。 |
| Citizenship | TEXT | text |  |  | 驾驶员国籍或公民身份。 样例值：United States。 |
| Racing_Series | TEXT | text |  |  | 驾驶员参加的赛车系列。 样例值：NASCAR、IndyCar Series。 |

样例数据（前 5 行）：

| Driver_ID | Name | Citizenship | Racing_Series |
| --- | --- | --- | --- |
| 1 | Jeff Gordon | United States | NASCAR |
| 2 | Jimmie Johnson | United States | NASCAR |
| 3 | Tony Stewart | United States | NASCAR |
| 4 | Ryan Hunter-Reay | United States | IndyCar Series |

### 6.2 `vehicle`

- 表含义：车辆型号和性能信息。
- 行数：`8`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Vehicle_ID | INT | number | PK |  | 车辆的唯一编号，用于标识一条车辆记录。 样例值：1、2、3。 |
| Model | TEXT | text |  |  | 车辆型号。 样例值：AC4000、DJ 、DJ1。 |
| Build_Year | TEXT | text |  |  | 车辆制造年份。 样例值：1996、2000、2000–2001。 |
| Top_Speed | INT | number |  |  | 最高速度。 样例值：120、200。 |
| Power | INT | number |  |  | 车辆功率。 样例值：4000、4800、6400。 |
| Builder | TEXT | text |  |  | 建造商。 样例值：Zhuzhou、Zhuzhou Siemens , Germany、Datong。 |
| Total_Production | TEXT | text |  |  | 总产量。 样例值：1、2、20。 |

样例数据（前 5 行）：

| Vehicle_ID | Model | Build_Year | Top_Speed | Power | Builder | Total_Production |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | AC4000 | 1996 | 120 | 4000 | Zhuzhou | 1 |
| 2 | DJ  | 2000 | 200 | 4800 | Zhuzhou | 2 |
| 3 | DJ1 | 2000–2001 | 120 | 6400 | Zhuzhou Siemens , Germany | 20 |
| 4 | DJ2 | 2001 | 200 | 4800 | Zhuzhou | 3 |
| 5 | Tiansuo | 2003 | 200 | 4800 | Datong | 1 |

### 6.3 `vehicle_driver`

- 表含义：驾驶员与车辆的对应关系。
- 行数：`11`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Driver_ID | INT | number | PK, FK | driver.Driver_ID | 外键，指向 `driver.Driver_ID`，表示本记录关联的驾驶员。 |
| Vehicle_ID | INT | number | PK, FK | vehicle.Vehicle_ID | 外键，指向 `vehicle.Vehicle_ID`，表示本记录关联的车辆。 |

样例数据（前 5 行）：

| Driver_ID | Vehicle_ID |
| --- | --- |
| 1 | 1 |
| 1 | 3 |
| 1 | 5 |
| 2 | 2 |
| 2 | 6 |

## 7. SQL 生成注意事项

- `vehicle_driver` 是驾驶员与车辆的多对多关系表，连接后聚合需注意重复。
- `vehicle.Build_Year` 有范围文本样例，不能全部当作单一年份整数。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
