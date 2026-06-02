# TrafficSQL-Bench

**TrafficSQL-Bench** 是一个面向交通领域的 Text-to-SQL / NL2SQL 基准数据集。数据集整理自公开 Spider 与 BIRD 交通相关子集，覆盖机场航空、铁路交通、共享单车、道路车辆、船运物流、公共服务、赛车竞赛等 7 类交通场景。

本仓库已经整理好数据库 schema、自然语言问题、gold SQL、数据库知识说明，以及逐库压缩后的 SQLite 数据库文件。

## 数据规模

- 数据库：28 个
- 场景：7 个
- Task：1714 条
- Spider 交通子集 task：1153 条
- BIRD train 交通子集 task：561 条
- 完整结果 task：1686 条
- 大结果校核 task：28 条
- 修订后 task：223 条
- 其中修订问题文本：17 条
- 其中修订 gold SQL：220 条
- SQLite 原始总大小：约 5.0GB
- 逐库 `.7z` 压缩包：28 个，压缩后总大小约 258.5MB

## Task 来源与修订说明

本仓库发布的 task **不是未经修订的原始 Spider/BIRD 问题集合**。发布版使用的是修订后的正式版本：

1. 先以 `Data/normalized_text2sql_tasks/tasks/` 中的规范化 task 为底稿；
2. 再对存在修复记录的 task，使用 `Data/normalized_text2sql_tasks/task_fix/<task_id>/<task_id>.fixed.json` 覆盖对应的 question、gold SQL、evidence 和执行校核结果；
3. 最终导出为本仓库中的 `tasks/tasks.jsonl`、`tasks/tasks.csv`、`tasks/by_database/*.jsonl` 和 `tasks/by_scenario/*.jsonl`。

因此，`tasks/` 目录中的 `question` 与 `gold_sql` 是当前 benchmark 的正式评测口径。为便于追溯，修订过的 task 额外保留了：

- `is_corrected`
- `correction_type`
- `correction_category`
- `correction_reason`
- `original_question`
- `original_gold_sql`

修订类型包括 gold SQL 修正、问题文本修正、大结果校核口径修正，以及 question + SQL 同步修正。

## 场景

| 场景 ID | 中文场景名 | 数据库数 | Task 数 |
|---|---|---:|---:|
| `aviation_airport` | 机场航空 | 8 | 512 |
| `rail_train_station` | 铁路交通 | 3 | 84 |
| `bike_micromobility` | 共享单车 | 2 | 217 |
| `road_vehicle_business` | 道路车辆 | 5 | 388 |
| `maritime_shipping_logistics` | 船运物流 | 4 | 262 |
| `public_service_transport` | 公共服务 | 1 | 18 |
| `racing_competition` | 赛车竞赛 | 5 | 233 |

更完整的数据库与场景清单见：

- `docs/DATABASES.md`
- `docs/SCENARIOS.md`

## 问题示例

### 共享单车

```json
{
  "task_id": "task_000036",
  "database_uid": "spider_data__bike_1",
  "question": "What are the names and ids of all stations that have more than 14 bikes available on average or had bikes installed in December?",
  "gold_sql": "SELECT T1.name ,  T1.id FROM station AS T1 JOIN status AS T2 ON T1.id  =  T2.station_id GROUP BY T2.station_id HAVING avg(T2.bikes_available)  >  14 UNION SELECT name ,  id FROM station WHERE installation_date LIKE \"12/%\""
}
```

### 机场航空

```json
{
  "task_id": "task_001551",
  "database_uid": "train__airline",
  "question": "On August 2018, which day had the highest number of cancelled flights due to the most serious reasons in Dallas/Fort Worth International?",
  "gold_sql": "SELECT T2.FL_DATE FROM Airports AS T1 INNER JOIN Airlines AS T2 ON T1.Code = T2.ORIGIN WHERE T2.FL_DATE LIKE '2018/8%' AND T1.Description = 'Dallas/Fort Worth, TX: Dallas/Fort Worth International' AND T2.ORIGIN = 'DFW' AND T2.CANCELLED = 1 AND T2.CANCELLATION_CODE = 'A' GROUP BY T2.FL_DATE ORDER BY COUNT(T2.FL_DATE) DESC LIMIT 1"
}
```

### 道路车辆

```json
{
  "task_id": "task_001257",
  "database_uid": "train__car_retails",
  "question": "Of the clients whose businesses are located in the city of Boston, calculate which of them has a higher average amount of payment.",
  "gold_sql": "SELECT T1.customerNumber FROM customers AS T1 INNER JOIN payments AS T2 ON T1.customerNumber = T2.customerNumber WHERE T1.city = 'Boston' GROUP BY T1.customerNumber ORDER BY SUM(T2.amount) / COUNT(T2.paymentDate) DESC LIMIT 1"
}
```

