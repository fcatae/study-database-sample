External Data Source

https://docs.microsoft.com/en-us/sql/t-sql/statements/create-external-data-source-transact-sql

##

sp_execute_remote
https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-execute-remote-azure-sql-database


## External Table ##

```sql
CREATE MASTER KEY; -- (optional) ENCRYPTION BY PASSWORD = '<password>';

CREATE DATABASE SCOPED CREDENTIAL <LabDataCredential>
WITH 
  IDENTITY = '<username>',
  SECRET = '<password>';

CREATE EXTERNAL DATA SOURCE <LabData> 
WITH (
    TYPE = RDBMS, 
    LOCATION = '<server_name>.database.windows.net', 
    DATABASE_NAME = '<database_name>', 
    CREDENTIAL = <LabDataCredential>
);

CREATE EXTERNAL TABLE [dbo].[all_dm_exec_requests]([session_id] smallint NOT NULL,  
  [request_id] int NOT NULL,  
  [start_time] datetime NOT NULL,   
  [status] nvarchar(30) NOT NULL,  
  [command] nvarchar(32) NOT NULL,  
  [sql_handle] varbinary(64),  
  [statement_start_offset] int,  
  [statement_end_offset] int,  
  [cpu_time] int NOT NULL)  
WITH  
(  
  DATA_SOURCE = MyExtSrc,  
  SCHEMA_NAME = 'sys',  
  OBJECT_NAME = 'dm_exec_requests'
);   
```