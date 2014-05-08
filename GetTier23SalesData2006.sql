
ALTER PROC GetTier23SalesData2006
@FromPeriod bigint,
@ToPeriod bigint
AS

Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))
-- GetTier23SalesData2006 19000000, 20061231

-- GetTier23SalesData2006 19000000, 19921231
-- GetTier23SalesData2006 19930000, 19961231
-- GetTier23SalesData2006 19970000, 19991231
-- GetTier23SalesData2006 20000000, 20021231
-- GetTier23SalesData2006 20030000, 20041231
-- GetTier23SalesData2006 20050000, 20061231
IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2006')
   DROP TABLE [dbo].[SalesDisbDataHist2006]

CREATE TABLE [dbo].[SalesDisbDataHist2006](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[ADMCLICOD] [varchar](3) NOT NULL,
	[ADMACCCOD] [varchar](10) NOT NULL,
	[ADMAGRCOD] [varchar](20) NOT NULL,
	[ADMAGRSFX] [varchar](3) NOT NULL,
	[ADMPRDCOD] [varchar](10) NOT NULL,
	[CUSTFNAME] [Varchar] (100) NOT NULL,
	[CUSTLNAME] [Varchar] (100) NOT NULL,
	[ADMTRNTYP] [varchar](3) NOT NULL,
	[ADMDISTYP] [varchar](10) NOT NULL,
	[ADMDISCOD] [varchar](10) NOT NULL,
	[Amt] [numeric](38, 2) NULL,
	[AGMPRGCOD] [varchar](10) NOT NULL,	
	[AGDPLNCOD] [varchar](40) NOT NULL,
	[PRDSTS] [varchar](40) NOT NULL,
	[TERM] [numeric](21, 10) NOT NULL,
	[NWUSNA] [varchar](40) NOT NULL,
	[AGMPSTDAT] [numeric](8, 0) NOT NULL,
	[ADMPSTDAT] [numeric](8, 0) NOT NULL,
	[AADREGION] [varchar](10) NOT NULL,
	[VendorID] [int] NULL,
	[VendorName] [Varchar](255) NULL,
	[VendorStatus] [int] NULL,
	[SalesManager] [varchar](255) NULL,
	[AccountName] [varchar](255) NULL,
	[City] [varchar](100) NULL,
	[StateProvince] [varchar](20) NULL,
	[PostalCode] [varchar](12) NULL,
	[Country] [varchar](50) NULL,
	[Partner] [varchar](255) NULL,
	[ProductCategory] [varchar](255) NULL,
	[ProductType] [varchar](255) NULL,
	[ProductName] [varchar](255) NULL,
	[Coverage] [varchar](255) NULL,
	[GrossAmount] [numeric](18, 2) NULL,
	[GrossCount] [int] NULL,
	[NetAmount] [numeric](18, 2) NULL,
	[NetCount] [int] NULL,
CONSTRAINT [pk_SalesDisbDataHist2006] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
) ON [FactData2006]		






INSERT [SalesDisbDataHist2006] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		
--Select * into  SalesDisbDataOld from      drop table SalesDisbData      

FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
							  
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
										ON  a.AGMCLICOD = D.ADMCLICOD AND
										  a.AGMACCCOD = D.ADMACCCOD AND
										  a.AGMAGRCOD = D.ADMAGRCOD AND
										  a.AGMAGRSFX = D.ADMAGRSFX
										  
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM p
															ON a.AGMCLICOD = p.APVCLICOD AND
																  a.AGMACCCOD = p.APVACCCOD AND
																  a.AGMAGRCOD = p.APVAGRCOD AND
																  a.AGMAGRSFX = p.APVAGRSFX AND 
																  D.ADMPRDCOD = p.APVPRDCOD AND 
																  p.APVFLDCOD = '~MVPRDSTS' AND 
																  p.APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PLN
															ON a.AGMCLICOD = PLN.APVCLICOD AND
																  a.AGMACCCOD = PLN.APVACCCOD AND
																  a.AGMAGRCOD = PLN.APVAGRCOD AND
																  a.AGMAGRSFX = PLN.APVAGRSFX AND 
																  D.ADMPRDCOD = PLN.APVPRDCOD AND 
																  PLN.APVFLDCOD = '~MVPLNCOD'
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM TERM
															ON a.AGMCLICOD = TERM.APVCLICOD AND
																  a.AGMACCCOD = TERM.APVACCCOD AND
																  a.AGMAGRCOD = TERM.APVAGRCOD AND
																  a.AGMAGRSFX = TERM.APVAGRSFX AND 
																  D.ADMPRDCOD = TERM.APVPRDCOD AND 
																  TERM.APVFLDCOD = '~MVTRMTIM'
																  
							INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM V
															ON a.AGMCLICOD = V.APVCLICOD AND
																  a.AGMACCCOD = V.APVACCCOD AND
																  a.AGMAGRCOD = V.APVAGRCOD AND
																  a.AGMAGRSFX = V.APVAGRSFX AND 
																  D.ADMPRDCOD = V.APVPRDCOD AND 
																  V.APVFLDCOD = '~MVNWUSNA'		


							  INNER JOIN ( SELECT  AADACCCOD, AADREGION FROM I400DASQL.EFGAS400.SESCSEFG.SCALTADR  R
											 INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM S oN S.AGMACCCOD=R.AADACCCOD
											 WHERE AADADRTYP = 'PRIMARY'
											 Group By AADACCCOD, AADREGION
											) AS ADDR ON ADDR.AADACCCOD=AGMACCCOD
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' 
							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2006 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2006_5Keys] ON [dbo].[SalesDisbDataHist2006] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_AADREGION] ON [dbo].[SalesDisbDataHist2006] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2006] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_D_T_TYP] ON [dbo].[SalesDisbDataHist2006] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_NWUSNA] ON [dbo].[SalesDisbDataHist2006] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_Partner] ON [dbo].[SalesDisbDataHist2006] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_PCat] ON [dbo].[SalesDisbDataHist2006] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_PCoverage] ON [dbo].[SalesDisbDataHist2006] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_PName] ON [dbo].[SalesDisbDataHist2006] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_PType] ON [dbo].[SalesDisbDataHist2006] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_SalesMgr] ON [dbo].[SalesDisbDataHist2006] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_TERM] ON [dbo].[SalesDisbDataHist2006] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2006_VendorID] ON [dbo].[SalesDisbDataHist2006] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]



-- Drop table #CRMData
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


UPDATE D SET AccountName=CRM.AccountName,
             City=CRM.City,
             StateProvince=CRM.StateCode,
             PostalCode=CRM.PostalCode,
             Country=CRM.Country
FROM SalesDisbDataHist2006 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2006 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2006 					
					
UPDATE SalesDisbDataHist2006 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2006 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2006 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2006 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2006 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2006 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2006) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2006) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2006) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2006) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2006) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2006) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2006) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2006) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2006) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2006) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2006) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2006) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2006 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2006 D 
		INNER JOIN MasterProductMatrix M ON 
		D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG 
		AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN
) as cp
LEFT JOIN DimPlan P ON P.PlanName=Cplan
WHERE P.PlanID IS NULL
Group by Cplan

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
SELECT AG.SourcePLNCOD, AG.SourcePLNCOD +' (NO DESC)',0, 1, GETDATE(), GETDATE()  FROM (Select distinct SourcePLNCOD From DimAgreement) AS AG
LEFT JOIN DimPlan D ON D.PlanName=AG.SourcePLNCOD
WHERE D.PLanid is null


