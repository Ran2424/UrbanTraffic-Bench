# 数据库知识说明：train__cars

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | train__cars |
| source | train |
| db_id | cars |
| database_dir | database_layer/train__cars |
| sqlite_path | database_layer/train__cars/cars.sqlite |
| table_count | 4 |
| scenario_id | automobile_catalog |
| scenario_name | 汽车型号与性能 |
| scenario_description | 汽车油耗、动力、重量、价格、产地和生产年份。 |

## 2. 业务子场景说明

本库聚焦“汽车型号与性能”子场景，核心对象包括产地、汽车性能记录、价格、生产记录等。它适合回答关于汽车油耗、动力、重量、价格、产地和生产年份的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `train`
- db_id: `cars`
- database_dir: `database_layer/train__cars`
- db_path: `database_layer/train__cars/cars.sqlite`
- original_db_path: `train/train_databases/cars/cars.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| country | 汽车产地编号和地区名称维表。 | 2 | 3 |
| data | 汽车性能数据。 | 9 | 398 |
| price | 汽车价格数据。 | 2 | 398 |
| production | 汽车生产年份与产地记录；同一车辆 ID 可对应多个生产年份记录。 | 3 | 692 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| data.ID | price.ID |
| production.ID | price.ID |
| production.ID | data.ID |
| production.country | country.origin |

## 6. 表与字段说明

### 6.1 `country`

- 表含义：汽车产地编号和地区名称维表。
- 行数：`3`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| origin | INTEGER | integer | PK |  | 产地编号。 样例值：1、2、3。 |
| country | TEXT | text |  |  | 国家或地区。 样例值：USA、Europe、Japan。 |

样例数据（前 5 行）：

| origin | country |
| --- | --- |
| 1 | USA |
| 2 | Europe |
| 3 | Japan |

### 6.2 `data`

- 表含义：汽车性能数据。
- 行数：`398`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ID | INTEGER | integer | PK, FK | price.ID | 外键，指向 `price.ID`，表示本记录关联的价格。 |
| mpg | REAL | real |  |  | 每加仑英里数，表示燃油经济性。 别名：mileage per gallon。 取值说明：commonsense evidence: The car with higher mileage is more fuel-efficient。 |
| cylinders | INTEGER | integer |  |  | 发动机气缸数。 别名：number of cylinders。 样例值：8。 |
| displacement | REAL | real |  |  | 发动机排量。 取值说明：commonsense evidence: sweep volume = displacement / no_of cylinders。 |
| horsepower | INTEGER | integer |  |  | 发动机马力。 别名：horse power。 取值说明：commonsense evidence: horse power is the metric used to indicate the power produced by a car's engine - the higher the number, the more power is sent to the wheels and, in theory, the faster it will go。 |
| weight | INTEGER | integer |  |  | 重量指标。 取值说明：commonsense evidence: A bigger, heavier vehicle provides better crash protection than a smaller。 |
| acceleration | REAL | real |  |  | 车辆加速指标。 样例值：12.0、11.5、11.0。 |
| model | INTEGER | integer |  |  | 汽车型号年份编码，样例 70 表示 1970 年、71 表示 1971 年；不要把 1970 写成 `model = 0`。 |
| car_name | TEXT | text |  |  | 汽车名称。 别名：car name。 样例值：chevrolet chevelle malibu、buick skylark 320、plymouth satellite。 |

样例数据（前 5 行）：

| ID | mpg | cylinders | displacement | horsepower | weight | acceleration | model | car_name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 18.0 | 8 | 307.0 | 130 | 3504 | 12.0 | 70 | chevrolet chevelle malibu |
| 2 | 15.0 | 8 | 350.0 | 165 | 3693 | 11.5 | 70 | buick skylark 320 |
| 3 | 18.0 | 8 | 318.0 | 150 | 3436 | 11.0 | 70 | plymouth satellite |
| 4 | 16.0 | 8 | 304.0 | 150 | 3433 | 12.0 | 70 | amc rebel sst |
| 5 | 17.0 | 8 | 302.0 | 140 | 3449 | 10.5 | 70 | ford torino |

### 6.3 `price`

- 表含义：汽车价格数据。
- 行数：`398`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ID | INTEGER | integer | PK |  | 汽车价格记录编号，可与 data.ID、production.ID 连接。 样例值：1、2、3。 |
| price | REAL | real |  |  | 价格或票价。 样例值：25561.59078、24221.42273、27240.84373。 |

样例数据（前 5 行）：

| ID | price |
| --- | --- |
| 1 | 25561.59078 |
| 2 | 24221.42273 |
| 3 | 27240.84373 |
| 4 | 33684.96888 |
| 5 | 20000.0 |

### 6.4 `production`

- 表含义：汽车生产年份与产地记录；这是车辆与生产年份、产地之间的记录表，不是唯一车辆维表。
- 行数：`692`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ID | INTEGER | integer | PK, FK | price.ID, data.ID | 汽车记录编号，可与 `data.ID`、`price.ID` 连接；同一 ID 在 `production` 中可能因不同 `model_year` 出现多行。 |
| model_year | INTEGER | integer | PK |  | 生产或上市年份。 别名：model year。 样例值：1970、1971。 |
| country | INTEGER | integer | FK | country.origin | 外键，指向 `country.origin`，表示本记录关联的产地。 |

样例数据（前 5 行）：

| ID | model_year | country |
| --- | --- | --- |
| 1 | 1970 | 1 |
| 1 | 1971 | 1 |
| 2 | 1970 | 1 |
| 3 | 1970 | 1 |
| 4 | 1970 | 1 |

## 7. SQL 生成注意事项

- `data.ID`、`price.ID`、`production.ID` 可连接同一车辆记录；但 `production` 是生产/上市记录表，同一 `ID` 可能对应多个 `model_year`，连接后默认保留这些多行记录。
- 默认保持查询涉及的事实表或记录表行粒度，不主动 `DISTINCT`。只有题目明确出现 distinct、different、unique，或明确要求唯一 car/model/entity 时，才使用 `COUNT(DISTINCT ...)` 或 `SELECT DISTINCT ...`。
- 按产地、生产年份、上市记录统计 “how many cars”、计算平均价格/重量/马力、或计算百分比时，若查询连接了 `production`，默认按连接后的 production 记录行计算；不要用 `IN (SELECT DISTINCT ID ...)` 或 `COUNT(DISTINCT ID)` 把多年份记录折叠掉。
- 百分比的分子和分母必须保持同一行粒度。若题目问某产地车辆记录占比，分母应来自同一个 `production JOIN country` 结果；不要把分子按 production 行算、分母却改成 `data` 的唯一车辆行数。
- `model` 与 `model_year` 口径不同：`data.model` 是两位车型年份编码（70、71、72...），`production.model_year` 是四位生产/上市年份（1970、1971...）。题目出现完整年份 1970/1971 时优先使用 `production.model_year`，不要自动改写为 `data.model = 0`。
- 题目说 introduced、introduced to the market、market year、produced in YEAR 时使用 `production.model_year`；如果返回年份列表，再根据题目是否要求 unique/different 判断是否 `DISTINCT`。
- `car_name` 在库中是小写原文，SQLite 字符串比较区分大小写；题目中的车型名应映射为数据库原文小写值。不要改成标题大小写，也不要默认 `LIKE '%...%'`。
- 题目问 fastest car 时，优先确认题目指标：若语义是动力最强，按 `data.horsepower DESC`；若明确问 acceleration time，才使用 `data.acceleration`。
- 查询国家、价格、年份列表时不要随意 `LIMIT 1`。只有题目要求单个最高/最低/最重/最便宜等极值实体时才 `LIMIT 1`；极值查询若先选 ID 再连接 `production`，需注意该 ID 可能对应多条生产年份记录。
- “how many times introduced” 这类问题按生产/上市记录次数计数；“how many different years/models/entities” 才按不同年份或不同实体去重。
- 价格、油耗、马力、重量、排量、加速等数值字段单位不同，排序或比较前需确认题目要求的指标。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
