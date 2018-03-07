select * from sys.databases

create database LabModel
(service_objective=elastic_pool(name=[DBS]))

-- USE [LabModel]

GO
-- Setup database schema
CREATE PROC setupSchema
AS
SET NOCOUNT ON 

CREATE TABLE [Customer]
(
	[CustomerID] 	[int] IDENTITY(1,1)		NOT NULL,
	[NameStyle] 	[bit]					NOT NULL,
	[Title] 		[nvarchar](8)			NULL,
	[FirstName] 	[nvarchar](50)			NOT NULL,
	[MiddleName] 	[nvarchar](50)			NULL,
	[LastName] 		[nvarchar](50)			NOT NULL,
	[Suffix] 		[nvarchar](10)			NULL,
	[CompanyName] 	[nvarchar](128)			NULL,
	[SalesPerson] 	[nvarchar](256)			NULL,
	[EmailAddress] 	[nvarchar](50)			NULL,
	[Phone] 		[nvarchar](25)			NULL,
	[PasswordHash] 	[varchar](128)			NOT NULL,
	[PasswordSalt] 	[varchar](10)			NOT NULL,
	[rowguid] 		[uniqueidentifier]		NOT NULL,
	[ModifiedDate] 	[datetime]				NOT NULL,
	[Description]   [CHAR](7000)            NULL
	CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID]),
	CONSTRAINT [UNI_Customer_rowguid] UNIQUE NONCLUSTERED ([rowguid])
);

CREATE TABLE [Address]
(
	[AddressID]	    [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[AddressLine1]  [nvarchar](60)		NOT NULL,
	[AddressLine2]  [nvarchar](60)		NULL,
	[City]	        [nvarchar](30)		NOT NULL,
	[StateProvince] [nvarchar](50)		NOT NULL,
	[CountryRegion] [nvarchar](50)		NOT NULL,
	[PostalCode]    [VARCHAR](15)		NOT NULL,
	[rowguid]       [uniqueidentifier]  NOT NULL,
	[ModifiedDate]  [datetime]			NOT NULL,
    [Description]   [CHAR](7000)        NULL
 CONSTRAINT [UNI_Address_rowguid] UNIQUE NONCLUSTERED ([rowguid])
);

CREATE TABLE [CustomerAddress]
(
	[CustomerID] 	[int] 				NOT NULL,
	[AddressID] 	[int] 				NOT NULL,
	[AddressType] 	[nvarchar](50) 		NOT NULL,
	[rowguid] 		[uniqueidentifier] 	NOT NULL,
	[ModifiedDate] 	[datetime] 			NOT NULL,
 CONSTRAINT [UNI_CustomerAddress_rowguid] UNIQUE NONCLUSTERED ([rowguid])
);

ALTER TABLE [Address] ADD  CONSTRAINT [DF_Address_rowguid]  DEFAULT (newid()) FOR [rowguid]
ALTER TABLE [Address] ADD  CONSTRAINT [DF_Address_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
ALTER TABLE [Customer] ADD  CONSTRAINT [DF_Customer_NameStyle]  DEFAULT ((0)) FOR [NameStyle]
ALTER TABLE [Customer] ADD  CONSTRAINT [DF_Customer_rowguid]  DEFAULT (newid()) FOR [rowguid]
ALTER TABLE [Customer] ADD  CONSTRAINT [DF_Customer_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
ALTER TABLE [CustomerAddress] ADD  CONSTRAINT [DF_CustomerAddress_rowguid]  DEFAULT (newid()) FOR [rowguid]
ALTER TABLE [CustomerAddress] ADD  CONSTRAINT [DF_CustomerAddress_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]

ALTER TABLE [CustomerAddress]  ADD  CONSTRAINT [FK_CustomerAddress_CustomerID] FOREIGN KEY([CustomerID]) REFERENCES [Customer] ([CustomerID])
ALTER TABLE [CustomerAddress]  ADD  CONSTRAINT [FK_CustomerAddress_AddressID] FOREIGN KEY([AddressId]) REFERENCES [Address] ([AddressId])
GO

DROP PROC setupClean
GO
CREATE PROC setupClean
AS
	IF(OBJECT_ID('CustomerAddress') IS NOT NULL)
		DROP TABLE CustomerAddress

	IF(OBJECT_ID('Address') IS NOT NULL)
		DROP TABLE Address

	IF(OBJECT_ID('Customer') IS NOT NULL)
		DROP TABLE Customer
GO
DROP PROC setup
GO
CREATE PROC setup
AS
EXEC setupClean
EXEC setupSchema
EXEC setupData_Address
EXEC setupData_Customer
EXEC setupData_CustomerAddress
PRINT 'Setup DONE'
GO

DROP PROC setupUser
GO
CREATE PROC setupUser(@loginname VARCHAR(50))
WITH EXECUTE AS OWNER
AS
SET XACT_ABORT ON

DECLARE @login VARCHAR(100) = QUOTENAME(@loginname);
DECLARE @user VARCHAR(100) = QUOTENAME(@loginname);
DECLARE @schema VARCHAR(100) = @user;

-- create the user
PRINT 'create the user: ' + @user
SELECT * FROM sys.database_principals
IF USER_ID(@loginname) is NULL
	EXEC('CREATE USER ' + @user + ' FROM LOGIN ' + @login + ' WITH DEFAULT_SCHEMA=' + @schema );
IF SCHEMA_ID(@loginname) is NULL
	EXEC('CREATE SCHEMA ' + @schema + ' AUTHORIZATION ' + @user);

-- ALTER/CREATE permission
PRINT 'ALTER/CREATE permission'
EXEC('GRANT CREATE TABLE TO ' + @user );
EXEC('GRANT ALTER ON schema::' + @schema + ' TO ' + @user );

-- setup permission
PRINT 'setup permission'
EXEC('GRANT EXECUTE ON setup TO ' + @user );
GO
