Declare @FromPeriod bigint=NULL,
@ToPeriod bigint=NULL

IF @FromPeriod IS NULL
	SELECT @FromPeriod = MAX(ADMPSTDAT) FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM
IF @ToPeriod IS NULL
	SELECT @ToPeriod =@FromPeriod

Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))
Declare @ETLDateTime DateTime = GetDate();
Declare @DateFrom DateTime, @DateTo Datetime
SET @DateFrom = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @FromPeriod),6),2)+'/' + RIGHT(Convert(Varchar(8), @FromPeriod),2)+'/'+ LEFT(Convert(Varchar(8), @FromPeriod),4))
SET @DateTo = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @ToPeriod),6),2)+'/' + RIGHT(Convert(Varchar(8), @ToPeriod),2)+'/'+ LEFT(Convert(Varchar(8), @ToPeriod),4))


------------ Delete March Data and Wrong Dimensions ------------------------


Delete FactSales Where Period=20140331
Delete FactSalesAggregate Where Period=20140331
Delete DimAccount Where UpdateDate > '2014/04/01' And AccountID not in (Select distinct AccountID From FactSalesAggregate)
Delete DimNationalAccount Where NationalAccountID not in (Select distinct NationalAccountID From FactSalesAggregate)
Delete DimSalesManager Where SalesManagerID not in (Select distinct SalesManagerID From FactSalesAggregate)

UPDATE FSA SET NationalAccountID=1, SalesManagerID=1
FROM FactSalesAggregate FSA
INNER JOIN DimNationalAccount NA ON  NA.NationalAccountID = FSA.NationalAccountID
INNER JOIN DimSalesManager SM ON SM.SalesManagerID=FSA.SalesManagerID
INNER JOIN DimPartner P ON P.PartnerID=FSA.PartnerID
WHERE NA.NationalAccountID > 1 AND NA.PartnerID=1


UPDATE FS SET NationalAccountID=1, SalesManagerID=1
FROM FactSales FS
INNER JOIN DimNationalAccount NA ON  NA.NationalAccountID = FS.NationalAccountID
INNER JOIN DimSalesManager SM ON SM.SalesManagerID=FS.SalesManagerID
INNER JOIN DimPartner P ON P.PartnerID=FS.PartnerID
WHERE NA.NationalAccountID > 1 AND NA.PartnerID=1


Delete DimNationalAccount Where PartnerID=1 And NationalAccountID>1
Delete DimSalesManager Where NationalAccountID NOT IN (Select NationalAccountID FRoM DimNationalAccount)
Delete FactSalesAggregate Where NationalAccountID in (Select NationalAccountID From DimNationalAccount Where PartnerID=1 And NationalAccountID>1)

-------------------------------------------------------------------------------------



IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'Idx__Staging_LastPull_SalesDisbDataHist_5Keys')
	DROP INDEX [Idx__Staging_LastPull_SalesDisbDataHist_5Keys] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_AADREGION')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_AADREGION] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_AG_AD_PSTDAT')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_AG_AD_PSTDAT] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_D_T_TYP')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_D_T_TYP] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_NWUSNA')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_NWUSNA] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_Partner')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_Partner] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PCat')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PCat] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PCoverage')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PCoverage] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PName')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PName] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PType')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PType] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_SalesMgr')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_SalesMgr] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_TERM')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_TERM] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_VendorID')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_VendorID] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
	

CREATE NONCLUSTERED INDEX [Idx__Staging_LastPull_SalesDisbDataHist_5Keys] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 


CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_AADREGION] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_AG_AD_PSTDAT] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_D_T_TYP] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_NWUSNA] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_Partner] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_PCat] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_PCoverage] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_PName] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_PType] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_SalesMgr] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_TERM] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_SalesDisbDataHist_VendorID] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 



UPDATE _Staging_LastPull_SalesDisbDataHist SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod


UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM _Staging_LastPull_SalesDisbDataHist D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM _Staging_LastPull_SalesDisbDataHist D 
WHERE D.ProductCategory IS NULL
AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

UPDATE _Staging_LastPull_SalesDisbDataHist Set Coverage='N/A' 
Where Coverage IS NULL AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

UPDATE _Staging_LastPull_SalesDisbDataHist Set Partner='EFG' 
Where Partner IS NULL
AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod


