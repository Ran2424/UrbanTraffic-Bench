# 项目结构

## 设计目标

UrbanTraffic-Bench 围绕一个上海多方式交通数据库组织 100 道交通业务分析任务。每道任务同时固化业务问题、计算条件、结果契约、参考查询和参考结果，支持按最终分析结果评分。

当前项目只有一个评测主体，不再区分两个 track。原公开 Text-to-SQL 数据只作为历史归档保存。

## 活跃内容

| 路径 | 作用 |
|---|---|
| `tasks/tasks.jsonl` | 100 道任务的唯一结构化主文件 |
| `tasks/by_category/` | 按单方式、多方式和空间关联导出的任务视图 |
| `题库.md` | 用于人工审阅的题库清单 |
| `database_files/` | 上海精简评测库压缩包 |
| `schemas/` | 表结构、字段口径和数据规模 |
| `knowledge/` | 题库公共时间、缺失值、Top-K 和分类口径 |
| `sql/` | 100 份逐题参考 SQL |
| `results/` | 100 份参考执行结果与 Top-K 边界兼容数据 |
| `baselines/four_models_v2/` | 当前论文使用的四模型、两种方法评测记录 |
| `metadata/` | 版本、校验和审核状态 |

`tasks/tasks.jsonl` 是题目主数据。CSV、分类 JSONL、逐题 SQL 和参考结果必须与主文件保持一致，不应作为独立版本维护。

## 归档内容

`archive/open_source_sql/` 保留原双轨版本中的 Spider 和 BIRD 交通相关数据、schema、题目和修订记录。`archive/legacy_baselines/` 保留早期三模型增量结果。两类归档均不参与当前版本校验和主指标计算。
