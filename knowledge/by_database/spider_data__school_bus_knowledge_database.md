# 数据库知识说明：spider_data__school_bus

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__school_bus |
| source | spider_data |
| db_id | school_bus |
| database_dir | database_layer/spider_data__school_bus |
| sqlite_path | database_layer/spider_data__school_bus/school_bus.sqlite |
| table_count | 3 |
| scenario_id | public_service_transport |
| scenario_name | 公共服务运输 |
| scenario_description | 校车服务、学校、司机、工龄和全职状态。 |

## 2. 业务子场景说明

本库聚焦“公共服务运输”子场景，核心对象包括校车司机、学校、校车服务关系等。它适合回答关于校车服务、学校、司机、工龄和全职状态的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `school_bus`
- database_dir: `database_layer/spider_data__school_bus`
- db_path: `database_layer/spider_data__school_bus/school_bus.sqlite`
- original_db_path: `spider_data/spider_data/database/school_bus/school_bus.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| driver | 校车司机基础信息。 | 5 | 12 |
| school | 学校基础信息。 | 5 | 7 |
| school_bus | 学校与校车司机的服务关系。 | 4 | 5 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| school_bus.School_ID | school.School_ID |
| school_bus.Driver_ID | driver.Driver_ID |

## 6. 表与字段说明

### 6.1 `driver`

- 表含义：校车司机基础信息。
- 行数：`12`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Driver_ID | INT | number | PK |  | 校车司机的唯一编号，用于标识一条校车司机记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Matthew Ritter、Dan Carter、Minnie Gonzalez。 |
| Party | TEXT | text |  |  | 司机所属党派或政治派别，样例为 Dem、Rep。 |
| Home_city | TEXT | text |  |  | 城市名称。 样例值：Hartford、Bethel。 |
| Age | INT | number |  |  | 年龄。 样例值：40、30、46。 |

样例数据（前 5 行）：

| Driver_ID | Name | Party | Home_city | Age |
| --- | --- | --- | --- | --- |
| 1 | Matthew Ritter | Dem | Hartford | 40 |
| 2 | Dan Carter | Rep | Bethel | 30 |
| 3 | Minnie Gonzalez | Dem | Hartford | 46 |
| 4 | Angel Acre | Dem | Hartford | 42 |
| 5 | Brandon McGee | Dem | Hartford | 45 |

### 6.2 `school`

- 表含义：学校基础信息。
- 行数：`7`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| School_ID | INT | number | PK |  | 学校的唯一编号，用于标识一条学校记录。 样例值：1、2、3。 |
| Grade | TEXT | text |  |  | 学校对应的就读年级或教育阶段。 样例值：Kindergarten、1st-3rd grade、4th grade。 |
| School | TEXT | text |  |  | 学校名称。 样例值：Noelani Elementary School、St. Francis Assisi、State Elementary School Menteng 01。 |
| Location | TEXT | text |  |  | 地点或城市位置。 样例值：Honolulu, Hawaii、Jakarta, Indonesia、Los Angeles, California。 |
| Type | TEXT | text |  |  | 学校类型，例如公立、私立或私立天主教学校。 样例值：Public、Private Catholic、Private。 |

样例数据（前 5 行）：

| School_ID | Grade | School | Location | Type |
| --- | --- | --- | --- | --- |
| 1 | Kindergarten | Noelani Elementary School | Honolulu, Hawaii | Public |
| 2 | 1st-3rd grade | St. Francis Assisi | Jakarta, Indonesia | Private Catholic |
| 3 | 4th grade | State Elementary School Menteng 01 | Jakarta, Indonesia | Public |
| 4 | 5th-12th grade | Punahou School | Honolulu, Hawaii | Private |
| 5 | Freshman–Sophomore year | Occidental College | Los Angeles, California | Private |

### 6.3 `school_bus`

- 表含义：学校与校车司机的服务关系。
- 行数：`5`
- 字段数：`4`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| School_ID | INT | number | PK, FK | school.School_ID | 外键，指向 `school.School_ID`，表示本记录关联的学校。 |
| Driver_ID | INT | number | PK, FK | driver.Driver_ID | 外键，指向 `driver.Driver_ID`，表示本记录关联的校车司机。 |
| Years_Working | INT | number |  |  | 司机为对应学校提供校车服务的工作年数。 样例值：10、8、6。 |
| If_full_time | bool | others |  |  | 是否全职提供服务，T 表示是，F 表示否。 |

样例数据（前 5 行）：

| School_ID | Driver_ID | Years_Working | If_full_time |
| --- | --- | --- | --- |
| 1 | 10 | 10 | F |
| 5 | 7 | 8 | T |
| 3 | 4 | 6 | T |
| 7 | 9 | 2 | T |
| 4 | 3 | 3 | T |

## 7. SQL 生成注意事项

- `school_bus` 是学校与司机关系表，复合主键包含学校和司机；统计学校或司机时注意去重。
- `If_full_time` 使用 T/F 文本表示是否全职，不是 1/0。
- `driver.Party` 是党派缩写，不能当作驾驶班次或团队字段。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