INSERT DimAgreementStatus(StatusName, StatusCode, dimType, Active, FromDate, UPdateDate, SourceKey)
Select CASE PRDSTS 
		WHEN 'CANCELLED' THEN 'Cancelled'
		WHEN 'EXPIRED' THEN 'Expired'
		WHEN 'INFORCE' THEN 'Inforce'
		ELSE PRDSTS END,
		PRDSTS, 
		0, 1, GETDATE(), GETDATE(), PRDSTS
		 From SalesDisbDataHist2006 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2006 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2006 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2006 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2006 
		WHERE ADMDISTYP='RESV' 
		GROUP BY ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP	
		
	
	
    Select t.ADMPSTDAT, t.ADMCLICOD, t.ADMACCCOD, t.ADMAGRCOD, t.ADMAGRSFX, t.ADMPRDCOD  into #tmp2
    FROM #tmp t
	--Select * From #tmp t
		INNER JOIN (SELECT t.ADMPSTDAT, t.ADMCLICOD, t.ADMACCCOD, t.ADMAGRCOD, t.ADMAGRSFX, t.ADMPRDCOD FROM #tmp t
					INNER JOIN (Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT From #tmp t
									WHERE ADMTRNTYP='AMD'
									GROUP BY ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) 
					As amd on amd.ADMCLICOD=t.ADMCLICOD and amd.ADMACCCOD=t.ADMACCCOD and 
					amd.ADMAGRCOD=t.ADMAGRCOD and amd.ADMAGRSFX=t.ADMAGRSFX and amd.ADMPRDCOD=t.ADMPRDCOD and amd.ADMPSTDAT=t.ADMPSTDAT
					GROUP BY t.ADMPSTDAT, t.ADMCLICOD, t.ADMACCCOD, t.ADMAGRCOD, t.ADMAGRSFX, t.ADMPRDCOD Having COUNT(*) > 1) AS AMD ON 
					amd.ADMCLICOD=t.ADMCLICOD and amd.ADMACCCOD=t.ADMACCCOD and 
					amd.ADMAGRCOD=t.ADMAGRCOD and amd.ADMAGRSFX=t.ADMAGRSFX and amd.ADMPRDCOD=t.ADMPRDCOD and amd.ADMPSTDAT=t.ADMPSTDAT
	GROUP BY t.ADMPSTDAT, t.ADMCLICOD, t.ADMACCCOD, t.ADMAGRCOD, t.ADMAGRSFX, t.ADMPRDCOD  
	HAVING COUNT(*) > 2
		
--Select * From #tmp t
--INNER JOIN		
--#tmp2 t2 
--ON 
--	t2.ADMCLICOD=t.ADMCLICOD and t2.ADMACCCOD=t.ADMACCCOD and 
--	t2.ADMAGRCOD=t.ADMAGRCOD and t2.ADMAGRSFX=t.ADMAGRSFX and t2.ADMPRDCOD=t.ADMPRDCOD and t2.ADMPSTDAT=t.ADMPSTDAT
--	Order by t.ADMPSTDAT, t.ADMCLICOD, t.ADMACCCOD, t.ADMAGRCOD, t.ADMAGRSFX, t.ADMPRDCOD


--select * From SalesDisbDataHist2006 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2006 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2006
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2006 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2006 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2006
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2006 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2006 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2006
				--WHERE ADMPSTDAT=@PSTDATE
				WHERE ADMDISTYP='RESV'	
					) AS RES
			ON 	RES.ADMCLICOD=D.ADMCLICOD AND RES.ADMACCCOD=D.ADMACCCOD AND RES.ADMAGRCOD=D.ADMAGRCOD AND RES.ADMAGRSFX=D.ADMAGRSFX
			   AND RES.ADMPRDCOD=D.ADMPRDCOD
			WHERE RES.ADMCLICOD IS NULL  AND D.ADMDISTYP<>'RESV'	 
	GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, D.ADMTRNTYP, D.ADMPSTDAT, D.AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID
AND Y.ADMDISTYP<>'RESV'
							

-------- Claim Summary
-- DROP TABLE 

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2006')
   DROP TABLE [dbo].[ClaimSummaryHist2006]
   
