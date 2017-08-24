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
