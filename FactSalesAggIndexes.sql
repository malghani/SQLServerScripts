IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_PRD_PRF')
	DROP INDEX [Idx_FactSalesAggregate_PRD_PRF] ON [dbo].[FactSalesAggregate]
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_Period')
	DROP INDEX [Idx_FactSalesAggregate_Period] ON [dbo].[FactSalesAggregate];

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_Account')
	DROP INDEX [Idx_FactSalesAggregate_Account] ON [dbo].[FactSalesAggregate]; 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_NationalAccount')
	DROP INDEX [Idx_FactSalesAggregate_NationalAccount] ON [dbo].[FactSalesAggregate];

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_NewUsed')
	DROP INDEX [Idx_FactSalesAggregate_NewUsed] ON [dbo].[FactSalesAggregate] ;

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_Partner')
	DROP INDEX [Idx_FactSalesAggregate_Partner] ON [dbo].[FactSalesAggregate] ;
	
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_Partner_Prod')
	DROP INDEX [Idx_FactSalesAggregate_Partner_Prod] ON [dbo].[FactSalesAggregate] ;

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_PName_Other')
	DROP INDEX [Idx_FactSalesAggregate_PName_Other] ON [dbo].[FactSalesAggregate] ;

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_ProductType_Period')
	DROP INDEX [Idx_FactSalesAggregate_ProductType_Period] ON [dbo].[FactSalesAggregate] ;

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'idx_FactSalesAggregate_ProductType_Period_Term')
	DROP INDEX [idx_FactSalesAggregate_ProductType_Period_Term] ON [dbo].[FactSalesAggregate] ;

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'Idx_FactSalesAggregate_State')
	DROP INDEX [Idx_FactSalesAggregate_State] ON [dbo].[FactSalesAggregate] ;

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSalesAggregate]') AND name = N'idx_FactSalesAggregate_PName')
	DROP INDEX [idx_FactSalesAggregate_PName] ON [dbo].[FactSalesAggregate];

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_PRD_PRF] ON [dbo].[FactSalesAggregate] 
(
	[Period] DESC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON);

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_Period] ON [dbo].[FactSalesAggregate] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 


CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_Account] ON [dbo].[FactSalesAggregate] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_NationalAccount] ON [dbo].[FactSalesAggregate] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_NewUsed] ON [dbo].[FactSalesAggregate] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_Partner] ON [dbo].[FactSalesAggregate] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_Partner_Prod] ON [dbo].[FactSalesAggregate] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_PName_Other] ON [dbo].[FactSalesAggregate] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_ProductType_Period] ON [dbo].[FactSalesAggregate] 
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

CREATE NONCLUSTERED INDEX [idx_FactSalesAggregate_ProductType_Period_Term] ON [dbo].[FactSalesAggregate] 
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
[CanceledAmount],
[AmendedAmount],
[ReinstatedAmount],
[NetReserves],
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [Idx_FactSalesAggregate_State] ON [dbo].[FactSalesAggregate] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx_FactSalesAggregate_PName] ON [dbo].[FactSalesAggregate] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--Select Period, AgreementCountDist=count(distinct agreementid), AgreementCount=count(agreementid), dupes=count(agreementid)-count(distinct agreementid)  From FactSales Group by Period 






