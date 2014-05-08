

Select * From sys.filegroups
Select * From sysfiles
ALTER DATABASE EFGSales
ADD FILEGROUP FactData2006;
GO
ALTER DATABASE EFGSales
ADD FILEGROUP FactData20072008;
GO

ALTER DATABASE EFGSales
ADD FILEGROUP FactData2009;
GO

ALTER DATABASE EFGSales
ADD FILEGROUP FactData2010;
GO

ALTER DATABASE EFGSales
ADD FILEGROUP FactData2011;
GO

ALTER DATABASE EFGSales
ADD FILEGROUP FactData2012;
GO
ALTER DATABASE EFGSales
ADD FILEGROUP FactData2013;
GO
ALTER DATABASE EFGSales
ADD FILEGROUP FactData2014;
GO
ALTER DATABASE EFGSales
ADD FILEGROUP FactData2015;
GO
ALTER DATABASE EFGSales
ADD FILEGROUP FactData2016;
GO

ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2006,
    FILENAME = 'E:\SQLData\EFGSales2006.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2006;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact20072008,
    FILENAME = 'E:\SQLData\EFGSales20072008.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2009;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2009,
    FILENAME = 'E:\SQLData\EFGSales2009.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2009;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2010,
    FILENAME = 'E:\SQLData\EFGSales2010.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2010;
GO
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2011,
    FILENAME = 'E:\SQLData\EFGSales2011.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2011;

GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2012,
    FILENAME = 'E:\SQLData\EFGSales2012.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2012;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2013,
    FILENAME = 'E:\SQLData\EFGSales2013.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2013;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2014,
    FILENAME = 'E:\SQLData\EFGSales2014.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2014;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2015,
    FILENAME = 'E:\SQLData\EFGSales2015.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2015;
GO
ALTER DATABASE EFGSales 
ADD FILE 
(
    NAME = Fact2016,
    FILENAME = 'E:\SQLData\EFGSales2016.ndf',
    SIZE = 2MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
)
TO FILEGROUP FactData2016;

-- ---------------------------------------------------- Partion Function and Scheme ----------------------------------------
GO
CREATE PARTITION FUNCTION SalesPeriodsPF (bigint)
    AS RANGE RIGHT FOR VALUES (20070100, 20090100, 20100100,20110100,20120100, 20130100,20140100, 20150100, 20160100) ;
GO
CREATE PARTITION FUNCTION [SalesPeriodsPF2](bigint) AS RANGE RIGHT FOR VALUES (200701, 200901, 201001, 201101, 201201, 201301, 201401, 201501, 201601)
GO
CREATE PARTITION SCHEME [SalePeriodsPS] AS PARTITION [SalesPeriodsPF] TO ([FactData2006], [FactData20072008], [FactData2009], [FactData2010], [FactData2011], [FactData2012], [FactData2013], [FactData2014],[FactData2015],[FactData2016])
GO
CREATE PARTITION SCHEME [SalePeriodsPS2] AS PARTITION [SalesPeriodsPF2] TO ([FactData2006], [FactData20072008], [FactData2009], [FactData2010], [FactData2011], [FactData2012], [FactData2013], [FactData2014], [FactData2015], [FactData2016])
GO
--------------------------------------------------------------------------------  TABLE CREATION -------------------------------
CREATE TABLE [dbo].[FactSales](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[Period] [bigint] NOT NULL,
	[AgreementPostedPeriod] [bigint] NOT NULL,
	[ProductNameID] [int] NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[CoverageID] [int] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[SalesManagerID] [int] NOT NULL,
	[StateID] [int] NOT NULL,
	[VehicleStateID] [int] NOT NULL,
	[NationalAccountID] [int] NOT NULL,
	[TermID] [int] NOT NULL,
	[AgreementID] [bigint] NOT NULL,
	[PlanID] [int] NOT NULL,
	[FourPartKeyID] [int] NOT NULL,
	[LastPostedPeriod] [int] NULL,
	[CancelCount] [float] NOT NULL,
	[ClaimsCount] [float] NOT NULL,
	[ClaimsPaidCount] [float] NOT NULL,
	[NetContractCount] [float] NOT NULL,
	[GrossContractCount] [float] NOT NULL,
	[CURCount] [float] NOT NULL,
	[AMDCount] [float] NOT NULL,
	[CANCount] [float] NOT NULL,
	[RENCount] [float] NOT NULL,
	[CURAmt] [float] NOT NULL,
	[CANAmt] [float] NOT NULL,
	[AMDAmt] [float] NOT NULL,
	[RENAmt] [float] NOT NULL,
	[ClaimsPaid] [float] NOT NULL,
	[ClaimsPaidITD] [float] NOT NULL,
	[EarnedReserves] [float] NOT NULL,
	[EarnedReservesITD] [float] NOT NULL,
	[NetReserves] [float] NOT NULL,
	[GrossReserves] [float] NOT NULL,
	[UnearnedReserves] [float] NOT NULL,
	[NetWrittenReserves] [float] NOT NULL,
	[GrossWrittenReserves] [float] NOT NULL,
	[PremiumReserves] [float] NOT NULL,
	[AmendedReserves] [float] NOT NULL,
	[ETLExtractDateTime] [datetime] NULL,
	[ETLUpdateDateTime] [datetime] NULL,
 CONSTRAINT [pk_FactSales] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ) ON [SalePeriodsPS] ([Period])
