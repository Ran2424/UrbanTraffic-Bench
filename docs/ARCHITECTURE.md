# 基准结构

## 设计目标

TrafficSQL-Bench 不把所有交通题目放入同一个统计池，而是区分两类能力：

1. 跨数据库 SQL 生成：考察 schema linking、连接、聚合、子查询和集合运算。
2. 城市交通业务分析：考察业务指标、时间窗口、多方式对齐、空间集合和最近邻等问题。

## 术语

| 字段 | 含义 |
|---|---|
| `track_id` | 评测赛道：`open_source_sql` 或 `shanghai_mobility` |
| `domain` | 数据业务主题，如航空、铁路或城市交通 |
| `task_family` | 题目分析类型，如单方式、多方式联合或 GIS |
| `database_uid` | 数据库唯一标识 |
| `task_id` | 赛道内稳定题号 |
| `legacy_task_id` | 历史题号，仅用于追溯 |
| `language` | 问题语言 |
| `difficulty` | 难度标签；没有可靠标注时保持为空 |

旧版任务中的 `scenario` 是交通主题；上海任务中的 `scenario` 是分析类型。新增工具不应把两者当成同一层级，统一读取时应映射到 `domain` 和 `task_family`。

## 唯一数据源

每个赛道的 `tasks/tasks.jsonl` 是任务主文件。CSV、按数据库文件和按题型文件属于派生视图，应由脚本生成或校验，避免多份数据独立维护。

数据库、schema、知识说明、标准结果和 baseline 均保存在所属赛道内。顶层 metadata 只保存跨赛道索引，不复制任务正文。
