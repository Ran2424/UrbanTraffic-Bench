# 任务格式

## 公共字段

| 字段 | 必需 | 说明 |
|---|---|---|
| `task_id` | 是 | 赛道内稳定题号 |
| `database_uid` | 是 | 数据库唯一标识 |
| `question` | 是 | 自然语言问题 |
| `gold_sql` | 是 | 标准 SQLite 查询 |
| `schema_ref` | 是 | 相对赛道根目录的 schema 路径 |
| `knowledge_ref` | 否 | 相对赛道根目录的知识说明路径 |
| `execution_status` | 是 | 标准 SQL 校核状态 |
| `result_mode` | 是 | 完整结果或校核模式 |
| `result_columns` | 是 | 结果字段 |

## 开源赛道扩展

开源赛道保留 `source`、`split`、`db_id`、`evidence` 和修订追踪字段。历史值 `source=train` 表示 BIRD train 数据，后续统一索引时映射为 `source_dataset=bird`、`source_split=train`，不直接改写旧任务主键。

## 上海赛道扩展

上海赛道增加：

- `scenario_zh`：单方式查询、多方式联合查询或 GIS 空间关联查询。
- `difficulty`：简、中、难。
- `analysis_dimension`：时间、排名、空间聚合等分析维度。
- `legacy_task_id`：上一版题号。
- `evaluation_policy`：字段、行序、数值和 TopK 比较规则。
- `review_status`：人工审核状态。

跨赛道索引使用 `track_id + task_id` 形成全局唯一键，不要求两个赛道采用同一种本地编号格式。