Select distinct ltrim(rtrim(an.efg_AccountNumberName)) COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber, ab.name COLLATE SQL_Latin1_General_CP1_CI_AS AccountName, 
Address1_Line1 COLLATE SQL_Latin1_General_CP1_CI_AS Address,
Address1_City  COLLATE SQL_Latin1_General_CP1_CI_AS City,
Address1_StateOrProvince  COLLATE SQL_Latin1_General_CP1_CI_AS StateCode,
Address1_Country  COLLATE SQL_Latin1_General_CP1_CI_AS Country,
Address1_PostalCode  COLLATE SQL_Latin1_General_CP1_CI_AS PostalCode
INTO #CRMData
 From [SV-SQL02].EFG_MSCRM.dbo.Account a
INNER JOIN [SV-SQL02].EFG_MSCRM.dbo.AccountBase ab ON a.accountid = ab.accountid 
LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an ON  an.efg_accountid = a.accountid
WHERE an.EFG_AccountNumberName IS NOT NULL


UPDATE _Staging_LastPull_SalesDisbDataHist
			SET VendorID=NULL,
			SalesManager=NULL,
			VendorStatus=NULL,
			VendorName=NULL,
			AccountName=NULL,
			City=NULL,
			StateProvince=NULL,
			PostalCode=NULL,
			Country=NULL

UPDATE D SET AccountName=CRM.AccountName,
             City=CRM.City,
             StateProvince=CRM.StateCode,
             PostalCode=CRM.PostalCode,
             Country=CRM.Country
FROM _Staging_LastPull_SalesDisbDataHist D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod



UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM _Staging_LastPull_SalesDisbDataHist D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED 
				) AS S ON S.AccountNumber=D.ADMACCCOD
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
AND D.Partner='Santander'


					
UPDATE _Staging_LastPull_SalesDisbDataHist SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE (ISNULL(VendorID, -1)=-1 OR SalesManager IS NULL)
AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod




------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
UPDATE NA Set NationalAccountName=P.VendorName, Status=P.VendorStatus, StatusDesc=CASE P.VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END , UpdateDate=@ETLDateTime
--Select P.VendorName, NA.NationalAccountName, P.VendorStatus, NA.Status, UpdateDate
FROM DimNationalAccount NA 
INNER JOIN (Select Distinct VendorID, VendorStatus, VendorName 
			  From _Staging_LastPull_SalesDisbDataHist 
			  --WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
			  ) P
			  ON P.VendorID=NA.NationalAccountSrcID
WHERE P.VendorName<>NA.NationalAccountName OR P.VendorStatus<>NA.Status


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PR.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, @ETLDateTime, @ETLDateTime, VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From _Staging_LastPull_SalesDisbDataHist WHERE Partner='Santander') P
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountName=VendorName and NA.NationalAccountSrcID=P.VendorID
LEFT JOIN DimPartner PR ON PR.PartnerName=P.Partner AND PR.PartnerName='Santander'
WHERE NA.NationalAccountID IS NULL


UPDATE SM SET SalesManagerName=P.SalesManager, SourceKey=P.SalesManager
---Select distinct NA.PartnerID, NA.NationalAccountName, P.VendorID, SM.SalesManagerName, P.SalesManager
FROM DimSalesManager SM
INNER JOIN DimNationalAccount NA ON NA.NationalAccountID=SM.NationalAccountID AND NationalAccountName<>'N/A'
INNER JOIN (Select Distinct  Partner, VendorID, SalesManager From _Staging_LastPull_SalesDisbDataHist WHERE Partner='Santander') P ON P.VendorID=NA.NationalAccountSrcID 
AND SM.SalesManagerName<>P.SalesManager

/*
Select NationalAccountSrcID, SalesManagerName, count(*) From DimSalesManager DSM
INNER JOIN DimNationalAccount NA ON NA.NationalAccountID=DSM.NationalAccountID
Group by NationalAccountSrcID, SalesManagerName
Having count(*) > 1
*/


INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, @ETLDateTime, @ETLDateTime, P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From _Staging_LastPull_SalesDisbDataHist WHERE Partner='Santander') P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner AND DP.PartnerName='Santander'
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=P.VendorID AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=P.SalesManager And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager


INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, @ETLDateTime, @ETLDateTime, P.NWUSNA From
(Select Distinct NWUSNA  From _Staging_LastPull_SalesDisbDataHist ) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, @ETLDateTime, @ETLDateTime, P.PRDSTS From
(Select Distinct PRDSTS  From _Staging_LastPull_SalesDisbDataHist) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, @ETLDateTime, @ETLDateTime, 
P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From _Staging_LastPull_SalesDisbDataHist) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, @ETLDateTime, @ETLDateTime, SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From _Staging_LastPull_SalesDisbDataHist) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName


UPDATE DA Set AccountName=P.AccountName, UpdateDate=@ETLDateTime
--Select * 
FROM DimAccount DA 
INNER JOIN 
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ADMACCCOD  From _Staging_LastPull_SalesDisbDataHist) P
ON P.ADMACCCOD=DA.SourceKey
WHERE DA.AccountName<>P.AccountName

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, @ETLDateTime, @ETLDateTime, P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ADMACCCOD  From _Staging_LastPull_SalesDisbDataHist ) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

	

-------------------- DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Period')
DROP INDEX [Idx_FactSales_Period] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Account')
DROP INDEX [Idx_FactSales_Account] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_NationalAccount')
DROP INDEX [Idx_FactSales_NationalAccount] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_NewUsed')
DROP INDEX [Idx_FactSales_NewUsed] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Partner')
DROP INDEX [Idx_FactSales_Partner] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_Partner_Prod')
DROP INDEX [Idx_FactSales_Partner_Prod] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_PName_Other')
DROP INDEX [Idx_FactSales_PName_Other] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_PRD_PRF')
DROP INDEX [Idx_FactSales_PRD_PRF] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_ProductType_Period')
DROP INDEX [Idx_FactSales_ProductType_Period] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'idx_FactSales_ProductType_Period_Term')
DROP INDEX [idx_FactSales_ProductType_Period_Term] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_State')
DROP INDEX [Idx_FactSales_State] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'idx_FactSales_PName')
DROP INDEX [idx_FactSales_PName] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_AgreementID_Period')
DROP INDEX [Idx_FactSales_AgreementID_Period] ON [dbo].[FactSales] WITH ( ONLINE = OFF )


Delete FactSales WHERE Period Between @FromPeriod AND @ToPeriod

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales ( 
	Period, AccountID, PartnerID, NationalAccountID, SalesManagerID, 
	StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID,   
	TermID, VehicleStateID, AgreementID, PlanID, FourPartKeyID, AgreementPostedPeriod,


	
	CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD, 
	GrossReserves, NetReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, 
	AmendedReserves, CURCount, AMDCount, CANCount, RENCount, CURAmt, AMDAmt, CANAmt, RENAmt, ETLExtractDateTime, ETLUpdateDateTime)
	
SELECT
CAL.DATEID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
tm.TermID, vs.VehicleStateID, AGR.AgreementID, PLN.PlanID, FPPK.KeyID, AGMPSTDAT,

