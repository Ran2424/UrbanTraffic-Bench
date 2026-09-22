# 数据库知识说明：spider_data__boat_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__boat_1 |
| source | spider_data |
| db_id | boat_1 |
| database_dir | database_layer/spider_data__boat_1 |
| sqlite_path | database_layer/spider_data__boat_1/boat_1.sqlite |
| table_count | 3 |
| scenario_id | marine_reservation |
| scenario_name | 船只预约 |
| scenario_description | 船只、水手和船只预约记录。 |

## 2. 业务子场景说明

本库聚焦“船只预约”子场景，核心对象包括船只、预约记录、水手等。它适合回答关于船只、水手和船只预约记录的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `boat_1`
- database_dir: `database_layer/spider_data__boat_1`
- db_path: `database_layer/spider_data__boat_1/boat_1.sqlite`
- original_db_path: `spider_data/spider_data/test_database/boat_1/boat_1.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| Boats | 船只基础信息。 | 3 | 3 |
| Reserves | 水手预约船只的记录。 | 3 | 4 |
| Sailors | 水手基础信息。 | 4 | 3 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| Reserves.sid | Sailors.sid |
| Reserves.bid | Boats.bid |

## 6. 表与字段说明

### 6.1 `Boats`

- 表含义：船只基础信息。
- 行数：`3`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| bid | INTEGER | number | PK |  | 船只编号，关联 Boats.bid。 样例值：101、102、103。 |
| name | TEXT | text |  |  | 名称。 样例值：Legacy、Melon、Mars。 |
| color | TEXT | text |  |  | 船只颜色。 样例值：red、blue。 |

样例数据（前 5 行）：

| bid | name | color |
| --- | --- | --- |
| 101 | Legacy | red |
| 102 | Melon | blue |
| 103 | Mars | red |

### 6.2 `Reserves`

- 表含义：水手预约船只的记录。
- 行数：`4`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| sid | INTEGER | number | FK | Sailors.sid | 外键，指向 `Sailors.sid`，表示本记录关联的水手。 |
| bid | INTEGER | number | FK | Boats.bid | 外键，指向 `Boats.bid`，表示本记录关联的船只。 |
| day | TEXT | text |  |  | 预约日期，样例为月/日格式。 样例值：9/12、9/13、9/14。 |

样例数据（前 5 行）：

| sid | bid | day |
| --- | --- | --- |
| 1 | 102 | 9/12 |
| 2 | 102 | 9/13 |
| 2 | 103 | 9/14 |
| 2 | 103 | 9/15 |

### 6.3 `Sailors`

- 表含义：水手基础信息。
- 行数：`3`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| sid | INTEGER | number | PK |  | 水手编号，关联 Sailors.sid。 样例值：1、2、3。 |
| name | TEXT | text |  |  | 名称。 样例值：Eugene、Luis、Ken。 |
| rating | INTEGER | number |  |  | 水手评级或能力评分。 样例值：7、2、8。 |
| age | INTEGER | number |  |  | 年龄。 样例值：22、39、27。 |

样例数据（前 5 行）：

| sid | name | rating | age |
| --- | --- | --- | --- |
| 1 | Eugene | 7 | 22 |
| 2 | Luis | 2 | 39 |
| 3 | Ken | 8 | 27 |

## 7. SQL 生成注意事项

- `Reserves` 是多对多预约表，统计船只或水手时要注意一条预约会同时连接一个水手和一条船。
- `day` 只有月/日格式，没有年份；涉及跨年排序或完整日期时不能假设年份。
- 当同一水手需要同时满足多个船只属性条件时，应使用 `INTERSECT` 或按 `sid` 分组后在 `HAVING` 中检查多个条件；不要把多个属性值简单写成 `IN (...)` 的并集。
- 统计每条船的预约次数且需要保留没有预约记录的船时，应从 `Boats` 出发 `LEFT JOIN Reserves`，让未预约船只计为 0；只从 `Reserves` 分组会丢失 0 次记录。
- 年龄比较中的 any/all 语义需区分：`any` 通常表示至少满足一个比较对象，可对应 `age > (SELECT MIN(age) FROM Sailors)`；`all` 才对应与最大年龄比较。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
