//Begin by creating a database and a table
USE ROLE SYSADMIN;
CREATE OR REPLACE DATABASE test_tasks;
CREATE TABLE test_tasks.public.customer_report
(
customer_name STRING,
total_price NUMBER
);

// prepare the data that you will load into this table. The SQL joins the Customer and the Order table to produce a customer-level spending report
SELECT c.c_name as customer_name,SUM(o.o_totalprice) AS total_price
FROM snowflake_sample_data.tpch_sf1.orders o
INNER JOIN snowflake_sample_data.tpch_sf1.customer c
ON o.o_custkey = c.c_custkey
GROUP BY c.c_name;


//use task to execute a scheduled INSERT statement in a recurring schedule of 5 minutes,
CREATE TASK generate_customer_report
WAREHOUSE=COMPUTE_WH
SCHEDULE = '5 MINUTE'
AS
INSERT INTO test_tasks.public.customer_report
SELECT c.c_name as customer_name,SUM(o.o_totalprice) AS total_price
FROM snowflake_sample_data.tpch_sf1.orders o
INNER JOIN snowflake_sample_data.tpch_sf1.customer c
ON o.o_custkey = c.c_custkey
GROUP BY c.c_name;


//new Snowflake tasks are created in a suspended state, set the task status to RESUME to ensure that the task starts running on the defined schedule
//privillege is required, so we grant it from an ACCOUNTADMIN role, then switch back to SYSADMIN role
USE ROLE ACCOUNTADMIN;
GRANT EXECUTE TASK ON ACCOUNT TO ROLE SYSADMIN;
USE ROLE SYSADMIN;
ALTER TASK generate_customer_report RESUME;

select * from test_tasks.public.customer_report;


//watch the task execution by querying the task_history() table function
USE ROLE ACCOUNTADMIN;
SELECT name, state,
completed_time, scheduled_time,
error_code, error_message
FROM TABLE(information_schema.task_history())
WHERE name = 'GENERATE_CUSTOMER_REPORT';


//see the loaded data
SELECT COUNT(*) FROM test_tasks.public.customer_report;

//suspend the scheduled task 
ALTER TASK generate_customer_report SUSPEND;