### 铁路交通

```json
{
  "task_id": "task_001161",
  "database_uid": "train__trains",
  "question": "Please list the IDs of all the trains that run in the east direction and have less than 4 cars.",
  "gold_sql": "SELECT T1.id FROM trains AS T1 INNER JOIN ( SELECT train_id, MAX(position) AS carsNum FROM cars GROUP BY train_id ) AS T2 ON T1.id = T2.train_id WHERE T1.direction = 'east' AND T2.carsNum < 4"
}
```

完整 task 文件见：

- `tasks/tasks.jsonl`
- `tasks/tasks.csv`
- `tasks/by_database/<database_uid>.jsonl`
- `tasks/by_scenario/<scenario>.jsonl`

## 目录结构

```text
TrafficSQL-Bench/
  README.md
  docs/
    DATABASES.md
    SCENARIOS.md
    TASKS.md
    OPEN_SOURCE_NOTES.md
  metadata/
    benchmark_summary.json
    databases.csv
    databases.jsonl
    scenarios.csv
    scenarios.json
    database_task_map.csv
  schemas/
    all_schemas.json
    all_schemas.md
    by_database/<database_uid>.json
    by_database/<database_uid>.md
  tasks/
    tasks.jsonl
    tasks.csv
    by_database/<database_uid>.jsonl
    by_scenario/<scenario>.jsonl
  knowledge/
    by_database/<database_uid>_knowledge_database.md
  database_files/
    README.md
    database_files_manifest.csv
    archives_manifest.csv
    archives_manifest.json
    archives/<database_uid>.7z
```

## 文件说明

- `tasks/tasks.jsonl`：全部自然语言问题、gold SQL、schema 引用、执行校核摘要。
- `schemas/by_database/`：每个数据库的 schema，提供 JSON 与 Markdown 两种格式。
- `knowledge/by_database/`：每个数据库的业务知识说明，可用于 knowledge-enhanced Text-to-SQL。
- `metadata/databases.csv`：数据库清单，包括场景、来源、表数、字段数、task 数、SQLite 大小。
- `metadata/database_task_map.csv`：数据库、task、问题、schema 的映射关系。
- `database_files/archives/`：每个数据库一个 `.7z` 压缩包。
- `database_files/archives_manifest.csv`：压缩包大小、压缩比、SHA256 与包含文件清单。

## 使用方式

### 读取全部 task

```python
import json
from pathlib import Path

tasks = []
for line in Path("tasks/tasks.jsonl").open():
    tasks.append(json.loads(line))

print(len(tasks))
print(tasks[0]["question"])
print(tasks[0]["gold_sql"])
```

### 解压单个数据库

```bash
7z x database_files/archives/spider_data__bike_1.7z -odatabase_layer/spider_data__bike_1
```

每个压缩包包含：

- `.sqlite`
- `database.json`
- `knowledge.md`
- `knowledge_database.md`

### 按场景评测

```text
tasks/by_scenario/aviation_airport.jsonl
tasks/by_scenario/bike_micromobility.jsonl
tasks/by_scenario/road_vehicle_business.jsonl
```

### 按数据库评测

```text
tasks/by_database/spider_data__bike_1.jsonl
tasks/by_database/train__airline.jsonl
tasks/by_database/train__shipping.jsonl
```

## Task 格式

每条 task 保留问题、gold SQL、schema 引用和执行校核摘要。示例字段：

```json
{
  "task_id": "task_000001",
  "source": "spider_data",
  "split": "train",
  "db_id": "bike_1",
  "database_uid": "spider_data__bike_1",
  "scenario": "bike_micromobility",
  "scenario_zh": "共享单车",
  "question": "Give me the dates when the max temperature was higher than 85.",
  "gold_sql": "SELECT date FROM weather WHERE max_temperature_f  >  85",
  "schema_ref": "schemas/by_database/spider_data__bike_1.json",
  "knowledge_ref": "knowledge/by_database/spider_data__bike_1_knowledge_database.md",
  "execution_status": "ok",
  "result_mode": "full_rows",
  "result_row_count": 179,
  "is_corrected": false
}
```

更完整的字段说明见 `docs/TASKS.md`。

## 数据来源

TrafficSQL-Bench 整理自公开 Text-to-SQL 数据集的交通相关子集：

- Spider traffic subset
- BIRD train traffic subset

发布或引用本 benchmark 时，请同时遵守原始数据集的许可证和引用要求。开源注意事项见 `docs/OPEN_SOURCE_NOTES.md`。
