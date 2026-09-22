# UrbanTraffic-Bench

UrbanTraffic-Bench 是一个城市交通业务数据分析评测集。它以 2026 年 8 月 24 日上海五种交通方式数据为评测环境，包含 100 道交通业务问题、参考 SQL、参考结果和评分规则。

评测对象是模型能否交付符合业务口径的分析结果，SQL 是完成任务的实现方式。参评查询与参考查询的写法可以不同，只要执行结果满足题目的字段、类型、数值和行集合契约，即可判定为正确。

## 评测构成

| 任务类型 | 题号 | 数量 | 主要内容 |
|---|---|---:|---|
| 单方式 | `S01–S40` | 40 | 单一交通方式的总量、时段、排名、峰值和观测完整性 |
| 多方式 | `X01–X30` | 30 | 不同交通方式之间的时间对齐、共同观测范围、占比和联合排名 |
| 空间关联 | `G01–G30` | 30 | 站点缓冲区、最近邻、距离分环、空间归属和时空联合分析 |

单方式题在地铁、公交、出租车、网约车和共享单车中均衡分布，每种方式 8 题。整个题库包含简单题 12 道、中等题 40 道和困难题 48 道。

## 数据与任务

评测数据库为 SQLite 文件，共有 10 张表，包含地铁、公交、出租车、网约车和共享单车的小时级数据，以及地铁站与网格、公交线路和其他地铁站之间的预计算距离。

每道题包含：

- `question`：需要回答的交通业务问题；
- `supplementary_notes`：日期、时段、空间范围、候选集合和并列处理等计算条件；
- `output_contract`：输出字段、数据类型、精度和 Top-K 规则；
- `gold_sql` 与 `result_ref`：可重执行的参考查询和参考结果。

题目详细说明见 [题库](题库.md)，结构化主文件为 [`tasks/tasks.jsonl`](tasks/tasks.jsonl)。

## 仓库结构

```text
UrbanTraffic-Bench/
├── tasks/              # 100 道任务及分类视图
├── database_files/     # 上海评测数据库压缩包
├── schemas/            # 数据库结构与字段口径
├── knowledge/          # 评测公共口径
├── sql/                # 逐题参考 SQL
├── results/            # 逐题参考结果
├── baselines/          # 论文使用的四模型系统比较记录
├── evaluation/         # 评分与结果提交约定
├── docs/               # 结构、数据、任务格式和评测协议
├── metadata/           # 版本、校验和审核状态
├── archive/            # 不参与当前评测的历史资料
└── scripts/            # 发布校验脚本
```

## 快速检查

数据库压缩包由 Git LFS 管理。拉取数据后解压：

```bash
git lfs pull
7z x database_files/archives/shanghai_multimodal__20260824.7z -odatabase_files
```

执行发布校验：

```bash
/Users/ran/WorkSpace/SoftWare/miniconda3/envs/research/bin/python3.10 scripts/validate_release.py
```

校验项包括 100 道题的编号、分类、输出契约、参考 SQL、参考结果、数据库压缩包和基线记录。

## 评测方式

论文使用同一套 100 道题比较两种方式：

- **Text2SQL**：模型获取题目、数据说明和完整表结构，直接生成 SQLite 查询；
- **TransportX Agent**：Agent 围绕交通业务问题读取数据资料、执行查询、根据反馈调整并交付可复核结果。

四种基础模型的 800 条题目级记录位于 [`baselines/four_models_v2/`](baselines/four_models_v2/)。该数据包在历史全量记录上更新了 5 道多方式题，用于当前论文的正确率分析；它不是在单一提示词版本上完成的 100 题全量重测。

## 发布状态与边界

- 100 道参考 SQL 均可执行，参考结果均非空。
- 当前题库状态为 `pending_two_person_review`，尚未完成双人独立审核。
- 当前评测反映上海单日数据与受控任务环境下的表现，不用于推断上海交通运行规律。
- 数据发布授权、许可和脱敏说明确认前，本仓库保持候选版本状态，不声明为已正式开放的数据集。

## 历史归档

原 TrafficSQL-Bench 中基于 Spider 和 BIRD 的 27 个公开数据库及 1,696 道题已移入 [`archive/open_source_sql/`](archive/open_source_sql/)。它们仅用于历史追溯，不属于 UrbanTraffic-Bench 的当前题库，不参与正确率或综合指标计算。
