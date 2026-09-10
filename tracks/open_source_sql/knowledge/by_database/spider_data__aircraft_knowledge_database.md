# 数据库知识说明：spider_data__aircraft

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__aircraft |
| source | spider_data |
| db_id | aircraft |
| database_dir | database_layer/spider_data__aircraft |
| sqlite_path | database_layer/spider_data__aircraft/aircraft.sqlite |
| table_count | 5 |
| scenario_id | aviation_aircraft_airport |
| scenario_name | 航空器、机场与飞行竞赛 |
| scenario_description | 航空器性能、机场吞吐、飞行比赛、飞行员和获胜飞机。 |

## 2. 业务子场景说明

本库聚焦“航空器、机场与飞行竞赛”子场景，核心对象包括航空器、机场、机场-航空器关系、比赛、飞行员等。它适合回答关于航空器性能、机场吞吐、飞行比赛、飞行员和获胜飞机的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `aircraft`
- database_dir: `database_layer/spider_data__aircraft`
- db_path: `database_layer/spider_data__aircraft/aircraft.sqlite`
- original_db_path: `spider_data/spider_data/database/aircraft/aircraft.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| aircraft | 航空器基础信息或飞机性能参数记录。 | 6 | 5 |
| airport | 机场基础信息和客运、货运、起降吞吐指标。 | 9 | 10 |
| airport_aircraft | 机场与航空器的对应关系表。 | 3 | 4 |
| match | 飞行比赛分站赛记录，包含举办地、日期、最快资格赛选手、获胜飞行员和获胜航空器。 | 7 | 7 |
| pilot | 飞行员或驾驶员基础信息。 | 3 | 12 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| airport_aircraft.Airport_ID | airport.Airport_ID |
| airport_aircraft.Aircraft_ID | aircraft.Aircraft_ID |
| match.Winning_Pilot | pilot.Pilot_Id |
| match.Winning_Aircraft | aircraft.Aircraft_ID |

## 6. 表与字段说明

### 6.1 `aircraft`

- 表含义：航空器基础信息或飞机性能参数记录。
- 行数：`5`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Aircraft_ID | int(11) | number | PK, NOT NULL |  | 航空器的唯一编号，用于标识一条航空器记录。 样例值：1、2、3。 |
| Aircraft | varchar(50) | text | NOT NULL |  | 航空器型号名称。 样例值：Robinson R-22、Bell 206B3 JetRanger、CH-47D Chinook。 |
| Description | varchar(50) | text | NOT NULL |  | 描述文本。 样例值：Light utility helicopter、Turboshaft utility helicopter、Tandem rotor helicopter。 |
| Max_Gross_Weight | varchar(50) | text | NOT NULL |  | 航空器最大总重，文本中包含磅和千克单位。 样例值：1,370 lb (635 kg)、3,200 lb (1,451 kg)、50,000 lb (22,680 kg)。 |
| Total_disk_area | varchar(50) | text | NOT NULL |  | 旋翼或旋盘总面积，文本中包含平方英尺和平方米单位。 样例值：497 ft² (46.2 m²)、872 ft² (81.1 m²)、5,655 ft² (526 m²)。 |
| Max_disk_Loading | varchar(50) | text | NOT NULL |  | 最大盘载，文本中包含 lb/ft² 和 kg/m² 单位。 样例值：2.6 lb/ft² (14 kg/m²)、3.7 lb/ft² (18 kg/m²)、8.8 lb/ft² (43 kg/m²)。 |

样例数据（前 5 行）：

| Aircraft_ID | Aircraft | Description | Max_Gross_Weight | Total_disk_area | Max_disk_Loading |
| --- | --- | --- | --- | --- | --- |
| 1 | Robinson R-22 | Light utility helicopter | 1,370 lb (635 kg) | 497 ft² (46.2 m²) | 2.6 lb/ft² (14 kg/m²) |
| 2 | Bell 206B3 JetRanger | Turboshaft utility helicopter | 3,200 lb (1,451 kg) | 872 ft² (81.1 m²) | 3.7 lb/ft² (18 kg/m²) |
| 3 | CH-47D Chinook | Tandem rotor helicopter | 50,000 lb (22,680 kg) | 5,655 ft² (526 m²) | 8.8 lb/ft² (43 kg/m²) |
| 4 | Mil Mi-26 | Heavy-lift helicopter | 123,500 lb (56,000 kg) | 8,495 ft² (789 m²) | 14.5 lb/ft² (71 kg/m²) |
| 5 | CH-53E Super Stallion | Heavy-lift helicopter | 73,500 lb (33,300 kg) | 4,900 ft² (460 m²) | 15 lb/ft² (72 kg/m²) |

### 6.2 `airport`

- 表含义：机场基础信息和客运、货运、起降吞吐指标。
- 行数：`10`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Airport_ID | INT | number | PK |  | 机场的唯一编号，用于标识一条机场记录。 样例值：1、2、3。 |
| Airport_Name | TEXT | text |  |  | 机场名称或姓名。 样例值：London Heathrow、London Gatwick、London Stansted。 |
| Total_Passengers | REAL | number |  |  | 总旅客量。 样例值：67054745.0、34205887.0、22360364.0。 |
| %_Change_2007 | TEXT | text |  |  | 相对 2007 年的百分比变化，值带百分号，应按文本处理或清洗后转数值。 样例值：1.5%、2.9%、6.0%。 |
| International_Passengers | REAL | number |  |  | 国际旅客量。 样例值：61344438.0、30431051.0、19996947.0。 |
| Domestic_Passengers | REAL | number |  |  | 国内旅客量。 样例值：5562516.0、3730963.0、2343428.0。 |
| Transit_Passengers | REAL | number |  |  | 中转旅客量。 样例值：147791.0、43873.0、19989.0。 |
| Aircraft_Movements | REAL | number |  |  | 飞机起降或活动架次。 样例值：478693.0、263653.0、193282.0。 |
| Freight_Metric_Tonnes | REAL | number |  |  | 货运量，单位为公吨。 样例值：1397054.0、107702.0、197738.0。 |

样例数据（前 5 行）：

| Airport_ID | Airport_Name | Total_Passengers | %_Change_2007 | International_Passengers | Domestic_Passengers | Transit_Passengers | Aircraft_Movements | Freight_Metric_Tonnes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | London Heathrow | 67054745.0 | 1.5% | 61344438.0 | 5562516.0 | 147791.0 | 478693.0 | 1397054.0 |
| 2 | London Gatwick | 34205887.0 | 2.9% | 30431051.0 | 3730963.0 | 43873.0 | 263653.0 | 107702.0 |
| 3 | London Stansted | 22360364.0 | 6.0% | 19996947.0 | 2343428.0 | 19989.0 | 193282.0 | 197738.0 |
| 4 | Manchester | 21219195.0 | 4.0% | 18119230.0 | 2943719.0 | 156246.0 | 204610.0 | 141781.0 |
| 5 | London Luton | 10180734.0 | 2.6% | 8853224.0 | 1320678.0 | 6832.0 | 117859.0 | 40518.0 |

### 6.3 `airport_aircraft`

- 表含义：机场与航空器的对应关系表。
- 行数：`4`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ID | INT | number |  |  | 机场-航空器关系的唯一编号，用于标识一条机场-航空器关系记录。 样例值：1、2、3。 |
| Airport_ID | INT | number | PK, FK | airport.Airport_ID | 外键，指向 `airport.Airport_ID`，表示本记录关联的机场。 |
| Aircraft_ID | INT | number | PK, FK | aircraft.Aircraft_ID | 外键，指向 `aircraft.Aircraft_ID`，表示本记录关联的航空器。 |

样例数据（前 5 行）：

| ID | Airport_ID | Aircraft_ID |
| --- | --- | --- |
| 1 | 6 | 5 |
| 2 | 2 | 1 |
| 3 | 1 | 2 |
| 4 | 9 | 3 |

### 6.4 `match`

- 表含义：飞行比赛分站赛记录，包含举办地、日期、最快资格赛选手、获胜飞行员和获胜航空器。
- 行数：`7`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Round | REAL | number | PK |  | 比赛分站轮次。 样例值：1.0、2.0、3.0。 |
| Location | TEXT | text |  |  | 地点或城市位置。 样例值：Mina' Zayid , Abu Dhabi、Swan River , Perth、Flamengo Beach , Rio de Janeiro。 |
| Country | TEXT | text |  |  | 国家或地区。 样例值：United Arab Emirates、Australia、Brazil。 |
| Date | TEXT | text |  |  | 日期。 样例值：March 26–27、April 17–18、May 8–9。 |
| Fastest_Qualifying | TEXT | text |  |  | 资格赛最快选手姓名。 样例值：Hannes Arch、Paul Bonhomme、Nigel Lamb。 |
| Winning_Pilot | TEXT | text | FK | pilot.Pilot_Id | 外键，指向 `pilot.Pilot_Id`，表示本记录关联的飞行员。 |
| Winning_Aircraft | TEXT | text | FK | aircraft.Aircraft_ID | 外键，指向 `aircraft.Aircraft_ID`，表示本记录关联的航空器。 |

样例数据（前 5 行）：

| Round | Location | Country | Date | Fastest_Qualifying | Winning_Pilot | Winning_Aircraft |
| --- | --- | --- | --- | --- | --- | --- |
| 1.0 | Mina' Zayid , Abu Dhabi | United Arab Emirates | March 26–27 | Hannes Arch | 1 | 1 |
| 2.0 | Swan River , Perth | Australia | April 17–18 | Paul Bonhomme | 4 | 1 |
| 3.0 | Flamengo Beach , Rio de Janeiro | Brazil | May 8–9 | Hannes Arch | 6 | 2 |
| 4.0 | Windsor , Ontario | Canada | June 5–6 | Nigel Lamb | 4 | 4 |
| 5.0 | New York City | United States | June 19–20 | Hannes Arch | 9 | 3 |

### 6.5 `pilot`

- 表含义：飞行员或驾驶员基础信息。
- 行数：`12`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Pilot_Id | int(11) | number | PK, NOT NULL |  | 飞行员的唯一编号，用于标识一条飞行员记录。 样例值：1、2、3。 |
| Name | varchar(50) | text | NOT NULL |  | 名称或姓名。 样例值：Prof. Zackery Collins、Katheryn Gorczany IV、Mr. Cristian Halvorson II。 |
| Age | int(11) | number | NOT NULL |  | 年龄。 样例值：23、20、25。 |

样例数据（前 5 行）：

| Pilot_Id | Name | Age |
| --- | --- | --- |
| 1 | Prof. Zackery Collins | 23 |
| 2 | Katheryn Gorczany IV | 20 |
| 3 | Mr. Cristian Halvorson II | 23 |
| 4 | Ayana Spencer | 25 |
| 5 | Ellen Ledner III | 31 |

## 7. SQL 生成注意事项

- 字段 `%_Change_2007` 带 `%` 且字段名含特殊字符，SQL 中需用双引号引用，如 `"%_Change_2007"`。
- 航空器重量、面积、盘载是带单位的文本，不能直接按数值比较；需要先抽取数值再转换。
- `match.Winning_Pilot` 和 `match.Winning_Aircraft` 存编号文本，可分别连接 `pilot.Pilot_Id`、`aircraft.Aircraft_ID`；除非题目要求数值比较或范围筛选，不要主动 `CAST` 编号字段。
- `Fastest_Qualifying` 是资格赛最快选手姓名文本，不是飞行员编号；筛选或返回最快资格赛选手时直接使用该文本字段，不要与 `pilot.Pilot_Id` 混用。
- 统计获胜次数、最多获胜航空器或最多获胜飞行员时，按 `match` 表中的获胜编号分组计数，再连接实体表取名称；不要按名称或经过类型转换后的表达式重新分组。
- `most number of times`、`highest count` 等题目若没有指定并列处理，不要额外添加二级排序或改变分组键类型；使用原始外键分组并按 `COUNT(*) DESC LIMIT 1` 保持查询口径稳定。
- 以下表名或字段名含空格、特殊字符或关键字，SQL 中建议加双引号：`airport.%_Change_2007`。
- 日期/时间多为文本字段：`match.Date`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