CancelCount=ISNULL(Sum(CASE WHEN ADMTRNTYP='CAN' THEN NETCount ELSE 0 END),0),
ClaimsCount=0, 
ClaimsPaidCount=0, 
NetContractCount=ISNULL(Sum(NetCount),0),
GrossContractCount=ISNULL(Sum(GrossCount),0),
ClaimsPaid=0,
ClaimsPaidITD=0, 
EarnedReserves=0, 
EarnedReservesITD=0, 
GrossReserves=ISNULL(Sum(CASE WHEN ADMTRNTYP='CUR' AND ADMDISTYP='RESV' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0.0 END),0),
NetReserves=ISNULL(Sum(CASE WHEN ADMDISTYP='RESV' THEN Amt ELSE 0.0 END),0),
UnearnedReserves=0, 
NetWrittenReserves=ISNULL(Sum(CASE WHEN ADMDISTYP='RESV' THEN Amt ELSE 0.0 END),0),
GrossWrittenReserves=ISNULL(Sum(CASE WHEN ADMTRNTYP='CUR' AND ADMDISTYP='RESV' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0.0 END),0),
PremiumReserves=ISNULL(Sum(CASE WHEN ADMDISTYP='RESV' THEN Amt ELSE 0.0 END),0),
AmendedReserves=ISNULL(Sum(CASE WHEN ADMTRNTYP='CUR' AND ADMDISTYP='RESV' AND ADMPSTDAT<>AGMPSTDAT THEN Amt ELSE 0.0 END),0)+ISNULL(Sum(CASE WHEN ADMTRNTYP='AMD' AND ADMDISTYP='RESV' THEN Amt ELSE 0.0 END), 0),
CURCount=ISNULL(Sum(CASE WHEN ADMTRNTYP='CUR' THEN NetCount ELSE 0 END),0),
AMDCount=ISNULL(Sum(CASE WHEN ADMTRNTYP='AMD' THEN NetCount ELSE 0 END),0),
CANCount=ISNULL(Sum(CASE WHEN ADMTRNTYP='CAN' THEN NetCount ELSE 0 END),0),
RENCount=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN NetCount ELSE 0 END),0),
CURAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='CUR' THEN H.NetAmount ELSE 0 END),0),
AMDAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='AMD' THEN H.NetAmount ELSE 0 END), 0),
CANAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='CAN' THEN H.NetAmount ELSE 0 END), 0),
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0) , @ETLDateTime, @ETLDateTime


  FROM _Staging_LastPull_SalesDisbDataHist H (NOLOCK)
INNER JOIN DimAccount AN (NOLOCK) ON AN.EFGAccountCode=H.ADMACCCOD
INNER JOIN DimPartner PRT (NOLOCK) ON PRT.SourceKey=H.Partner
INNER JOIN DimNationalAccount NA (NOLOCK) ON NA.NationalAccountSrcID=H.VendorID AND NA.PartnerID=PRT.PartnerID
INNER JOIN DimSalesManager SM (NOLOCK) ON SM.SourceKey=H.SalesManager AND SM.NationalAccountID=NA.NationalAccountID
INNER JOIN DimState ST (NOLOCK) ON ST.SourceKey=H.AADREGION
INNER JOIN DimProductCategory PC (NOLOCK) ON PC.SourceKey=H.ProductCategory
INNER JOIN DimProductType PT (NOLOCK) ON PT.SourceKey=H.ProductType
INNER JOIN DimProductName PN (NOLOCK) ON PN.SourceKey=H.ProductName
INNER JOIN DimCoverage CV (NOLOCK) ON CV.SourceKey=H.Coverage
INNER JOIN DimTerms TM (NOLOCK) ON TM.SourceKey=H.TERM
INNER JOIN DimVehicleState VS (NOLOCK) ON VS.SourceKey=H.NWUSNA
INNER JOIN Calendar CAL (NOLOCK) ON CAL.DateID=H.ADMPSTDAT
INNER JOIN DimAgreement AGR (NOLOCK) ON AGR.SourceCLICOD=H.ADMCLICOD 
		AND AGR.SourceACCCOD=H.ADMACCCOD AND AGR.SourceAGRCOD=ADMAGRCOD 
		AND AGR.SourcePRDCOD=H.ADMPRDCOD AND AGR.SourceAGRSFX=H.ADMAGRSFX
LEFT JOIN DimPlan PLN(NOLOCK) ON PLN.PlanName=H.AGDPLNCOD
LEFT JOIN DimAgreementStatus AGS (NOLOCK) ON AGS.SourceKey=H.ADMTRNTYP
LEFT JOIN DimFourPartProductKey FPPK (NOLOCK) ON FPPK.ClientCode=H.ADMCLICOD AND FPPK.ProgramCode=H.AGMPRGCOD 
                                              AND FPPK.ProductCode=H.ADMPRDCOD AND FPPK.PlanCode=H.AGDPLNCOD
