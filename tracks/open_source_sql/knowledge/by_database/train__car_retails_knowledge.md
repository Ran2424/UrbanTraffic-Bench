# Database Knowledge: train__car_retails

- source: `train`
- db_id: `car_retails`
- database_dir: `database_layer/train__car_retails`
- db_path: `database_layer/train__car_retails/car_retails.sqlite`
- original_db_path: `train/train_databases/car_retails/car_retails.sqlite`
- schema_source_path: `train/train_tables_traffic.json`

## Table and Column Notes

### customers

- `customerNumber`: unique id number of customer
- `customerName`: the name when the customer registered
- `contactLastName`: contact last name
- `contactFirstName`: contact first name
- `phone`: phone
- `addressLine1`: addressLine1
- `addressLine2`: addressLine2 | values: commonsense evidence: addressLine1 + addressLine2 = entire address
- `city`: city
- `state`: state
- `postalCode`: postalCode
- `country`: country
- `salesRepEmployeeNumber`: sales representative employee number
- `creditLimit`: credit limit

### employees

- `employeeNumber`: unique string ID of the employees
- `lastName`: last name of employees
- `firstName`: first name of employees
- `extension`: extension number
- `email`: email
- `officeCode`: office code of the employees
- `reportsTo`: represents for organization structure such as who reports to whom | values: commonsense evidence: "reportsTO" is the leader of the "employeeNumber"
- `jobTitle`: job title

### offices

- `officeCode`: unique ID of the office | values: unique ID of the office
- `city`
- `phone`: phone number
- `addressLine1`: addressLine1
- `addressLine2`: addressLine2 | values: commonsense evidence: addressLine1 + addressLine2 = entire address
- `state`
- `country`: country
- `postalCode`: postalCode
- `territory`: territory

### orderdetails

- `orderNumber`: order number
- `productCode`: product code
- `quantityOrdered`: quantity ordered
- `priceEach`: price for each | values: commonsense evidence: total price = quantityOrdered x priceEach
- `orderLineNumber`: order Line Number

### orders

- `orderNumber`: unique order number | values: unique order number
- `orderDate`: order date
- `requiredDate`: required Date
- `shippedDate`: shipped Date
- `status`: status
- `comments`: comments
- `customerNumber`: customer number

### payments

- `customerNumber`: customer number
- `checkNumber`: check Number
- `paymentDate`: payment Date
- `amount`: amount

### productlines

- `productLine`: unique product line name
- `textDescription`: text description
- `htmlDescription`: html description
- `image`: image

### products

- `productCode`: unique product code
- `productName`: product name
- `productLine`: product line name
- `productScale`: product scale
- `productVendor`: product vendor
- `productDescription`: product description
- `quantityInStock`: quantity in stock
- `buyPrice`: buy price from vendors
- `MSRP`: Manufacturer Suggested Retail Price | values: commonsense evidence: expected profits: msrp - buyPrice
