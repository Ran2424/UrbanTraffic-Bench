# 评测入口

当前发布校验使用：

```bash
/Users/ran/WorkSpace/SoftWare/miniconda3/envs/research/bin/python3.10 scripts/validate_release.py
```

模型评测实现需遵守 [`docs/EVALUATION.md`](../docs/EVALUATION.md)，并保存以下信息：

- 模型名称、接口返回名称和推理设置；
- 提示词版本和 SHA-256；
- 任务文件、数据库和评分器 SHA-256；
- 温度、Token 限制、API 超时、SQL 超时、并发数和重试次数；
- 每题的最终 SQL、执行状态、判定原因和耗时。

当前论文数据包见 [`baselines/four_models_v2/`](../baselines/four_models_v2/)。历史公开数据已归档，不进入 UrbanTraffic-Bench 的评分流程。
