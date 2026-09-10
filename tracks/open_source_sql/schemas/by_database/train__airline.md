# train__airline

- 场景：机场航空 (`aviation_airport`)
- 来源：`train`
- 原始 db_id：`airline`
- Task 数：92
- 表数：3
- 字段数：32
- 总行数：709518
- SQLite 源路径：`Data/normalized_text2sql_tasks/database_layer/train__airline/airline.sqlite`

## 表：`Air Carriers`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Code` | `INTEGER` | 是 |  | the code of the air carriers |
| `Description` | `TEXT` | 否 |  | the description of air carriers |

## 表：`Airlines`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `FL_DATE` | `TEXT` | 否 |  | flight date |
| `OP_CARRIER_AIRLINE_ID` | `INTEGER` | 否 | Air Carriers.Code | operator carrier airline id |
| `TAIL_NUM` | `TEXT` | 否 |  | plane's tail number |
| `OP_CARRIER_FL_NUM` | `INTEGER` | 否 |  | operator carrier flight number |
| `ORIGIN_AIRPORT_ID` | `INTEGER` | 否 |  | origin airport id |
| `ORIGIN_AIRPORT_SEQ_ID` | `INTEGER` | 否 |  | origin airport sequence id |
| `ORIGIN_CITY_MARKET_ID` | `INTEGER` | 否 |  | origin city market id |
| `ORIGIN` | `TEXT` | 否 | Airports.Code | airport of origin |
| `DEST_AIRPORT_ID` | `INTEGER` | 否 |  | ID of the destination airport |
| `DEST_AIRPORT_SEQ_ID` | `INTEGER` | 否 |  |  |
| `DEST_CITY_MARKET_ID` | `INTEGER` | 否 |  |  |
| `DEST` | `TEXT` | 否 | Airports.Code | Destination airport |
| `CRS_DEP_TIME` | `INTEGER` | 否 |  |  |
| `DEP_TIME` | `INTEGER` | 否 |  | Flight departure time |
| `DEP_DELAY` | `INTEGER` | 否 |  | Departure delay indicator |
| `DEP_DELAY_NEW` | `INTEGER` | 否 |  | departure delay new |
| `ARR_TIME` | `INTEGER` | 否 |  | Flight arrival time. |
| `ARR_DELAY` | `INTEGER` | 否 |  | arrival delay time |
| `ARR_DELAY_NEW` | `INTEGER` | 否 |  | arrival delay new |
| `CANCELLED` | `INTEGER` | 否 |  | Flight cancellation indicator. |
| `CANCELLATION_CODE` | `TEXT` | 否 |  | cancellation code |
| `CRS_ELAPSED_TIME` | `INTEGER` | 否 |  | scheduled elapsed time |
| `ACTUAL_ELAPSED_TIME` | `INTEGER` | 否 |  | actual elapsed time |
| `CARRIER_DELAY` | `INTEGER` | 否 |  | carrier delay |
| `WEATHER_DELAY` | `INTEGER` | 否 |  | delay caused by the wheather problem |
| `NAS_DELAY` | `INTEGER` | 否 |  | delay, in minutes, attributable to the National Aviation System |
| `SECURITY_DELAY` | `INTEGER` | 否 |  | delay attribute to security |
| `LATE_AIRCRAFT_DELAY` | `INTEGER` | 否 |  | delay attribute to late aircraft |

## 表：`Airports`

| 字段 | 类型 | 主键 | 外键 | 说明 |
|---|---|---:|---|---|
| `Code` | `TEXT` | 是 |  | IATA code of the air airports |
| `Description` | `TEXT` | 否 |  | the description of airports |