SELECT	AEPCLICOD,
		AEPACCCOD,
		AEPAGRCOD,
		AEPAGRSFX,
		AEPPRDCOD,
		AEPYRMON,
		AEPCLMCM=SUM(AEPCLMCM) ,
		AEPCLMITD=SUM(AEPCLMITD),
		AEPERNITD=SUM(AEPERNITD),
		AEPERNCM=SUM(AEPERNCM)
INTO ClaimSummaryHist2006		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2006_AYPYRMON] ON [dbo].[ClaimSummaryHist2006] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2006_5Keys] ON [dbo].[ClaimSummaryHist2006] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]


-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2006')
   DROP TABLE ClaimsHist2006
   
	CREATE TABLE [dbo].[ClaimsHist2006](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2006]

INSERT dbo.ClaimsHist2006 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
SELECT  PRDCLICOD,
		PRDACCCOD,
		PRDAGRCOD,
		PRDAGRSFX,
		PRDPRDCOD,
		PRDCLMTID,
		PRDPAYSTS,		
		PRDPRTDAT=MIN(PRDPRTDAT)
FROM I400DASQL.EFGAS400.SESCSEFG.SCPAYRD 
WHERE PRDPRTDAT BETWEEN @FromPeriod AND @ToPeriod
GROUP BY 
PRDCLICOD,
PRDACCCOD,
PRDAGRCOD,
PRDAGRSFX,
PRDPRDCOD,
PRDCLMTID,
PRDPAYSTS

UPDATE ClaimsHist2006 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2006_PRDPRTDAT] ON [dbo].[ClaimsHist2006] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2006_5Keys] ON [dbo].[ClaimsHist2006] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2006 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2006 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2006 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2006 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2006 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2006 Where PRDAGRCOD=''

Delete ClaimsHist2006 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2006)

--Select * From ClaimsHist2006 WHERE (PRDCLMTID=0 OR PRDPRTDAT=0) and PRDPRTDAT> 20120101
Delete ClaimSummaryHist2006
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2006 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))


UPDATE ClaimsHist2006 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_Period')
DROP INDEX [Idx_FactSales2006_Period] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_Account')
DROP INDEX [Idx_FactSales2006_Account] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_NationalAccount')
DROP INDEX [Idx_FactSales2006_NationalAccount] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_NewUsed')
DROP INDEX [Idx_FactSales2006_NewUsed] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_Partner')
DROP INDEX [Idx_FactSales2006_Partner] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_Partner_Prod')
DROP INDEX [Idx_FactSales2006_Partner_Prod] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_PName_Other')
DROP INDEX [Idx_FactSales2006_PName_Other] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_PRD_PRF')
DROP INDEX [Idx_FactSales2006_PRD_PRF] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_ProductType_Period')
DROP INDEX [Idx_FactSales2006_ProductType_Period] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'idx_FactSales2006_ProductType_Period_Term')
DROP INDEX [idx_FactSales2006_ProductType_Period_Term] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_State')
DROP INDEX [Idx_FactSales2006_State] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_FactSales2006_UniqueIdx')
DROP INDEX [Idx_FactSales2006_UniqueIdx] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'idx_FactSales2006_PName')
DROP INDEX [idx_FactSales2006_PName] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2006]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2006] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2006 for this period.
Delete FactSales2006 Where Period Between @FromPeriod And @ToPeriod
--Truncate Table FactSales2006 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2006 ( 
	Period, AccountID, PartnerID, NationalAccountID, SalesManagerID, 
	StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID,   
	TermID, VehicleStateID, AgreementID, PlanID, FourPartKeyID, AgreementPostedPeriod,


	
	CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD, 
	GrossReserves, NetReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, 
	AmendedReserves, CURCount, AMDCount, CANCount, RENCount, CURAmt, AMDAmt, CANAmt, RENAmt)
	
SELECT
CAL.DATEID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
tm.TermID, vs.VehicleStateID, AGR.AgreementID, PLN.PlanID, FPPK.KeyID, AGMPSTDAT,