GO


CREATE TABLE [dbo].[FactSalesAggregate](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Period] [bigint] NOT NULL,
	[ProductNameID] [int] NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[CoverageID] [int] NOT NULL,
	[PartnerID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[SalesManagerID] [int] NOT NULL,
	[StateID] [int] NOT NULL,
	[VehicleStateID] [int] NOT NULL,
	[NationalAccountID] [int] NOT NULL,
	[TermID] [int] NOT NULL,
	[FourPartKeyID] [int] NOT NULL,
	[PlanID] [int] NOT NULL,
	[CancelCount] [float] NULL,
	[NetContractCount] [float] NULL,
	[GrossContractCount] [float] NULL,
	[ClaimsCount] [float] NULL,
	[ClaimsPaidCount] [float] NULL,
	[NetReserves] [float] NULL,
	[GrossReserves] [float] NULL,
	[EarnedReserves] [float] NULL,
	[UnearnedReserves] [float] NULL,
	[NetWrittenReserves] [float] NULL,
	[GrossWrittenReserves] [float] NULL,
	[PremiumReserves] [float] NULL,
	[AmendedReserves] [float] NULL,
	[ClaimsPaid] [float] NULL,
	[CancelCountITD] [float] NULL,
	[NetContractCountITD] [float] NULL,
	[GrossContractCountITD] [float] NULL,
	[ClaimsCountITD] [float] NULL,
	[ClaimsPaidCountITD] [float] NULL,
	[NetReservesITD] [float] NULL,
	[GrossReservesITD] [float] NULL,
	[EarnedReservesITD] [float] NULL,
	[UnearnedReservesITD] [float] NULL,
	[NetWrittenReservesITD] [float] NULL,
	[GrossWrittenReservesITD] [float] NULL,
	[PremiumReservesITD] [float] NULL,
	[AmendedReservesITD] [float] NULL,
	[ClaimsPaidITD] [float] NULL,
	[CanceledAmount] [float] NOT NULL,
	[AmendedAmount] [float] NOT NULL,
	[ReinstatedAmount] [float] NOT NULL,
	[CurrentAmount] [float] NOT NULL,
	[CanceledReserves] [float] NOT NULL,
	[CanceledAmountITD] [float] NOT NULL,
	[AmendedAmountITD] [float] NOT NULL,
	[ReinstatedAmountITD] [float] NOT NULL,
	[CurrentAmountITD] [float] NOT NULL,
	[CanceledReservesITD] [float] NOT NULL

CONSTRAINT [pk_FactSalesAggregate] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ) ON [SalePeriodsPS] ([Period])


----------------------------------- STAGING TABLE FOR DELTA LOADS...........................  They are truncated every period...... So, the data for the last period is kept.
CREATE TABLE [dbo].[_Staging_LastPull_ClaimSummaryHist](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL,
) ON [SalePeriodsPS2] ([AEPYRMON])
GO

						--These indexes are dropped and recreated during ETL ..............
GO-- Needs Space...
ALTER TABLE [dbo].[_Staging_LastPull_ClaimSummaryHist] ADD  CONSTRAINT [cidx_ClaimSummaryHist] PRIMARY KEY CLUSTERED 
(
	[AEPYRMON] ASC,
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist_AYPYRMON] ON [dbo].[_Staging_LastPull_ClaimSummaryHist] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
-- Need Space
CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist_5Keys] ON [dbo].[_Staging_LastPull_ClaimSummaryHist] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

CREATE TABLE [dbo].[_Staging_LastPull_SalesDisbDataHist](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[ADMCLICOD] [varchar](3) NOT NULL,
	[ADMACCCOD] [varchar](10) NOT NULL,
	[ADMAGRCOD] [varchar](20) NOT NULL,
	[ADMAGRSFX] [varchar](3) NOT NULL,
	[ADMPRDCOD] [varchar](10) NOT NULL,
	[CUSTFNAME] [varchar](100) NOT NULL,
	[CUSTLNAME] [varchar](100) NOT NULL,
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
	[ADMPSTDAT] [bigint] NOT NULL,
	[AADREGION] [varchar](10) NOT NULL,
	[VendorID] [int] NULL,
	[VendorName] [varchar](255) NULL,
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
 CONSTRAINT [pk_SalesDisbDataHist] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ) ON [SalePeriodsPS] ([ADMPSTDAT])

GO-- Needs Space...This is dropped and recreated during ETL Process........................
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[_Staging_LastPull_SalesDisbDataHist]') AND name = N'pk_SalesDisbDataHist')
	ALTER TABLE [dbo].[_Staging_LastPull_SalesDisbDataHist] DROP CONSTRAINT [pk_SalesDisbDataHist]
ALTER TABLE [dbo].[_Staging_LastPull_SalesDisbDataHist] ADD  CONSTRAINT [pk_SalesDisbDataHist] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SalePeriodsPS] ([ADMPSTDAT])
GO


