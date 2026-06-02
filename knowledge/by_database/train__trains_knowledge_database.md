# 数据库知识说明：train__trains

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | train__trains |
| source | train |
| db_id | trains |
| database_dir | database_layer/train__trains |
| sqlite_path | database_layer/train__trains/trains.sqlite |
| table_count | 2 |
| scenario_id | train_composition |
| scenario_name | 列车编组形状 |
| scenario_description | 列车方向和车厢位置、形状、长度、车轮、载荷属性。 |

## 2. 业务子场景说明

本库聚焦“列车编组形状”子场景，核心对象包括车厢、列车等。它适合回答关于列车方向和车厢位置、形状、长度、车轮、载荷属性的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `train`
- db_id: `trains`
- database_dir: `database_layer/train__trains`
- db_path: `database_layer/train__trains/trains.sqlite`
- original_db_path: `train/train_databases/trains/trains.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| cars | 列车中的车厢属性记录。 | 10 | 63 |
| trains | 列车基础信息。 | 2 | 20 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| cars.train_id | trains.id |

## 6. 表与字段说明

### 6.1 `cars`

- 表含义：列车中的车厢属性记录。
- 行数：`63`
- 字段数：`10`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INTEGER | integer | PK, NOT NULL |  | the unique id number representing the cars 样例值：1、2、3。 |
| train_id | INTEGER | integer | FK, DEFAULT NULL | trains.id | 外键，指向 `trains.id`，表示本记录关联的列车。 |
| position | INTEGER | integer | DEFAULT NULL |  | 车厢在列车中的位置序号。 取值说明：1-4: commonsense evidence: 1: head car 4: tail car。 |
| shape | TEXT | text | DEFAULT NULL |  | 车厢形状。取值包括 `rectangle`、`bucket`、`u_shaped`、`hexagon`、`ellipse`。注意正式数据和 Gold SQL 使用 `ellipse`，不要写成 `elipse`。 |
| len | TEXT | text | DEFAULT NULL |  | 车厢长度类别。 别名：length。 取值说明：• short • long。 |
| sides | TEXT | text | DEFAULT NULL |  | 车厢侧面属性。 取值说明：• not_double • double。 |
| roof | TEXT | text | DEFAULT NULL |  | 车厢顶部形状。 取值说明：commonsense evidence: • none: the roof is open • peaked • flat • arc • jagged。 |
| wheels | INTEGER | integer | DEFAULT NULL |  | 车轮数量。 取值说明：• 2: • 3:。 |
| load_shape | TEXT | text | DEFAULT NULL |  | 载荷形状。 取值说明：• circle • hexagon • triangle • rectangle • diamond。 |
| load_num | INTEGER | integer | DEFAULT NULL |  | 载荷数量。 别名：load number。 取值说明：0-3: commonsense evidence: • 0: empty load • 3: full load。 |

样例数据（前 5 行）：

| id | train_id | position | shape | len | sides | roof | wheels | load_shape | load_num |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 1 | 1 | rectangle | short | not_double | none | 2 | circle | 1 |
| 2 | 1 | 2 | rectangle | long | not_double | none | 3 | hexagon | 1 |
| 3 | 1 | 3 | rectangle | short | not_double | peaked | 2 | triangle | 1 |
| 4 | 1 | 4 | rectangle | long | not_double | none | 2 | rectangle | 3 |
| 5 | 2 | 1 | rectangle | short | not_double | flat | 2 | circle | 2 |

### 6.2 `trains`

- 表含义：列车基础信息。
- 行数：`20`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| id | INTEGER | integer | PK, NOT NULL |  | the unique id representing the trains 样例值：1、2、3。 |
| direction | TEXT | text | DEFAULT NULL |  | 列车行驶方向。 取值说明：• east; • west;。 |

样例数据（前 5 行）：

| id | direction |
| --- | --- |
| 1 | east |
| 2 | east |
| 3 | east |
| 4 | east |
| 5 | east |

## 7. SQL 生成注意事项

- `cars` 是车厢属性表，不是汽车；每列 train 可对应多个 cars 行。
- `position` 表示车厢顺序，筛选第 N 节车厢时用该字段。
- `len` 是长度类别字段名，避免与 SQL 函数或语义中的字符串长度混淆。
- 题目中的 “4 short cars” 在本库任务里可能指 `position = 4 AND len = 'short'`，即第 4 节车厢是短车厢；不要默认理解为一列车有 4 节短车厢，除非题目明确说 “four short cars” 或 “has 4 cars that are short”。
- 问 “How many wheels do the long/short cars have?” 通常要求车轮总数，使用 `SUM(wheels)`，不是列出不同的 `wheels` 取值。
- 问 head car/tail car 时，head car 对应 `position = 1`，tail car 通常对应最大位置或 `position = 4`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
