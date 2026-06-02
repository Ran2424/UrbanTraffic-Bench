# 数据库知识说明：spider_data__ship_1

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__ship_1 |
| source | spider_data |
| db_id | ship_1 |
| database_dir | database_layer/spider_data__ship_1 |
| sqlite_path | database_layer/spider_data__ship_1/ship_1.sqlite |
| table_count | 2 |
| scenario_id | marine_ship_captain |
| scenario_name | 船舶与船长 |
| scenario_description | 船舶属性、船长、船级和军衔。 |

## 2. 业务子场景说明

本库聚焦“船舶与船长”子场景，核心对象包括船舶、船长等。它适合回答关于船舶属性、船长、船级和军衔的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `ship_1`
- database_dir: `database_layer/spider_data__ship_1`
- db_path: `database_layer/spider_data__ship_1/ship_1.sqlite`
- original_db_path: `spider_data/spider_data/database/ship_1/ship_1.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| Ship | 船舶基础信息。 | 6 | 9 |
| captain | 船长基础信息及其所属船舶。 | 6 | 7 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| captain.Ship_ID | Ship.Ship_ID |

## 6. 表与字段说明

### 6.1 `Ship`

- 表含义：船舶基础信息。
- 行数：`9`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Ship_ID | INT | number | PK |  | 船舶唯一编号。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：HMS Manxman、HMS Gorgon、HM Cutter Avenger。 |
| Type | TEXT | text |  |  | 船舶类型或船型，例如 Panamax。 样例值：Panamax。 |
| Built_Year | REAL | number |  |  | 船舶建造年份。 样例值：1997.0、1998.0。 |
| Class | TEXT | text |  |  | 类别、级别或船级，按所在表判断。 样例值：KR。 |
| Flag | TEXT | text |  |  | 船舶注册旗国。 样例值：Panama。 |

样例数据（前 5 行）：

| Ship_ID | Name | Type | Built_Year | Class | Flag |
| --- | --- | --- | --- | --- | --- |
| 1 | HMS Manxman | Panamax | 1997.0 | KR | Panama |
| 2 | HMS Gorgon | Panamax | 1998.0 | KR | Panama |
| 3 | HM Cutter Avenger | Panamax | 1997.0 | KR | Panama |
| 4 | HM Schooner Hotspur | Panamax | 1998.0 | KR | Panama |
| 5 | HMS Destiny | Panamax | 1998.0 | KR | Panama |

### 6.2 `captain`

- 表含义：船长基础信息及其所属船舶。
- 行数：`7`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Captain_ID | INT | number | PK |  | 船长唯一编号。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Captain Sir Henry Langford、Captain Beves Conway、Lieutenant Hugh Bolitho。 |
| Ship_ID | INT | number | FK | Ship.Ship_ID | 外键，指向 `Ship.Ship_ID`，表示本记录关联的船舶。 |
| age | TEXT | text |  |  | 船长年龄，存为文本数字；排序、最大/最小时建议 `CAST(age AS INTEGER)`。 样例值：40、54、43。 |
| Class | TEXT | text |  |  | 类别、级别或船级，按所在表判断。 样例值：Third-rate ship of the line、Cutter、Armed schooner。 |
| Rank | TEXT | text |  |  | 船长军衔或职级。 样例值：Midshipman、Lieutenant。 |

样例数据（前 5 行）：

| Captain_ID | Name | Ship_ID | age | Class | Rank |
| --- | --- | --- | --- | --- | --- |
| 1 | Captain Sir Henry Langford | 1 | 40 | Third-rate ship of the line | Midshipman |
| 2 | Captain Beves Conway | 2 | 54 | Third-rate ship of the line | Midshipman |
| 3 | Lieutenant Hugh Bolitho | 3 | 43 | Cutter | Midshipman |
| 4 | Lieutenant Montagu Verling | 4 | 45 | Armed schooner | Midshipman |
| 5 | Captain Henry Dumaresq | 5 | 38 | Frigate | Lieutenant |

## 7. SQL 生成注意事项

- `captain.Ship_ID` 连接 `Ship.Ship_ID` 后才能按船舶类型、旗国或建造年份筛选船长。
- `Ship.Class` 和 `captain.Class` 含义不同，前者偏船级/船舶分类，后者偏船长关联的舰船等级描述。
- 问 youngest/oldest captain 时，`captain.age` 是文本数字，使用 `CAST(age AS INTEGER)` 更稳。
- 若题目问“由最年轻/最年长船长指挥的船”，注意是否需要保留并列最小/最大年龄：题目若未指定只取一条，可用子查询 `WHERE CAST(age AS INTEGER) = (SELECT MIN(...))`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
