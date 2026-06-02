# 数据库知识说明：train__airline

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | train__airline |
| source | train |
| db_id | airline |
| database_dir | database_layer/train__airline |
| sqlite_path | database_layer/train__airline/airline.sqlite |
| table_count | 3 |
| scenario_id | flight_delay_operation |
| scenario_name | 航空运行与延误 |
| scenario_description | 航班日期、承运航空公司、起降机场、延误、取消和延误原因。 |

## 2. 业务子场景说明

本库聚焦“航空运行与延误”子场景，核心对象包括航空承运人、航班明细、机场等。它适合回答关于航班日期、承运航空公司、起降机场、延误、取消和延误原因的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `train`
- db_id: `airline`
- database_dir: `database_layer/train__airline`
- db_path: `database_layer/train__airline/airline.sqlite`
- original_db_path: `train/train_databases/airline/airline.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| Air Carriers | 航空承运人代码表。 | 2 | 1656 |
| Airlines | 航班运行明细记录。 | 28 | 701352 |
| Airports | 机场代码表。 | 2 | 6510 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| Airlines.OP_CARRIER_AIRLINE_ID | Air Carriers.Code |
| Airlines.ORIGIN | Airports.Code |
| Airlines.DEST | Airports.Code |

## 6. 表与字段说明

### 6.1 `Air Carriers`

- 表含义：航空承运人代码表。
- 行数：`1656`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Code | INTEGER | integer | PK |  | 航空承运人数字代码，可与 Airlines.OP_CARRIER_AIRLINE_ID 连接。 样例值：19031、19032、19033。 |
| Description | TEXT | text |  |  | 航空承运人名称及简称说明。 样例值：Mackey International Inc.: MAC、Munz Northern Airlines Inc.: XY、Cochise Airlines Inc.: COC。 |

样例数据（前 5 行）：

| Code | Description |
| --- | --- |
| 19031 | Mackey International Inc.: MAC |
| 19032 | Munz Northern Airlines Inc.: XY |
| 19033 | Cochise Airlines Inc.: COC |
| 19034 | Golden Gate Airlines Inc.: GSA |
| 19035 | Aeromech Inc.: RZZ |

### 6.2 `Airlines`

- 表含义：航班运行明细记录。
- 行数：`701352`
- 字段数：`28`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| FL_DATE | TEXT | text |  |  | 航班日期。 别名：flight date。 样例值：2018/8/1。 |
| OP_CARRIER_AIRLINE_ID | INTEGER | integer | FK | Air Carriers.Code | 外键，指向 `Air Carriers.Code`，表示本记录关联的航空承运人。 |
| TAIL_NUM | TEXT | text |  |  | 飞机尾号。 别名：tail number。 取值说明：plane's tail number。 样例值：N956AN、N973AN、N9006。 |
| OP_CARRIER_FL_NUM | INTEGER | integer |  |  | 承运航空公司航班号。 别名：operator carrier flight number。 样例值：1587、1588、1590。 |
| ORIGIN_AIRPORT_ID | INTEGER | integer |  |  | 起飞机场数字编号。 别名：origin airport id。 样例值：12478、14107、11042。 |
| ORIGIN_AIRPORT_SEQ_ID | INTEGER | integer |  |  | 起飞机场序列编号。 别名：origin airport sequence id。 样例值：1247805、1410702、1104205。 |
| ORIGIN_CITY_MARKET_ID | INTEGER | integer |  |  | 起飞城市市场编号。 别名：origin city market id。 样例值：31703、30466、30647。 |
| ORIGIN | TEXT | text | FK | Airports.Code | 外键，指向 `Airports.Code`，表示本记录关联的机场。 |
| DEST_AIRPORT_ID | INTEGER | integer |  |  | 到达机场数字编号。 别名：destination airport id。 样例值：14107、11618、11298。 |
| DEST_AIRPORT_SEQ_ID | INTEGER | integer |  |  | 到达机场序列编号。 别名：destination airport sequence id。 样例值：1410702、1161802、1129806。 |
| DEST_CITY_MARKET_ID | INTEGER | integer |  |  | 到达城市市场编号。 别名：destination city market id。 样例值：30466、31703、30194。 |
| DEST | TEXT | text | FK | Airports.Code | 外键，指向 `Airports.Code`，表示本记录关联的机场。 |
| CRS_DEP_TIME | INTEGER | integer |  |  | 计划起飞时间。 别名：scheduled local departure time。 样例值：1640、1512、744。 |
| DEP_TIME | INTEGER | integer |  |  | 实际起飞时间。 别名：departure time。 取值说明：stored as the integer。 样例值：1649、1541、741。 |
| DEP_DELAY | INTEGER | integer |  |  | 起飞延误分钟数，可为负数。 别名：Departure delay。 取值说明：in minutes commonsense evidence: • if this value is positive: it means this flight delays; if the value is negative, it means this flight departs in advance (-4) • if this value <= 0, it means this flight departs on time。 |
| DEP_DELAY_NEW | INTEGER | integer |  |  | 非负起飞延误分钟数，提前或准点记为 0。 别名：departure delay new。 取值说明：not useful。 样例值：9、29、0。 |
| ARR_TIME | INTEGER | integer |  |  | 实际到达时间。 别名：arrival time。 样例值：2006、2350、938。 |
| ARR_DELAY | INTEGER | integer |  |  | 到达延误分钟数，可为负数。 别名：arrival delay。 取值说明：in minutes commonsense evidence: • if this value is positive: it means this flight will arrives late (delay); If the value is negative, this flight arrives earlier than scheduled. (-4) • if this value <= 0, it means this flight arrives on time。 |
| ARR_DELAY_NEW | INTEGER | integer |  |  | 非负到达延误分钟数，提前或准点记为 0。 别名：arrival delay new。 取值说明：not useful。 样例值：44、53、0。 |
| CANCELLED | INTEGER | integer |  |  | 是否取消，1 表示取消，0 表示未取消。 |
| CANCELLATION_CODE | TEXT | text |  |  | 航班取消原因代码。 别名：cancellation code。 取值说明：commonsense evidence: C--> A: more serious reasons lead to this cancellation。 |
| CRS_ELAPSED_TIME | INTEGER | integer |  |  | 计划飞行耗时分钟数。 别名：scheduled elapsed time。 样例值：342、285、176。 |
| ACTUAL_ELAPSED_TIME | INTEGER | integer |  |  | 实际飞行耗时分钟数。 别名：actual elapsed time。 取值说明：commonsense evidence: if ACTUAL_ELAPSED_TIME < CRS_ELAPSED_TIME: this flight is faster than scheduled; if ACTUAL_ELAPSED_TIME > CRS_ELAPSED_TIME: this flight is slower than scheduled。 |
| CARRIER_DELAY | INTEGER | integer |  |  | 承运人原因延误分钟数。 别名：carrier delay。 取值说明：minutes。 样例值：9、0、43。 |
| WEATHER_DELAY | INTEGER | integer |  |  | 天气原因延误分钟数。 别名：weather delay。 取值说明：minutes。 样例值：0。 |
| NAS_DELAY | INTEGER | integer |  |  | 国家空域系统原因延误分钟数。 别名：National Aviavtion System delay。 取值说明：minutes。 样例值：35、53、0。 |
| SECURITY_DELAY | INTEGER | integer |  |  | 安检原因延误分钟数。 别名：security delay。 取值说明：minutes。 样例值：0。 |
| LATE_AIRCRAFT_DELAY | INTEGER | integer |  |  | 前序飞机晚到原因延误分钟数。 别名：late aircraft delay。 取值说明：minutes。 样例值：0。 |

样例数据（前 5 行）：

| FL_DATE | OP_CARRIER_AIRLINE_ID | TAIL_NUM | OP_CARRIER_FL_NUM | ORIGIN_AIRPORT_ID | ORIGIN_AIRPORT_SEQ_ID | ORIGIN_CITY_MARKET_ID | ORIGIN | DEST_AIRPORT_ID | DEST_AIRPORT_SEQ_ID | DEST_CITY_MARKET_ID | DEST | CRS_DEP_TIME | DEP_TIME | DEP_DELAY | DEP_DELAY_NEW | ARR_TIME | ARR_DELAY | ARR_DELAY_NEW | CANCELLED | CANCELLATION_CODE | CRS_ELAPSED_TIME | ACTUAL_ELAPSED_TIME | CARRIER_DELAY | WEATHER_DELAY | NAS_DELAY | SECURITY_DELAY | LATE_AIRCRAFT_DELAY |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 2018/8/1 | 19805 | N956AN | 1587 | 12478 | 1247805 | 31703 | JFK | 14107 | 1410702 | 30466 | PHX | 1640 | 1649 | 9 | 9 | 2006 | 44 | 44 | 0 |  | 342 | 377 | 9 | 0 | 35 | 0 | 0 |
| 2018/8/1 | 19805 | N973AN | 1588 | 14107 | 1410702 | 30466 | PHX | 11618 | 1161802 | 31703 | EWR | 1512 | 1541 | 29 | 29 | 2350 | 53 | 53 | 0 |  | 285 | 309 | 0 | 0 | 53 | 0 | 0 |
| 2018/8/1 | 19805 | N9006 | 1590 | 11042 | 1104205 | 30647 | CLE | 11298 | 1129806 | 30194 | DFW | 744 | 741 | -3 | 0 | 938 | -2 | 0 | 0 |  | 176 | 177 |  |  |  |  |  |
| 2018/8/1 | 19805 | N870NN | 1591 | 14843 | 1484306 | 34819 | SJU | 11298 | 1129806 | 30194 | DFW | 900 | 944 | 44 | 44 | 1347 | 43 | 43 | 0 |  | 304 | 303 | 43 | 0 | 0 | 0 | 0 |
| 2018/8/1 | 19805 | N9023N | 1593 | 10423 | 1042302 | 30423 | AUS | 13303 | 1330303 | 32467 | MIA | 600 | 556 | -4 | 0 | 951 | -2 | 0 | 0 |  | 173 | 175 |  |  |  |  |  |

### 6.3 `Airports`

- 表含义：机场代码表。
- 行数：`6510`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Code | TEXT | text | PK |  | 机场代码，可与 Airlines.ORIGIN 或 Airlines.DEST 连接。 样例值：01A、03A、04A。 |
| Description | TEXT | text |  |  | 机场所在城市、州和机场名称说明。 样例值：Afognak Lake, AK: Afognak Lake Airport、Granite Mountain, AK: Bear Creek Mining Strip、Lik, AK: Lik Mining Camp。 |

样例数据（前 5 行）：

| Code | Description |
| --- | --- |
| 01A | Afognak Lake, AK: Afognak Lake Airport |
| 03A | Granite Mountain, AK: Bear Creek Mining Strip |
| 04A | Lik, AK: Lik Mining Camp |
| 05A | Little Squaw, AK: Little Squaw Airport |
| 06A | Kizhuyak, AK: Kizhuyak Bay |

## 7. SQL 生成注意事项

- 表名 `Air Carriers` 含空格，SQL 中必须使用双引号、反引号或方括号引用。
- `Air Carriers.Description` 的值通常是 `航空公司官方名称: 承运人代码`，如 `American Airlines Inc.: AA`、`Endeavor Air Inc.: 9E`、`Delta Air Lines Inc.: DL`。按承运人名称筛选时，不要写成 `Description = 'American Airlines Inc.'` 这类缺少后缀的精确匹配；优先使用库中完整值，或使用 `Description LIKE 'American Airlines Inc.:%'` / `LIKE '%Republic Airline%'` 这类能覆盖后缀的匹配。
- `Airlines` 是航班事实表。能直接映射到 `ORIGIN`、`DEST`、`OP_CARRIER_AIRLINE_ID`、`OP_CARRIER_FL_NUM`、`TAIL_NUM` 等事实表字段的查询，优先直接查询 `Airlines`；不要为了语义解释而强制连接代码表。
- `ORIGIN` 和 `DEST` 是机场代码。origin、destination、origin city、destination city 等字段级表达默认返回对应代码字段；origin airport、destination airport、airport name、airport description 或机场全名筛选才连接 `Airports` 并返回/匹配 `Airports.Description`。
- 地名不要自动扩展为州内所有机场。只有 state、all airports in、airports in the state of 等明确州域语义，才使用 `Airports.Description LIKE '%, 州缩写:%'` 这类州级匹配。
- 自然语言地名常指代具体机场代码，而不是全州或同名城市所有机场。常见别名映射包括：`New York`/`John F. Kennedy International` -> `JFK`，`Allentown, Pennsylvania` -> `ABE`，`Albany` -> `ABY`，`Oklahoma` -> `OKC`，`Phoenix` -> `PHX`。简短地点名优先映射到对应 `ORIGIN`/`DEST` 代码。
- `Airports.Description` 的格式通常是 `城市, 州缩写: 机场名`，机场名不一定包含单词 `Airport`。按机场名称匹配时优先使用题目核心名称或数据库精确描述，不要自行补 `Airport` 后缀。
- 机场描述要按库中原文精确匹配或用不含后缀的核心片段。常见精确值包括：`New York, NY: John F. Kennedy International`、`Los Angeles, CA: Los Angeles International`、`San Diego, CA: San Diego International`、`Lake Charles, LA: Lake Charles Regional`、`Charlotte, NC: Charlotte Douglas International`、`Austin, TX: Austin - Bergstrom International`、`Fort Lauderdale, FL: Fort Lauderdale-Hollywood International`。
- 延误字段分为可为负的原始延误和非负的 `_NEW` 延误。delayed、late、on time、arrived earlier、average delay 等语义优先使用原始字段 `DEP_DELAY` 或 `ARR_DELAY`，不要默认使用 `_NEW` 字段。
- departure delay 只使用 `DEP_DELAY`，arrival delay 只使用 `ARR_DELAY`。不要把 delayed 自动写成 `DEP_DELAY > 0 OR ARR_DELAY > 0`；明确 departure/arrival 时只看对应字段。
- departed on time / arrived on time 在本库中通常表示“不晚于计划”，即出发按 `DEP_DELAY <= 0`、到达按 `ARR_DELAY <= 0`；departed early/arrived earlier 使用 `< 0`；departure/arrival delayed 使用 `> 0`。exactly on schedule、delay equals zero 或 zero minutes late 才使用 `= 0`。
- 不要默认添加 `CANCELLED = 0`、`TAIL_NUM IS NOT NULL`、`ACTUAL_ELAPSED_TIME IS NOT NULL`。只有明确要求未取消、实际完成、有效实际耗时或需要排除空值计算时才添加。
- `CANCELLED = 1` 的航班可能没有实际起降时间或实际耗时；只有计算 actual elapsed time 等实际完成指标时，才考虑排除取消航班或空值。
- 日期字段 `Airlines.FL_DATE` 是文本，样例格式为 `2018/8/1`、`2018/8/31`。按月份筛选优先使用 `LIKE '2018/8%'`，不要写成只能匹配两层斜杠的 `LIKE '2018/8/%'`，也不要改成不存在的补零格式。
- flights to/from X、flights of carrier X、flights on date X 等限定条件通常既限制外层候选航班，也限制相关聚合、平均值或百分比的统计范围；不要只把条件放在子查询里。
- 同时要求总体聚合和某个最高/最低实体时，通常需要一个总体聚合和一个按实体分组排序的子查询/CTE，再合并输出；不要只返回最高实体自己的聚合值。
- 百分比和平均值不要主动 `ROUND`，除非明确要求四舍五入或指定小数位。
- air carrier description、airport code、tail number 等列表需判断是否为唯一集合；描述/代码集合通常使用 `GROUP BY` 或 `DISTINCT` 去重，避免重复行导致大结果截断。
- 输出列严格匹配自然语言要求，不额外返回中间指标、解释性指标或排序辅助列。
- number of airplanes 通常对应不同飞机尾号，使用 `COUNT(DISTINCT TAIL_NUM)`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
