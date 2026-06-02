# 数据库知识说明：spider_data__bike_racing

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__bike_racing |
| source | spider_data |
| db_id | bike_racing |
| database_dir | database_layer/spider_data__bike_racing |
| sqlite_path | database_layer/spider_data__bike_racing/bike_racing.sqlite |
| table_count | 3 |
| scenario_id | racing_competition |
| scenario_name | 赛车、赛道与竞赛 |
| scenario_description | 自行车选手、比赛成绩、自行车配置与选手购车关系。 |

## 2. 业务子场景说明

本库聚焦“赛车、赛道与竞赛”子场景，核心对象包括自行车、自行车选手、选手-自行车关系等。它适合回答关于自行车选手、比赛成绩、自行车配置与选手购车关系的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `bike_racing`
- database_dir: `database_layer/spider_data__bike_racing`
- db_path: `database_layer/spider_data__bike_racing/bike_racing.sqlite`
- original_db_path: `spider_data/spider_data/test_database/bike_racing/bike_racing.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| bike | 自行车产品配置、重量、价格和材质。 | 5 | 6 |
| cyclist | 自行车比赛选手及其分组、国家和成绩。 | 5 | 8 |
| cyclists_own_bikes | 自行车选手拥有或购买自行车的关系记录。 | 3 | 14 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| cyclists_own_bikes.cyclist_id | cyclist.id |
| cyclists_own_bikes.bike_id | bike.id |

## 6. 表与字段说明

### 6.1 `bike`

- 表含义：自行车产品配置、重量、价格和材质。
- 行数：`6`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 自行车的唯一编号，用于标识一条自行车记录。 样例值：1、2、3。 |
| product_name | TEXT | text |  |  | 自行车产品或型号名称。 样例值：BIANCHI SPECIALISSIMA、CANNONDALE SUPERSIX EVO HI-MOD DURA ACE、CANYON AEROAD CF SLX 8.0 DI2。 |
| weight | INT | number |  |  | 重量指标。 样例值：780、850、880。 |
| price | REAL | number |  |  | 价格或票价。 样例值：9999.0、5330.0、3050.0。 |
| material | TEXT | text |  |  | 自行车车架或主体材质。 样例值：Carbon CC、carbon fiber、Toray T700 and T800 carbon fiber。 |

样例数据（前 5 行）：

| id | product_name | weight | price | material |
| --- | --- | --- | --- | --- |
| 1 | BIANCHI SPECIALISSIMA | 780 | 9999.0 | Carbon CC |
| 2 | CANNONDALE SUPERSIX EVO HI-MOD DURA ACE | 850 | 5330.0 | carbon fiber |
| 3 | CANYON AEROAD CF SLX 8.0 DI2 | 880 | 3050.0 | Toray T700 and T800 carbon fiber |
| 4 | GIANT TCR ADVANCED SL 0 | 750 | 9000.0 | Carbon CC |
| 5 | Ibis | 800 | 3599.0 | Carbon CC |

### 6.2 `cyclist`

- 表含义：自行车比赛选手及其分组、国家和成绩。
- 行数：`8`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INT | number | PK |  | 自行车选手的唯一编号，用于标识一条自行车选手记录。 样例值：1、2、3。 |
| heat | INT | number |  |  | 比赛分组或预赛组别。 样例值：4、3、1。 |
| name | TEXT | text |  |  | 名称。 样例值：Bradley Wiggins、Hayden Roulston、Steven Burke。 |
| nation | TEXT | text |  |  | 选手代表国家或地区。 样例值：Great Britain、New Zealand、Russia。 |
| result | REAL | number |  |  | 比赛成绩时间。 样例值：4:16.571、4:19.232、4:21.558。 |

样例数据（前 5 行）：

| id | heat | name | nation | result |
| --- | --- | --- | --- | --- |
| 1 | 4 | Bradley Wiggins | Great Britain | 4:16.571 |
| 2 | 3 | Hayden Roulston | New Zealand | 4:19.232 |
| 3 | 1 | Steven Burke | Great Britain | 4:21.558 |
| 4 | 2 | Alexei Markov | Russia | 4:22.308 |
| 5 | 1 | Volodymyr Dyudya | Ukraine | 4:22.471 |

### 6.3 `cyclists_own_bikes`

- 表含义：自行车选手拥有或购买自行车的关系记录。
- 行数：`14`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| cyclist_id | INT | number | PK, FK | cyclist.id | 外键，指向 `cyclist.id`，表示本记录关联的自行车选手。 |
| bike_id | INT | number | PK, FK | bike.id | 外键，指向 `bike.id`，表示本记录关联的自行车。 |
| purchase_year | INT | number |  |  | 选手购买或拥有该自行车的年份。 样例值：2011、2015、2017。 |

样例数据（前 5 行）：

| cyclist_id | bike_id | purchase_year |
| --- | --- | --- |
| 1 | 2 | 2011 |
| 1 | 3 | 2015 |
| 2 | 3 | 2017 |
| 2 | 5 | 2013 |
| 2 | 4 | 2018 |

## 7. SQL 生成注意事项

- 涉及多表查询时优先沿显式外键连接，避免用名称文本字段硬连接。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
