# 上海交通业务分析赛道

本赛道使用一个统一、精简的上海多方式交通 SQLite 数据库，评测模型能否把中文业务问题转换为可执行 SQL。

## 题库结构

| 题型 | 题号 | 数量 |
|---|---|---:|
| 单方式查询 | `S01–S40` | 40 |
| 多方式联合查询 | `X01–X30` | 30 |
| GIS 空间关联查询 | `G01–G30` | 30 |

难度分布为简 12 题、中 40 题、难 48 题。单方式题覆盖地铁、公交、出租车、网约车和共享单车，每种方式 8 题。

## 数据库

数据库包含 10 张表：

- 地铁：线路、站点、站点分线路小时客流。
- 公交：线路、线路小时客流。
- 网格交通：出租车、网约车和共享单车小时指标。
- 空间关系：地铁站—网格、地铁站—公交线路、地铁站—地铁站距离。

数据日期为 `2026-08-24`。完整结构见 `schemas/simplified_v1.md`。

解压数据库：

```bash
7z x tracks/shanghai_mobility/database_files/archives/shanghai_multimodal__20260824.7z \
  -otracks/shanghai_mobility/database_files/database
```

## 主要文件

- `tasks/tasks.jsonl`：任务主文件。
- `题库.md`：人工审阅清单。
- `sql/`：逐题标准 SQL。
- `results/`：逐题标准执行结果及 TopK 边界兼容数据。
- `mappings/legacy_task_mapping.csv`：与上一版题号和评测结果的对应关系。
- `baselines/three_models_20260910/`：DeepSeek、GPT 和 Qwen 自动评测结果。

## 当前状态

100 道标准 SQL 均已执行成功且结果非空。90 道题迁移或修订自上一版，10 道为新增题。题目目前仍处于双人审核前的候选状态，baseline 不是正式排行榜成绩。
