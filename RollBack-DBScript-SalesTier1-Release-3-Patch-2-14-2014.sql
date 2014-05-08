USE EFGSales
GO
SET NOCOUNT OFF 
GO
GO
DROP INDEX [tier1_acctgrp] ON [dbo].[SAL002_Tier1_Sales] WITH ( ONLINE = OFF )
GO
DROP INDEX [tier1_LOB] ON [dbo].[SAL002_Tier1_Sales] WITH ( ONLINE = OFF )
GO
DROP INDEX [tier1_prod] ON [dbo].[SAL002_Tier1_Sales] WITH ( ONLINE = OFF )
GO
GO
DROP INDEX [SAL002_Tier_Sales_YTD_PSTDT] ON [dbo].[SAL002_Tier1_Sales_YTD] WITH ( ONLINE = OFF )
GO
DROP INDEX [sal002_tier1_sales_ytd_Idx1] ON [dbo].[SAL002_Tier1_Sales_YTD] WITH ( ONLINE = OFF )
GO
DROP INDEX [tier1_ytd_] ON [dbo].[SAL002_Tier1_Sales_YTD] WITH ( ONLINE = OFF )
GO
DROP INDEX [tier1_ytd_acctgrp] ON [dbo].[SAL002_Tier1_Sales_YTD] WITH ( ONLINE = OFF )
GO
			TRUNCATE TABLE dbo.MasterProductMatrix  
			INSERT dbo.MasterProductMatrix (CLICOD, ClientDesc, Partner, Category, Type, ProductName, CProg, ProgramDesc, CProd, ProductDesc, CPlan, PlanDesc, Coverage)
			SELECT CLICOD, ClientDesc, Partner, Category, Type, ProductName, CProg, ProgramDesc, CProd, ProductDesc, CPlan, PlanDesc, Coverage
			FROM dbo.MDM
GO			
-- Change the Open Month
		UPDATE S Set ProductType=NULL, ProductCategory=NULL, ProductName=NULL
		from SAL002_Tier1_Sales S
GO
		UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
		from SAL002_Tier1_Sales S
		INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
GO

		UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
		-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
		from SAL002_Tier1_Sales S
		LEFT JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
		WHERE M.Category IS NULL 
GO

		UPDATE SAL002_Tier1_Sales
		SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
		Where (cprog like 'SAN%'  OR cprog like 'SG%') 
GO

-- Change the History
GO
		UPDATE S Set ProductType=NULL, ProductCategory=NULL, ProductName=NULL
		from SAL002_Tier1_Sales_YTD S
GO
		UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
		from SAL002_Tier1_Sales_YTD S
		INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
GO

		UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
		-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
		from SAL002_Tier1_Sales_YTD S
		LEFT JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
		WHERE M.Category IS NULL 
GO

		UPDATE SAL002_Tier1_Sales_YTD
		SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
		Where (cprog like 'SAN%'  OR cprog like 'SG%') 
GO
CREATE NONCLUSTERED INDEX [SAL002_Tier_Sales_YTD_PSTDT] ON [dbo].[SAL002_Tier1_Sales_YTD] 
(
	[ADMPSTDAT] ASC,
	[AGMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [sal002_tier1_sales_ytd_Idx1] ON [dbo].[SAL002_Tier1_Sales_YTD] 
(
	[LOB] ASC,
	[EFG_Rep] ASC
)
INCLUDE ( [Account_Group],
[Dealer_Name],
[ProductName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [tier1_ytd_] ON [dbo].[SAL002_Tier1_Sales_YTD] 
(
	[ProductName] ASC,
	[ProductType] ASC,
	[ProductCategory] ASC,
	[cprod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [tier1_ytd_acctgrp] ON [dbo].[SAL002_Tier1_Sales_YTD] 
(
	[Account_Group] ASC,
	[Dealer_Name] ASC
)
INCLUDE ( [ProductName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [tier1_acctgrp] ON [dbo].[SAL002_Tier1_Sales] 
(
	[Account_Group] ASC,
	[Dealer_Name] ASC
)
INCLUDE ( [ProductName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [tier1_LOB] ON [dbo].[SAL002_Tier1_Sales] 
(
	[LOB] ASC,
	[EFG_Rep] ASC
)
INCLUDE ( [Account_Group],
[Dealer_Name],
[ProductName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [tier1_prod] ON [dbo].[SAL002_Tier1_Sales] 
(
	[ProductName] ASC,
	[ProductType] ASC,
	[ProductCategory] ASC,
	[cprod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
PRINT 'SCRIPT FINISHED SUCCESSFULLY'


       