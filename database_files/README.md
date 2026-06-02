# 数据库文件清单与压缩包

`archives/` 目录中按数据库分别保存 `.7z` 压缩包。每个压缩包包含：

- 对应数据库的 `.sqlite` 文件
- `database.json`
- `knowledge.md`
- `knowledge_database.md`

清单文件：

- `database_files_manifest.csv`：原始 SQLite 文件路径与大小
- `archives_manifest.csv`：每个 `.7z` 压缩包的大小、压缩比、SHA256 和包含文件
- `archives_manifest.json`：JSON 版本压缩包清单

解压示例：

```bash
7z x archives/spider_data__bike_1.7z -odatabase_layer/spider_data__bike_1
```

开源建议：小型压缩包可直接入库；较大的 `train__bike_share_1.7z` 建议作为 Git LFS 或 release asset 发布。
