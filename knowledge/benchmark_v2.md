# v2 数据与分类规则

## 题目结构

- `question` 只描述业务问题、筛选范围和计算口径，不包含输出格式约束。
- `supplementary_notes` 保存日期口径、候选集合范围、边界和并列消歧等题目补充条件。
- `output_contract.columns` 依次定义输出字段的 `name`、`type` 和 `nullable`。
- 小数字段通过 `decimal_places` 或 `minimum_decimal_places` 约束精度。
- 枚举字段通过 `allowed_values` 给出合法值；补充排列或连接规则写入 `output_contract.notes`。
- 固定Top-K规则写入 `output_contract.row_selection`。
- `evaluation_policy` 保存评测器使用的容差和匹配方式，不作为题目正文。

提示词按“问题—数据说明—补充说明—结果要求—产物要求”组织。补充说明由 `supplementary_notes` 生成，结果要求由 `output_contract` 生成。

## 数据与分类规则

- “今天”指 `2026-08-24`。
- 早高峰为7、8、9时；晚高峰为17、18、19时；夜间为0至5时。
- `NULL` 表示没有观测，0表示有观测且数值为零。
- `metro_station.station_name` 不含“站”后缀。
- 固定Top-K返回K行；边界同值对象可替换。明确要求保留并列时保留全部并列。
- 涉及距离、缓冲区、空间集合或最近邻的题归入GIS空间关联查询。
- 其余使用两种及以上交通方式的题归入多方式联合查询；其他题归入单方式查询。
