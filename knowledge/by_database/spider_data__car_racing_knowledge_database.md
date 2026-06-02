# 数据库知识说明：spider_data__car_racing

本文档用于快速理解该 SQLite 数据库的业务含义、表结构、字段语义、样例数据和 SQL 生成注意事项。
字段含义综合 `database.json`、原始 `knowledge.md`、外键关系、字段名和样例值整理。

## 1. 数据库概览

| 项目 | 内容 |
| --- | --- |
| database_uid | spider_data__car_racing |
| source | spider_data |
| db_id | car_racing |
| database_dir | database_layer/spider_data__car_racing |
| sqlite_path | database_layer/spider_data__car_racing/car_racing.sqlite |
| table_count | 4 |
| scenario_id | racing_competition |
| scenario_name | 赛车、赛道与竞赛 |
| scenario_description | 赛车手、车队、车辆品牌、国家和车队成员关系。 |

## 2. 业务子场景说明

本库聚焦“赛车、赛道与竞赛”子场景，核心对象包括国家、赛车手、车队、车队-驾驶员关系等。它适合回答关于赛车手、车队、车辆品牌、国家和车队成员关系的查询，例如基础信息检索、数量统计、排名比较、按类别/地点/时间筛选，以及通过外键关系追踪实体之间的业务联系。

可回答的问题类型包括：

- 实体基础信息查询：按名称、编号、国家/城市、类别、年份等条件查找记录。
- 统计与排名：按实体、时间、地点或类别统计数量、求和、平均、最大/最小和排序。
- 关系追踪：通过外键或关系表查询实体之间的归属、服务、拥有、运营、停靠、租赁或参赛关系。
- 指标比较：比较客流、价格、速度、重量、积分、延误、燃油经济性、容量等业务指标。

## 3. 原始知识摘要

- source: `spider_data`
- db_id: `car_racing`
- database_dir: `database_layer/spider_data__car_racing`
- db_path: `database_layer/spider_data__car_racing/car_racing.sqlite`
- original_db_path: `spider_data/spider_data/test_database/car_racing/car_racing.sqlite`
- schema_source_path: `spider_data/test_tables_traffic.json`

No extra natural-language database description was found.
Use the database JSON record for the full schema.

## 4. 表清单

| 表名 | 表含义 | 字段数 | 行数 |
| --- | --- | --- | --- |
| country | 赛车手所属国家维表。 | 5 | 6 |
| driver | 赛车手比赛表现和车辆品牌信息。 | 9 | 10 |
| team | 赛车队及其车辆品牌、经理、赞助商和车主。 | 6 | 12 |
| team_driver | 赛车队与赛车手的成员关系。 | 2 | 10 |

## 5. 表关系

| 本表字段 | 关联到 |
| --- | --- |
| driver.Country | country.Country_ID |
| team_driver.Team_ID | team.Team_ID |
| team_driver.Driver_ID | driver.Driver_ID |

## 6. 表与字段说明

### 6.1 `country`

- 表含义：赛车手所属国家维表。
- 行数：`6`
- 字段数：`5`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Country_Id | INT | number | PK |  | 国家的唯一编号，用于标识一条国家记录。 样例值：1、2、6。 |
| Country | TEXT | text |  |  | 国家或地区。 样例值：Japan、USA、Britain。 |
| Capital | TEXT | text |  |  | 国家首都。 样例值：Tokyo、Washington、London。 |
| Official_native_language | TEXT | text |  |  | 国家官方本土语言。 样例值：Japanese、English、British English。 |
| Regoin | TEXT | text |  |  | 国家所在大区或洲区；字段名拼写为 Regoin。 样例值：Asia、North America、Europe。 |

样例数据（前 5 行）：

| Country_Id | Country | Capital | Official_native_language | Regoin |
| --- | --- | --- | --- | --- |
| 1 | Japan | Tokyo | Japanese | Asia |
| 2 | USA | Washington | English | North America |
| 6 | Britain | London | British English | Europe |
| 3 | China | Beijing | Chinese | Asia |
| 4 | Ireland | Dublin | Irish English | Europe |

### 6.2 `driver`

- 表含义：赛车手比赛表现和车辆品牌信息。
- 行数：`10`
- 字段数：`9`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Driver_ID | INT | number | PK |  | 赛车手的唯一编号，用于标识一条赛车手记录。 样例值：1、2、3。 |
| Driver | TEXT | text |  |  | 赛车手姓名。 样例值：Kasey Kahne、Matt Kenseth、Tony Stewart。 |
| Country | INT | number | FK | country.Country_ID | 外键，指向 `country.Country_ID`，表示本记录关联的国家。 |
| Age | INT | number |  |  | 年龄。 样例值：23、21、19。 |
| Car_# | REAL | number |  |  | 赛车车号。 样例值：9.0、17.0、20.0。 |
| Make | TEXT | text |  |  | 赛车手驾驶车辆品牌。 样例值：Dodge、Ford、Chevrolet。 |
| Points | TEXT | text |  |  | 比赛积分，字段类型为 TEXT；按原字段排序、聚合或比较时会遵循 SQLite 的文本口径，只有明确需要数值口径时再转换类型。 样例值：185、175、165。 |
| Laps | REAL | number |  |  | 完成圈数。 样例值：334.0。 |
| Winnings | TEXT | text |  |  | 奖金金额。 样例值：$530,164、$362,491、$286,386。 |

