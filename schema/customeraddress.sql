CREATE TABLE [CustomerAddress]
(
	[CustomerID] 	[int] 				NOT NULL,
	[AddressID] 	[int] 				NOT NULL,
	[AddressType] 	[nvarchar](50) 		NOT NULL,
	[rowguid] 		[uniqueidentifier] 	NOT NULL,
	[ModifiedDate] 	[datetime] 			NOT NULL,
 CONSTRAINT [UNI_CustomerAddress_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)