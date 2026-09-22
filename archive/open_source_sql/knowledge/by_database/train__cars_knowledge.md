# Database Knowledge: train__cars

- source: `train`
- db_id: `cars`
- database_dir: `database_layer/train__cars`
- db_path: `database_layer/train__cars/cars.sqlite`
- original_db_path: `train/train_databases/cars/cars.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## Table and Column Notes

### country

- `origin`: the unique identifier for the origin country
- `country`: the origin country of the car

### data

- `ID`: unique ID for each car
- `mpg`: mileage of the car in miles per gallon | values: commonsense evidence: The car with higher mileage is more fuel-efficient.
- `cylinders`: the number of cylinders present in the car
- `displacement`: engine displacement in cubic mm | values: commonsense evidence: sweep volume = displacement / no_of cylinders
- `horsepower`: horse power associated with the car | values: commonsense evidence: horse power is the metric used to indicate the power produced by a car's engine - the higher the number, the more power is sent to the wheels and, in theory, the faster it will go.
- `weight`: weight of the car in lbs | values: commonsense evidence: A bigger, heavier vehicle provides better crash protection than a smaller
- `acceleration`: acceleration of the car in miles per squared hour
- `model`: the year when the car model was introduced in the market | values: commonsense evidence: 0 --> 1970
- `car_name`: name of the car

### price

- `ID`: unique ID for each car
- `price`: price of the car in USD

### production

- `ID`: the id of the car
- `model_year`: year when the car model was introduced in the market
- `country`: country id to which the car belongs | values: Japan --> Asia USA --> North America
