# 数据来源与使用说明

## 数据来源

TrafficSQL-Bench 基于公开 Text-to-SQL 数据集中的交通相关数据库和问题整理而成，主要包括：

- Spider traffic subset
- BIRD train traffic subset

本数据集将这些交通相关样本整理为统一的数据库 ID、场景标签、schema 文件、task 文件和数据库知识说明。使用、发布或引用本数据集时，请同时遵守原始数据集的许可证和引用要求。

## 数据集内容

本仓库包含以下核心内容：

- `tasks/`：自然语言问题、gold SQL、schema 引用、数据库知识引用和执行校核摘要。
- `schemas/`：每个数据库的表结构说明，提供 JSON 与 Markdown 两种格式。
- `knowledge/`：每个数据库的业务知识说明，可用于 knowledge-enhanced Text-to-SQL。
- `metadata/`：场景、数据库和 task 的映射清单。
- `database_files/archives/`：逐库 `.7z` 数据库压缩包。

数据库压缩包中通常包含 SQLite 数据库文件、`database.json`、`knowledge.md` 和 `knowledge_database.md`。使用者可以只下载需要的数据库压缩包，也可以基于 `tasks/by_scenario/` 或 `tasks/by_database/` 做分场景、分数据库评测。

## Task 修订说明

`tasks/` 目录中的 task 是 TrafficSQL-Bench 的正式评测任务。数据整理过程中，部分原始问题文本或 gold SQL 经过人工校核与修订，以减少题意歧义、SQL 明显错误和大结果校核口径不一致等问题。

当前共 `223` 条 task 带有修订追踪字段，其中：

- 修订问题文本：`17` 条
- 修订 gold SQL：`220` 条
- 同时修订问题文本和 gold SQL：`15` 条

评测时应以本仓库 `tasks/*.jsonl` 中的 `question` 和 `gold_sql` 为准。对于修订过的 task，相关追踪字段包括：

- `is_corrected`
- `correction_type`
- `correction_category`
- `correction_reason`
- `original_question`
- `original_gold_sql`

这些字段用于说明修订原因和保留修订前内容，不应替代正式评测字段。

## 数据库文件说明

SQLite 数据库按数据库分别压缩为 `.7z` 文件，存放在 `database_files/archives/`。压缩包信息可通过以下清单查看：

- `database_files/database_files_manifest.csv`
- `database_files/archives_manifest.csv`
- `database_files/archives_manifest.json`

`archives_manifest.csv` 和 `archives_manifest.json` 记录压缩包大小、压缩比、SHA256 和包含文件，便于下载后做完整性校验。
