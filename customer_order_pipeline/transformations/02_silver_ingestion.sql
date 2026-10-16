 -- Staging

CREATE STREAMING TABLE order_silver_stg 
(CONSTRAINT valid_order EXPECT (order_id is not null) ON VIOLATION DROP ROW,
CONSTRAINT valid_customer EXPECT (customer_id is NOT NULL) ON VIOLATION DROP ROW)
AS
select 
    orderid as order_id,
    orderdate as order_date,
    customerid as customer_id,
    totalamount as total_amount,
    status,
    _file_nm,
    current_timestamp() as _ingest_ts
from STREAM (order_bronze);

CREATE STREAMING TABLE customer_silver_stg
(CONSTRAINT valid_customer EXPECT (customer_id is not null) ON VIOLATION DROP ROW)
AS
select 
    customerid as customer_id,
    customername as customer_name,
    contactnumber as contact_number,
    email,
    address as city,
    dateofbirth as dob,
    registrationdate as customer_since,
    _file_nm,
    current_timestamp() as _ingest_ts  
from STREAM (customer_bronze);


 -- Silver

 CREATE STREAMING TABLE order_silver;

APPLY CHANGES
INTO order_silver 
from STREAM (order_silver_stg)
KEYS (order_id)
SEQUENCE BY _ingest_ts
;


CREATE STREAMING TABLE customer_silver;

CREATE FLOW customer_silver_flow AS AUTO CDC
INTO customer_silver
from STREAM (customer_silver_stg)
KEYS (customer_id)
SEQUENCE BY _ingest_ts
STORED AS SCD TYPE 2
;