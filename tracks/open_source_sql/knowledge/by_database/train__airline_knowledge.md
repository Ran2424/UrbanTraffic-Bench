# Database Knowledge: train__airline

- source: `train`
- db_id: `airline`
- database_dir: `database_layer/train__airline`
- db_path: `database_layer/train__airline/airline.sqlite`
- original_db_path: `train/train_databases/airline/airline.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## Table and Column Notes

### Air Carriers

- `Code`: the code of the air carriers
- `Description`: the description of air carriers

### Airlines

- `FL_DATE`: flight date
- `OP_CARRIER_AIRLINE_ID`: operator carrier airline id
- `TAIL_NUM`: plane's tail number | values: plane's tail number
- `OP_CARRIER_FL_NUM`: operator carrier flight number
- `ORIGIN_AIRPORT_ID`: origin airport id
- `ORIGIN_AIRPORT_SEQ_ID`: origin airport sequence id
- `ORIGIN_CITY_MARKET_ID`: origin city market id
- `ORIGIN`: airport of origin | values: commonsense evidence: • the origin city could be inferred by this code: you can refer to https://www.iata.org/en/publications/directories/code-search/?airport.search=mia to quickly check
- `DEST_AIRPORT_ID`: ID of the destination airport
- `DEST_AIRPORT_SEQ_ID`
- `DEST_CITY_MARKET_ID`
- `DEST`: Destination airport | values: commonsense evidence: • the dest city could be inferred by this code: you can refer to https://www.iata.org/en/publications/directories/code-search/?airport.search=mia to quickly check
- `CRS_DEP_TIME`
- `DEP_TIME`: Flight departure time | values: stored as the integer
- `DEP_DELAY`: Departure delay indicator | values: in minutes commonsense evidence: • if this value is positive: it means this flight delays; if the value is negative, it means this flight departs in advance (-4) • if this value <= 0, it means this flight departs on time
- `DEP_DELAY_NEW`: departure delay new | values: not useful
- `ARR_TIME`: Flight arrival time.
- `ARR_DELAY`: arrival delay time | values: in minutes commonsense evidence: • if this value is positive: it means this flight will arrives late (delay); If the value is negative, this flight arrives earlier than scheduled. (-4) • if this value <= 0, it means this flight arrives on time
- `ARR_DELAY_NEW`: arrival delay new | values: not useful
- `CANCELLED`: Flight cancellation indicator.
- `CANCELLATION_CODE`: cancellation code | values: commonsense evidence: C--> A: more serious reasons lead to this cancellation
- `CRS_ELAPSED_TIME`: scheduled elapsed time
- `ACTUAL_ELAPSED_TIME`: actual elapsed time | values: commonsense evidence: if ACTUAL_ELAPSED_TIME < CRS_ELAPSED_TIME: this flight is faster than scheduled; if ACTUAL_ELAPSED_TIME > CRS_ELAPSED_TIME: this flight is slower than scheduled
- `CARRIER_DELAY`: carrier delay | values: minutes
- `WEATHER_DELAY`: delay caused by the wheather problem | values: minutes
- `NAS_DELAY`: delay, in minutes, attributable to the National Aviation System | values: minutes
- `SECURITY_DELAY`: delay attribute to security | values: minutes
- `LATE_AIRCRAFT_DELAY`: delay attribute to late aircraft | values: minutes

### Airports

- `Code`: IATA code of the air airports
- `Description`: the description of airports
