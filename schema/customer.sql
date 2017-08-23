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
)