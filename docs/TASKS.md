# Task 格式说明

发布包中的 task 采用瘦身格式，保留问题、gold SQL、schema 引用和执行校核摘要，不保留大体量完整查询结果。

## 字段

| 字段 | 含义 |
|---|---|
| `task_id` | 规范化任务 ID。 |
| `source` | 数据来源，`spider_data` 或 `train`。 |
| `split` | 原始 split。 |
| `db_id` | 原始数据集中的数据库 ID。 |
| `database_uid` | 发布包内唯一数据库 ID。 |
| `scenario` | 场景 ID。 |
| `scenario_zh` | 中文场景名。 |
| `question` | 自然语言问题。 |
| `gold_sql` | 标准 SQL。 |
| `evidence` | BIRD 样本中的 evidence 或补充条件；Spider 样本通常为空。 |
| `schema_ref` | 对应 schema JSON 文件。 |
| `knowledge_ref` | 对应数据库知识文件。 |
| `execution_status` | gold SQL 在整理阶段的执行状态。 |
| `result_mode` | `full_rows` 表示原结果不超过阈值；`verification_only` 表示只保留行数校核。 |
| `result_row_count` | gold SQL 返回行数。 |
| `verification_sql` | 大结果任务的行数校核 SQL。 |

## 示例

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
  "evidence": null,
  "original_sample_index": 0,
  "original_source_path": "spider_data/train_spider_traffic.json",
  "schema_ref": "schemas/by_database/spider_data__bike_1.json",
  "schema_markdown_ref": "schemas/by_database/spider_data__bike_1.md",
  "knowledge_ref": "knowledge/by_database/spider_data__bike_1_knowledge_database.md",
  "execution_status": "ok",
  "result_mode": "full_rows",
  "result_columns": [
    "date"
  ],
  "result_row_count": 179,
  "verification_sql": null,
  "verification_result_row_count": null
}
```
