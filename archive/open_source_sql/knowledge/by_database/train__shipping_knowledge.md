# Database Knowledge: train__shipping

- source: `train`
- db_id: `shipping`
- database_dir: `database_layer/train__shipping`
- db_path: `database_layer/train__shipping/shipping.sqlite`
- original_db_path: `train/train_databases/shipping/shipping.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## Table and Column Notes

### city

- `city_id`: unique identifier for the city
- `city_name`: name of the city
- `state`: state in which the city is
- `population`: population of the city
- `area`: square miles the city covers | values: commonsense evidence: population density (land area per capita) = area / population

### customer

- `cust_id`: Unique identifier for the customer
- `cust_name`: Business name of the customer
- `annual_revenue`: Annual revenue of the customer
- `cust_type`: Whether the customer is a manufacturer or a wholes
- `address`: Physical street address of the customer
- `city`: City of the customer's address
- `state`: State of the customer's address | values: commonsense evidence: please mention its full name in the question, by referring to https://www23.statcan.gc.ca/imdb/p3VD.pl?Function=getVD&TVD=53971 e.g., NY --> New York
- `zip`: Postal code of the customer's address
- `phone`: Telephone number to reach the customer

### driver

- `driver_id`: Unique identifier for the driver
- `first_name`: First given name of the driver
- `last_name`: Family name of the driver | values: commonsense evidence: full name = first_name + last_name
- `address`: Street address of the driver's home
- `city`: City the driver lives in
- `state`: State the driver lives in | values: commonsense evidence: please mention its full name in the question, by referring to https://www23.statcan.gc.ca/imdb/p3VD.pl?Function=getVD&TVD=53971 e.g., NY --> New York
- `zip_code`: postal code of the driver's address
- `phone`: telephone number of the driver

### shipment

- `ship_id`: Unique identifier of the shipment
- `cust_id`: A reference to the customer table that indicates which customer the shipment is for
- `weight`: The number of pounds being transported on the shipment
- `truck_id`: A reference to the truck table that indicates which truck is used in the shipment
- `driver_id`: A reference to the driver table that indicates which driver transported the goods in the shipment
- `city_id`: A reference to the city table that indicates the destination of the shipment
- `ship_date`: the date the items were received by the driver | values: yyyy-mm-dd

### truck

- `truck_id`: Unique identifier of the truck table
- `make`: The brand of the truck | values: commonsense evidence:  Peterbilt headquarter: Texas (TX)  Mack headquarter: North Carolina (NC)  Kenworth headquarter: Washington (WA) can ask question about headquarters of the truck
- `model_year`: The year the truck was manufactured | values: commonsense evidence: The truck with earlier model year means this truck is newer.
