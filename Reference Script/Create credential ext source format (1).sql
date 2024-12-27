CREATE DATABASE SCOPED CREDENTIAL cred_gsn56
WITH
    IDENTITY = 'Managed Identity'


CREATE EXTERNAL DATA SOURCE source_silvergsn
WITH(
    LOCATION = 'https://awstoragedatalakegsn.dfs.core.windows.net/silver',
    CREDENTIAL = cred_gsn56
)

CREATE EXTERNAL DATA SOURCE source_goldgsn
WITH(
    LOCATION = 'https://awstoragedatalakegsn.dfs.core.windows.net/gold',
    CREDENTIAL = cred_gsn56
)

CREATE EXTERNAL FILE FORMAT gsn_file_parquet
WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)

------------------------------------------
---CREATE EXTERNAL TABLE EXTSALES
------------------------------------------

CREATE EXTERNAL TABLE gold.extsales
WITH(
    LOCATION = 'extsales',
    DATA_SOURCE = source_goldgsn,
    FILE_FORMAT = gsn_file_parquet
) 
AS 
SELECT * FROM gold.sales

------------------------------------------
---CREATE EXTERNAL TABLE EXTProducts
------------------------------------------

CREATE EXTERNAL TABLE gold.extproducts
WITH(
    LOCATION = 'products',
    DATA_SOURCE = source_goldgsn,
    FILE_FORMAT = gsn_file_parquet
) 
AS 
SELECT * FROM gold.products

------------------------------------------
---CREATE EXTERNAL TABLE EXTCustomers
------------------------------------------

CREATE EXTERNAL TABLE gold.extcustomers
WITH(
    LOCATION = 'customers',
    DATA_SOURCE = source_goldgsn,
    FILE_FORMAT = gsn_file_parquet
) 
AS 
SELECT * FROM gold.customers


------------------------------------------
---CREATE EXTERNAL TABLE EXTTerritories
------------------------------------------

CREATE EXTERNAL TABLE gold.extterritories
WITH(
    LOCATION = 'territories',
    DATA_SOURCE = source_goldgsn,
    FILE_FORMAT = gsn_file_parquet
) 
AS 
SELECT * FROM gold.territories



select * from gold.extsales