CancelCount=ISNULL(Sum(CASE WHEN ADMTRNTYP='CAN' THEN NETCount ELSE 0 END),0),
ClaimsCount=0, --ClaimsCount=ISNULL(SUM(CH.Claims),0),
ClaimsPaidCount=0, --ClaimsPaidCount=ISNULL(SUM(CH.Claims),0),
NetContractCount=ISNULL(Sum(NetCount),0),
GrossContractCount=ISNULL(Sum(GrossCount),0),
ClaimsPaid=0,--ClaimsPaid=ISNULL(SUM(AEPCLMCM),0),
ClaimsPaidITD=0, --ClaimsPaidITD=ISNULL(SUM(AEPCLMITD),0),
EarnedReserves=0, --EarnedReserves=ISNULL(SUM(AEPCLMCM),0),
EarnedReservesITD=0, --EarnedReservesITD=ISNULL(SUM(AEPCLMITD),0),
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0)

 FROM SalesDisbDataHist2006 H (NOLOCK)
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
--WHERE ADMPSTDAT=20140131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales2006 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2006 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2006 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2006
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2006 FS GROUP BY FS.AgreementID
INSERT FactSales2006 ( 
	Period, AccountID, PartnerID, NationalAccountID, SalesManagerID, 
	StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID,   
	TermID, VehicleStateID, AgreementID, PlanID, FourPartKeyID, AgreementPostedPeriod,	
	CancelCount, NetContractCount, GrossContractCount, 
	GrossReserves, NetReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, 
	AmendedReserves, CURCount, AMDCount, CANCount, RENCount, CURAmt, AMDAmt, CANAmt, RENAmt,
	ClaimsCount, ClaimsPaidCount,
	ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD,UnearnedReserves)
	
	
	Select 	
	C.DateID, FS.AccountID, FS.PartnerID, FS.NationalAccountID, FS.SalesManagerID, 
	FS.StateID, FS.ProductCategoryID, FS.ProductTypeID, FS.ProductNameID, FS.CoverageID, 
	FS.TermID, FS.VehicleStateID, FS.AgreementID, FS.PlanID, FS.FourPartKeyID, FS.AgreementPostedPeriod,	
	CancelCount=0, NetContractCount=0, GrossContractCount=0, 
	GrossReserves=0, NetReserves=0, NetWrittenReserves=0, GrossWrittenReserves=0, PremiumReserves=0, 
	AmenededReserves=0, CURCount=0, AMDCount=0, CANCount=0, RENCount=0, CURAmt=0, AMDAmt=0, CANAmt=0, RENAmt=0,
	ClaimsCount=ISNULL(CH.Claims,0),
	ClaimsPaidCount=ISNULL(CH.Claims,0), 
	ClaimsPaid=ISNULL(AEPCLMCM,0), 
	ClaimsPaidITD=ISNULL(AEPCLMITD,0), 
	EarnedReserves=ISNULL(H.AEPERNCM,0),
	EarnedReservesITD=ISNULL(AEPERNITD,0),
	UnearnedReserves=FS.GrossReserves-ISNULL(AEPERNCM,0)
         	
       From  ClaimSummaryHist2006 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2006 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2006 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2006
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2006] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_Period] ON [dbo].[FactSales2006] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_Account] ON [dbo].[FactSales2006] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_NationalAccount] ON [dbo].[FactSales2006] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_NewUsed] ON [dbo].[FactSales2006] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_Partner] ON [dbo].[FactSales2006] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_Partner_Prod] ON [dbo].[FactSales2006] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_PName_Other] ON [dbo].[FactSales2006] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_PRD_PRF] ON [dbo].[FactSales2006] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_ProductType_Period] ON [dbo].[FactSales2006] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_FactSales2006_ProductType_Period_Term] ON [dbo].[FactSales2006] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_State] ON [dbo].[FactSales2006] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE UNIQUE NONCLUSTERED INDEX [Idx_FactSales2006_UniqueIdx] ON [dbo].[FactSales2006] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_FactSales2006_PName] ON [dbo].[FactSales2006] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED


