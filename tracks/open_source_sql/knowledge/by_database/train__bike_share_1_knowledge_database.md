# 数据库知识说明：train__bike_share_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | train__bike_share_1 |
| source | train |
| db_id | bike_share_1 |
| database_dir | database_layer/train__bike_share_1 |
| sqlite_path | database_layer/train__bike_share_1/bike_share_1.sqlite |
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

- source: `train`
- db_id: `bike_share_1`
- database_dir: `database_layer/train__bike_share_1`
- db_path: `database_layer/train__bike_share_1/bike_share_1.sqlite`
- original_db_path: `train/train_databases/bike_share_1/bike_share_1.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| station | 共享单车站点基础信息。 | 7 | 70 |
| status | 共享单车站点在某一时间点的可借车与可还桩状态快照。 | 4 | 71984434 |
| trip | 共享单车一次骑行行程记录。 | 11 | 658901 |
| weather | 按日期和邮编记录的天气观测数据。 | 24 | 3665 |

## 5. 表关系

`database.json` 中没有显式外键关系；使用时需要结合字段名、题目语义和样例数据判断关联路径。

## 6. 表与字段说明

### 6.1 `station`

- 表含义：共享单车站点基础信息。
- 行数：`70`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INTEGER | integer | PK, NOT NULL |  | 共享单车站点唯一编号。 样例值：2、3、4。 |
| name | TEXT | text |  |  | 名称。 样例值：San Jose Diridon Caltrain Station、San Jose Civic Center、Santa Clara at Almaden。 |
| lat | REAL | real |  |  | 纬度坐标。 别名：latitude。 取值说明：commonsense evidence: Can represent the location of the station when combined with longitude。 |
| long | REAL | real |  |  | 经度坐标。 别名：longitude。 取值说明：commonsense evidence: Can represent the location of the station when combined with latitude。 |
| dock_count | INTEGER | integer |  |  | 站点泊位总数，即可停放自行车的车桩容量。 别名：dock count。 样例值：27、15、11。 |
| city | TEXT | text |  |  | 城市。 样例值：San Jose。 |
| installation_date | TEXT | text |  |  | 站点安装或启用日期。 别名：installation date。 样例值：8/6/2013、8/5/2013、8/7/2013。 |

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
- 行数：`71984434`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| station_id | INTEGER | integer |  |  | 状态快照所属站点编号，可与 station.id 连接。 别名：station id。 样例值：2。 |
| bikes_available | INTEGER | integer |  |  | 该时间点站点可借自行车数量。 取值说明：commonsense evidence: 0 means no bike can be borrowed。 样例值：2。 |
| docks_available | INTEGER | integer |  |  | 该时间点站点可还车的空车桩数量。 取值说明：commonsense evidence: 0 means no bike can be returned to this station。 |
| time | TEXT | text |  |  | 时间戳或时间。 样例值：2013/08/29 12:06:01、2013/08/29 12:07:01、2013/08/29 12:08:01。 |

样例数据（前 5 行）：

| station_id | bikes_available | docks_available | time |
| --- | --- | --- | --- |
| 2 | 2 | 25 | 2013/08/29 12:06:01 |
| 2 | 2 | 25 | 2013/08/29 12:07:01 |
| 2 | 2 | 25 | 2013/08/29 12:08:01 |
| 2 | 2 | 25 | 2013/08/29 12:09:01 |
| 2 | 2 | 25 | 2013/08/29 12:10:01 |

### 6.3 `trip`

- 表含义：共享单车一次骑行行程记录。
- 行数：`658901`
- 字段数：`11`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INTEGER | integer | PK, NOT NULL |  | 骑行行程的唯一编号，用于标识一条骑行行程记录。 样例值：4069、4073、4074。 |
| duration | INTEGER | integer |  |  | 骑行持续时间，单位为秒。 取值说明：commonsense evidence: duration = end_date - start_date。 样例值：174、1067、1131。 |
| start_date | TEXT | text |  |  | 骑行开始日期时间。 别名：start date。 样例值：8/29/2013 9:08、8/29/2013 9:24、8/29/2013 9:25。 |
| start_station_name | TEXT | text |  |  | 骑行起点站名称。 别名：start station name。 取值说明：commonsense evidence: It represents the station name the bike borrowed from。 |
| start_station_id | INTEGER | integer |  |  | 骑行起点站编号。 别名：start station id。 样例值：64、66。 |
| end_date | TEXT | text |  |  | 骑行结束日期时间。 别名：end date。 样例值：8/29/2013 9:11、8/29/2013 9:42、8/29/2013 9:43。 |
| end_station_name | TEXT | text |  |  | 骑行终点站名称。 别名：end station name。 取值说明：commonsense evidence: It represents the station name the bike returned to。 |
| end_station_id | INTEGER | integer |  |  | 骑行终点站编号。 别名：end station id。 样例值：64、69。 |
| bike_id | INTEGER | integer |  |  | 自行车编号。 别名：bike id。 样例值：288、321、317。 |
| subscription_type | TEXT | text |  |  | 用户订阅类型，取值包括 Subscriber 和 Customer。 别名：subscription type。 取值说明：Allowed input: Subscriber, Customer。 |
| zip_code | INTEGER | integer |  |  | 邮政编码。 别名：zip code。 样例值：94114、94703、94115。 |

样例数据（前 5 行）：

| id | duration | start_date | start_station_name | start_station_id | end_date | end_station_name | end_station_id | bike_id | subscription_type | zip_code |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 4069 | 174 | 8/29/2013 9:08 | 2nd at South Park | 64 | 8/29/2013 9:11 | 2nd at South Park | 64 | 288 | Subscriber | 94114 |
| 4073 | 1067 | 8/29/2013 9:24 | South Van Ness at Market | 66 | 8/29/2013 9:42 | San Francisco Caltrain 2 (330 Townsend) | 69 | 321 | Subscriber | 94703 |
| 4074 | 1131 | 8/29/2013 9:24 | South Van Ness at Market | 66 | 8/29/2013 9:43 | San Francisco Caltrain 2 (330 Townsend) | 69 | 317 | Subscriber | 94115 |
| 4075 | 1117 | 8/29/2013 9:24 | South Van Ness at Market | 66 | 8/29/2013 9:43 | San Francisco Caltrain 2 (330 Townsend) | 69 | 316 | Subscriber | 94122 |
| 4076 | 1118 | 8/29/2013 9:25 | South Van Ness at Market | 66 | 8/29/2013 9:43 | San Francisco Caltrain 2 (330 Townsend) | 69 | 322 | Subscriber | 94597 |

### 6.4 `weather`

- 表含义：按日期和邮编记录的天气观测数据。
- 行数：`3665`
- 字段数：`24`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| date | TEXT | text |  |  | 日期。 样例值：8/29/2013、8/30/2013、8/31/2013。 |
| max_temperature_f | INTEGER | integer |  |  | 当日最高气温，单位为华氏度。 别名：max temperature in Fahrenheit degree。 取值说明：commonsense evidence: It represents the hottest temperature。 |
| mean_temperature_f | INTEGER | integer |  |  | 当日平均气温，单位为华氏度。 别名：mean temperature in Fahrenheit degree。 样例值：68、69、64。 |
| min_temperature_f | INTEGER | integer |  |  | 当日最低气温，单位为华氏度。 别名：min temperature in Fahrenheit degree。 取值说明：commonsense evidence: It represents the coldest temperature。 |
| max_dew_point_f | INTEGER | integer |  |  | 当日最高露点温度，单位为华氏度。 别名：max dew point in Fahrenheit degree。 样例值：61、57、60。 |
| mean_dew_point_f | INTEGER | integer |  |  | 当日平均露点温度，单位为华氏度。 别名：mean dew point in Fahrenheit degree。 样例值：58、56、60。 |
| min_dew_point_f | INTEGER | integer |  |  | 当日最低露点温度，单位为华氏度。 别名：min dew point in Fahrenheit degree。 样例值：56、54、53。 |
| max_humidity | INTEGER | integer |  |  | 当日最高湿度。 别名：max humidity。 样例值：93、90、87。 |
| mean_humidity | INTEGER | integer |  |  | 当日平均湿度。 别名：mean humidity。 样例值：75、70、68。 |
| min_humidity | INTEGER | integer |  |  | 当日最低湿度。 别名：min humidity。 样例值：57、50、49。 |
| max_sea_level_pressure_inches | REAL | real |  |  | 当日最高海平面气压，单位为英寸汞柱。 别名：max sea level pressure in inches。 样例值：30.07、30.05、30.0。 |
| mean_sea_level_pressure_inches | REAL | real |  |  | 当日平均海平面气压，单位为英寸汞柱。 别名：mean sea level pressure in inches。 样例值：30.02、30.0、29.96。 |
| min_sea_level_pressure_inches | REAL | real |  |  | 当日最低海平面气压，单位为英寸汞柱。 别名：min sea level pressure in inches。 样例值：29.97、29.93、29.92。 |
| max_visibility_miles | INTEGER | integer |  |  | 当日最大能见度，单位为英里。 别名：max visibility in miles。 样例值：10。 |
| mean_visibility_miles | INTEGER | integer |  |  | 当日平均能见度，单位为英里。 别名：mean visibility in miles。 样例值：10。 |
| min_visibility_miles | INTEGER | integer |  |  | 当日最小能见度，单位为英里。 别名：min visibility in miles。 样例值：10、7、6。 |
| max_wind_Speed_mph | INTEGER | integer |  |  | 当日最大风速，单位为英里/小时。 别名：max wind Speed in mph。 样例值：23、29、26。 |
| mean_wind_speed_mph | INTEGER | integer |  |  | 当日平均风速，单位为英里/小时。 别名：mean wind Speed in mph。 样例值：11、13、15。 |
| max_gust_speed_mph | INTEGER | integer |  |  | 当日最大阵风风速，单位为英里/小时。 别名：max gust Speed in mph。 样例值：28、35、31。 |
| precipitation_inches | TEXT | text |  |  | 当日降水量，单位为英寸。 别名：precipitation in inches。 样例值：0。 |
| cloud_cover | INTEGER | integer |  |  | 云量覆盖等级。 别名：cloud cover。 样例值：4、2、6。 |
| events | TEXT | text |  |  | 天气事件类型，例如 Rain 或空值。 取值说明：Allowed input: [null], Rain, other。 |
| wind_dir_degrees | INTEGER | integer |  |  | 风向角度，单位为度。 别名：wind direction degrees。 样例值：286、291、284。 |
| zip_code | TEXT | text |  |  | 邮政编码。 别名：zip code。 样例值：94107。 |

样例数据（前 5 行）：

| date | max_temperature_f | mean_temperature_f | min_temperature_f | max_dew_point_f | mean_dew_point_f | min_dew_point_f | max_humidity | mean_humidity | min_humidity | max_sea_level_pressure_inches | mean_sea_level_pressure_inches | min_sea_level_pressure_inches | max_visibility_miles | mean_visibility_miles | min_visibility_miles | max_wind_Speed_mph | mean_wind_speed_mph | max_gust_speed_mph | precipitation_inches | cloud_cover | events | wind_dir_degrees | zip_code |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 8/29/2013 | 74 | 68 | 61 | 61 | 58 | 56 | 93 | 75 | 57 | 30.07 | 30.02 | 29.97 | 10 | 10 | 10 | 23 | 11 | 28 | 0 | 4 |  | 286 | 94107 |
| 8/30/2013 | 78 | 69 | 60 | 61 | 58 | 56 | 90 | 70 | 50 | 30.05 | 30.0 | 29.93 | 10 | 10 | 7 | 29 | 13 | 35 | 0 | 2 |  | 291 | 94107 |
| 8/31/2013 | 71 | 64 | 57 | 57 | 56 | 54 | 93 | 75 | 57 | 30.0 | 29.96 | 29.92 | 10 | 10 | 10 | 26 | 15 | 31 | 0 | 4 |  | 284 | 94107 |
| 9/1/2013 | 74 | 66 | 58 | 60 | 56 | 53 | 87 | 68 | 49 | 29.96 | 29.93 | 29.91 | 10 | 10 | 10 | 25 | 13 | 29 | 0 | 4 |  | 284 | 94107 |
| 9/2/2013 | 75 | 69 | 62 | 61 | 60 | 58 | 93 | 77 | 61 | 29.97 | 29.94 | 29.9 | 10 | 10 | 6 | 23 | 12 | 30 | 0 | 6 |  | 277 | 94107 |

## 7. SQL 生成注意事项

- `status` 行数非常大，生成 SQL 时应尽量先用时间、站点条件过滤，避免无条件全表聚合。
- `trip` 同时有站点名和站点编号，连接 `station` 时优先使用 `start_station_id` 或 `end_station_id`。
- `weather.date` 与 `trip.start_date/end_date` 格式不同，按日期关联前需要截取或格式化日期部分。
- `database.json` 没有显式外键时，连接关系需依据同名编号字段、样例值和题目语义确认。
- 日期/时间多为文本字段：`station.installation_date`、`status.time`、`trip.start_date`、`trip.end_date`、`weather.date`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
