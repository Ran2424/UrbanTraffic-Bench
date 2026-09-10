# TrafficSQL-Bench

TrafficSQL-Bench 是一个面向交通领域的双轨 Text-to-SQL 基准。它同时评测模型的跨数据库 SQL 生成能力，以及模型在真实城市交通数据上的业务分析能力。

## 两个评测赛道

| 赛道 | 主要目标 | 数据库 | 题目 |
|---|---|---:|---:|
| [开源交通 SQL 生成](tracks/open_source_sql/README.md) | 在异构 schema 上完成表选择、连接、聚合、子查询等 SQL 生成 | 27 | 1,696 |
| [上海交通业务分析](tracks/shanghai_mobility/README.md) | 在统一的上海多方式交通数据库上完成单方式、多方式和 GIS 业务查询 | 1 | 100 |

第一个赛道强调跨 schema 泛化，第二个赛道强调业务口径、时间粒度、多方式联合和空间推理。两者分别计分，不按 1,796 道题直接混算正确率。

## 仓库结构

```text
TrafficSQL-Bench/
├── tracks/
│   ├── open_source_sql/       # Spider、BIRD 交通相关数据库与题目
│   └── shanghai_mobility/     # 上海多方式交通业务题库
├── docs/                      # 总体设计、任务格式和评测协议
├── evaluation/                # 评测入口与结果提交约定
├── metadata/                  # 全局清单
└── scripts/                   # 发布校验脚本
```

## 快速检查

使用项目规定的 Python 环境执行：

```bash
python3 scripts/validate_release.py
```

校验内容包括题目数量、题号唯一性、引用文件、上海题库标准结果、数据库压缩包及元数据一致性。

## 评测与报告

- 两个赛道必须分别报告正确率。
- 如需单一汇总分，使用两个赛道正确率的等权宏平均，并同时公布两个原始分数。
- 上海赛道进一步报告单方式、多方式联合和 GIS 三类结果。
- 当前上海赛道仍为候选版本，标准答案尚待两人独立人工审核，因此已有三模型结果属于自动开发集评分。

完整规则见 [评测协议](docs/EVALUATION.md)。

## 数据来源

开源赛道整理自 Spider 和 BIRD 的交通相关数据。上海赛道使用经过统一、精简和去来源化处理的上海多方式交通评测数据库。来源与发布边界见 [数据来源说明](docs/DATA_SOURCES.md)。