--WHERE ADMPSTDAT=0131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID



		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-ISNULL(AEPERNCM,0)

       From FactSales FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN _Staging_LastPull_ClaimSummaryHist H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From _Staging_LastPull_ClaimsHist
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
WHERE FS.Period Between @FromPeriod And @ToPeriod



	
	Select 	
	C.DateID, BA.AccountID, BA.PartnerID, BA.NationalAccountID, BA.SalesManagerID, 
	BA.StateID, BA.ProductCategoryID, BA.ProductTypeID, BA.ProductNameID, BA.CoverageID, 
	BA.TermID, BA.VehicleStateID, BA.AgreementID, BA.PlanID, BA.FourPartKeyID, BA.AgreementPostedPeriod,	
	CancelCount=0, NetContractCount=0, GrossContractCount=0, 
	GrossReserves=0, NetReserves=0, NetWrittenReserves=0, GrossWrittenReserves=0, PremiumReserves=0, 
	AmenededReserves=0, CURCount=0, AMDCount=0, CANCount=0, RENCount=0, CURAmt=0, AMDAmt=0, CANAmt=0, RENAmt=0,
	ClaimsCount=ISNULL(CH.Claims,0),
	ClaimsPaidCount=ISNULL(CH.Claims,0), 
	ClaimsPaid=ISNULL(AEPCLMCM,0), 
	ClaimsPaidITD=ISNULL(AEPCLMITD,0), 
	EarnedReserves=ISNULL(H.AEPERNCM,0),
	EarnedReservesITD=ISNULL(AEPERNITD,0),
	UnearnedReserves=BA.NetReserves-ISNULL(AEPERNCM,0)
    into #tmp	   
       From  _Staging_LastPull_ClaimSummaryHist H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From _Staging_LastPull_ClaimsHist
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

		
INSERT FactSales ( 
	Period, AccountID, PartnerID, NationalAccountID, SalesManagerID, 
	StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID,   
	TermID, VehicleStateID, AgreementID, PlanID, FourPartKeyID, AgreementPostedPeriod,	
	CancelCount, NetContractCount, GrossContractCount, 
	GrossReserves, NetReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, 
	AmendedReserves, CURCount, AMDCount, CANCount, RENCount, CURAmt, AMDAmt, CANAmt, RENAmt,
	ClaimsCount, ClaimsPaidCount,
	ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD,UnearnedReserves)
SELECT * From #tmp	
	
	UPDATE FactSales Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0 AND Period Between @FromPeriod And @ToPeriod
	
--	------------------ RECREATE INDEXES --------------------------------------------------
	
