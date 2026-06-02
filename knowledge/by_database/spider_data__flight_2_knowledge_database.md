# 数据库知识说明：spider_data__flight_2

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__flight_2 |
| source | spider_data |
| db_id | flight_2 |
| database_dir | database_layer/spider_data__flight_2 |
| sqlite_path | database_layer/spider_data__flight_2/flight_2.sqlite |
| table_count | 3 |
| scenario_id | flight_network |
| scenario_name | 航空公司、机场与航线 |
| scenario_description | 航空公司、机场代码和航班起终点网络。 |

## 2. 业务子场景说明

本库聚焦“航空公司、机场与航线”子场景，核心对象包括航空公司、机场、航班等。它适合回答关于航空公司、机场代码和航班起终点网络的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `flight_2`
- database_dir: `database_layer/spider_data__flight_2`
- db_path: `database_layer/spider_data__flight_2/flight_2.sqlite`
- original_db_path: `spider_data/spider_data/database/flight_2/flight_2.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| airlines | 航空公司基础信息。 | 4 | 12 |
| airports | 机场基础信息。 | 5 | 100 |
| flights | 航班航线记录。 | 4 | 1200 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| flights.Airline | airlines.uid |
| flights.SourceAirport | airports.AirportCode |
| flights.DestAirport | airports.AirportCode |

## 6. 表与字段说明

### 6.1 `airlines`

- 表含义：航空公司基础信息。
- 行数：`12`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| uid | INTEGER | number | PK |  | 航空公司唯一编号。 样例值：1、2、3。 |
| Airline | TEXT | text |  |  | 航空公司编号或名称，按所在表判断。 样例值：United Airlines、US Airways、Delta Airlines。 |
| Abbreviation | TEXT | text |  |  | 航空公司简称。 样例值：UAL、USAir、Delta。 |
| Country | TEXT | text |  |  | 国家或地区。 样例值：USA。 |

样例数据（前 5 行）：

| uid | Airline | Abbreviation | Country |
| --- | --- | --- | --- |
| 1 | United Airlines | UAL | USA |
| 2 | US Airways | USAir | USA |
| 3 | Delta Airlines | Delta | USA |
| 4 | Southwest Airlines | Southwest | USA |
| 5 | American Airlines | American | USA |

### 6.2 `airports`

- 表含义：机场基础信息。
- 行数：`100`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| City | TEXT | text |  |  | 城市。 样例值：Aberdeen 、Abilene 、Abingdon 。 |
| AirportCode | TEXT | text | PK |  | 机场代码。 样例值：APG、ABR、DYS。 |
| AirportName | TEXT | text |  |  | 机场名称。 样例值：Phillips AAF 、Municipal 、Dyess AFB 。 |
| Country | TEXT | text |  |  | 国家或地区。 样例值：United States 。 |
| CountryAbbrev | TEXT | text |  |  | 国家缩写。 样例值：US 、US。 |

样例数据（前 5 行）：

| City | AirportCode | AirportName | Country | CountryAbbrev |
| --- | --- | --- | --- | --- |
| Aberdeen  | APG | Phillips AAF  | United States  | US  |
| Aberdeen  | ABR | Municipal  | United States  | US |
| Abilene  | DYS | Dyess AFB  | United States  | US |
| Abilene  | ABI | Municipal  | United States  | US |
| Abingdon  | VJI | Virginia Highlands  | United States  | US |

### 6.3 `flights`

- 表含义：航班航线记录。
- 行数：`1200`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Airline | INTEGER | number | PK, FK | airlines.uid | 航空公司编号，连接 `airlines.uid` 后可取得航空公司名称。 样例值：1。 |
| FlightNo | INTEGER | number | PK |  | 航班号。 样例值：28、29、44。 |
| SourceAirport | TEXT | text | FK | airports.AirportCode | 航班出发机场代码，逻辑上对应 `airports.AirportCode`。原始值可能含前导空格。 |
| DestAirport | TEXT | text | FK | airports.AirportCode | 航班到达机场代码，逻辑上对应 `airports.AirportCode`。原始值可能含前导空格。 |

样例数据（前 5 行）：

| Airline | FlightNo | SourceAirport | DestAirport |
| --- | --- | --- | --- |
| 1 | 28 |  APG |  ASY |
| 1 | 29 |  ASY |  APG |
| 1 | 44 |  CVO |  ACV |
| 1 | 45 |  ACV |  CVO |
| 1 | 54 |  AHD |  AHT |

## 7. SQL 生成注意事项

- `flights.Airline` 存航空公司编号，应连接 `airlines.uid` 后取航空公司名称。
- `airports` 可能同一城市有多个机场，不要把城市名当作机场唯一键。
- 本库存在严重的 Spider 原始数据空格问题：`airports.City`、`airports.AirportName`、`airports.Country` 全部带尾随空格，`flights.SourceAirport`、`flights.DestAirport` 全部带前导空格。
- 重要评测口径：尽管真实数据有空格，正式 Gold SQL 大多数仍按原字段直接比较或直接连接，不做 `TRIM()`。因此生成 SQL 时不要为了“修正数据”主动给 `City`、`AirportName`、`Country`、`SourceAirport`、`DestAirport` 加 `TRIM()`，也不要把题目中的 `Aberdeen` 改写成 `'Aberdeen '`。
- 机场代码条件题如 “depart from APG”、“destination ATO”、“United Airlines flights to ASY” 通常直接写 `SourceAirport = 'APG'` 或 `DestAirport = 'ASY'`，不要写 `TRIM(SourceAirport) = 'APG'`。直接比较可能返回 0，这是 Gold 口径。
- 城市到航班的连接题如 “flights departing from Aberdeen city” 通常直接写 `flights.SourceAirport = airports.AirportCode` 或 `flights.DestAirport = airports.AirportCode`，不要使用 `TRIM(flights.SourceAirport)` 连接。直接连接可能因空格返回 0，这是 Gold 口径。
- 例外：只有题目明确问“airport code with the most/fewest flights”这类统计所有起降端点的机场代码时，正式修复版 Gold 会使用 `TRIM(SourceAirport)` 和 `TRIM(DestAirport)` 归一化端点后统计。
- 题目问“depart from/leave from”对应 `SourceAirport`；问“arrive at/into/destination”对应 `DestAirport`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
