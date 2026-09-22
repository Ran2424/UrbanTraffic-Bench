# Database Knowledge: train__trains

- source: `train`
- db_id: `trains`
- database_dir: `database_layer/train__trains`
- db_path: `database_layer/train__trains/trains.sqlite`
- original_db_path: `train/train_databases/trains/trains.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## Table and Column Notes

### cars

- `id`: the unique id number representing the cars
- `train_id`: the counterpart id for trains that the cars belong to
- `position`: postion id of cars in the trains | values: 1-4: commonsense evidence: 1: head car 4: tail car
- `shape`: shape of the cars | values: • rectangle • bucket • u_shaped • hexagon • elipse commonsense evidence: regular shape: rectangle, u_shaped, hexagon
- `len`: length of the cars | values: • short • long
- `sides`: sides of the cars | values: • not_double • double
- `roof`: roof of the cars | values: commonsense evidence: • none: the roof is open • peaked • flat • arc • jagged
- `wheels`: wheels of the cars | values: • 2: • 3:
- `load_shape`: load shape | values: • circle • hexagon • triangle • rectangle • diamond
- `load_num`: load number | values: 0-3: commonsense evidence: • 0: empty load • 3: full load

### trains

- `id`: the unique id representing the trains
- `direction`: the direction of trains that are running | values: • east; • west;
