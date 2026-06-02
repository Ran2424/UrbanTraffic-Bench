# 数据库知识说明：spider_data__car_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__car_1 |
| source | spider_data |
| db_id | car_1 |
| database_dir | database_layer/spider_data__car_1 |
| sqlite_path | database_layer/spider_data__car_1/car_1.sqlite |
| table_count | 6 |
| scenario_id | automobile_catalog |
| scenario_name | 汽车型号与性能 |
| scenario_description | 汽车制造商、车型、国家地区和汽车性能数据。 |

## 2. 业务子场景说明

本库聚焦“汽车型号与性能”子场景，核心对象包括汽车制造商、汽车名称、汽车性能记录、大洲、国家、车型等。它适合回答关于汽车制造商、车型、国家地区和汽车性能数据的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `car_1`
- database_dir: `database_layer/spider_data__car_1`
- db_path: `database_layer/spider_data__car_1/car_1.sqlite`
- original_db_path: `spider_data/spider_data/database/car_1/car_1.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| car_makers | 汽车制造商及其所属国家。 | 4 | 22 |
| car_names | 具体汽车名称与车型代码。 | 3 | 406 |
| cars_data | 汽车油耗、排量、马力、重量、加速和年份等性能数据。 | 8 | 406 |
| continents | 大洲维表。 | 2 | 5 |
| countries | 国家与所属大洲维表。 | 3 | 15 |
| model_list | 汽车制造商下的车型列表。 | 3 | 36 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| car_makers.Country | countries.CountryId |
| car_names.Model | model_list.Model |
| cars_data.Id | car_names.MakeId |
| countries.Continent | continents.ContId |
| model_list.Maker | car_makers.Id |

## 6. 表与字段说明

### 6.1 `car_makers`

- 表含义：汽车制造商及其所属国家。
- 行数：`22`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Id | INTEGER | number | PK |  | 汽车制造商的唯一编号，用于标识一条汽车制造商记录。 样例值：1、2、3。 |
| Maker | TEXT | text |  |  | 制造商简称或制造商编号，按所在表判断。 样例值：amc、volkswagen、bmw。 |
| FullName | TEXT | text |  |  | 制造商全称。 样例值：American Motor Company、Volkswagen、BMW。 |
| Country | TEXT | text | FK | countries.CountryId | 外键，指向 `countries.CountryId`，表示本记录关联的国家。 |

样例数据（前 5 行）：

| Id | Maker | FullName | Country |
| --- | --- | --- | --- |
| 1 | amc | American Motor Company | 1 |
| 2 | volkswagen | Volkswagen | 2 |
| 3 | bmw | BMW | 2 |
| 4 | gm | General Motors | 1 |
| 5 | ford | Ford Motor Company | 1 |

### 6.2 `car_names`

- 表含义：具体汽车名称与车型代码。
- 行数：`406`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| MakeId | INTEGER | number | PK |  | 汽车名称记录编号，也用于关联 cars_data.Id。 样例值：1、2、3。 |
| Model | TEXT | text | FK | model_list.Model | 外键，指向 `model_list.Model`，表示本记录关联的车型。 |
| Make | TEXT | text |  |  | 汽车完整名称或款式名称。 样例值：chevrolet chevelle malibu、buick skylark 320、plymouth satellite。 |

样例数据（前 5 行）：

| MakeId | Model | Make |
| --- | --- | --- |
| 1 | chevrolet | chevrolet chevelle malibu |
| 2 | buick | buick skylark 320 |
| 3 | plymouth | plymouth satellite |
| 4 | amc | amc rebel sst |
| 5 | ford | ford torino |

### 6.3 `cars_data`

- 表含义：汽车油耗、排量、马力、重量、加速和年份等性能数据。
- 行数：`406`
- 字段数：`8`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Id | INTEGER | number | PK, FK | car_names.MakeId | 外键，指向 `car_names.MakeId`，表示本记录关联的汽车名称。 |
| MPG | TEXT | text |  |  | 每加仑英里数，表示燃油经济性。 样例值：18、15、16。 |
| Cylinders | INTEGER | number |  |  | 发动机气缸数。 样例值：8。 |
| Edispl | REAL | number |  |  | 发动机排量。 样例值：307.0、350.0、318.0。 |
| Horsepower | TEXT | text |  |  | 发动机马力。 样例值：130、165、150。 |
| Weight | INTEGER | number |  |  | 车辆重量。 样例值：3504、3693、3436。 |
| Accelerate | REAL | number |  |  | 车辆加速指标。 样例值：12.0、11.5、11.0。 |
| Year | INTEGER | number |  |  | 年份。 样例值：1970。 |

样例数据（前 5 行）：

| Id | MPG | Cylinders | Edispl | Horsepower | Weight | Accelerate | Year |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 18 | 8 | 307.0 | 130 | 3504 | 12.0 | 1970 |
| 2 | 15 | 8 | 350.0 | 165 | 3693 | 11.5 | 1970 |
| 3 | 18 | 8 | 318.0 | 150 | 3436 | 11.0 | 1970 |
| 4 | 16 | 8 | 304.0 | 150 | 3433 | 12.0 | 1970 |
| 5 | 17 | 8 | 302.0 | 140 | 3449 | 10.5 | 1970 |

### 6.4 `continents`

- 表含义：大洲维表。
- 行数：`5`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ContId | INTEGER | number | PK |  | 大洲唯一编号。 样例值：1、2、3。 |
| Continent | TEXT | text |  |  | 大洲名称或大洲编号，按所在表判断。 样例值：america、europe、asia。 |

样例数据（前 5 行）：

| ContId | Continent |
| --- | --- |
| 1 | america |
| 2 | europe |
| 3 | asia |
| 4 | africa |
| 5 | australia |

### 6.5 `countries`

- 表含义：国家与所属大洲维表。
- 行数：`15`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| CountryId | INTEGER | number | PK |  | 国家的唯一编号，用于标识一条国家记录。 样例值：1、2、3。 |
| CountryName | TEXT | text |  |  | 国家名称。 样例值：usa、germany、france。 |
| Continent | INTEGER | number | FK | continents.ContId | 外键，指向 `continents.ContId`，表示本记录关联的大洲。 |

样例数据（前 5 行）：

| CountryId | CountryName | Continent |
| --- | --- | --- |
| 1 | usa | 1 |
| 2 | germany | 2 |
| 3 | france | 2 |
| 4 | japan | 3 |
| 5 | italy | 2 |

### 6.6 `model_list`

- 表含义：汽车制造商下的车型列表。
- 行数：`36`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| ModelId | INTEGER | number | PK |  | 车型唯一编号。 样例值：1、2、3。 |
| Maker | INTEGER | number | FK | car_makers.Id | 外键，指向 `car_makers.Id`，表示本记录关联的汽车制造商。 |
| Model | TEXT | text |  |  | 车型简称或车型名称。 样例值：amc、audi、bmw。 |

样例数据（前 5 行）：

| ModelId | Maker | Model |
| --- | --- | --- |
| 1 | 1 | amc |
| 2 | 2 | audi |
| 3 | 3 | bmw |
| 4 | 4 | buick |
| 5 | 4 | cadillac |

## 7. SQL 生成注意事项

- `cars_data.Id` 关联 `car_names.MakeId`，车型品牌路径通常是 `cars_data -> car_names -> model_list -> car_makers -> countries -> continents`。
- `Year` 是车型年份的两位或四位数值口径需结合样例判断；不要和 `model_list.ModelId` 混用。
- 国家和大洲是维表编号，按名称筛选时需要连接 `countries` 或 `continents`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
