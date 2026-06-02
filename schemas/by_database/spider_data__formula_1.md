# spider_data__formula_1

- 场景：赛车竞赛 (`racing_competition`)
- 来源：`spider_data`
- 原始 db_id：`formula_1`
- Task 数：80
- 表数：13
- 字段数：94
- 总行数：88380
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/spider_data__formula_1/formula_1.sqlite`

## 表：`circuits`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `circuitId` | `INTEGER` | 是 |  |  |
| `circuitRef` | `TEXT` | 否 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `location` | `TEXT` | 否 |  |  |
| `country` | `TEXT` | 否 |  |  |
| `lat` | `REAL` | 否 |  |  |
| `lng` | `REAL` | 否 |  |  |
| `alt` | `TEXT` | 否 |  |  |
| `url` | `TEXT` | 否 |  |  |

## 表：`constructorResults`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `constructorResultsId` | `INTEGER` | 是 |  |  |
| `raceId` | `INTEGER` | 否 | races.raceId |  |
| `constructorId` | `INTEGER` | 否 | constructors.constructorId |  |
| `points` | `REAL` | 否 |  |  |
| `status` | `TEXT` | 否 |  |  |

## 表：`constructorStandings`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `constructorStandingsId` | `INTEGER` | 是 |  |  |
| `raceId` | `INTEGER` | 否 | races.raceId |  |
| `constructorId` | `INTEGER` | 否 | constructors.constructorId |  |
| `points` | `REAL` | 否 |  |  |
| `position` | `INTEGER` | 否 |  |  |
| `positionText` | `TEXT` | 否 |  |  |
| `wins` | `INTEGER` | 否 |  |  |

## 表：`constructors`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `constructorId` | `INTEGER` | 是 |  |  |
| `constructorRef` | `TEXT` | 否 |  |  |
| `name` | `TEXT` | 否 |  |  |
| `nationality` | `TEXT` | 否 |  |  |
| `url` | `TEXT` | 否 |  |  |

## 表：`driverStandings`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `driverStandingsId` | `INTEGER` | 是 |  |  |
| `raceId` | `INTEGER` | 否 | races.raceId |  |
| `driverId` | `INTEGER` | 否 | drivers.driverId |  |
| `points` | `REAL` | 否 |  |  |
| `position` | `INTEGER` | 否 |  |  |
| `positionText` | `TEXT` | 否 |  |  |
| `wins` | `INTEGER` | 否 |  |  |

## 表：`drivers`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `driverId` | `INTEGER` | 是 |  |  |
| `driverRef` | `TEXT` | 否 |  |  |
| `number` | `TEXT` | 否 |  |  |
| `code` | `TEXT` | 否 |  |  |
| `forename` | `TEXT` | 否 |  |  |
| `surname` | `TEXT` | 否 |  |  |
| `dob` | `TEXT` | 否 |  |  |
| `nationality` | `TEXT` | 否 |  |  |
| `url` | `TEXT` | 否 |  |  |

## 表：`lapTimes`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `raceId` | `INTEGER` | 是 | races.raceId |  |
| `driverId` | `INTEGER` | 是 | drivers.driverId |  |
| `lap` | `INTEGER` | 是 |  |  |
| `position` | `INTEGER` | 否 |  |  |
| `time` | `TEXT` | 否 |  |  |
| `milliseconds` | `INTEGER` | 否 |  |  |

## 表：`pitStops`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `raceId` | `INTEGER` | 是 | races.raceId |  |
| `driverId` | `INTEGER` | 是 | drivers.driverId |  |
| `stop` | `INTEGER` | 是 |  |  |
| `lap` | `INTEGER` | 否 |  |  |
| `time` | `TEXT` | 否 |  |  |
| `duration` | `TEXT` | 否 |  |  |
| `milliseconds` | `INTEGER` | 否 |  |  |

## 表：`qualifying`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `qualifyId` | `INTEGER` | 是 |  |  |
| `raceId` | `INTEGER` | 否 | races.raceId |  |
| `driverId` | `INTEGER` | 否 | drivers.driverId |  |
| `constructorId` | `INTEGER` | 否 | constructors.constructorId |  |
| `number` | `INTEGER` | 否 |  |  |
| `position` | `INTEGER` | 否 |  |  |
| `q1` | `TEXT` | 否 |  |  |
| `q2` | `TEXT` | 否 |  |  |
| `q3` | `TEXT` | 否 |  |  |

## 表：`races`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `raceId` | `INTEGER` | 是 |  |  |
| `year` | `INTEGER` | 否 |  |  |
| `round` | `INTEGER` | 否 |  |  |
| `circuitId` | `INTEGER` | 否 | circuits.circuitId |  |
| `name` | `TEXT` | 否 |  |  |
| `date` | `TEXT` | 否 |  |  |
| `time` | `TEXT` | 否 |  |  |
| `url` | `TEXT` | 否 |  |  |

## 表：`results`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `resultId` | `INTEGER` | 是 |  |  |
| `raceId` | `INTEGER` | 否 | races.raceId |  |
| `driverId` | `INTEGER` | 否 | drivers.driverId |  |
| `constructorId` | `INTEGER` | 否 | constructors.constructorId |  |
| `number` | `INTEGER` | 否 |  |  |
| `grid` | `INTEGER` | 否 |  |  |
| `position` | `TEXT` | 否 |  |  |
| `positionText` | `TEXT` | 否 |  |  |
| `positionOrder` | `INTEGER` | 否 |  |  |
| `points` | `REAL` | 否 |  |  |
| `laps` | `TEXT` | 否 |  |  |
| `time` | `TEXT` | 否 |  |  |
| `milliseconds` | `TEXT` | 否 |  |  |
| `fastestLap` | `TEXT` | 否 |  |  |
| `rank` | `TEXT` | 否 |  |  |
| `fastestLapTime` | `TEXT` | 否 |  |  |
| `fastestLapSpeed` | `TEXT` | 否 |  |  |
| `statusId` | `INTEGER` | 否 |  |  |

## 表：`seasons`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `year` | `INTEGER` | 是 |  |  |
| `url` | `TEXT` | 否 |  |  |

## 表：`status`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `statusId` | `INTEGER` | 是 |  |  |
| `status` | `TEXT` | 否 |  |  |

