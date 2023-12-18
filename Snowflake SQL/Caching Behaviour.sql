/*----------------Different caches----------------
1) Metadata Cache
2) Results Cache
3) Virtual Warehouse Local Storage
----------------------------------------------*/

-- Set context
USE ROLE SYSADMIN;

USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000;

--stop the warehouse from resume so that we know which queries make use of metadata
ALTER WAREHOUSE COMPUTE_WH SUSPEND;
ALTER WAREHOUSE SET AUTO_RESUME=FALSE;



-------------------All these use metadata which runs instantly without the need of warehouse-------------------------
-- Count all records

SELECT COUNT(*) FROM CUSTOMER;

-- Context Functions

SELECT CURRENT_USER();

-- Object descriptions

DESCRIBE TABLE CUSTOMER;

-- List objects

SHOW TABLES;

-- System functions 

SELECT SYSTEM$CLUSTERING_INFORMATION('LINEITEM', ('L_ORDERKEY'));


-- cannot use this directly as this requires a warehouse
SELECT * FROM CUSTOMER;

---------------Results Cache store 24 hours for result re-use ----------------------------------------

--resume the warehouse
ALTER WAREHOUSE COMPUTE_WH RESUME IF SUSPENDED;
ALTER WAREHOUSE SET AUTO_RESUME=TRUE;

--first time take times
SELECT C_CUSTKEY, C_NAME, C_ADDRESS, C_NATIONKEY, C_PHONE FROM CUSTOMER LIMIT 1000000;

-second time much faster
SELECT C_CUSTKEY, C_NAME, C_ADDRESS, C_NATIONKEY, C_PHONE FROM CUSTOMER LIMIT 1000000;

-- Syntactically different, Results Cache is not used
SELECT C_CUSTKEY, C_NAME, C_ADDRESS, C_NATIONKEY, C_ACCTBAL FROM CUSTOMER LIMIT 1000000;

-- Includes functions evaluated at execution time, Results Cache is not used
SELECT C_CUSTKEY, C_NAME, C_ADDRESS, C_NATIONKEY, C_PHONE, CURRENT_TIMESTAMP() FROM CUSTOMER LIMIT 1000000;

--turn off result cache
USE ROLE ACCOUNTADMIN;
ALTER ACCOUNT SET USE_CACHED_RESULT = FALSE;

SELECT C_CUSTKEY, C_NAME, C_ADDRESS, C_NATIONKEY, C_PHONE FROM CUSTOMER LIMIT 1000000;

-- Local storage (second time will be faster)------------------------------------------
SELECT O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE
FROM ORDERS
WHERE O_ORDERDATE > DATE('1997-09-19')
ORDER BY O_ORDERDATE
LIMIT 1000;

SELECT O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE
FROM ORDERS
WHERE O_ORDERDATE > DATE('1997-09-19')
ORDER BY O_ORDERDATE
LIMIT 1000;

-- Additional column (still faster)
SELECT O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE, O_CLERK, O_ORDERPRIORITY
FROM ORDERS
WHERE O_ORDERDATE > DATE('1997-09-19')
ORDER BY O_ORDERDATE
LIMIT 1000;

--turned on the result catched as original state
ALTER ACCOUNT SET USE_CACHED_RESULT = TRUE;