--CREATE NONCLUSTERED INDEX [Idx_FactSales_Period] ON [dbo].[FactSales] 
--(
--	[Period] DESC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_Account] ON [dbo].[FactSales] 
--(
--	[AccountID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_NationalAccount] ON [dbo].[FactSales] 
--(
--	[NationalAccountID] ASC,
--	[SalesManagerID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_NewUsed] ON [dbo].[FactSales] 
--(
--	[VehicleStateID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_Partner] ON [dbo].[FactSales] 
--(
--	[PartnerID] ASC
--)
--INCLUDE ( 
--[Period],
--[AccountID],
--[SalesManagerID],
--[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_Partner_Prod] ON [dbo].[FactSales] 
--(
--	[PartnerID] ASC
--)
--INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_PName_Other] ON [dbo].[FactSales] 
--(
--	[ProductNameID] ASC,
--	[PartnerID] ASC,
--	[Period] ASC
--)
--INCLUDE ( [AccountID],
--[SalesManagerID],
--[StateID],
--[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

--CREATE NONCLUSTERED INDEX [Idx_FactSales_PRD_PRF] ON [dbo].[FactSales] 
--(
--	[Period] ASC,
--	[ProductNameID] ASC,
--	[AccountID] ASC,
--	[SalesManagerID] ASC,
--	[StateID] ASC,
--	[NationalAccountID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
--CREATE NONCLUSTERED INDEX [Idx_FactSales_ProductType_Period] ON [dbo].[FactSales] 
--(
--	[ProductTypeID] ASC,
--	[Period] ASC
--)
--INCLUDE ( [ProductNameID],
--[CoverageID],
--[TermID],
--[CancelCount],
--[ClaimsCount],
--[NetContractCount],
--[GrossContractCount],
--[NetReserves],
--[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
--CREATE NONCLUSTERED INDEX [idx_FactSales_ProductType_Period_Term] ON [dbo].[FactSales] 
--(
--	[ProductTypeID] ASC,
--	[Period] ASC
--)
--INCLUDE ( [ProductNameID],
--[CoverageID],
--[TermID],
--[CancelCount],
--[ClaimsCount],
--[NetContractCount],
--[GrossContractCount],
--[CANAmt],
--[AMDAmt],
--[RENAmt],
--[NetReserves],
--[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
--CREATE NONCLUSTERED INDEX [Idx_FactSales_State] ON [dbo].[FactSales] 
--(
--	[StateID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
--CREATE NONCLUSTERED INDEX [Idx_FactSales_AgreementID_Period] ON [dbo].[FactSales] 
--(
--	[Period] ASC,
--	[AgreementID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
--CREATE NONCLUSTERED INDEX [idx_FactSales_PName] ON [dbo].[FactSales] 
--(
--	[ProductNameID] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

Declare @RecCountPerPeriod int
Select @RecCountPerPeriod = Count(*) From FactSales Where Period Between @FromPeriod And @ToPeriod



------------------- RECREATE AGGREGATE TABLE  (FactSalesAggregate) --------------  

Declare @Periods TABLE (Period bigint)
Declare @MaxPeriod bigint

Select @MaxPeriod = Max(period) From FactSalesAggregate
If @MaxPeriod > @ToPeriod
   SET @ToPeriod = @MaxPeriod


INSERT @Periods (Period)
SELECT DateID From Calendar Where DateID Between @FromPeriod And @ToPeriod Group by DateID Order by DateID

IF Exists(Select * From FactSalesAggregate Where Period Between @FromPeriod And @ToPeriod)
	Begin
		Delete FactSalesAggregate Where Period Between @FromPeriod And @ToPeriod
	End 

   DECLARE @Period bigint   
   DECLARE period_cursor CURSOR  STATIC LOCAL 
      FOR
       SELECT Period From @Periods Order by Period-- Order is very Important for ITD being sum of previous
	  
   OPEN period_cursor
   FETCH NEXT FROM period_cursor INTO @Period
   WHILE (@@fetch_status <> -1)
   BEGIN  
      EXEC _ETL_T2T3_AggregateFactSales @Period
	  --SELECT 'Processed ' + Convert(Varchar, @Period)
      FETCH NEXT FROM period_cursor INTO @Period
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor
   

------------------------- PROCESS REPORT PARAMETERS
EXEC _ETL_T2T3_ProcessReportsParameters
---

--DROP INDEXES
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'Idx__Staging_LastPull_SalesDisbDataHist_5Keys')
	DROP INDEX [Idx__Staging_LastPull_SalesDisbDataHist_5Keys] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_AADREGION')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_AADREGION] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_AG_AD_PSTDAT')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_AG_AD_PSTDAT] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_D_T_TYP')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_D_T_TYP] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_NWUSNA')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_NWUSNA] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_Partner')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_Partner] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PCat')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PCat] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PCoverage')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PCoverage] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PName')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PName] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_PType')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_PType] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_SalesMgr')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_SalesMgr] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_TERM')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_TERM] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'idx__Staging_LastPull_SalesDisbDataHist_VendorID')
	DROP INDEX [idx__Staging_LastPull_SalesDisbDataHist_VendorID] ON [dbo].[_Staging_LastPull_SalesDisbDataHist] 


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimsHist]') AND name = N'idx__Staging_LastPull_ClaimsHist_PRDPRTDAT')
	DROP INDEX [idx__Staging_LastPull_ClaimsHist_PRDPRTDAT] ON [dbo].[_Staging_LastPull_ClaimsHist]
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimsHist]') AND name = N'idx__Staging_LastPull_ClaimsHist_5Keys')
	DROP INDEX [idx__Staging_LastPull_ClaimsHist_5Keys] ON [dbo].[_Staging_LastPull_ClaimsHist] 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimSummaryHist]') AND name = N'_Staging_LastPull_idx_ClaimSummaryHist_AYPYRMON')
	DROP INDEX [_Staging_LastPull_idx_ClaimSummaryHist_AYPYRMON] ON [dbo].[_Staging_LastPull_ClaimSummaryHist] 

INSERT dbo.ETL_Log (ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, [Parameters], ProcedureName)
SELECT 'SAL_TIER_2', @ETLDateTime, @FromPeriod, @DateFrom, 1, NULL, @RecCountPerPeriod,'For Periods  [' + ISNULL(Convert(Varchar, @FromPeriod),'NULL') + '] AND  [' + ISNULL(Convert(Varchar, @ToPeriod),'NULL')+']',  '_ETL_T2T3_'




