# Task 格式说明

发布包中的 task 采用瘦身格式，保留问题、gold SQL、schema 引用、执行校核摘要和修订追踪字段，不保留大体量完整查询结果。

## 来源与修订口径

`tasks/` 目录中的 task 使用修订后的正式发布口径，不是未经修订的原始 Spider/BIRD 样本。

生成逻辑：

1. 以 `Data/normalized_text2sql_tasks/tasks/` 的规范化 task 为底稿。
2. 如果 `Data/normalized_text2sql_tasks/task_fix/<task_id>/<task_id>.fixed.json` 存在，则使用该 fixed 版本覆盖 question、gold SQL、evidence 和执行校核结果。
3. 将覆盖后的正式版本导出到本仓库。

当前共应用 `223` 条 task 修订：

- 修订问题文本：`17` 条
- 修订 gold SQL：`220` 条
- 同时修订问题文本和 gold SQL：`15` 条

因此，评测时应以本仓库 `tasks/*.jsonl` 中的 `question` 和 `gold_sql` 为准。对于 `is_corrected = true` 的 task，可通过 `original_question` 和 `original_gold_sql` 回看修订前内容。

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
| `is_corrected` | 是否应用过人工修订。 |
| `correction_category` | 修订类别，例如 gold SQL 错误、题目歧义、评测标准问题等。 |
| `correction_type` | 修订类型，例如 `sql`、`question`、`question_and_sql`、`sql_large_result`。 |
| `correction_reason` | 修订原因说明。 |
| `original_question` | 修订前的问题文本；仅修订过的 task 非空。 |
| `original_gold_sql` | 修订前的 gold SQL；仅修订过的 task 非空。 |

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
  "verification_result_row_count": null,
  "is_corrected": false,
  "correction_category": null,
  "correction_type": null,
  "correction_reason": null,
  "original_question": null,
  "original_gold_sql": null
}
```
