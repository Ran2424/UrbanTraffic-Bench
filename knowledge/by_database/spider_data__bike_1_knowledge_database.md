# 数据库知识说明：spider_data__bike_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__bike_1 |
| source | spider_data |
| db_id | bike_1 |
| database_dir | database_layer/spider_data__bike_1 |
| sqlite_path | database_layer/spider_data__bike_1/bike_1.sqlite |
| table_count | 4 |
| scenario_id | bike_micromobility |
| scenario_name | 共享单车与微出行 |
| scenario_description | 共享单车站点、实时车桩状态、骑行记录和天气。 |

## 2. 业务子场景说明

本库聚焦“共享单车与微出行”子场景，核心对象包括站点、状态快照、骑行行程、天气记录等。它适合回答关于共享单车站点、实时车桩状态、骑行记录和天气的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `bike_1`
- database_dir: `database_layer/spider_data__bike_1`
- db_path: `database_layer/spider_data__bike_1/bike_1.sqlite`
- original_db_path: `spider_data/spider_data/database/bike_1/bike_1.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| station | 共享单车站点基础信息。 | 7 | 70 |
| status | 共享单车站点在某一时间点的可借车与可还桩状态快照。 | 4 | 8487 |
| trip | 共享单车一次骑行行程记录。 | 11 | 9959 |
| weather | 按日期和邮编记录的天气观测数据。 | 24 | 3665 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| status.station_id | station.id |

## 6. 表与字段说明

### 6.1 `station`

- 表含义：共享单车站点基础信息。
- 行数：`70`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INTEGER | number | PK |  | 共享单车站点唯一编号。 样例值：2、3、4。 |
| name | TEXT | text |  |  | 名称。 样例值：San Jose Diridon Caltrain Station、San Jose Civic Center、Santa Clara at Almaden。 |
| lat | NUMERIC | number |  |  | 纬度坐标。 样例值：37.329732、37.330698、37.333988。 |
| long | NUMERIC | number |  |  | 经度坐标。 样例值：-121.90178200000001、-121.888979、-121.894902。 |
| dock_count | INTEGER | number |  |  | 站点泊位总数，即可停放自行车的车桩容量。 样例值：27、15、11。 |
| city | TEXT | text |  |  | 城市。 样例值：San Jose。 |
| installation_date | TEXT | text |  |  | 站点安装或启用日期。 样例值：8/6/2013、8/5/2013、8/7/2013。 |

样例数据（前 5 行）：

| id | name | lat | long | dock_count | city | installation_date |
| --- | --- | --- | --- | --- | --- | --- |
| 2 | San Jose Diridon Caltrain Station | 37.329732 | -121.90178200000001 | 27 | San Jose | 8/6/2013 |
| 3 | San Jose Civic Center | 37.330698 | -121.888979 | 15 | San Jose | 8/5/2013 |
| 4 | Santa Clara at Almaden | 37.333988 | -121.894902 | 11 | San Jose | 8/6/2013 |
| 5 | Adobe on Almaden | 37.331415 | -121.8932 | 19 | San Jose | 8/5/2013 |
| 6 | San Pedro Square | 37.336721000000004 | -121.894074 | 15 | San Jose | 8/7/2013 |

### 6.2 `status`

- 表含义：共享单车站点在某一时间点的可借车与可还桩状态快照。
- 行数：`8487`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| station_id | INTEGER | number | FK | station.id | 外键，指向 `station.id`，表示本记录关联的站点。 |
| bikes_available | INTEGER | number |  |  | 该时间点站点可借自行车数量。 样例值：12。 |
| docks_available | INTEGER | number |  |  | 该时间点站点可还车的空车桩数量。 样例值：3。 |
| time | TEXT | text |  |  | 时间戳或时间。 样例值：2015-06-02 12:46:02、2015-06-02 12:47:02、2015-06-02 12:48:02。 |

样例数据（前 5 行）：

| station_id | bikes_available | docks_available | time |
| --- | --- | --- | --- |
| 3 | 12 | 3 | 2015-06-02 12:46:02 |
| 3 | 12 | 3 | 2015-06-02 12:47:02 |
| 3 | 12 | 3 | 2015-06-02 12:48:02 |
| 3 | 12 | 3 | 2015-06-02 12:49:02 |
| 3 | 12 | 3 | 2015-06-02 12:50:02 |

### 6.3 `trip`

- 表含义：共享单车一次骑行行程记录。
- 行数：`9959`
- 字段数：`11`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INTEGER | number | PK |  | 骑行行程的唯一编号，用于标识一条骑行行程记录。 样例值：900504、900505、900506。 |
| duration | INTEGER | number |  |  | 骑行持续时间，单位为秒。 样例值：384、588、196。 |
| start_date | TEXT | text |  |  | 骑行开始日期时间。 样例值：8/21/2015 17:03、8/21/2015 17:04。 |
| start_station_name | TEXT | text |  |  | 骑行起点站名称。 样例值：Howard at 2nd、South Van Ness at Market、Market at Sansome。 |
| start_station_id | INTEGER | number |  |  | 骑行起点站编号。 样例值：63、66、77。 |
| end_date | TEXT | text |  |  | 骑行结束日期时间。 样例值：8/21/2015 17:10、8/21/2015 17:13、8/21/2015 17:07。 |
| end_station_name | TEXT | text |  |  | 骑行终点站名称。 样例值：San Francisco Caltrain 2 (330 Townsend)、Harry Bridges Plaza (Ferry Building)、2nd at Townsend。 |
| end_station_id | INTEGER | number |  |  | 骑行终点站编号。 样例值：69、50、61。 |
| bike_id | INTEGER | number |  |  | 自行车编号。 样例值：454、574、636。 |
| subscription_type | TEXT | text |  |  | 用户订阅类型，取值包括 Subscriber 和 Customer。 |
| zip_code | INTEGER | number |  |  | 邮政编码。 样例值：94041、95119、94925。 |

样例数据（前 5 行）：

| id | duration | start_date | start_station_name | start_station_id | end_date | end_station_name | end_station_id | bike_id | subscription_type | zip_code |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 900504 | 384 | 8/21/2015 17:03 | Howard at 2nd | 63 | 8/21/2015 17:10 | San Francisco Caltrain 2 (330 Townsend) | 69 | 454 | Subscriber | 94041 |
| 900505 | 588 | 8/21/2015 17:03 | South Van Ness at Market | 66 | 8/21/2015 17:13 | San Francisco Caltrain 2 (330 Townsend) | 69 | 574 | Subscriber | 95119 |
| 900506 | 196 | 8/21/2015 17:04 | Market at Sansome | 77 | 8/21/2015 17:07 | Harry Bridges Plaza (Ferry Building) | 50 | 636 | Subscriber | 94925 |
| 900507 | 823 | 8/21/2015 17:04 | Washington at Kearny | 46 | 8/21/2015 17:18 | 2nd at Townsend | 61 | 187 | Subscriber | 94103 |
| 900508 | 1059 | 8/21/2015 17:04 | Beale at Market | 56 | 8/21/2015 17:22 | San Francisco Caltrain (Townsend at 4th) | 70 | 363 | Customer | 94107 |

### 6.4 `weather`

- 表含义：按日期和邮编记录的天气观测数据。
- 行数：`3665`
- 字段数：`24`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| date | TEXT | text |  |  | 日期。 样例值：8/29/2013、8/30/2013、8/31/2013。 |
| max_temperature_f | INTEGER | number |  |  | 当日最高气温，单位为华氏度。 样例值：74、78、71。 |
| mean_temperature_f | INTEGER | number |  |  | 当日平均气温，单位为华氏度。 样例值：68、69、64。 |
| min_temperature_f | INTEGER | number |  |  | 当日最低气温，单位为华氏度。 样例值：61、60、57。 |
| max_dew_point_f | INTEGER | number |  |  | 当日最高露点温度，单位为华氏度。 样例值：61、57、60。 |
| mean_dew_point_f | INTEGER | number |  |  | 当日平均露点温度，单位为华氏度。 样例值：58、56、60。 |
| min_dew_point_f | INTEGER | number |  |  | 当日最低露点温度，单位为华氏度。 样例值：56、54、53。 |
| max_humidity | INTEGER | number |  |  | 当日最高湿度。 样例值：93、90、87。 |
| mean_humidity | INTEGER | number |  |  | 当日平均湿度。 样例值：75、70、68。 |
| min_humidity | INTEGER | number |  |  | 当日最低湿度。 样例值：57、50、49。 |
| max_sea_level_pressure_inches | NUMERIC | number |  |  | 当日最高海平面气压，单位为英寸汞柱。 样例值：30.07、30.05、30。 |
| mean_sea_level_pressure_inches | NUMERIC | number |  |  | 当日平均海平面气压，单位为英寸汞柱。 样例值：30.02、30、29.96。 |
| min_sea_level_pressure_inches | NUMERIC | number |  |  | 当日最低海平面气压，单位为英寸汞柱。 样例值：29.97、29.93、29.92。 |
| max_visibility_miles | INTEGER | number |  |  | 当日最大能见度，单位为英里。 样例值：10。 |
| mean_visibility_miles | INTEGER | number |  |  | 当日平均能见度，单位为英里。 样例值：10。 |
| min_visibility_miles | INTEGER | number |  |  | 当日最小能见度，单位为英里。 样例值：10、7、6。 |
| max_wind_Speed_mph | INTEGER | number |  |  | 当日最大风速，单位为英里/小时。 样例值：23、29、26。 |
| mean_wind_speed_mph | INTEGER | number |  |  | 当日平均风速，单位为英里/小时。 样例值：11、13、15。 |
| max_gust_speed_mph | INTEGER | number |  |  | 当日最大阵风风速，单位为英里/小时。 样例值：28、35、31。 |
| precipitation_inches | INTEGER | number |  |  | 当日降水量，单位为英寸。 样例值：0。 |
| cloud_cover | INTEGER | number |  |  | 云量覆盖等级。 样例值：4、2、6。 |
| events | TEXT | text |  |  | 天气事件类型，例如 Rain 或空值。 |
| wind_dir_degrees | INTEGER | number |  |  | 风向角度，单位为度。 样例值：286、291、284。 |
| zip_code | INTEGER | number |  |  | 邮政编码。 样例值：94107。 |

样例数据（前 5 行）：

| date | max_temperature_f | mean_temperature_f | min_temperature_f | max_dew_point_f | mean_dew_point_f | min_dew_point_f | max_humidity | mean_humidity | min_humidity | max_sea_level_pressure_inches | mean_sea_level_pressure_inches | min_sea_level_pressure_inches | max_visibility_miles | mean_visibility_miles | min_visibility_miles | max_wind_Speed_mph | mean_wind_speed_mph | max_gust_speed_mph | precipitation_inches | cloud_cover | events | wind_dir_degrees | zip_code |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 8/29/2013 | 74 | 68 | 61 | 61 | 58 | 56 | 93 | 75 | 57 | 30.07 | 30.02 | 29.97 | 10 | 10 | 10 | 23 | 11 | 28 | 0 | 4 |  | 286 | 94107 |
| 8/30/2013 | 78 | 69 | 60 | 61 | 58 | 56 | 90 | 70 | 50 | 30.05 | 30 | 29.93 | 10 | 10 | 7 | 29 | 13 | 35 | 0 | 2 |  | 291 | 94107 |
| 8/31/2013 | 71 | 64 | 57 | 57 | 56 | 54 | 93 | 75 | 57 | 30 | 29.96 | 29.92 | 10 | 10 | 10 | 26 | 15 | 31 | 0 | 4 |  | 284 | 94107 |
| 9/1/2013 | 74 | 66 | 58 | 60 | 56 | 53 | 87 | 68 | 49 | 29.96 | 29.93 | 29.91 | 10 | 10 | 10 | 25 | 13 | 29 | 0 | 4 |  | 284 | 94107 |
| 9/2/2013 | 75 | 69 | 62 | 61 | 60 | 58 | 93 | 77 | 61 | 29.97 | 29.94 | 29.9 | 10 | 10 | 6 | 23 | 12 | 30 | 0 | 6 |  | 277 | 94107 |

## 7. SQL 生成注意事项

- `status` 是时间序列快照，按站点聚合前要明确是按记录数、时间点还是站点去重。
- `trip` 同时有站点名和站点编号；判断起点/终点站所在城市、站点容量、经纬度或安装日期时，应通过 `start_station_id` 或 `end_station_id` 连接 `station.id`，不要用站点名称字符串猜城市。
- `trip.start_station_name`、`trip.end_station_name` 是站点名称，不等同于城市名称。例如判断是否在 `San Francisco`、`Mountain View`、`Palo Alto` 等城市，应连接 `station.city`。
- 题目说 bike traveled the most、most trips、most frequently used bike 等默认按 trip 记录次数 `COUNT(*)` 排序；只有明确问 total duration、total time、longest travel time 时，才按 `SUM(duration)` 或 `duration` 排序。
- 极值查询需保留并列结果：如果题目问达到最小/最大温差、最高/最低天气指标的日期，通常应先求极值，再用 `WHERE 指标 = (SELECT MIN/MAX(...))` 返回所有并列日期；不要简单 `ORDER BY ... LIMIT 1`。
- 天气事件 `events` 可能是组合文本，如 `Fog-Rain`、`Rain-Thunderstorm`，也可能为空。排除 Fog 或 Rain 时应使用 `events IS NULL OR (events NOT LIKE '%Fog%' AND events NOT LIKE '%Rain%')`；不要只用 `NOT IN ('Fog','Rain')`。
- `weather` 和 `trip` 都有 `zip_code`，但粒度不同：`weather` 是按日期和邮编的天气记录，`trip` 是单次行程记录。按 zip 同时要求天气均值和 trip 数量时，应分别按 zip 聚合后再组合条件，避免直接明细 join 放大行数和改变平均值。
- 题目只问天气日期、温度和 zip code 时，通常直接查询 `weather`；不要因为出现 “station” 就强行连接 `station` 或 `trip`，除非题目明确要求站点属性或行程属性。
- `weather.date` 与 `trip.start_date/end_date` 格式不同，按日期关联前需要截取或格式化日期部分；不要直接把完整 datetime 与天气日期等值连接。
- 日期/时间多为文本字段：`station.installation_date`、`status.time`、`trip.start_date`、`trip.end_date`、`weather.date`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
