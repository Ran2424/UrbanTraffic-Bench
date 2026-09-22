# 任务格式

`tasks/tasks.jsonl` 是 UrbanTraffic-Bench 的任务主文件，每行对应一道交通业务问题。

## 主要字段

| 字段 | 必需 | 说明 |
|---|---|---|
| `task_id` | 是 | 稳定题号：`S01–S40`、`X01–X30` 或 `G01–G30` |
| `question` | 是 | 交通业务问题 |
| `supplementary_notes` | 是 | 时间、空间、候选集合、并列和观测边界等计算条件 |
| `output_contract` | 是 | 必需输出字段、类型、可空性、精度和行选取规则 |
| `gold_sql` | 是 | 参考 SQLite 查询，不要求参评系统复现同一写法 |
| `result_ref` | 是 | 相对项目根目录的参考结果路径 |
| `schema_ref` | 是 | 相对项目根目录的 schema 路径 |
| `knowledge_ref` | 是 | 相对项目根目录的公共口径说明路径 |
| `scenario` / `scenario_zh` | 是 | 单方式、多方式或空间关联任务 |
| `difficulty` | 是 | 简、中或难 |
| `evaluation_policy` | 是 | 字段映射、行顺序、重复行、数值容差和空值的比较规则 |
| `review_status` | 是 | 人工审核状态 |

## 任务类型

- `single_mode`：单方式任务，40 道。
- `cross_modal`：多方式任务，30 道。
- `spatial_gis`：空间关联任务，30 道。

三类任务反映完成问题所需的数据关系，不等同于 SQL 语法难度。

## 结果契约

`output_contract.columns` 逐列规定字段名、数据类型和可空性，可选项包括小数位数、枚举值和固定 Top-K 规则。`evaluation_policy` 规定评分器如何比较参评结果与参考结果。完整 JSON Schema 见 [`docs/task.schema.json`](task.schema.json)。

CSV 和 `tasks/by_category/` 是从主文件导出的视图，不单独维护版本。
