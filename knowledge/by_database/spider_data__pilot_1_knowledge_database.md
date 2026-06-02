# 数据库知识说明：spider_data__pilot_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__pilot_1 |
| source | spider_data |
| db_id | pilot_1 |
| database_dir | database_layer/spider_data__pilot_1 |
| sqlite_path | database_layer/spider_data__pilot_1/pilot_1.sqlite |
| table_count | 2 |
| scenario_id | pilot_skill_inventory |
| scenario_name | 飞行员技能与机库 |
| scenario_description | 机库飞机、飞行员可驾驶机型和飞行员年龄。 |

## 2. 业务子场景说明

本库聚焦“飞行员技能与机库”子场景，核心对象包括机库飞机、飞行员技能等。它适合回答关于机库飞机、飞行员可驾驶机型和飞行员年龄的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `pilot_1`
- database_dir: `database_layer/spider_data__pilot_1`
- db_path: `database_layer/spider_data__pilot_1/pilot_1.sqlite`
- original_db_path: `spider_data/spider_data/test_database/pilot_1/pilot_1.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| Hangar | 机库内飞机及其停放地点。 | 2 | 4 |
| PilotSkills | 飞行员可驾驶机型及年龄信息。 | 3 | 13 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| PilotSkills.plane_name | Hangar.plane_name |

## 6. 表与字段说明

### 6.1 `Hangar`

- 表含义：机库内飞机及其停放地点。
- 行数：`4`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| plane_name | CHAR(15) | text | PK, NOT NULL |  | 飞机名称或机型名称。 样例值：B-1 Bomber、B-52 Bomber、F-14 Fighter。 |
| location | CHAR(15) | text |  |  | 地点或城市位置。 样例值：Chicago、Austin、Boston。 |

样例数据（前 5 行）：

| plane_name | location |
| --- | --- |
| B-1 Bomber | Chicago |
| B-52 Bomber | Austin |
| F-14 Fighter | Boston |
| Piper Cub | Seattle |

### 6.2 `PilotSkills`

- 表含义：飞行员可驾驶机型及年龄信息。
- 行数：`13`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| pilot_name | CHAR(15) | text | PK, NOT NULL |  | 飞行员姓名。 样例值：Celko、Higgins、Jones。 |
| plane_name | CHAR(15) | text | PK, NOT NULL, FK | Hangar.plane_name | 外键，指向 `Hangar.plane_name`，表示本记录关联的机库飞机。 |
| age | INTEGER | number |  |  | 年龄。 样例值：23、34、50。 |

样例数据（前 5 行）：

| pilot_name | plane_name | age |
| --- | --- | --- |
| Celko | Piper Cub | 23 |
| Higgins | B-52 Bomber | 34 |
| Higgins | F-14 Fighter | 50 |
| Higgins | Piper Cub | 30 |
| Jones | B-52 Bomber | 24 |

## 7. SQL 生成注意事项

- `PilotSkills` 是飞行员与可驾驶机型关系表，同一飞行员可对应多个飞机。
- `plane_name` 是文本主键/连接键，连接时需使用完全一致的飞机名称。
- 统计“多少飞行员”时应按 `pilot_name` 去重：`COUNT(DISTINCT pilot_name)`，因为同一飞行员可驾驶多种飞机，在 `PilotSkills` 中会出现多行。
- 问“每种飞机最年长飞行员”时应以 `PilotSkills` 为主表按 `plane_name` 分组找 `MAX(age)`，并保留并列最年长者；不要为了“不同飞机”额外连接 `Hangar`，否则会排除只出现在 `PilotSkills` 中的机型。
- 输出列只包含题目要求的字段；例如问飞行员姓名和飞机名称时，不要额外输出 `age`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
