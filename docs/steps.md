
-- master
create database DB01 as copy of LabModel
create login u01 with password='fiap#2017'

-- db01
create user dev from login u01 with default_schema=dev
create schema dev

-- MASTERDB

CREATE MASTER KEY;
CREATE DATABASE SCOPED CREDENTIAL LabDataCredential
...
  
CREATE PROC setupDataSource(@servername VARCHAR(30), @dbname VARCHAR(30))
AS
DECLARE @server VARCHAR(30) = QUOTENAME(@servername);
DECLARE @db VARCHAR(30) =  QUOTENAME(@dbname);

	EXEC('
	CREATE EXTERNAL DATA SOURCE LabData
	WITH (
		TYPE = RDBMS, 
		LOCATION = ''' + @server + '.database.windows.net'', 
		DATABASE_NAME = ''' + @db + ''', 
		CREDENTIAL = LabDataCredential
		)'
	);
GO
