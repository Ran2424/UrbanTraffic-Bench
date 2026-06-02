# Traffic Text-to-SQL Benchmark Release

这是一个面向交通领域 Text-to-SQL / NL2SQL 评测的整理版 benchmark 发布包。它从 `Data/normalized_text2sql_tasks/` 中抽取并重组得到，原始数据目录未被移动或修改。

## 数据规模

- 数据库：28 个
- 场景：7 个
- Task：1714 条
- Spider 交通子集 task：1153 条
- BIRD train 交通子集 task：561 条
- 完整结果 task：1686 条
- 大结果校核 task：28 条

## 目录结构

```text
traffic_text2sql_benchmark_release/
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
    database_files_manifest.csv
    archives_manifest.csv
    archives/<database_uid>.7z
```

## 推荐使用方式

1. 从 `metadata/databases.csv` 查看数据库、场景、schema、task 数和 SQLite 文件信息。
2. 从 `tasks/tasks.jsonl` 读取全部问题和 gold SQL。
3. 从 `schemas/by_database/` 读取每个数据库的 schema。
4. 从 `tasks/by_database/` 或 `tasks/by_scenario/` 做分库、分场景评测。
5. 如需执行 SQL，可直接解压 `database_files/archives/<database_uid>.7z`，或根据 `database_files/database_files_manifest.csv` 配置原始 SQLite 文件路径。

## 重要说明

本发布包已按数据库分别生成 `.7z` 压缩包。压缩包位于 `database_files/archives/`，每个压缩包包含对应数据库的 `.sqlite`、`database.json`、`knowledge.md` 和 `knowledge_database.md`。

- SQLite 原始总大小约 5.0GB
- 逐库 `.7z` 压缩包共 28 个
- 压缩后总大小约 258.5MB
- 压缩包清单：`database_files/archives_manifest.csv`

解压示例：

```bash
7z x database_files/archives/spider_data__bike_1.7z -odatabase_layer/spider_data__bike_1
```
