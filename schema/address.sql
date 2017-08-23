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
)