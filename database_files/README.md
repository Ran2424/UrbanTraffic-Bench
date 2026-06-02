# 数据库文件与压缩包

本目录保存 TrafficSQL-Bench 的数据库文件清单与逐库 `.7z` 压缩包。

## 当前状态

- 数据库压缩包：28 个
- 原始 SQLite 总大小：约 5.0GB
- `.7z` 压缩后总大小：约 258.5MB
- 最大压缩包：`train__bike_share_1.7z`，约 231.1MB
- 所有 `.7z` 文件已配置 Git LFS
- 所有 `.7z` 文件已通过 `7z t` 完整性测试

## 目录结构

```text
database_files/
  README.md
  database_files_manifest.csv
  archives_manifest.csv
  archives_manifest.json
  archives/
    spider_data__aircraft.7z
    spider_data__bike_1.7z
    ...
    train__bike_share_1.7z
```

## 压缩包内容

每个 `<database_uid>.7z` 压缩包包含对应数据库目录中的核心文件：

- `<db_id>.sqlite`
- `database.json`
- `knowledge.md`
- `knowledge_database.md`

例如：

```text
archives/spider_data__bike_1.7z
  bike_1.sqlite
  database.json
  knowledge.md
  knowledge_database.md
```

## 清单文件

### `database_files_manifest.csv`

记录原始 SQLite 文件信息：

- `database_uid`
- `db_id`
- `source`
- `scenario`
- `scenario_zh`
- `sqlite_file`
- `sqlite_source_path`
- `sqlite_size_bytes`
- `sqlite_size_mb`

### `archives_manifest.csv`

记录压缩包信息：

- `database_uid`
- `archive_file`
- `archive_size_bytes`
- `archive_size_mb`
- `sqlite_size_mb`
- `compression_ratio`
- `sha256`
- `included_files`

`archives_manifest.json` 是同一信息的 JSON 版本。

## 解压方式

解压单个数据库：

```bash
7z x archives/spider_data__bike_1.7z -odatabase_layer/spider_data__bike_1
```

解压后得到：

```text
database_layer/spider_data__bike_1/
  bike_1.sqlite
  database.json
  knowledge.md
  knowledge_database.md
```

## 完整性校验

测试单个压缩包：

```bash
7z t archives/spider_data__bike_1.7z
```

测试全部压缩包：

```bash
find archives -name "*.7z" -print0 | xargs -0 -n 1 7z t
```

也可以使用 `archives_manifest.csv` 中的 `sha256` 字段校验文件哈希。

## Git LFS

本仓库使用 Git LFS 跟踪数据库压缩包：

```text
*.7z filter=lfs diff=lfs merge=lfs -text
```

如果 clone 后没有得到真实压缩包，请确认本地已安装 Git LFS：

```bash
git lfs install
git lfs pull
```
