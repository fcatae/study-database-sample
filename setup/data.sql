

CREATE PROC setupData_Address
AS
EXEC('INSERT Address ([AddressID], [AddressLine1], [AddressLine2], [City], [StateProvince], [CountryRegion], [PostalCode], [rowguid], [ModifiedDate])
		EXEC GetData_Address');
GO

CREATE PROC setupData_Customer
AS
EXEC('INSERT [Customer] ([CustomerID], [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [CompanyName], [SalesPerson], [EmailAddress], [Phone], [PasswordHash], [PasswordSalt], [rowguid], [ModifiedDate])
		EXEC GetData_Customer');
GO

CREATE PROC setupData_CustomerAddress
AS
EXEC('INSERT [CustomerAddress] ([CustomerID], [AddressID], [AddressType], [rowguid], [ModifiedDate])
		EXEC GetData_CustomerAddress');
GO

CREATE   PROC GetData_Address
WITH EXECUTE AS OWNER
AS
SELECT [AddressID], [AddressLine1], [AddressLine2], [City], [StateProvince], [CountryRegion], [PostalCode], [rowguid], [ModifiedDate]
FROM dbo.[Address]
GO

CREATE   PROC GetData_Customer
WITH EXECUTE AS OWNER
AS
SELECT [CustomerID], [NameStyle], [Title], [FirstName], [MiddleName], [LastName], [Suffix], [CompanyName], [SalesPerson], [EmailAddress], [Phone], [PasswordHash], [PasswordSalt], [rowguid], [ModifiedDate] 
FROM dbo.[Customer]
GO

CREATE   PROC GetData_CustomerAddress
WITH EXECUTE AS OWNER
AS
SELECT [CustomerID], [AddressID], [AddressType], [rowguid], [ModifiedDate]
FROM dbo.[CustomerAddress]

