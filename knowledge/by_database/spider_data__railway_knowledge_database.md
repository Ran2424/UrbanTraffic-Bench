# 数据库知识说明：spider_data__railway

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__railway |
| source | spider_data |
| db_id | railway |
| database_dir | database_layer/spider_data__railway |
| sqlite_path | database_layer/spider_data__railway/railway.sqlite |
| table_count | 4 |
| scenario_id | rail_transport |
| scenario_name | 铁路、列车与管理者 |
| scenario_description | 铁路车辆、列车班次、到达时间、管理者和管理年份。 |

## 2. 业务子场景说明

本库聚焦“铁路、列车与管理者”子场景，核心对象包括管理者、铁路车辆、铁路管理关系、列车等。它适合回答关于铁路车辆、列车班次、到达时间、管理者和管理年份的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `railway`
- database_dir: `database_layer/spider_data__railway`
- db_path: `database_layer/spider_data__railway/railway.sqlite`
- original_db_path: `spider_data/spider_data/database/railway/railway.sqlite`
- schema_source_path: `spider_data/tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| manager | 铁路管理者基础信息。 | 6 | 7 |
| railway | 铁路车辆或铁路藏品基础信息。 | 7 | 10 |
| railway_manage | 铁路与管理者的管理起始年份关系。 | 3 | 4 |
| train | 列车班次或列车服务基础信息。 | 6 | 9 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| railway_manage.Railway_ID | railway.Railway_ID |
| railway_manage.Manager_ID | manager.Manager_ID |
| train.Railway_ID | railway.Railway_ID |

## 6. 表与字段说明

### 6.1 `manager`

- 表含义：铁路管理者基础信息。
- 行数：`7`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Manager_ID | INT | number | PK |  | 管理者的唯一编号，用于标识一条管理者记录。 样例值：1、2、3。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Ben Curtis、Todd Hamilton、Tiger Woods。 |
| Country | TEXT | text |  |  | 国家或地区。 样例值：United States、Scotland。 |
| Working_year_starts | TEXT | text |  |  | 管理者开始工作的年份。 样例值：2003、2004、2006。 |
| Age | INT | number |  |  | 年龄。 样例值：45、55、46。 |
| Level | INT | number |  |  | 管理者等级。 样例值：5、7、8。 |

样例数据（前 5 行）：

| Manager_ID | Name | Country | Working_year_starts | Age | Level |
| --- | --- | --- | --- | --- | --- |
| 1 | Ben Curtis | United States | 2003 | 45 | 5 |
| 2 | Todd Hamilton | United States | 2004 | 55 | 5 |
| 3 | Tiger Woods | United States | 2006 | 46 | 5 |
| 4 | David Duval | United States | 2001 | 47 | 7 |
| 5 | Sandy Lyle | Scotland | 1985 | 48 | 8 |

### 6.2 `railway`

- 表含义：铁路车辆或铁路藏品基础信息。
- 行数：`10`
- 字段数：`7`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Railway_ID | INT | number | PK |  | 铁路车辆的唯一编号，用于标识一条铁路车辆记录。 样例值：1、2、3。 |
| Railway | TEXT | text |  |  | 铁路车辆或铁路公司简称。 样例值：SECR、MR、GNRD。 |
| Builder | TEXT | text |  |  | 建造商。 样例值：SECR Ashford、MR Derby、GNR Doncaster。 |
| Built | TEXT | text |  |  | 建造年份或建造说明。 样例值：1901、1902 Midland Railway 1000 was rebuilt in 1914.、1902。 |
| Wheels | TEXT | text |  |  | 轮式或轴式配置。 样例值：4-4-0、4-4-2、0-6-0T。 |
| Location | TEXT | text |  |  | 地点或城市位置。 样例值：York、Bo'ness、Barrow Hill。 |
| ObjectNumber | TEXT | text |  |  | 藏品或对象编号。 样例值：1975-7006、1975-7018、1975-7005。 |

样例数据（前 5 行）：

| Railway_ID | Railway | Builder | Built | Wheels | Location | ObjectNumber |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | SECR | SECR Ashford | 1901 | 4-4-0 | York | 1975-7006 |
| 2 | MR | MR Derby | 1902 Midland Railway 1000 was rebuilt in 1914. | 4-4-0 | Bo'ness | 1975-7018 |
| 3 | GNRD | GNR Doncaster | 1902 | 4-4-2 | Barrow Hill | 1975-7005 |
| 4 | GWRS | GWR Swindon | 1903 | 4-4-0 | Toddington | 1978-7025 |
| 5 | GERSt | GER Stratford | 1904 | 0-6-0T | Bressingham | 1975-7003 |

### 6.3 `railway_manage`

- 表含义：铁路与管理者的管理起始年份关系。
- 行数：`4`
- 字段数：`3`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Railway_ID | INT | number | PK, FK | railway.Railway_ID | 外键，指向 `railway.Railway_ID`，表示本记录关联的铁路车辆。 |
| Manager_ID | INT | number | PK, FK | manager.Manager_ID | 外键，指向 `manager.Manager_ID`，表示本记录关联的管理者。 |
| From_Year | TEXT | text |  |  | 管理关系开始年份。 样例值：2010、2011、2012。 |

样例数据（前 5 行）：

| Railway_ID | Manager_ID | From_Year |
| --- | --- | --- |
| 8 | 1 | 2010 |
| 9 | 2 | 2011 |
| 7 | 3 | 2012 |
| 2 | 4 | 2013 |

### 6.4 `train`

- 表含义：列车班次或列车服务基础信息。
- 行数：`9`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Train_ID | INT | number | PK |  | 列车的唯一编号，用于标识一条列车记录。 样例值：1、2、3。 |
| Train_Num | TEXT | text |  |  | 列车车次号。 样例值：51195、12139、12140。 |
| Name | TEXT | text |  |  | 名称或姓名。 样例值：Wardha-Ballarshah Pass、Sewagram Exp、Ballarshah-Mumbai Pass。 |
| From | TEXT | text |  |  | 列车出发地；SQL 中建议加双引号。 样例值：Wardha、Mumbai CST、Ballarshah。 |
| Arrival | TEXT | text |  |  | 列车到达时间。 样例值：08:54、09:08、09:48。 |
| Railway_ID | INT | number | FK | railway.Railway_ID | 外键，指向 `railway.Railway_ID`，表示本记录关联的铁路车辆。 |

样例数据（前 5 行）：

| Train_ID | Train_Num | Name | From | Arrival | Railway_ID |
| --- | --- | --- | --- | --- | --- |
| 1 | 51195 | Wardha-Ballarshah Pass | Wardha | 08:54 | 1 |
| 2 | 12139 | Sewagram Exp | Mumbai CST | 09:08 | 1 |
| 3 | 12140 | Ballarshah-Mumbai Pass | Ballarshah | 09:48 | 2 |
| 4 | 57135 | Nagpur-Kazipet Pass | Nagpur | 23:44 | 3 |
| 5 | 57136 | Kazipet-Nagpur Pass | Kazipet | 05:09 | 5 |

## 7. SQL 生成注意事项

- `train.From` 字段名是 SQL 关键字，建议写成 `"From"`。
- `railway.Built` 可能包含年份加说明文本，不能直接全部当作整数年份。
- `railway_manage` 是铁路与管理者关系表，按管理者统计铁路数量时注意去重。
- 问 manager oldest/youngest 时按 `manager.Age` 排序；`Working_year_starts` 表示开始工作年份，不表示年龄。
- 以下表名或字段名含空格、特殊字符或关键字，SQL 中建议加双引号：`train.From`。
- 日期/时间多为文本字段：`train.Arrival`；做范围筛选或排序前需确认格式。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体题目的隐含口径仍需结合 `task_knowledge/`、`task_fix/` 和正式评测记录判断。
