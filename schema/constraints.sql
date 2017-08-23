ALTER TABLE [Address] ADD  CONSTRAINT [DF_Address_rowguid]  DEFAULT (newid()) FOR [rowguid]
ALTER TABLE [Address] ADD  CONSTRAINT [DF_Address_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
ALTER TABLE [Customer] ADD  CONSTRAINT [DF_Customer_NameStyle]  DEFAULT ((0)) FOR [NameStyle]
ALTER TABLE [Customer] ADD  CONSTRAINT [DF_Customer_rowguid]  DEFAULT (newid()) FOR [rowguid]
ALTER TABLE [Customer] ADD  CONSTRAINT [DF_Customer_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
ALTER TABLE [CustomerAddress] ADD  CONSTRAINT [DF_CustomerAddress_rowguid]  DEFAULT (newid()) FOR [rowguid]
ALTER TABLE [CustomerAddress] ADD  CONSTRAINT [DF_CustomerAddress_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]

ALTER TABLE [CustomerAddress]  ADD  CONSTRAINT [FK_CustomerAddress_CustomerID] FOREIGN KEY([CustomerID]) REFERENCES [Customer] ([CustomerID])
ALTER TABLE [CustomerAddress]  ADD  CONSTRAINT [FK_CustomerAddress_AddressID] FOREIGN KEY([AddressId]) REFERENCES [Address] ([AddressId])

