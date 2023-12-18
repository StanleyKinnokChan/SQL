CREATE DATABASE IF NOT EXISTS demo_data_loading;


USE DATABASE demo_data_loading;
CREATE TABLE flights_temp
(
rj VARIANT
);

//create an external stage pointing to the S3 path where the sample
CREATE OR REPLACE STAGE flights_json_stage
url = 's3://snowpro-core-study-guide/dataloading/json/'
file_format = (type = json);

LIST @employee_json_stage;

//load the JSON data into the employee_temp table
COPY INTO flights_temp
FROM @flights_json_stage;

SELECT * FROM flights_temp;

//access individual elements in the JSON and convert the data
SELECT rj:data_set::String as data_set_name, rj:provided_by::String as
provided_by from flights_temp;


//use the FLATTEN function to explode the array values into their respective rows
SELECT
rj:data_set::String as data_set_name, rj:provided_by::String as
provided_by,
value
FROM
flights_temp
, lateral flatten( input => rj:flights );

//proper data type to each value and make
SELECT
rj:data_set::String as data_set_name, rj:provided_by::String as
provided_by,
value:airline::String AS airline,
value:origin.airport::String as orig_airport,
value:origin.city::String as orig_city,
value:destination.airport::String as dest_airport,
value:destination.city::String as dest_city
FROM
flights_temp
, lateral flatten( input => rj:flights );
