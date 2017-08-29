EXEC('create database DB10 as copy of LabModel')
-- select * from sys.dm_database_copies

DECLARE @pwd VARCHAR(100) = ''
EXEC('create login u09 with password=''' + @pwd + '''')

-- MASTERDB
CREATE DATABASE MASTERDB
ALTER DATABASE MASTERDB
MODIFY (SERVICE_OBJECTIVE=ELASTIC_POOL(NAME=DBS))

CREATE MASTER KEY;
CREATE DATABASE SCOPED CREDENTIAL LabDataCredential
WITH IDENTITY='', SECRET=''
GO
CREATE OR ALTER PROC setupDataSource(@servername VARCHAR(30), @dbname VARCHAR(30))
AS
DECLARE @source VARCHAR(30) = 'LabData' + @dbname
DECLARE @server VARCHAR(30) = @servername;
DECLARE @db VARCHAR(30) =  @dbname;

	EXEC('
	CREATE EXTERNAL DATA SOURCE ' + @source + '
	WITH (
		TYPE = RDBMS, 
		LOCATION = ''' + @server + '.database.windows.net'', 
		DATABASE_NAME = ''' + @db + ''', 
		CREDENTIAL = LabDataCredential
		)'
	);
GO

EXEC setupDataSource 'sqlfcatae', 'DB09'
drop external data source LabData

select * from sys.external_data_sources

-- setup user with low privilege
declare @source NVARCHAR(30) = N'LabData' + 'DB09'
exec sp_execute_remote @source, 
		N'setupUser @loginname, @username', 
		N'@loginname VARCHAR(50), @username VARCHAR(50)',
		'u08',
		'u08'

-- List visible objects
declare @source NVARCHAR(30) = N'LabData' + 'DB09'
exec sp_execute_remote @source, 
		N'sp_tables'
exec sp_execute_remote @source, 
		N'select * from sys.objects'

-- List visible objects
sp_execute_remote N'LabData', 
		N'setupUser @loginname, @username', 
		N'@loginname VARCHAR(50), @username VARCHAR(50)',
		'u08',
		'u08'

declare @source NVARCHAR(30) = N'LabData' + 'DB09'
exec sp_execute_remote @source, 
		N'setupRunAs @username',
		N'@username VARCHAR(50)',
		'u08'

CREATE PROC setupRunAs(@username VARCHAR(50))
WITH EXECUTE AS OWNER
AS
EXEC('EXEC(''setup'') AS USER=''' + @username + '''');

-- fix permission
sp_execute_remote N'LabData', 
		N'grant showplan to u08'