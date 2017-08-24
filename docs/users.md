Multi-Tentant Scenarios


Login per Schema
==================

Centralize user information in `master`

```sql
-- USE [master]
CREATE LOGIN <user_login> WITH PASSWORD='<password>'
```

Map the login to a specific schema

```sql
-- USE [database]

-- create the user
CREATE USER <username> FROM LOGIN <user_login>
    WITH DEFAULT_SCHEMA = <user_schema>;

-- create the schema for the user
CREATE SCHEMA <user_schema> 
GRANT ALTER ON schema::<user_schema> TO <username>

-- grant 'create table' permission
GRANT CREATE TABLE TO <username>;

-- since the user already has ALTER on schema, it can drop objects
```

Each login can have additional access to other databases in the server. 

```sql
-- USE [another_database]
CREATE USER <username> FROM LOGIN <user_login>
```

User per Schema
=================

Create database user pointing to a specific schema.

```sql
-- USE [database]

-- create the user
CREATE USER <username> WITH PASSWORD='<password>'
    WITH DEFAULT_SCHEMA = <user_schema>;

-- create the schema for the user
CREATE SCHEMA <user_schema> 
GRANT ALTER ON schema::<user_schema> TO <username>

-- grant 'create table' permission
GRANT CREATE TABLE TO <username>;

-- since the user already has ALTER on schema, it can drop objects
```

It is a similar configuration to "Login per Schema" except that the user is contained in the database. The advantage is that there is no external dependency such as [master] database. 


User per Database
==================

Create a login for database administration

```sql
-- USE [master]
CREATE LOGIN <user_login> WITH PASSWORD='<password>'
```

Assign the database ownership to the login

```sql
-- USE [database]
ALTER AUTHORIZATION ON database::<dbname> to <user_login>
```

Operational
============

## Change Password ##

User:

```sql
ALTER USER <username> WITH PASSWORD='<password>'
```

## External Table ##

```sql
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<password>';

CREATE DATABASE SCOPED CREDENTIAL SQL_Credential  
WITH IDENTITY = '<username>',
SECRET = '<password>';

CREATE EXTERNAL DATA SOURCE MyElasticDBQueryDataSrc 
WITH (
    TYPE = RDBMS, 
    LOCATION = '<server_name>.database.windows.net', 
    DATABASE_NAME = 'Customers', 
    CREDENTIAL = SQL_Credential 
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