CREATE TABLE [dbo].[_Staging_LastPull_ClaimsHist](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDCHKAMT] [numeric](38,4) NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
) ON [SalePeriodsPS] (PRDPRTDATMIN)

SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ClaimsHist_5Keys] ON [dbo].[_Staging_LastPull_ClaimsHist] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDATMIN ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
GO
CREATE NONCLUSTERED INDEX [idx_ClaimsHist_PRDPRTDAT] ON [dbo].[_Staging_LastPull_ClaimsHist] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO

-----------------------------------------------------------  MOVE DATA OVER ----------------------------------------- REMOVE LATER ALL BELOW

INSERT FactSalesAggregate (Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID, CancelCount, NetContractCount, GrossContractCount, ClaimsCount, ClaimsPaidCount, NetReserves, GrossReserves, EarnedReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ClaimsPaid, CancelCountITD, NetContractCountITD, GrossContractCountITD, ClaimsCountITD, ClaimsPaidCountITD, NetReservesITD, GrossReservesITD, EarnedReservesITD, UnearnedReservesITD, NetWrittenReservesITD, GrossWrittenReservesITD, PremiumReservesITD, AmendedReservesITD, ClaimsPaidITD, CanceledAmount, AmendedAmount, ReinstatedAmount, CurrentAmount, CanceledReserves, CanceledAmountITD, AmendedAmountITD, ReinstatedAmountITD, CurrentAmountITD, CanceledReservesITD)
Select Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, FourPartKeyID, PlanID, CancelCount, NetContractCount, GrossContractCount, ClaimsCount, ClaimsPaidCount, NetReserves, GrossReserves, EarnedReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ClaimsPaid, CancelCountITD, NetContractCountITD, GrossContractCountITD, ClaimsCountITD, ClaimsPaidCountITD, NetReservesITD, GrossReservesITD, EarnedReservesITD, UnearnedReservesITD, NetWrittenReservesITD, GrossWrittenReservesITD, PremiumReservesITD, AmendedReservesITD, ClaimsPaidITD, CanceledAmount, AmendedAmount, ReinstatedAmount, CurrentAmount, CanceledReserves, CanceledAmountITD, AmendedAmountITD, ReinstatedAmountITD, CurrentAmountITD, CanceledReservesITD From FactSalesAggregate2


--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2006
GO
Truncate Table FactSales2006
DROP table FactSales2006
GO
DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(7,1);


--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales20072008
GO

Select count(*) From FactSales Where Period Between 20070000 And 20090000 
Select count(*) From FactSales20072008 --
Truncate Table FactSales20072008
DROP table FactSales20072008
GO
DBCC Shrinkfile(2,1);
GO
DBCC Shrinkfile(3,1);

--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2009
GO
Select count(*) From FactSales --17412178
Select count(*) From FactSales Where Period Between 20090000 And 20100000 
Select count(*) From FactSales2009 
Truncate Table FactSales2009
DROP table FactSales2009
GO
DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(4,1);

--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2010
GO
Select count(*) From FactSales --Select 17412178+8179372=25591550
Select count(*) From FactSales Where Period Between 20100000 And 20110000 
Select count(*) From FactSales2010 -- 8179372
Truncate Table FactSales2010
DROP table FactSales2010
GO
DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(5,1);
--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2011

Select count(*) From FactSales --Select 25591550+8101959=33693509
Select count(*) From FactSales Where Period Between 20110000 And 20120000 
Select count(*) From FactSales2011 -- 8101959
Truncate Table FactSales2011
DROP table FactSales2011
GO
Truncate Table FactSales2011
DROP table FactSales2011
GO
DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(6,1);

--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2012
Select count(*) From FactSales Where Period Between 20120000 And 20130000 
Select count(*) From FactSales2012 -- 8101959
GO
Truncate Table FactSales2012
DROP table FactSales2012
GO
DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(8,1);

--Done
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2013
GO
Select Period ,ct=Count(*) From FactSales (NOLOCK) Group by Period 


DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(9,1);

--Pending
Select count(*) From FactSales Where Period Between 20140000 And 20150000 
INSERT FactSales (Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime)
SELECT Period, AgreementPostedPeriod, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, TermID, AgreementID, PlanID, FourPartKeyID, LastPostedPeriod, CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount, GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, ClaimsPaidITD, EarnedReserves, EarnedReservesITD, NetReserves, GrossReserves, UnearnedReserves, NetWrittenReserves, GrossWrittenReserves, PremiumReserves, AmendedReserves, ETLExtractDateTime, ETLUpdateDateTime FROM FactSales2014
GO
Truncate Table FactSales2014
DROP table FactSales2014
GO
DBCC Shrinkfile(2,2);
GO
DBCC Shrinkfile(10,1);



Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20140000 AND 20141231
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20130000 AND 20140000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20120000 AND 20130000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20110000 AND 20120000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20100000 AND 20110000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20090000 AND 20100000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20080000 AND 20090000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 20070000 AND 20080000
Select count(*) From  StagingSales.dbo.SalesDisbDataHist WHERE ADMPSTDAT BETWEEN 19000000 AND 20070000







