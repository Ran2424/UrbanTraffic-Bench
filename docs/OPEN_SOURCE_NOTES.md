# 开源说明草案

## 来源

本 benchmark 整理自两个公开 Text-to-SQL 数据集的交通相关子集：

- Spider 交通子集
- BIRD train 交通子集

## 发布前建议检查

1. 分别确认 Spider 与 BIRD 的原始许可证、引用要求和再分发要求。
2. SQLite 文件已按数据库分别压缩为 `.7z`，位于 `database_files/archives/`；较大的压缩包可作为 Git LFS 或 release assets 发布。
3. 仓库正文可优先发布 schema、task、场景映射、评测脚本和知识文件。
4. README 中应明确引用原始数据集论文和官方网站。
5. 如果后续加入模型预测结果，应与 benchmark 数据分目录保存，避免污染 gold 数据。

## 当前目录状态

当前 release 目录已提供逐库 `.7z` 压缩包，并保留 `database_files/database_files_manifest.csv` 与 `database_files/archives_manifest.csv` 两份清单，便于后续按开源平台限制选择普通 Git、Git LFS 或 release assets。
