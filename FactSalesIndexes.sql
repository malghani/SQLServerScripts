
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_AgreementID_Period')
	DROP INDEX [Idx_AgreementID_Period] ON [dbo].[FactSales] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Period')
	DROP INDEX [Idx_FactSales_Period] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Account')
	DROP INDEX [Idx_FactSales_Account] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_NationalAccount')
	DROP INDEX [Idx_FactSales_NationalAccount] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_NewUsed')
	DROP INDEX [Idx_FactSales_NewUsed] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Partner')
	DROP INDEX [Idx_FactSales_Partner] ON [dbo].[FactSales] 
	
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Partner_Prod')
	DROP INDEX [Idx_FactSales_Partner_Prod] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_PName_Other')
	DROP INDEX [Idx_FactSales_PName_Other] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_ProductType_Period')
	DROP INDEX [Idx_FactSales_ProductType_Period] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'idx_FactSales_ProductType_Period_Term')
	DROP INDEX [idx_FactSales_ProductType_Period_Term] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_State')
	DROP INDEX [Idx_FactSales_State] ON [dbo].[FactSales] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'idx_FactSales_PName')
	DROP INDEX [idx_FactSales_PName] ON [dbo].[FactSales]


CREATE NONCLUSTERED INDEX [Idx_AgreementID_Period] ON [dbo].[FactSales] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
	
CREATE NONCLUSTERED INDEX [Idx_FactSales_Period] ON [dbo].[FactSales] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSales_Account] ON [dbo].[FactSales] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 


CREATE NONCLUSTERED INDEX [Idx_FactSales_NationalAccount] ON [dbo].[FactSales] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSales_NewUsed] ON [dbo].[FactSales] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSales_Partner] ON [dbo].[FactSales] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSales_Partner_Prod] ON [dbo].[FactSales] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSales_PName_Other] ON [dbo].[FactSales] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSales_PRD_PRF] ON [dbo].[FactSales] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSales_ProductType_Period] ON [dbo].[FactSales] 
(
	[ProductTypeID] ASC,
	[Period] ASC
)
INCLUDE ( [ProductNameID],
[CoverageID],
[TermID],
[CancelCount],
[ClaimsCount],
[NetContractCount],
[GrossContractCount],
[NetReserves],
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx_FactSales_ProductType_Period_Term] ON [dbo].[FactSales] 
(
	[ProductTypeID] ASC,
	[Period] ASC
)
INCLUDE ( [ProductNameID],
[CoverageID],
[TermID],
[CancelCount],
[ClaimsCount],
[NetContractCount],
[GrossContractCount],
[CANAmt],
[AMDAmt],
[RENAmt],
[NetReserves],
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSales_State] ON [dbo].[FactSales] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx_FactSales_PName] ON [dbo].[FactSales] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

