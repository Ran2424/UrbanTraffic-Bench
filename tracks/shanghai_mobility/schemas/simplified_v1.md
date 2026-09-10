# 精简评测数据库 simplified_v1

数据库文件：`database_files/shanghai_text2sql_simplified_v1.db`

用途：仅用于 Text-to-SQL 评测。数据库不保留来源追踪、采集过程、旧系统兼容字段和映射状态。

完整 DDL 见 `schemas/simplified_v1.sql`。

## 全局规则

- 日期字段统一为 `stat_date`，小时字段统一为 `stat_hour`。
- 三张事实表均为小时粒度，共享单车半小时观测已汇总到小时。
- `NULL` 表示该网格小时没有该指标观测，`0` 表示有观测且数值为零。
- 网格事实只保留能关联到 GeoHash 7 网格的数据。
- 公交只使用 `bus_line_id`，不再区分业务 ID、来源路线 ID 和 GIS 线路键。
- 地铁只使用 `line_id` 和 `station_id`，不再暴露来源站点 ID。
- 空间表直接连接最终实体，不暴露来源站点记录。

## 表与粒度

| 表 | 粒度或用途 |
|---|---|
| `metro_line` | 一行一条地铁线路 |
| `metro_station` | 一行一个地铁站 |
| `metro_flow_hour` | 日期 × 小时 × 地铁线路 × 地铁站 |
| `bus_line` | 一行一条公交线路 |
| `bus_flow_hour` | 日期 × 小时 × 公交线路 |
| `grid` | 一行一个 GeoHash 7 网格 |
| `grid_flow_hour` | 日期 × 小时 × 网格，五项指标分列 |
| `metro_grid_distance` | 地铁站 × 1,000 米内网格 |
| `metro_bus_line_distance` | 地铁站 × 1,000 米内公交线路，保存最近站点距离 |
| `metro_station_distance` | 地铁站 × 2,000 米内其他地铁站 |

## 数据转换

### 地铁

来源站点按照线路编码和物理站归并。进站量、出站量转为同一行的两个字段。

`line_id` 使用业务观测中的整数线路编码。编码 `51` 对应市域机场线；其 7 个来源站点在原映射表中的 `canonical_line_id` 为空，但都能由线路站点关系确认属于市域机场线，因此没有删除。

### 公交

已映射到同一线路的业务 ID 合并为一个 `bus_line_id`。未映射业务 ID 各自形成一条独立评测线路。最终由 917 个业务 ID 得到 915 条公交线路。

929 路和 973 路分别有两个业务 ID，它们的小时客流已在统一线路粒度求和。

### 网格交通

出租车、网约车和共享单车合并为 `grid_flow_hour`：

- `taxi_pickups`
- `taxi_dropoffs`
- `ridehail_orders`
- `ridehail_dropoffs`
- `bike_locks`

共享单车同一小时的 0 分、30 分观测相加。不可定位记录不进入新库，后续题目中的总量统一指本评测网格范围内的总量。

### 空间关系

`metro_bus_line_distance.distance_m` 是地铁站到该公交线路已有站点的最小距离。原来的来源路线、来源站点记录和业务线路映射不进入评测库。

## 数据规模

| 表 | 行数 |
|---|---:|
| `metro_line` | 19 |
| `metro_station` | 416 |
| `metro_flow_hour` | 9,244 |
| `bus_line` | 915 |
| `bus_flow_hour` | 17,412 |
| `grid` | 104,011 |
| `grid_flow_hour` | 697,683 |
| `metro_grid_distance` | 55,888 |
| `metro_bus_line_distance` | 7,813 |
| `metro_station_distance` | 1,854 |

## 数据库版本

数据库压缩包见 `database_files/archives/shanghai_multimodal__20260824.7z`。

数据库 SHA-256：`f7ca83427740711cc54993085a2797dabdd17d4ce758b5305d11e4434c5aacdf`。
