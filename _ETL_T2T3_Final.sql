/****** Object:  StoredProcedure [dbo].[_ETL_T2T3_GetTier23SalesData]    Script Date: 4/11/2014 12:38:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[_ETL_T2T3_GetTier23SalesData]
@FromPeriod bigint=NULL,
@ToPeriod bigint=NULL
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

IF @FromPeriod IS NULL
	SELECT @FromPeriod = MAX(ADMPSTDAT) FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM
IF @ToPeriod IS NULL
	SELECT @ToPeriod =@FromPeriod

	
IF @FromPeriod<20080000
  Begin
			PRINT 'Cannot Process Prior to 2008.'
			RETURN(0)  --No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.
  End

Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))
Declare @ETLDateTime DateTime = GetDate();
Declare @DateFrom DateTime, @DateTo Datetime
SET @DateFrom = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @FromPeriod),6),2)+'/' + RIGHT(Convert(Varchar(8), @FromPeriod),2)+'/'+ LEFT(Convert(Varchar(8), @FromPeriod),4))
SET @DateTo = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @ToPeriod),6),2)+'/' + RIGHT(Convert(Varchar(8), @ToPeriod),2)+'/'+ LEFT(Convert(Varchar(8), @ToPeriod),4))


-------- DROP INDEXES 
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



Truncate TABLE [dbo].[_Staging_LastPull_SalesDisbDataHist]

INSERT [_Staging_LastPull_SalesDisbDataHist] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt,
		A.AGMPRGCOD, D.ADMPRDCOD, AGDPLNCOD,AGDPRDSTS PRDSTS, AGDTRMTIM TERM, O.AGDNWUSNA NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT, ADDR.AADREGION		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
							  
							   INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D
										ON  a.AGMCLICOD = D.ADMCLICOD AND
										  a.AGMACCCOD = D.ADMACCCOD AND
										  a.AGMAGRCOD = D.ADMAGRCOD AND
										  a.AGMAGRSFX = D.ADMAGRSFX
							  

							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.AGDTA00 O
															ON a.AGMCLICOD = O.AGDCLICOD AND
																  a.AGMACCCOD = O.AGDACCCOD AND
																  a.AGMAGRCOD = O.AGDAGRCOD AND 
																  a.AGMAGRSFX = O.AGDAGRSFX AND 
																  D.ADMPRDCOD = O.AGDPRDCOD AND AGDPRDSTS IN ('INFORCE','CANCELLED','EXPIRED')

							  INNER JOIN ( SELECT  AADACCCOD, AADREGION FROM I400DASQL.EFGAS400.SESCSEFG.SCALTADR  R
											 INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM S oN S.AGMACCCOD=R.AADACCCOD
											 WHERE AADADRTYP = 'PRIMARY'
											 Group By AADACCCOD, AADREGION
											) AS ADDR ON ADDR.AADACCCOD=AGMACCCOD
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY 
D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, AGDPLNCOD, AGDPRDSTS, AGDTRMTIM, AGDNWUSNA,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE _Staging_LastPull_SalesDisbDataHist SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END
WHERE ADMPSTDAT between @FromPeriod AND @ToPeriod


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
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

					
UPDATE _Staging_LastPull_SalesDisbDataHist SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE (ISNULL(VendorID, -1)=-1 OR SalesManager IS NULL)
AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

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


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, @ETLDateTime, @ETLDateTime, P.Partner From
(Select Distinct Partner From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, @ETLDateTime, @ETLDateTime, VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, @ETLDateTime, @ETLDateTime, P.NWUSNA From
(Select Distinct NWUSNA  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, @ETLDateTime, @ETLDateTime, P.PRDSTS From
(Select Distinct PRDSTS  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, @ETLDateTime, @ETLDateTime, P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From _Staging_LastPull_SalesDisbDataHist) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, @ETLDateTime, @ETLDateTime, SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, @ETLDateTime, @ETLDateTime, P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, @ETLDateTime, @ETLDateTime, P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ADMACCCOD  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, @ETLDateTime, @ETLDateTime, Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, @ETLDateTime, @ETLDateTime, ProductCategory From
(Select Distinct  ProductCategory  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, @ETLDateTime, @ETLDateTime, ProductType From
(Select Distinct  ProductCategory, ProductType  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, @ETLDateTime, @ETLDateTime, P.ProductName From
(Select Distinct  ProductType, ProductName  From _Staging_LastPull_SalesDisbDataHist WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, @ETLDateTime, @ETLDateTime, P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) 
	From _Staging_LastPull_SalesDisbDataHist 
	WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, @ETLDateTime, @ETLDateTime From 
(
		Select Distinct CPlan, PlanDesc 
		FROM _Staging_LastPull_SalesDisbDataHist D 
		INNER JOIN MasterProductMatrix M ON 
		D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG 
		AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN
		WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
) as cp
LEFT JOIN DimPlan P ON P.PlanName=Cplan
WHERE P.PlanID IS NULL
Group by Cplan

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
SELECT AG.SourcePLNCOD, AG.SourcePLNCOD +' (NO DESC)',0, 1, @ETLDateTime, @ETLDateTime  FROM (Select distinct SourcePLNCOD From DimAgreement) AS AG
LEFT JOIN DimPlan D ON D.PlanName=AG.SourcePLNCOD
WHERE D.PLanid is null


INSERT DimAgreementStatus(StatusName, StatusCode, dimType, Active, FromDate, UPdateDate, SourceKey)
Select CASE PRDSTS 
		WHEN 'CANCELLED' THEN 'Cancelled'
		WHEN 'EXPIRED' THEN 'Expired'
		WHEN 'INFORCE' THEN 'Inforce'
		ELSE PRDSTS END,
		PRDSTS, 
		0, 1, @ETLDateTime, @ETLDateTime, PRDSTS
		 From _Staging_LastPull_SalesDisbDataHist H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (
			SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD 
			FROM _Staging_LastPull_SalesDisbDataHist 
			WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
			GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H 
				ON SourceACCCOD=H.ADMACCCOD AND 
				   SourceCLICOD=H.ADMCLICOD AND 
				   SourceAGRCOD=H.ADMAGRCOD AND 
				   SourceAGRSFX=H.ADMAGRSFX AND 
				   SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN _Staging_LastPull_SalesDisbDataHist LS ON LS.ID=H.ID AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, @ETLDateTime, @ETLDateTime, P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName 
	From _Staging_LastPull_SalesDisbDataHist 
	WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 


Update _Staging_LastPull_SalesDisbDataHist SET GrossAmount=0, NetAmount=0, GrossCount=0, NetCount=0 WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
UPDATE _Staging_LastPull_SalesDisbDataHist
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	
AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod


UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
	NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
			 CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM _Staging_LastPull_SalesDisbDataHist Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM _Staging_LastPull_SalesDisbDataHist
	WHERE ADMDISTYP='RESV'
	AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

-- Contracts that don't have Reserves... Need to be counted in Net and Gross...
UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
	NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
			 CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM _Staging_LastPull_SalesDisbDataHist Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM _Staging_LastPull_SalesDisbDataHist D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM _Staging_LastPull_SalesDisbDataHist				
				WHERE ADMDISTYP='RESV'	AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod
					) AS RES
			ON 	RES.ADMCLICOD=D.ADMCLICOD AND RES.ADMACCCOD=D.ADMACCCOD AND RES.ADMAGRCOD=D.ADMAGRCOD AND RES.ADMAGRSFX=D.ADMAGRSFX
			   AND RES.ADMPRDCOD=D.ADMPRDCOD
			WHERE RES.ADMCLICOD IS NULL  AND D.ADMDISTYP<>'RESV'	
			AND ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod 
	GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, D.ADMTRNTYP, D.ADMPSTDAT, D.AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID
AND Y.ADMDISTYP<>'RESV'
WHERE ADMPSTDAT BETWEEN @FromPeriod AND @ToPeriod

--------------------------------------- PAID CLAIMS COUNTS --------------------------------------
-------- DROP INDEXES 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimsHist]') AND name = N'idx__Staging_LastPull_ClaimsHist_PRDPRTDAT')
	DROP INDEX [idx__Staging_LastPull_ClaimsHist_PRDPRTDAT] ON [dbo].[_Staging_LastPull_ClaimsHist]
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimsHist]') AND name = N'idx__Staging_LastPull_ClaimsHist_5Keys')
	DROP INDEX [idx__Staging_LastPull_ClaimsHist_5Keys] ON [dbo].[_Staging_LastPull_ClaimsHist] 


TRUNCATE TABLE [dbo].[_Staging_LastPull_ClaimsHist]
INSERT dbo._Staging_LastPull_ClaimsHist (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDCHKAMT, PRDPAYSTS, PRDPRTDATMIN)
SELECT  PRDCLICOD,
		PRDACCCOD,
		PRDAGRCOD,
		PRDAGRSFX,
		PRDPRDCOD,
		PRDCLMTID,
		PRDCHKAMT=SUM(PRDCHKAMT),
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

UPDATE _Staging_LastPull_ClaimsHist SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6) 
UPDATE _Staging_LastPull_ClaimsHist SET PRDPRTDAT=0 WHERE PRDPRTDATMIN=0
UPDATE _Staging_LastPull_ClaimsHist 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
	PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
	PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
	PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
	PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))


CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_ClaimsHist_PRDPRTDAT] ON [dbo].[_Staging_LastPull_ClaimsHist] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE NONCLUSTERED INDEX [idx__Staging_LastPull_ClaimsHist_5Keys] ON [dbo].[_Staging_LastPull_ClaimsHist] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

-- REMOVE VOIDED CLAIMS
Delete CL
	From dbo._Staging_LastPull_ClaimsHist CL
	INNER JOIN 
	(	Select PRDCLMTID, PRDPRTDAT FROM dbo._Staging_LastPull_ClaimsHist WHERE PRDPAYSTS='V'      
		GROUP BY PRDCLMTID, PRDPRTDAT 	
	) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
	From dbo._Staging_LastPull_ClaimsHist CL
	INNER JOIN 
	(	Select PRDCLMTID, PRDPRTDAT FROM dbo._Staging_LastPull_ClaimsHist WHERE PRDPAYSTS='V'
		GROUP BY PRDCLMTID, PRDPRTDAT 
	) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT
Delete _Staging_LastPull_ClaimsHist Where PRDCLMTID=0 OR PRDPRTDAT=0 OR PRDPRTDAT IS NULL OR PRDAGRCOD='' OR PRDPRTDAT>@PYRMONTO




							
----------------------------------- EARNINGS AND PAID CLAIM AMOUNTS --------------------------------
-------- DROP INDEXES 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimSummaryHist]') AND name = N'_Staging_LastPull_cidx_ClaimSummaryHist')
	ALTER TABLE [dbo].[_Staging_LastPull_ClaimSummaryHist] DROP CONSTRAINT [_Staging_LastPull_cidx_ClaimSummaryHist] 

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_ClaimSummaryHist]') AND name = N'_Staging_LastPull_idx_ClaimSummaryHist_AYPYRMON')
	DROP INDEX [_Staging_LastPull_idx_ClaimSummaryHist_AYPYRMON] ON [dbo].[_Staging_LastPull_ClaimSummaryHist] 

Truncate Table _Staging_LastPull_ClaimSummaryHist

INSERT _Staging_LastPull_ClaimSummaryHist (AEPCLICOD, AEPACCCOD, AEPAGRCOD, AEPAGRSFX, AEPPRDCOD, AEPYRMON, AEPCLMCM, AEPCLMITD, AEPERNITD, AEPERNCM)
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
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON

UPDATE _Staging_LastPull_ClaimSummaryHist 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))


ALTER TABLE [dbo].[_Staging_LastPull_ClaimSummaryHist] ADD  CONSTRAINT [_Staging_LastPull_cidx_ClaimSummaryHist] PRIMARY KEY CLUSTERED 
(
	[AEPYRMON] ASC,
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)


CREATE NONCLUSTERED INDEX [_Staging_LastPull_idx_ClaimSummaryHist_AYPYRMON] ON [dbo].[_Staging_LastPull_ClaimSummaryHist]
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

Delete [_Staging_LastPull_ClaimSummaryHist]
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0



------------------ DROP INDEXES FREOM FACT 
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

-------------- INSERT EARNINGS RECORDS
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL AND FS.Period Between @FromPeriod And @ToPeriod
Group by FS.AgreementID


INSERT FactSales ( 
	Period, AccountID, PartnerID, NationalAccountID, SalesManagerID, 
	StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID,   
	TermID, VehicleStateID, AgreementID, PlanID, FourPartKeyID, AgreementPostedPeriod,	
	CancelCount, NetContractCount, GrossContractCount, 
	GrossReserves, NetReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, 
	AmendedReserves, CURCount, AMDCount, CANCount, RENCount, CURAmt, AMDAmt, CANAmt, RENAmt,
	ClaimsCount, ClaimsPaidCount,
	ClaimsPaid, ClaimsPaidITD, EarnedReserves,EarnedReservesITD,UnearnedReserves)
	
	
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
	
	UPDATE FactSales Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0 AND Period Between @FromPeriod And @ToPeriod
	-------------------- RECREATE INDEXES --------------------------------------------------
	
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
INCLUDE ( 
[Period],
[AccountID],
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
CREATE NONCLUSTERED INDEX [Idx_FactSales_AgreementID_Period] ON [dbo].[FactSales] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
CREATE NONCLUSTERED INDEX [idx_FactSales_PName] ON [dbo].[FactSales] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

Declare @RecCountPerPeriod int
Select @RecCountPerPeriod = Count(*) From FactSales Where Period Between @FromPeriod And @ToPeriod

INSERT dbo.ETL_Log (ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, [Parameters], ProcedureName)
SELECT 'SAL_TIER_2', @ETLDateTime, @FromPeriod, @DateFrom, 1, NULL, @RecCountPerPeriod,'For Periods  [' + ISNULL(Convert(Varchar, @FromPeriod),'NULL') + '] AND  [' + ISNULL(Convert(Varchar, @ToPeriod),'NULL')+']',  '_ETL_T2T3_'


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
      --EXEC _ETL_T2T3_AggregateFactSales @Period
	  
	  -------------------------- THIS IS AN SP With @Period as parameter ------------------------

									Delete FactSalesAggregate WHERE Period=@Period

									INSERT FactSalesAggregate(Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID, 
											CancelCount, NetContractCount, GrossContractCount, ClaimsCount, ClaimsPaidCount, NetReserves, GrossReserves, EarnedReserves, UnearnedReserves, NetWrittenReserves, 
											GrossWrittenReserves, PremiumReserves, AmendedReserves, ClaimsPaid, CanceledAmount, AmendedAmount, ReinstatedAmount, CurrentAmount, CanceledReserves, 
											CancelCountITD, NetContractCountITD, GrossContractCountITD, ClaimsCountITD, ClaimsPaidCountITD, NetReservesITD, GrossReservesITD, EarnedReservesITD, UnearnedReservesITD, 
											NetWrittenReservesITD, GrossWrittenReservesITD, PremiumReservesITD, AmendedReservesITD, ClaimsPaidITD,CanceledAmountITD, AmendedAmountITD, ReinstatedAmountITD, CurrentAmountITD, CanceledReservesITD)

									SELECT 
										Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, 
										PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID,		
										CancelCount=SUM(CancelCount), 	
										NetContractCount=SUM(NetContractCount), 
										GrossContractCount=SUM(GrossContractCount), 
										ClaimsCount=SUM(ClaimsCount),	ClaimsPaidCount=SUM(ClaimsPaidCount), 		
										NetReserves=SUM(NetReserves), 
										GrossReserves=SUM(GrossReserves), 		
										EarnedReserves=SUM(EarnedReserves), 
										UnearnedReserves=SUM(NetReserves) - SUM(EarnedReserves), 
										NetWrittenReserves=SUM(NetWrittenReserves), 
										GrossWrittenReserves=SUM(GrossWrittenReserves), 
										PremiumReserves=SUM(PremiumReserves), 
										AmendedReserves=SUM(AmendedReserves),	
										ClaimsPaid=SUM(ClaimsPaid),	
										CanceledAmount=SUM(CANAmt), 
										AmendedAmount=SUM(AMDAmt), 
										ReinstatedAmount=SUM(RENAmt), 
										CurrentAmount=SUM(CURAmt), 	
										CanceledReserves=SUM(CANAmt), 	
										CancelCountITD=-6666666, 		
										NetContractCountITD=-6666666,
										GrossContractCountITD=-6666666,
										ClaimsCountITD=-6666666,
										ClaimsPaidCountITD=-6666666,
										NetReservesITD=-6666666,
										GrossReservesITD=-6666666,
										EarnedReservesITD=-6666666,
										UnearnedReservesITD=-6666666,
										NetWrittenReservesITD=-6666666,
										GrossWrittenReservesITD=-6666666,
										PremiumReservesITD=-6666666,
										AmendedReservesITD=-6666666,
										ClaimsPaidITD=-6666666,
	
										CanceledAmountITD=-6666666, 
										AmendedAmountITD=-6666666, 
										ReinstatedAmountITD=-6666666, 
										CurrentAmountITD=-6666666, 	
										CanceledReservesITD=-6666666
	
	
		
									FROM FactSales FS (NOLOCK)
									WHERE Period=@Period
									GROUP BY 	
										Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, 
										PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID

											UPDATE FSA SET
												CancelCountITD=AGCancelCountITD, 		
												NetContractCountITD=AGNetContractCountITD, 
												GrossContractCountITD=AGGrossContractCountITD, 
												ClaimsCountITD=AGClaimsCountITD,
												ClaimsPaidCountITD=AGClaimsPaidCountITD, 	
												NetReservesITD=AGNetReservesITD, 
												GrossReservesITD=AGGrossReservesITD, 
												EarnedReservesITD=AGEarnedReservesITD, 
												UnearnedReservesITD=AGUnearnedReservesITD, 
												NetWrittenReservesITD=AGNetWrittenReservesITD, 
												GrossWrittenReservesITD=AGGrossWrittenReservesITD, 
												PremiumReservesITD=AGPremiumReservesITD, 
												AmendedReservesITD=AGAmendedReservesITD,
												ClaimsPaidITD=AGClaimsPaidITD,
												CanceledAmountITD=AGCanceledAmount, 
												AmendedAmountITD=AGAmendedAmount, 
												ReinstatedAmountITD=AGReinstatedAmount, 
												CurrentAmountITD=AGCurrentAmount, 	
												CanceledReservesITD=AGCanceledAmount
							
											From FactSalesAggregate FSA
											INNER JOIN (
												SELECT ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, 
												PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID,	
												AGCancelCountITD=SUM(CancelCount), 		
												AGNetContractCountITD=SUM(NetContractCount), 
												AGGrossContractCountITD=SUM(GrossContractCount), 
												AGClaimsCountITD=SUM(ClaimsCount),
												AGClaimsPaidCountITD=SUM(ClaimsPaidCount), 	
												AGNetReservesITD=SUM(NetReserves), 
												AGGrossReservesITD=SUM(GrossReserves), 
												AGEarnedReservesITD=SUM(EarnedReserves), 
												AGUnearnedReservesITD=SUM(UnearnedReserves), 
												AGNetWrittenReservesITD=SUM(NetWrittenReserves), 
												AGGrossWrittenReservesITD=SUM(GrossWrittenReserves), 
												AGPremiumReservesITD=SUM(PremiumReserves), 
												AGAmendedReservesITD=SUM(AmendedReserves),
												AGClaimsPaidITD=SUM(ClaimsPaid),
												AGCanceledAmount=SUM(CanceledAmount), 
												AGAmendedAmount=SUM(AmendedAmount), 
												AGReinstatedAmount=SUM(ReinstatedAmount), 
												AGCurrentAmount=SUM(CurrentAmount), 	
												AGCanceledReserves=SUM(CanceledAmount)
												FROM FactSalesAggregate
												GROUP BY ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, 
												PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID
											   ) AS AG ON AG.ProductNameID=FSA.ProductNameID AND AG.ProductTypeID=FSA.ProductTypeID AND AG.ProductCategoryID=FSA.ProductCategoryID AND 
														AG.CoverageID=FSA.CoverageID AND AG.PartnerID=FSA.PartnerID  AND AG.AccountID=FSA.AccountID  AND AG.SalesManagerID=FSA.SalesManagerID  
														AND AG.StateID=FSA.StateID AND AG.VehicleStateID=FSA.VehicleStateID  AND AG.NationalAccountID=FSA.NationalAccountID  AND AG.TermID=FSA.TermID 
														 AND AG.FourPartKeyID =FSA.FourPartKeyID
														 AND AG.PlanID =FSA.PlanID
											WHERE FSA.Period=@Period



									INSERT FactSalesAggregate(Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID, 
											CancelCount, NetContractCount, GrossContractCount, ClaimsCount, ClaimsPaidCount, NetReserves, GrossReserves, EarnedReserves, UnearnedReserves, NetWrittenReserves, 
											GrossWrittenReserves, PremiumReserves, AmendedReserves, ClaimsPaid, CanceledAmount, AmendedAmount, ReinstatedAmount, CurrentAmount, CanceledReserves, 
											CancelCountITD, NetContractCountITD, GrossContractCountITD, ClaimsCountITD, ClaimsPaidCountITD, NetReservesITD, GrossReservesITD, EarnedReservesITD, UnearnedReservesITD, 
											NetWrittenReservesITD, GrossWrittenReservesITD, PremiumReservesITD, AmendedReservesITD, ClaimsPaidITD,CanceledAmountITD, AmendedAmountITD, ReinstatedAmountITD, CurrentAmountITD, CanceledReservesITD)
									SELECT 
										@Period,
										FSA.ProductNameID, FSA.ProductTypeID, FSA.ProductCategoryID, FSA.CoverageID, 
										FSA.PartnerID, FSA.AccountID, FSA.SalesManagerID, FSA.StateID, FSA.VehicleStateID, FSA.NationalAccountID, FSA.TermID, FSA.FourPartKeyID, FSA.PlanID,
										CancelCount=0, 	
										NetContractCount=0, 
										GrossContractCount=0, 
										ClaimsCount=0,
										ClaimsPaidCount=0, 		
										NetReserves=0, 
										GrossReserves=0, 
										EarnedReserves=0, 
										UnearnedReserves=0, 
										NetWrittenReserves=0, 
										GrossWrittenReserves=0, 
										PremiumReserves=0, 
										AmendedReserves=0,
										ClaimsPaid=0,	
										CanceledAmount=0, 
										AmendedAmount=0, 
										ReinstatedAmount=0, 
										CurrentAmount=0, 	
										CanceledReserves=0, 
										CancelCountITD=SUM(CancelCount), 		
										NetContractCountITD=SUM(NetContractCount), 
										GrossContractCountITD=SUM(GrossContractCount), 
										ClaimsCountITD=SUM(ClaimsCount),
										ClaimsPaidCountITD=SUM(ClaimsPaidCount), 	
										NetReservesITD=SUM(NetReserves), 
										GrossReservesITD=SUM(GrossReserves), 
										EarnedReservesITD=SUM(EarnedReserves), 
										UnearnedReservesITD=SUM(UnearnedReserves), 
										NetWrittenReservesITD=SUM(NetWrittenReserves), 
										GrossWrittenReservesITD=SUM(GrossWrittenReserves), 
										PremiumReservesITD=SUM(PremiumReserves), 
										AmendedReservesITD=SUM(AmendedReserves),
										ClaimsPaidITD=SUM(ClaimsPaid),	
										CanceledAmountITD=Sum(CanceledAmount), 
										AmendedAmountITD=Sum(AmendedAmount), 
										ReinstatedAmountITD=Sum(ReinstatedAmount), 
										CurrentAmountITD=SUM(CurrentAmount), 	
										CanceledReservesITD=Sum(CanceledAmount)


									FROM FactSalesAggregate FSA (NOLOCK)
									LEFT JOIN (SELECT ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, 
													  PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID
													  FROM FactSalesAggregate FSA
													  WHERE Period=@Period
													  Group BY ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, 
													  PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID
											   ) Existing ON 
											   Existing.ProductNameID=FSA.ProductNameID AND Existing.ProductTypeID=FSA.ProductTypeID AND Existing.ProductCategoryID=FSA.ProductCategoryID AND 
														Existing.CoverageID=FSA.CoverageID AND Existing.PartnerID=FSA.PartnerID  AND Existing.AccountID=FSA.AccountID  AND Existing.SalesManagerID=FSA.SalesManagerID  
														AND Existing.StateID=FSA.StateID AND Existing.VehicleStateID=FSA.VehicleStateID  AND Existing.NationalAccountID=FSA.NationalAccountID  AND Existing.TermID=FSA.TermID 
														 AND Existing.FourPartKeyID =FSA.FourPartKeyID
														 AND Existing.PlanID =FSA.PlanID
									WHERE Existing.ProductNameID IS NULL	
									GROUP BY 	
										FSA.ProductNameID, FSA.ProductTypeID, FSA.ProductCategoryID, FSA.CoverageID, 
										FSA.PartnerID, FSA.AccountID, FSA.SalesManagerID, FSA.StateID, FSA.VehicleStateID, FSA.NationalAccountID, FSA.TermID, FSA.FourPartKeyID, FSA.PlanID


									Print 'Proccessed Period ' + convert(varchar, @Period)

      FETCH NEXT FROM period_cursor INTO @Period
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor


------------------------- PROCESS REPORT PARAMETERS
Truncate Table T2T3ReportsParameters
INSERT T2T3ReportsParameters
SELECT Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID
From FactSalesAggregate (NOLOCK)
WHERE Period>=20080131
Group By Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID
