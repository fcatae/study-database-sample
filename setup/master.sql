-- Create Co-Admin
CREATE USER admsql WITH PASSWORD=''
ALTER ROLE loginmanager ADD MEMBER admsql
SELECT * FROM sys.database_principals
SELECT * FROM sys.database_role_members

-- Create Logins
CREATE LOGIN [u09] WITH PASSWORD=''
SELECT * FROM sys.sql_logins

-- Create Databases
CREATE DATABASE DB10 AS COPY OF [LabModel]
SELECT * FROM sys.databases

SELECT state_desc,* FROM sys.databases WHERE name='DB10'
SELECT * FROM sys.dm_database_copies

-- Inside database
-- ALTER AUTHORIZATION ON database::DB10 TO u04

-- Monitor resources
select * from sys.elastic_pool_resource_stats
select * from sys.resource_stats