样例数据（前 5 行）：

| Driver_ID | Driver | Country | Age | Car_# | Make | Points | Laps | Winnings |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Kasey Kahne | 2 | 23 | 9.0 | Dodge | 185 | 334.0 | $530,164 |
| 2 | Matt Kenseth | 2 | 21 | 17.0 | Ford | 175 | 334.0 | $362,491 |
| 3 | Tony Stewart | 2 | 19 | 20.0 | Chevrolet | 175 | 334.0 | $286,386 |
| 4 | Denny Hamlin * | 2 | 25 | 11.0 | Chevrolet | 165 | 334.0 | $208,500 |
| 5 | Kevin Li | 3 | 23 | 29.0 | Chevrolet | 160 | 334.0 | $204,511 |

### 6.3 `team`

- 表含义：赛车队及其车辆品牌、经理、赞助商和车主。
- 行数：`12`
- 字段数：`6`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Team_ID | INT | number | PK |  | 车队的唯一编号，用于标识一条车队记录。 样例值：1、2、3。 |
| Team | TEXT | text |  |  | 所属团队或学校。 样例值：Arrington Racing、Benfield Racing、Blue Max Racing。 |
| Make | TEXT | text |  |  | 车队使用的车辆品牌或车型。 样例值：Chrysler Imperial、Buick Regal、Pontiac Grand Prix。 |
| Manager | TEXT | text |  |  | 车队经理姓名。 样例值：Buddy Arrington、Joe Ruttman、Tim Richmond。 |
| Sponsor | TEXT | text |  |  | 车队赞助商。 样例值：Arrington Racing、Levi Garrett、Old Milwaukee。 |
| Car_Owner | TEXT | text |  |  | 赛车所有者。 样例值：Buddy Arrington、Ron Benfield、Raymond Beadle。 |

样例数据（前 5 行）：

| Team_ID | Team | Make | Manager | Sponsor | Car_Owner |
| --- | --- | --- | --- | --- | --- |
| 1 | Arrington Racing | Chrysler Imperial | Buddy Arrington | Arrington Racing | Buddy Arrington |
| 2 | Benfield Racing | Buick Regal | Joe Ruttman | Levi Garrett | Ron Benfield |
| 3 | Blue Max Racing | Pontiac Grand Prix | Tim Richmond | Old Milwaukee | Raymond Beadle |
| 4 | Bobby Hawkins Racing | Chevrolet Monte Carlo | David Pearson | Chattanooga Chew | Bobby Hawkins |
| 5 | Bud Moore Engineering | Ford Thunderbird | Dale Earnhardt | Wrangler Jeans | Bud Moore |

### 6.4 `team_driver`

- 表含义：赛车队与赛车手的成员关系。
- 行数：`10`
- 字段数：`2`

| 字段 | 类型 | 逻辑类型 | 约束 | 关联 | 含义 |
| --- | --- | --- | --- | --- | --- |
| Team_ID | INT | number | PK, FK | team.Team_ID | 外键，指向 `team.Team_ID`，表示本记录关联的车队。 |
| Driver_ID | INT | number | PK, FK | driver.Driver_ID | 外键，指向 `driver.Driver_ID`，表示本记录关联的赛车手。 |

样例数据（前 5 行）：

| Team_ID | Driver_ID |
| --- | --- |
| 1 | 1 |
| 2 | 3 |
| 1 | 5 |
| 5 | 4 |
| 1 | 9 |

## 7. SQL 生成注意事项

- `driver.Country` 存国家编号，筛选国家名称时需连接 `country.Country_Id`。
- `team_driver` 是车队与车手关系表，连接后可能一队多车手或一车手多队，聚合时注意去重。
- `Car_#` 字段名含 `#`，SQL 中建议用双引号引用。
- `driver.Points` 在表中是 TEXT；默认按原字段进行 max/min、排序、sum/avg 和比较，不主动写 `CAST(Points AS INTEGER/REAL)`，除非自然语言问题明确要求数值化处理。
- points 极值或排序查询应只投影问题要求的实体或指标；`Points` 可作为排序字段，但不要作为解释性辅助列额外返回。
- `country.Official_native_language` 需要按完整取值精确匹配；使用模糊匹配会把 `British English`、`English Manx` 等不同语言标签混入。
- 输出列应严格匹配自然语言问题要求；`Car_Owner`、`Points` 等排序或过滤字段不要额外投影，除非问题明确要求显示。
- 以下表名或字段名含空格、特殊字符或关键字，SQL 中建议加双引号：`driver.Car_#`。

## 8. 使用提示

- 自然语言问题中的实体名称、指标名称和时间条件，建议优先映射到上方字段说明中含义明确的字段。
- 如果字段没有显式外键，但字段名包含 `_id`、`code`、`name` 等，应结合样例数据判断是否可作为连接键。
- 涉及日期、时间、单位换算、百分比、最高/最低、平均值等问题时，应额外核对字段单位和聚合粒度。
- 本文档提供数据库级知识；具体问题的隐含口径仍需结合题面措辞、字段样例和查询粒度判断。
