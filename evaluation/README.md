# 评测入口

本目录保存跨赛道共用的评测约定。当前发布校验使用：

```bash
python3 scripts/validate_release.py
```

模型评测实现需要遵守 `docs/EVALUATION.md`，并保存以下信息：

- 模型名称与接口返回名称
- 提示词版本和 SHA256
- 任务文件、数据库和评判器 SHA256
- 温度、Token 限制、API 超时、SQL 超时和重试次数
- 每题生成 SQL、执行状态、判定原因和耗时

两个赛道的结果分别保存，不把题量直接相加计算主指标。
