select * from sys.sql_logins
select * from sys.database_principals
select * from sys.databases
select * from sys.elastic_pool_resource_stats

CREATE DATABASE DB10 AS COPY OF [LabModel]
select state_desc,* from sys.databases WHERE name='DB10'
select * from sys.dm_database_copies

create login u09 with password=''
