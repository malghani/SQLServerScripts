CREATE DATABASE StagingSales
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StagingSales', FILENAME = N'G:\Data\StagingSales.mdf' , SIZE = 12268992KB , MAXSIZE = UNLIMITED, FILEGROWTH = 204800KB )
GO
USE [StagingSales]
GO

ALTER DATABASE StagingSales
ADD FILEGROUP Staging2006;
GO
ALTER DATABASE StagingSales
ADD FILEGROUP Staging20072008;
GO

ALTER DATABASE StagingSales
ADD FILEGROUP Staging2009;
GO

ALTER DATABASE StagingSales
ADD FILEGROUP Staging2010;
GO

ALTER DATABASE StagingSales
ADD FILEGROUP Staging2011;
GO

ALTER DATABASE StagingSales
ADD FILEGROUP Staging2012;
GO
ALTER DATABASE StagingSales
ADD FILEGROUP Staging2013;
GO
ALTER DATABASE StagingSales
ADD FILEGROUP Staging2014;
GO
ALTER DATABASE StagingSales
ADD FILEGROUP Staging2015;
GO
ALTER DATABASE StagingSales
ADD FILEGROUP Staging2016;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2006,
    FILENAME = 'G:\Data\StagingSales2006.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2006;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales20072008,
    FILENAME = 'G:\Data\StagingSales20072008.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging20072008;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2009,
    FILENAME = 'G:\Data\StagingSales2009.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2009;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2010,
    FILENAME = 'G:\Data\StagingSales2010.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2010;

GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2011,
    FILENAME = 'G:\Data\StagingSales2011.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2011;
GO


ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2012,
    FILENAME = 'G:\Data\StagingSales2012.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2012;
GO

ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2013,
    FILENAME = 'G:\Data\StagingSales2013.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2013;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2014,
    FILENAME = 'G:\Data\StagingSales2014.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2014;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2015,
    FILENAME = 'G:\Data\StagingSales2015.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2015;
GO
ALTER DATABASE StagingSales 
ADD FILE 
(
    NAME = StagingSales2016,
    FILENAME = 'G:\Data\StagingSales2016.ndf',
    SIZE = 5MB,
    MAXSIZE = 5000MB,
    FILEGROWTH = 30MB
)
TO FILEGROUP Staging2016;

DBCC SHRINKFILE(2,2, TRUNCATEONLY)

Select * From Sys.filegroups
Select * From Sysfiles

-- Creates a partition function called myRangePF1 that will partition a table into four partitions
CREATE PARTITION FUNCTION SalesPeriodPF (bigint)
    AS RANGE RIGHT FOR VALUES (20070100, 20090100, 20100100,20110100,20120100, 20130100,20140100, 20150100, 20160100) ;
GO
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above
--drop partition SCHEME SalePeriodPS
CREATE PARTITION SCHEME SalePeriodPS
    AS PARTITION SalesPeriodPF
    TO (Staging2006, Staging20072008, Staging2009, Staging2010,Staging2011, Staging2012,Staging2013,Staging2014, Staging2015, Staging2016) ;
GO

/****** Object:  Table [dbo].[ClaimsHist2011]    Script Date: 4/4/2014 10:44:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Select * From sys.filegroups
Select * From Sysfiles


--drop PARTITION FUNCTION SalesPeriodPF2 
CREATE PARTITION FUNCTION SalesPeriodPF2 (bigint)
    AS RANGE RIGHT FOR VALUES (200701, 200901,201001,201101, 201201,201301, 201401, 201501, 201601) ;
GO
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above
--drop partition SCHEME SalePeriodPS2
CREATE PARTITION SCHEME SalePeriodPS2
    AS PARTITION SalesPeriodPF2
    TO (Staging2006, Staging20072008, Staging2009, Staging2010,Staging2011, Staging2012,Staging2013,Staging2014, Staging2015, Staging2016) ;
GO
SET ANSI_PADDING ON
GO
-- Drop Table [dbo].[ClaimsHist]
CREATE TABLE [dbo].[ClaimsHist](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDCHKAMT] [Numeric] (36,2),
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
) ON [SalePeriodPS] (PRDPRTDATMIN)

SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_ClaimsHist_5Keys] ON [dbo].[ClaimsHist] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDATMIN ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO
CREATE NONCLUSTERED INDEX [idx_ClaimsHist_PRDPRTDAT] ON [dbo].[ClaimsHist] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
GO
--drop table [dbo].[ClaimSummaryHist]
CREATE TABLE [dbo].[ClaimSummaryHist](
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
) ON [SalePeriodPS2] ([AEPYRMON])
GO
GO-- Needs Space...
--ALTER TABLE [dbo].[ClaimSummaryHist] ADD  CONSTRAINT [cidx_ClaimSummaryHist] PRIMARY KEY CLUSTERED 
--(
--	[AEPYRMON] ASC,
--	[AEPCLICOD] ASC,
--	[AEPACCCOD] ASC,
--	[AEPAGRCOD] ASC,
--	[AEPAGRSFX] ASC,
--	[AEPPRDCOD] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [SalePeriodPS2] ([AEPYRMON])
GO
CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist_AYPYRMON] ON [dbo].[ClaimSummaryHist] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
-- Need Space
--CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist_5Keys] ON [dbo].[ClaimSummaryHist] 
--(
--	[AEPCLICOD] ASC,
--	[AEPACCCOD] ASC,
--	[AEPAGRCOD] ASC,
--	[AEPAGRSFX] ASC,
--	[AEPPRDCOD] ASC,
--	[AEPYRMON] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

-- Drop table [dbo].[SalesDisbDataHist]
CREATE TABLE [dbo].[SalesDisbDataHist](
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ) ON [SalePeriodPS] ([ADMPSTDAT])



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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ) ON [SalePeriodPS] ([Period])
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ) ON [SalePeriodPS] ([Period])



CREATE TABLE [dbo].[FactSales2006](
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
 CONSTRAINT [pk_FactSales2006] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2006])
GO



CREATE TABLE [dbo].[FactSales20072008](
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
 CONSTRAINT [pk_FactSales20072008] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging20072008])

GO
CREATE TABLE [dbo].[FactSales2009](
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
 CONSTRAINT [pk_FactSales2009] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2009])

GO
CREATE TABLE [dbo].[FactSales2010](
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
 CONSTRAINT [pk_FactSales2010] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2010])


GO
CREATE TABLE [dbo].[FactSales2011](
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
 CONSTRAINT [pk_FactSales2011] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2011])


GO


CREATE TABLE [dbo].[FactSales2012](
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
 CONSTRAINT [pk_FactSales2012] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2012])




GO


CREATE TABLE [dbo].[FactSales2013](
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
 CONSTRAINT [pk_FactSales2013] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2013])





GO


CREATE TABLE [dbo].[FactSales2014](
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
 CONSTRAINT [pk_FactSales2014] PRIMARY KEY CLUSTERED 
(
    [Period] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ON [Staging2014])


GO

CREATE TABLE [dbo].[ClaimsHist2006](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2006]
GO

CREATE TABLE [dbo].[ClaimsHist20072008](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging20072008]

GO
CREATE TABLE [dbo].[ClaimsHist2009](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2009]

GO
CREATE TABLE [dbo].[ClaimsHist2010](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2010]


GO
CREATE TABLE [dbo].[ClaimsHist2011](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2011]

GO

CREATE TABLE [dbo].[ClaimsHist2012](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2012]

GO

CREATE TABLE [dbo].[ClaimsHist2013](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2013]

GO


CREATE TABLE [dbo].[ClaimsHist2014](
	[PRDCLICOD] [varchar](3) NOT NULL,
	[PRDACCCOD] [varchar](10) NOT NULL,
	[PRDAGRCOD] [varchar](20) NOT NULL,
	[PRDAGRSFX] [varchar](3) NOT NULL,
	[PRDPRDCOD] [varchar](10) NOT NULL,
	[PRDCLMTID] [numeric](11, 0) NOT NULL,
	[PRDPAYSTS] [char](1) NOT NULL,
	[PRDPRTDATMIN] [bigint] NULL,
	[PRDPRTDAT] [int] NULL
)
ON [Staging2014]

GO

CREATE TABLE [dbo].[ClaimSummaryHist2006](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging2006]
GO

CREATE TABLE [dbo].[ClaimSummaryHist20072008](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging20072008]
GO

CREATE TABLE [dbo].[ClaimSummaryHist2009](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging2009]
GO

CREATE TABLE [dbo].[ClaimSummaryHist2010](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging2010]
GO

CREATE TABLE [dbo].[ClaimSummaryHist2011](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging2011]
GO

CREATE TABLE [dbo].[ClaimSummaryHist2012](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging2012]
GO

CREATE TABLE [dbo].[ClaimSummaryHist2013](
	[AEPCLICOD] [varchar](3) NOT NULL,
	[AEPACCCOD] [varchar](10) NOT NULL,
	[AEPAGRCOD] [varchar](20) NOT NULL,
	[AEPAGRSFX] [varchar](3) NOT NULL,
	[AEPPRDCOD] [varchar](10) NOT NULL,
	[AEPYRMON] [bigint] NOT NULL,
	[AEPCLMCM] [numeric](38, 2) NULL,
	[AEPCLMITD] [numeric](38, 2) NULL,
	[AEPERNITD] [numeric](38, 2) NULL,
	[AEPERNCM] [numeric](38, 2) NULL
)
ON [Staging2013]
GO
GO
CREATE TABLE [dbo].[SalesDisbDataHist2006](
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
 CONSTRAINT [pk_SalesDisbDataHist2006] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2006]

GO
CREATE TABLE [dbo].[SalesDisbDataHist20072008](
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
 CONSTRAINT [pk_SalesDisbDataHist20072008] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging20072008]

GO
CREATE TABLE [dbo].[SalesDisbDataHist2009](
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
 CONSTRAINT [pk_SalesDisbDataHist2009] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2009]

GO
CREATE TABLE [dbo].[SalesDisbDataHist2010](
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
 CONSTRAINT [pk_SalesDisbDataHist2010] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2010]

GO
CREATE TABLE [dbo].[SalesDisbDataHist2011](
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
 CONSTRAINT [pk_SalesDisbDataHist2011] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2011]

GO
CREATE TABLE [dbo].[SalesDisbDataHist2012](
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
 CONSTRAINT [pk_SalesDisbDataHist2012] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2012]

GO
CREATE TABLE [dbo].[SalesDisbDataHist2013](
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
 CONSTRAINT [pk_SalesDisbDataHist2013] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2013]

GO
CREATE TABLE [dbo].[SalesDisbDataHist2014](
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
 CONSTRAINT [pk_SalesDisbDataHist2014] PRIMARY KEY CLUSTERED 
(
	[ADMPSTDAT] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [Staging2014]


/****** Object:  Table [dbo].[DimAccount]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimAccount](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](100) NOT NULL,
	[EFGAccountCode] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimAccount] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimAgreement]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimAgreement](
	[AgreementID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](200) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceCLICOD] [char](3) NULL,
	[SourceACCCOD] [char](20) NULL,
	[SourceAGRCOD] [char](20) NULL,
	[SourceAGRSFX] [char](3) NULL,
	[SourcePRDCOD] [char](10) NULL,
	[CustomerFirstName] [varchar](100) NOT NULL,
	[CustomerLastName] [varchar](100) NOT NULL,
	[SourcePLNCOD] [varchar](30) NULL,
	[AgreementStatusID] [int] NOT NULL,
 CONSTRAINT [pk_DimAgreement] PRIMARY KEY CLUSTERED 
(
	[AgreementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimAgreementStatus]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimAgreementStatus](
	[AgreementStatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](30) NOT NULL,
	[StatusCode] [char](10) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UPdateDate] [datetime] NULL,
	[SourceKey] [char](10) NULL,
 CONSTRAINT [PK__DimAgreementStatus] PRIMARY KEY CLUSTERED 
(
	[AgreementStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimContractStatus]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimContractStatus](
	[ContractStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ContractStatus] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContractStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimCoverage]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimCoverage](
	[CoverageID] [int] IDENTITY(1,1) NOT NULL,
	[CoverageName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UPdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimCoverage] PRIMARY KEY CLUSTERED 
(
	[CoverageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimFourPartProductKey]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimFourPartProductKey](
	[KeyID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[ClientCode] [char](3) NOT NULL,
	[ProgramCode] [char](5) NOT NULL,
	[ProductCode] [char](10) NOT NULL,
	[PlanCode] [char](10) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UPdateDate] [datetime] NULL,
	[SourceKey] [char](40) NULL,
	[ProductNameID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KeyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimNationalAccount]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimNationalAccount](
	[NationalAccountID] [int] IDENTITY(1,1) NOT NULL,
	[PartnerID] [int] NOT NULL,
	[NationalAccountName] [varchar](255) NOT NULL,
	[NationalAccountSrcID] [int] NULL,
	[Status] [int] NULL,
	[StatusCode] [char](5) NULL,
	[StatusDesc] [varchar](30) NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[NationalAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimPartner]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimPartner](
	[PartnerID] [int] IDENTITY(1,1) NOT NULL,
	[PartnerName] [varchar](100) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimPartner] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimPlan]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimPlan](
	[PlanID] [int] IDENTITY(1,1) NOT NULL,
	[PlanName] [varchar](100) NOT NULL,
	[PlanDesc] [varchar](100) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimPlan] PRIMARY KEY CLUSTERED 
(
	[PlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimProductCategory]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimProductCategory](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimProductCategory] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimProductName]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimProductName](
	[ProductNameID] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[ProductName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimProductName] PRIMARY KEY CLUSTERED 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimProductStatus]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimProductStatus](
	[ProductStatusID] [int] IDENTITY(1,1) NOT NULL,
	[ProductStatusName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimProductStatus] PRIMARY KEY CLUSTERED 
(
	[ProductStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimProductType]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimProductType](
	[ProductTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryID] [int] NULL,
	[ProductTypeName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimProductType] PRIMARY KEY CLUSTERED 
(
	[ProductTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimSalesManager]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimSalesManager](
	[SalesManagerID] [int] IDENTITY(1,1) NOT NULL,
	[SalesManagerName] [varchar](255) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
	[NationalAccountID] [int] NULL,
 CONSTRAINT [pk_DimSalesManager] PRIMARY KEY CLUSTERED 
(
	[SalesManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimState]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimState](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[StateCode] [varchar](4) NOT NULL,
	[StateName] [varchar](100) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimState] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimTerms]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimTerms](
	[TermID] [int] IDENTITY(1,1) NOT NULL,
	[TermName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimTerms] PRIMARY KEY CLUSTERED 
(
	[TermID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[DimVehicleState]    Script Date: 4/9/2014 5:23:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimVehicleState](
	[VehicleStateID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleStateName] [varchar](30) NOT NULL,
	[dimType] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[FromDate] [datetime] NULL,
	[ThruDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[SourceKey] [varchar](100) NULL,
 CONSTRAINT [pk_DimVehicleState] PRIMARY KEY CLUSTERED 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[MasterProductMatrix](
	[CLICOD] [nvarchar](255) NULL,
	[ClientDesc] [nvarchar](255) NULL,
	[Partner] [nvarchar](255) NULL,
	[Category] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[ProductName] [nvarchar](255) NULL,
	[CProg] [nvarchar](255) NULL,
	[ProgramDesc] [nvarchar](255) NULL,
	[CProd] [nvarchar](255) NULL,
	[ProductDesc] [nvarchar](255) NULL,
	[CPlan] [nvarchar](255) NULL,
	[PlanDesc] [nvarchar](255) NULL,
	[Coverage] [nvarchar](255) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[DimAccount] ADD  CONSTRAINT [DF_DimAccount_DimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimAgreement] ADD  CONSTRAINT [DF_DimAgreement_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimAgreementStatus] ADD  CONSTRAINT [DF_DimAGRStatus]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimAgreementStatus] ADD  CONSTRAINT [DF_DimAgreementStatus_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[DimContractStatus] ADD  CONSTRAINT [DF_DimContractStatus_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimCoverage] ADD  CONSTRAINT [DF_DimConverage]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimCoverage] ADD  CONSTRAINT [DF_DimCoverage_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[DimFourPartProductKey] ADD  CONSTRAINT [DF_DimFourPartProductKey]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimFourPartProductKey] ADD  CONSTRAINT [DF_DimFourPartProductKey_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[DimNationalAccount] ADD  CONSTRAINT [DF_DimNationalAcct_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimPartner] ADD  CONSTRAINT [DF_DimParnter_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimPlan] ADD  CONSTRAINT [DF_DimPlan_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimProductCategory] ADD  CONSTRAINT [DF_DimProductCategory_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimProductName] ADD  CONSTRAINT [DF_DimProductName_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimProductStatus] ADD  CONSTRAINT [DF_DimProductStatus_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimProductType] ADD  CONSTRAINT [DF_DimProductType_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimSalesManager] ADD  CONSTRAINT [DF_DimSalesManager_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimState] ADD  CONSTRAINT [DF_DimState_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimTerms] ADD  CONSTRAINT [DF_DimTerm_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimVehicleState] ADD  CONSTRAINT [DF_DimVehicleState_dimType]  DEFAULT ((0)) FOR [dimType]
GO

ALTER TABLE [dbo].[DimProductName]  WITH NOCHECK ADD  CONSTRAINT [fk_ProductType_ProductName] FOREIGN KEY([ProductTypeID])
REFERENCES [dbo].[DimProductType] ([ProductTypeID])
GO

ALTER TABLE [dbo].[DimProductName] NOCHECK CONSTRAINT [fk_ProductType_ProductName]
GO

ALTER TABLE [dbo].[DimProductType]  WITH NOCHECK ADD  CONSTRAINT [fk_ProductCategory_ProductType] FOREIGN KEY([ProductCategoryID])
REFERENCES [dbo].[DimProductCategory] ([ProductCategoryID])
GO

ALTER TABLE [dbo].[DimProductType] NOCHECK CONSTRAINT [fk_ProductCategory_ProductType]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADMTRNTYP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimContractStatus', @level2type=N'COLUMN',@level2name=N'SourceKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MasterProductMatrix' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductCategory', @level2type=N'COLUMN',@level2name=N'ProductCategoryName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MasterProductMatrix' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductCategory', @level2type=N'COLUMN',@level2name=N'SourceKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MasterProductMatrix' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductName', @level2type=N'COLUMN',@level2name=N'ProductName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MasterProductMatrix' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductName', @level2type=N'COLUMN',@level2name=N'SourceKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'CANCELLED
DENIED
EXPIRED
INFORCE
SUSPENDED
VOID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MasterProductMatrix' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductType', @level2type=N'COLUMN',@level2name=N'ProductTypeName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'From MasterProductMatrix' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimProductType', @level2type=N'COLUMN',@level2name=N'SourceKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'_Blank
AK
AL
AR
AZ
CA
CO
CT
DA
DC
DE
FL
GA
GEORGIA
HI
IA
ID
IL
IN
KS
KY
LA
MA
MD
ME
MI
MN
MO
MS
MT
NC
ND
NE
NH
NJ
NM
NV
NY
OH
OK
ON
OO
OR
OT
PA
PR
RI
SC
SD
T
TN
TX
UT
VA
VT
WA
WI
WV
WY
YO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimState'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Don''t Know' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTerms', @level2type=N'COLUMN',@level2name=N'TermName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Don''t Know' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimTerms', @level2type=N'COLUMN',@level2name=N'SourceKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'New
Used
Uknown
Blank' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimVehicleState', @level2type=N'COLUMN',@level2name=N'VehicleStateName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'N
U
X
_Blank' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimVehicleState', @level2type=N'COLUMN',@level2name=N'SourceKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'New = N
Used = U
Uknown = X
Blank =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DimVehicleState'
GO

------------------------------------------------------------- STORED PROCEDURES ------------------------------------------------------------------------------
USE [EFGSales]
GO

/****** Object:  StoredProcedure [dbo].[_ETL_T1_GetTier1Sales]    Script Date: 4/10/2014 10:32:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[_ETL_T1_GetTier1Sales]
@Period varchar(10) = NULL, --OP=OpenPeriod, CP=ClosedPeriods
@DateFrom DateTime = NULL ,
@DateTo DateTime = NULL


AS

-- EXEC GetTier1Sales 'Monthly', @DateFrom='01/01/2012', @DateTo='12/01/2013'
-- EXEC GetTier1Sales 'Daily'
-- EXEC GetTier1Sales 'Monthly'

SET NOCOUNT ON
SET XACT_ABORT ON


DECLARE @PSTDATE bigint
DECLARE @ClosedPeriodCount int=0
Declare @PostedPeriod DateTime
DECLARE @PSTDATES TABLE (PSTDATE bigint, PostDate DateTime) 
DECLARE @CurrentPeriod DateTime
DECLARE @OpenPeriod DateTime
DECLARE @ETLDateTime DateTime = GetDate()
DECLARE @ProcessingPeriod DateTime
DECLARE @RecCountPerPeriod bigint
DECLARE @ErrMsg Varchar(4000)


BEGIN TRY
SELECT @PSTDATE=MAX(ADMPSTDAT) FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM
SET @CurrentPeriod = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @PSTDATE),6),2)+'/' + RIGHT(Convert(Varchar(8), @PSTDATE),2)+'/'+ LEFT(Convert(Varchar(8), @PSTDATE),4))
SET @OpenPeriod=DateAdd(m, 1, @CurrentPeriod)
SET @OpenPeriod = Convert(DateTime, Convert(Varchar(2), DatePart(m, @OpenPeriod))+'/01/'+Convert(Varchar(4), DatePart(yy, @OpenPeriod)))
SET @OpenPeriod = DateAdd(m, 1, @OpenPeriod )
SET @OpenPeriod = DateAdd(d, -1, @OpenPeriod )
SET @CurrentPeriod = @OpenPeriod

   
If (@Period='Daily')
	INSERT @PSTDATES
	VALUES(0, @CurrentPeriod)
Else If (@Period = 'Monthly')
Begin
	IF @DateFrom IS NULL
	Begin		
		SET @DateFrom = Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), @PSTDATE),6),2)+'/' + RIGHT(Convert(Varchar(8), @PSTDATE),2)+'/'+ LEFT(Convert(Varchar(8), @PSTDATE),4))
		SET @DateTo = @DateFrom
		
		IF NOT (SELECT MAX(ADMPSTDAT) FROM dbo.SAL002_Tier1_Sales_YTD WHERE ADMPSTDAT>0 AND ADMPSTDAT=@PSTDATE) IS NULL
		Begin
			PRINT 'No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.'
			RETURN(0)  --No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.
		End			
    End				
		SET @PostedPeriod  = Convert(DateTime, Convert(Varchar(2), DatePart(Month, @DateFrom))+'/01/'+Convert(Varchar(4), DatePart(yy, @DateFrom)))
		SET @PostedPeriod  = DateAdd(Day, -1, DateAdd(Month, 1, @PostedPeriod))				
		SELECT @DateTo = ISNULL(@DateTo, @DateFrom)
		SELECT @ClosedPeriodCount=DATEDIFF(Month, @DateFrom, @DateTo)		
		WHILE @ClosedPeriodCount>=0
		Begin						
			INSERT @PSTDATES
			SELECT Convert(Varchar(4), DatePart(yy,@PostedPeriod ))+RIGHT('00'+Convert(Varchar(2), DatePart(Month,@PostedPeriod )),2)+Convert(Varchar(2), DatePart(d,@PostedPeriod )), @PostedPeriod				
			SET @DateFrom = DateAdd(Month, 1,@DateFrom)			
			SET @PostedPeriod  = Convert(DateTime, Convert(Varchar(2), DatePart(Month, @DateFrom))+'/01/'+Convert(Varchar(4), DatePart(yy, @DateFrom)))
			SET @PostedPeriod  = DateAdd(Day, -1, DateAdd(Month, 1, @PostedPeriod))				
			SET @ClosedPeriodCount = @ClosedPeriodCount - 1
		End			
End 
Else 
   Begin
		PRINT 'Parameter @Period has two possible values "Daily" Or "Monthly"'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Daily'' -- Will Run for the current Open Period'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Monthly'' -- Will Check if new period is available and '
		PRINT '                                                -- has no data in target then will Run for the new recently closed period'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Monthly'', @DateFrom=''11/15/2013'' -- Will Refresh(Replace the target) the Data for 11/2013 Posted Period  '
		PRINT '                                                                          -- Any Date for 11/2013 is acceptable.'
		PRINT 'USAGE :  EXEC GetTier1Sales @Period=''Monthly'', @DateFrom=''11/15/2012'' @DateTo=''11/15/2013'' -- Will Refresh (Replace the Target) the Data for all the Posted Periods falling in the  '
		PRINT '                                                                                                 -- Given Date Range. '				
		PRINT 'NOTE:Dates only help determine the posted periods and has no affect for the given day part.'
		RETURN(0)  --No Dates Given and there is a data for the last closed period. The Date must be fiven to process closed period.  
   End
--IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name like '#CRMData%' and type='U')
--	DROP TABLE #CRMData
SELECT DISTINCT   EFGRep COLLATE SQL_Latin1_General_CP1_CI_AS as EFG_Rep,
                  Parent1Name COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Group, 
                  Dealership COLLATE SQL_Latin1_General_CP1_CI_AS as Dealer_Name,
                  BillingAccountNumber COLLATE SQL_Latin1_General_CP1_CI_AS as Account_Code
                  ,BusinessUnit COLLATE SQL_Latin1_General_CP1_CI_AS as BusinessUnit
             into #CRMData
           FROM
            (SELECT
                  a.accountID
                  ,cast(an.EFG_AccountNumberName as nvarchar (10)) AS BillingAccountNumber
               ,EFG_AccountTypePLTable.value AS AccountType
               ,a.Address1_City AS City
               ,a.Address1_StateOrProvince AS StateProvince
               ,a.Address1_PostalCode AS PostalCode
               ,a.Address1_Country AS Country
               ,EFG_PrimaryMarketPLTable.value AS PrimaryMarket
               ,AccountCategoryCodePLTable.value AS ServiceApproach
               ,StateCodePLTable.value AS StatusReason
               ,a.EFG_CustomerEffectiveDate AS EffectiveDate
               ,a.EFG_CustomerTerminationDate AS TerminationDate
               ,pa.[Name] AS Parent1Name
               ,a.owneridyominame AS EFGRep
               ,a.[name] AS Dealership
               ,EFG_ChannelPLTable.value AS Channel
               ,getdate() as InsertDt
               ,AgentOrGroup = case when PartnerIdName is not null then PartnerIdName else pa.[Name] end
               ,efg_billingname as BillingAccountName
               ,a.EFG_SGuardVendornumber
               ,BU.[NAME] AS BusinessUnit   --,BU.IsDisabled,a.OwningBusinessUnit,BU.BusinessUnitId

            FROM
                  [SV-SQL02].EFG_MSCRM.dbo.Account a
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.BusinessUnitBase BU on a.OwningBusinessUnit = BU.BusinessUnitId                               
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_AccountTypePLTable
            ON  (
                    EFG_AccountTypePLTable.AttributeName = 'efg_accounttype'
                    AND EFG_AccountTypePLTable.ObjectTypeCode = 1
                    AND EFG_AccountTypePLTable.AttributeValue = a.EFG_AccountType
                    AND EFG_AccountTypePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_PrimaryMarketPLTable
            ON  (
                    EFG_PrimaryMarketPLTable.AttributeName = 'efg_primarymarket'
                    AND EFG_PrimaryMarketPLTable.ObjectTypeCode = 1
                    AND EFG_PrimaryMarketPLTable.AttributeValue = a.EFG_PrimaryMarket
                    AND EFG_PrimaryMarketPLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap AccountCategoryCodePLTable
            ON  (
                    AccountCategoryCodePLTable.AttributeName = 'accountcategorycode'
                    AND AccountCategoryCodePLTable.ObjectTypeCode = 1
                    AND AccountCategoryCodePLTable.AttributeValue = a.AccountCategoryCode
                    AND AccountCategoryCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap StateCodePLTable
            ON  (
                    StateCodePLTable.AttributeName = 'statecode'
                    AND StateCodePLTable.ObjectTypeCode = 1
                    AND StateCodePLTable.AttributeValue = a.StateCode
                    AND StateCodePLTable.LangId = 1033 )
            LEFT OUTER JOIN [SV-SQL02].EFG_MSCRM.dbo.StringMap EFG_ChannelPLTable
                    ON  (
                    EFG_ChannelPLTable.AttributeName = 'efg_channel'
                    AND EFG_ChannelPLTable.ObjectTypeCode = 1
                    AND EFG_ChannelPLTable.AttributeValue = a.EFG_Channel
                    AND EFG_ChannelPLTable.LangId = 1033 )
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.EFG_accountnumber an
                    ON  a.AccountID = an.efg_accountid and an.EFG_AccountNumberName IS NOT NULL
            LEFT JOIN [SV-SQL02].EFG_MSCRM.dbo.Account pa
                    ON  a.parentaccountid = pa.AccountId
            left join [SV-SQL02].EFG_MSCRM.dbo.CustomerRelationship cr
                    ON  a.accountid = cr.customerid and (partnerroleidname = 'Servicing Agent')
            WHERE an.EFG_AccountNumberName IS NOT null   )  A	

	

DECLARE period_cursor CURSOR
      FOR
      SELECT PSTDATE, PostDate FROM @PSTDATES	  
   OPEN period_cursor
   FETCH NEXT FROM period_cursor INTO @PSTDATE, @ProcessingPeriod
   WHILE (@@fetch_status <> -1)
   BEGIN  
				      
				IF (@Period = 'Monthly' OR @Period = 'History')
				BEGIN 
				
				
						--IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name = '#SalesDisbData' and type='U')
						--	drop table #SalesDisbData      
						SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMEFRTYN, 
								D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD, D.ADMDISAMT,
								A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL,
								A.AGMPSTDAT, D.ADMPSTDAT,D.ADMENTDAT, D.ADMEFFDAT, D.ADMRECDAT
						--Drop table #tmp
						INTO #SalesDisbData      
							  FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D      
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
																ON  a.AGMCLICOD = d.ADMCLICOD and
																  a.AGMACCCOD = d.ADMACCCOD and
																  a.AGMAGRCOD = d.ADMAGRCOD and
																  a.AGMAGRSFX = d.ADMAGRSFX
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM p
															ON a.AGMCLICOD = p.APVCLICOD and
																  a.AGMACCCOD = p.APVACCCOD and
																  a.AGMAGRCOD = p.APVAGRCOD and
																  a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS'
																  AND p.APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
							  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PLN
															ON a.AGMCLICOD = PLN.APVCLICOD and
																  a.AGMACCCOD = PLN.APVACCCOD and
																  a.AGMAGRCOD = PLN.APVAGRCOD and
																  a.AGMAGRSFX = PLN.APVAGRSFX AND PLN.APVFLDCOD = '~MVPLNCOD'                                          
							  
							  WHERE ADMEFRTYN = 'Y' 
							 AND ADMPSTDAT=@PSTDATE

							DELETE #SalesDisbData WHERE ADMDISCOD NOT IN (SELECT FieldValue
							FROM  ETL_SourceDataFilter 
							WHERE ReportTier = 'Sales Tier 1' And FilterType='Include Only'
							AND FieldName='ADMDISCOD' And ISNULL(EndDate,'01/01/3000') > GetDate())
				
						BEGIN TRANSACTION				 
						DELETE [dbo].[SAL002_Tier1_Sales_YTD] WHERE ADMPSTDAT=@PSTDATE 
						INSERT [dbo].[SAL002_Tier1_Sales_YTD]
							([APVALPVAL],[ADMPSTDAT],[ADMCLICOD],[ADMACCCOD],[ADMAGRCOD],[ADMAGRSFX]
							  ,[EFG_Rep],[Account_Group],[Dealer_Name],[ADMTRNTYP]
							  ,[ADMDISTYP],[AGMPRGCOD],[Disbursement_Code]
							  ,[Disbursement_Amount],CPROG, CPROD, CPLAN,[NON_CANCELFEE_STATUS]
							  ,[ETLDateTime],[LOB], AGMPSTDAT,ADMENTDAT , ADMEFFDAT, ADMRECDAT)
								   
						SELECT  APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
								EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD,								
								ADMDISCOD, ADMDISAMT,AGMPRGCOD,ADMPRDCOD,AGDPLNCOD,
								NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
								@ETLDateTime, BusinessUnit, AGMPSTDAT, ADMENTDAT , ADMEFFDAT, ADMRECDAT
						FROM #SalesDisbData se
						LEFT OUTER JOIN #CRMData c ON se.ADMACCCOD = c.Account_Code
		      

						-- overwrite all history for LOB, Rep, AccountGroup, Dealer_Name
						UPDATE Y SET LOB=c.BusinessUnit, EFG_Rep=c.EFG_Rep, Account_Group=c.Account_Group, Dealer_Name=c.Dealer_Name
						FROM SAL002_Tier1_Sales_YTD Y
						LEFT OUTER JOIN #CRMData c ON Y.ADMACCCOD = c.Account_Code

						UPDATE SAL002_Tier1_Sales_YTD SET SRC_LOB=LOB, SRC_EFG_Rep=EFG_Rep,						
						TXPostDate= CASE WHEN ISNULL(ADMPSTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMPSTDAT),4)) END,
						AGRPostDate= CASE WHEN ISNULL(AGMPSTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), AGMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), AGMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), AGMPSTDAT),4)) END,
						TXEntryDate= CASE WHEN ISNULL(ADMENTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMENTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMENTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMENTDAT),4)) END,
						TXRecordDate= CASE WHEN ISNULL(ADMRECDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMRECDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMRECDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMRECDAT),4)) END
						WHERE ADMPSTDAT=@PSTDATE
									

						UPDATE SAL002_Tier1_Sales_YTD
						SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
						Where (AGMPRGCOD like 'SAN%'  OR AGMPRGCOD like 'SG%') AND ADMPSTDAT=@PSTDATE
												

						UPDATE SAL002_Tier1_Sales_YTD
						SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Disbursement_Amount ELSE 0 END,							
							NetAmount=Disbursement_Amount
							WHERE ADMPSTDAT=@PSTDATE
							
						UPDATE Y 
						SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
						NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
						CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
						FROM SAL002_Tier1_Sales_YTD Y
						INNER JOIN (
							SELECT ID=MIN(ID) 
							FROM SAL002_Tier1_Sales_YTD
							WHERE ADMPSTDAT=@PSTDATE
							GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
						) AS FirstRec on FirstRec.ID=Y.ID
							

							--UPDATE SAL002_Tier1_Sales_YTD Set ProductType=NULL, ProductCategory=NULL, ProductName=NULL
							UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
							from SAL002_Tier1_Sales_YTD S
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
							WHERE ADMPSTDAT=@PSTDATE
							
							UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
							-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales_YTD S
							LEFT JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
							WHERE M.Category IS NULL AND ADMPSTDAT=@PSTDATE
													
						COMMIT TRANSACTION
						SELECT @RecCountPerPeriod=count(*) From #SalesDisbData
						DROP TABLE #SalesDisbData
						INSERT dbo.ETL_Log
						         (ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, [Parameters], ProcedureName)
						SELECT 'SAL_TIER_1', @ETLDateTime, @PSTDATE, @ProcessingPeriod, 1, NULL, @RecCountPerPeriod,'@Period:='+ @Period + ' @DateFrom := ' + ISNULL(Convert(Varchar, @DateFrom),'NULL') + ' @DateTo := ' + ISNULL(Convert(Varchar, @DateTo),'NULL'),  'GetTier1Sales'
						
			  END
				IF @Period = 'Daily' 
				BEGIN 
				  
				  
				IF EXISTS (SELECT * From tempdb.dbo.sysobjects where name LIke '#SalesDailyData%' and type='U')
					drop table #SalesDailyData      
				SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMEFRTYN, 
						D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD, D.ADMDISAMT,
						A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL,
						A.AGMPSTDAT, D.ADMPSTDAT,D.ADMENTDAT, D.ADMEFFDAT, D.ADMRECDAT
				
				INTO #SalesDailyData      
					  FROM I400DASQL.EFGAS400.SESCSEFG.SCAGRDM D      
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRM A
														ON  a.AGMCLICOD = d.ADMCLICOD and
														  a.AGMACCCOD = d.ADMACCCOD and
														  a.AGMAGRCOD = d.ADMAGRCOD and
														  a.AGMAGRSFX = d.ADMAGRSFX
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM p
													ON a.AGMCLICOD = p.APVCLICOD and
														  a.AGMACCCOD = p.APVACCCOD and
														  a.AGMAGRCOD = p.APVAGRCOD and
														  a.AGMAGRSFX = p.APVAGRSFX AND p.APVFLDCOD = '~MVPRDSTS'
														  AND p.APVALPVAL IN('INFORCE','CANCELLED','EXPIRED')
					  INNER JOIN I400DASQL.EFGAS400.SESCSEFG.SCAGRPVM PLN
													ON a.AGMCLICOD = PLN.APVCLICOD and
														  a.AGMACCCOD = PLN.APVACCCOD and
														  a.AGMAGRCOD = PLN.APVAGRCOD and
														  a.AGMAGRSFX = PLN.APVAGRSFX AND PLN.APVFLDCOD = '~MVPLNCOD'                                          
					  
					  WHERE ADMEFRTYN = 'Y' 
					 AND ADMPSTDAT=@PSTDATE

					DELETE #SalesDailyData WHERE ADMDISCOD NOT IN (SELECT FieldValue
					FROM  ETL_SourceDataFilter 
					WHERE ReportTier = 'Sales Tier 1' And FilterType='Include Only'
					AND FieldName='ADMDISCOD' And ISNULL(EndDate,'01/01/3000') > GetDate())
				
				
					BEGIN TRANSACTION
						TRUNCATE TABLE [dbo].[SAL002_Tier1_Sales]
						INSERT INTO [dbo].[SAL002_Tier1_Sales]
								   ([APVALPVAL]
								   ,[ADMPSTDAT]
								   ,[ADMCLICOD]
								   ,[ADMACCCOD]
								   ,[ADMAGRCOD]
								   ,[ADMAGRSFX]
								   ,[EFG_Rep]
								   ,[Account_Group]
								   ,[Dealer_Name]
								   ,[ADMTRNTYP]
								   ,[ADMDISTYP]
								   ,[AGMPRGCOD]
								   ,[Disbursement_Code]
								   ,[Disbursement_Amount]
								   ,[NON_CANCELFEE_STATUS]
								   ,[ETLDateTime]
								   ,[LOB]
								   ,CPROG
								   ,CPROD
								   ,CPLAN
								   ,AGMPSTDAT
								   ,ADMENTDAT 
								   ,ADMEFFDAT
								   ,ADMRECDAT)
						SELECT      APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
								EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD,
								ADMDISCOD, ADMDISAMT,
								NON_CANCELFEE_STATUS = (CASE WHEN ADMDISCOD LIKE '%CANCELFEE%' THEN 0 ELSE 1 END),
								@ETLDateTime, BusinessUnit, AGMPRGCOD,ADMPRDCOD,AGDPLNCOD, AGMPSTDAT, ADMENTDAT , ADMEFFDAT, ADMRECDAT

								
					FROM #SalesDailyData se
					LEFT OUTER JOIN #CRMData c ON se.ADMACCCOD = c.Account_Code
					
			
						UPDATE SAL002_Tier1_Sales SET SRC_LOB=LOB, SRC_EFG_Rep=EFG_Rep, 
						TXPostDate= CASE WHEN ISNULL(ADMPSTDAT,0)=0 THEN @ProcessingPeriod ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMPSTDAT),4)) END,
						AGRPostDate= CASE WHEN ISNULL(AGMPSTDAT,0)=0 THEN @ProcessingPeriod ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), AGMPSTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), AGMPSTDAT),2)+'/'+ LEFT(Convert(Varchar(8), AGMPSTDAT),4)) END,
						TXEntryDate= CASE WHEN ISNULL(ADMENTDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMENTDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMENTDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMENTDAT),4)) END,
						TXRecordDate= CASE WHEN ISNULL(ADMRECDAT,0)=0 THEN NULL ELSE Convert(DateTime, RIGHT(LEFT(Convert(Varchar(8), ADMRECDAT),6),2)+'/' + RIGHT(Convert(Varchar(8), ADMRECDAT),2)+'/'+ LEFT(Convert(Varchar(8), ADMRECDAT),4)) END
						From SAL002_Tier1_Sales 
			
						

						UPDATE SAL002_Tier1_Sales
						SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
						Where (AGMPRGCOD like 'SAN%'  OR AGMPRGCOD like 'SG%') 

						UPDATE SAL002_Tier1_Sales 
						SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Disbursement_Amount ELSE 0 END,							
							NetAmount=Disbursement_Amount
							
						UPDATE Y 
						SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
						NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
						CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
						FROM SAL002_Tier1_Sales Y
						INNER JOIN (
							SELECT ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT, ID=MIN(ID) 
							FROM SAL002_Tier1_Sales
							GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
						) AS FirstRec on FirstRec.ID=Y.ID
																			
							
							--UPDATE SAL002_Tier1_Sales Set ProductType=NULL, ProductCategory=NULL, ProductName=NULL
							UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
							--Select distinct S.PRoductCategory, M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales S							
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN

							
							UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
							-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales S
							LEFT JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
							WHERE M.Category IS NULL 
							

						DELETE SAL002_Tier1_Sales_YTD WHERE ADMPSTDAT = 0
						/************************************************************************************/
						/* SPECIALLY INSERTED BY AZHAR BECAUSE ONCE THE HEIRARCHY WILL CHANGE ON DAILY BASIS THE 
						   EFFECT HAS TO BE ALL THE HISTORIC DATA */
							UPDATE S Set ProductType=[Type], ProductCategory=Category, ProductName=M.ProductName
							from SAL002_Tier1_Sales_YTD S
							INNER JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
							
							
							UPDATE S Set ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
							-- Select distinct M.Category ,M.Type, M.ProductName, M.CLICOD, M.CPROG, M.CPROD, M.CPLAN, S.ADMCLICOD, S.CPROG, S.CPROD, S.CPLAN,  S.ProductCategory, S.ProductType,S.ProductName							
							from SAL002_Tier1_Sales_YTD S
							LEFT JOIN MasterProductMatrix M ON S.ADMCLICOD=M.CLICOD AND S.CPROG=M.CPROG AND S.CPROD=M.CPROD AND S.CPLAN=M.CPLAN
							WHERE M.Category IS NULL 
							
							UPDATE SAL002_Tier1_Sales_YTD
							SET EFG_Rep='Santander Rep', LOB='Specialty Channel'
							Where (AGMPRGCOD like 'SAN%'  OR AGMPRGCOD like 'SG%') 

							
						/************************************************************************************/												
						
						INSERT SAL002_Tier1_Sales_YTD (APVALPVAL,ADMPSTDAT,ADMCLICOD,ADMACCCOD,ADMAGRCOD,ADMAGRSFX,EFG_Rep,Account_Group,Dealer_Name,ADMTRNTYP,ADMDISTYP,
										AGMPRGCOD,Disbursement_Code,Disbursement_Amount,NON_CANCELFEE_STATUS,ETLDateTime,LOB,cprog,cprod,cplan,Program_Code,
										Product_Category,Super_Category,Src_LOB,Src_EFG_Rep,AGMPSTDAT,ADMENTDAT,ADMEFFDAT,ADMRECDAT,GrossAmount,GrossCount,
										NetAmount,NetCount,TXPostDate,AGRPostDate,TXEntryDate,TXEffectiveDate,TXRecordDate, ProductCategory, ProductType, ProductName)								   
						SELECT APVALPVAL,ADMPSTDAT,ADMCLICOD,ADMACCCOD,ADMAGRCOD,ADMAGRSFX,EFG_Rep,Account_Group,Dealer_Name,ADMTRNTYP,ADMDISTYP,
								AGMPRGCOD,Disbursement_Code,Disbursement_Amount,NON_CANCELFEE_STATUS,ETLDateTime,LOB,cprog,cprod,cplan,Program_Code,
								Product_Category,Super_Category,Src_LOB,Src_EFG_Rep,AGMPSTDAT,ADMENTDAT,ADMEFFDAT,ADMRECDAT,GrossAmount,GrossCount,
								NetAmount,NetCount,TXPostDate,AGRPostDate,TXEntryDate,TXEffectiveDate,TXRecordDate,ProductCategory, ProductType, ProductName
						FROM SAL002_Tier1_Sales
						COMMIT TRANSACTION
						
						SELECT @RecCountPerPeriod=count(*) From #SalesDailyData
						INSERT dbo.ETL_Log
						         (ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, [Parameters], ProcedureName)
						SELECT 'SAL_TIER_1', @ETLDateTime, @PSTDATE, @ProcessingPeriod, 1, NULL, @RecCountPerPeriod,'@Period:='+ @Period + ' @DateFrom := ' + ISNULL(Convert(Varchar, @DateFrom),'NULL') + ' @DateTo := ' + ISNULL(Convert(Varchar, @DateTo),'NULL'),  'GetTier1Sales'

				DROP TABLE #SalesDailyData
				
			  END			  
      
   FETCH NEXT FROM period_cursor INTO @PSTDATE, @ProcessingPeriod
   END
   CLOSE period_cursor
   DEALLOCATE period_cursor
   DROP TABLE #CRMData   
   
  -- UPdate the Security Dimensions
  Select Distinct LOB, EFG_Rep into #LOBRep From SAL002_Tier1_Sales_YTD
  
  INSERT SalesLOB (LOB, UPdatedBy, Deleted, CreatedDate, UPdatedDate)
  Select Distinct T.LOB, 'TIER1-ETL', 0, @ETLDateTime, @ETLDateTime from #LOBRep T
  LEFT JOIN dbo.SalesLOB LOB ON LOB.LOB=T.LOB
  WHERE LOB.LOBID IS NULL

  
  UPDATE LOB SET Deleted=1, UpdatedBy='TIER1-ETL', UpdatedDate=@ETLDateTime
  FROM SalesLOB LOB
  LEFT JOIN #LOBRep T ON T.LOB=LOB.LOB
  WHERE T.LOB IS NULL

  UPDATE LOB SET Deleted=0, UpdatedBy='TIER1-ETL', UpdatedDate=@ETLDateTime
  FROM SalesLOB LOB
  INNER JOIN #LOBRep T ON T.LOB=LOB.LOB
  WHERE LOB.Deleted=1
  
  INSERT SalesRep (Rep, UPdatedBy, Deleted, CreatedDate, UPdatedDate)
  Select Distinct T.EFG_Rep, 'TIER1-ETL', 0, @ETLDateTime, @ETLDateTime from #LOBRep T
  LEFT JOIN dbo.SalesRep R ON R.Rep=T.EFG_Rep
  WHERE R.RepID IS NULL
  
  UPDATE R SET Deleted=1, UpdatedBy='TIER1-ETL', UpdatedDate=@ETLDateTime
  FROM SalesRep R
  LEFT JOIN #LOBRep T ON T.EFG_Rep=R.Rep
  WHERE T.EFG_Rep IS NULL
  
  UPDATE R SET Deleted=0, UpdatedBy='TIER1-ETL', UpdatedDate=@ETLDateTime
  FROM SalesRep R
  INNER JOIN #LOBRep T ON T.EFG_Rep=R.Rep
  WHERE R.Deleted=1
    
  INSERT SalesLOBRep(RepID, LOBID, LOB, Rep, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
  Select Distinct R.RepID, LOB.LOBID, LOB.LOB, R.Rep, 'TIER1-ETL', 0, @ETLDateTime, @ETLDateTime 
  FROM #LOBRep T
  LEFT JOIN SalesLOBRep LR ON LR.LOB=T.LOB AND LR.Rep=T.EFG_Rep
  LEFT JOIN dbo.SalesRep R ON R.Rep=T.EFG_Rep
  LEFT JOIN dbo.SalesLOB LOB ON LOB.LOB=T.LOB
  WHERE LR.LOBID IS NULL
  
  UPDATE LR SET Deleted=1, UpdatedBy='TIER1-ETL', UpdatedDate=@ETLDateTime
  FROM SalesLOBRep LR
  LEFT JOIN #LOBRep T ON LR.LOB=T.LOB AND LR.Rep=T.EFG_Rep  
  WHERE T.EFG_Rep IS NULL

  UPDATE LR SET Deleted=0, UpdatedBy='TIER1-ETL', UpdatedDate=@ETLDateTime
  FROM SalesLOBRep LR
  INNER JOIN #LOBRep T ON LR.LOB=T.LOB AND LR.Rep=T.EFG_Rep  
  WHERE LR.Deleted=1   
END TRY	

BEGIN CATCH
IF @@TRANCOUNT > 1
   ROLLBACK TRANSACTION
SET	@ErrMsg=ERROR_MESSAGE()
PRINT @ErrMsg
	INSERT dbo.ETL_Log
	(ReportTier,ETLRunDateTime,PostPeriod, PostDate, Success, ExceptionMessage , RecordCount, [Parameters], ProcedureName)
	SELECT 'SAL_TIER_1', @ETLDateTime, @PSTDATE, @ProcessingPeriod, 0, convert(varchar(4000), ltrim(rtrim(@ErrMsg))) , @RecCountPerPeriod,'@Period:='+ @Period + ' @DateFrom := ' + ISNULL(Convert(Varchar, @DateFrom),'NULL') + ' @DateTo := ' + ISNULL(Convert(Varchar, @DateTo),'NULL'),  'GetTier1Sales'
END CATCH



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_BuildFact2007Onward]    Script Date: 4/10/2014 10:32:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[_ETL_IDL_T2T3_BuildFact2007Onward]

AS

SET ANSI_WARNINGS OFF;
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

TRUNCATE TABLE FactSales20072008
Begin Transaction 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Period')
DROP INDEX [Idx_FactSales20072008_Period] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Account')
DROP INDEX [Idx_FactSales20072008_Account] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_NationalAccount')
DROP INDEX [Idx_FactSales20072008_NationalAccount] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_NewUsed')
DROP INDEX [Idx_FactSales20072008_NewUsed] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Partner')
DROP INDEX [Idx_FactSales20072008_Partner] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Partner_Prod')
DROP INDEX [Idx_FactSales20072008_Partner_Prod] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_PName_Other')
DROP INDEX [Idx_FactSales20072008_PName_Other] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_PRD_PRF')
DROP INDEX [Idx_FactSales20072008_PRD_PRF] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_ProductType_Period')
DROP INDEX [Idx_FactSales20072008_ProductType_Period] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'idx_FactSales20072008_ProductType_Period_Term')
DROP INDEX [idx_FactSales20072008_ProductType_Period_Term] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_State')
DROP INDEX [Idx_FactSales20072008_State] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_UniqueIdx')
DROP INDEX [Idx_FactSales20072008_UniqueIdx] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'idx_FactSales20072008_PName')
DROP INDEX [idx_FactSales20072008_PName] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )

--------------- FILL THE FACT ---------------------------------------------------


INSERT FactSales20072008 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist20072008 H (NOLOCK)
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
--WHERE ADMPSTDAT=200720080131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales20072008 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales20072008 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist20072008 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist20072008
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
PRINT 'Done Fact Data for 20072008. Starting Earnings'
Commit Transaction

EXEC ShrinkLogFile;

Begin Transaction
INSERT FactSales20072008 ( 
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
         	
       From  ClaimSummaryHist20072008 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales20072008 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist20072008
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales20072008 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales200720082 WHERE NetReserves>0 Order by AgreementID

--------------------- RECREATE AGGREGATE TABLES IF NEEDED
Commit Transaction
PRINT 'Done with 20072008.'

EXEC ShrinkLogFile;

Truncate Table FactSales2009

Begin Transaction 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Period')
DROP INDEX [Idx_FactSales2009_Period] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Account')
DROP INDEX [Idx_FactSales2009_Account] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_NationalAccount')
DROP INDEX [Idx_FactSales2009_NationalAccount] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_NewUsed')
DROP INDEX [Idx_FactSales2009_NewUsed] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Partner')
DROP INDEX [Idx_FactSales2009_Partner] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Partner_Prod')
DROP INDEX [Idx_FactSales2009_Partner_Prod] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_PName_Other')
DROP INDEX [Idx_FactSales2009_PName_Other] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_PRD_PRF')
DROP INDEX [Idx_FactSales2009_PRD_PRF] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_ProductType_Period')
DROP INDEX [Idx_FactSales2009_ProductType_Period] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'idx_FactSales2009_ProductType_Period_Term')
DROP INDEX [idx_FactSales2009_ProductType_Period_Term] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_State')
DROP INDEX [Idx_FactSales2009_State] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_UniqueIdx')
DROP INDEX [Idx_FactSales2009_UniqueIdx] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'idx_FactSales2009_PName')
DROP INDEX [idx_FactSales2009_PName] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2009 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2009 H (NOLOCK)
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
--WHERE ADMPSTDAT=20090131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales2009 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2009 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2009 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2009
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
Commit Transaction
PRINT 'Done Fact Data for 2009. Starting Earning.'

EXEC ShrinkLogFile;

Begin Transaction
INSERT FactSales2009 ( 
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
         	
       From  ClaimSummaryHist2009 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2009 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2009
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales2009 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20092 WHERE NetReserves>0 Order by AgreementID
--------------------- RECREATE AGGREGATE TABLES IF NEEDED
PRINT 'Done with 2009.'
Commit Transaction

EXEC ShrinkLogFile;

Truncate Table SalesFact2010
Begin Transaction

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Period')
DROP INDEX [Idx_FactSales2010_Period] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Account')
DROP INDEX [Idx_FactSales2010_Account] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_NationalAccount')
DROP INDEX [Idx_FactSales2010_NationalAccount] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_NewUsed')
DROP INDEX [Idx_FactSales2010_NewUsed] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Partner')
DROP INDEX [Idx_FactSales2010_Partner] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Partner_Prod')
DROP INDEX [Idx_FactSales2010_Partner_Prod] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_PName_Other')
DROP INDEX [Idx_FactSales2010_PName_Other] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_PRD_PRF')
DROP INDEX [Idx_FactSales2010_PRD_PRF] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_ProductType_Period')
DROP INDEX [Idx_FactSales2010_ProductType_Period] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'idx_FactSales2010_ProductType_Period_Term')
DROP INDEX [idx_FactSales2010_ProductType_Period_Term] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_State')
DROP INDEX [Idx_FactSales2010_State] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_UniqueIdx')
DROP INDEX [Idx_FactSales2010_UniqueIdx] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'idx_FactSales2010_PName')
DROP INDEX [idx_FactSales2010_PName] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2010 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2010 H (NOLOCK)
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
--WHERE ADMPSTDAT=20100131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales2010 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2010 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2010 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2010
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
Commit Transaction
PRINT 'Done Fact Data 2010. Starting Earnings'

EXEC ShrinkLogFile;
Begin Transaction
INSERT FactSales2010 ( 
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
         	
       From  ClaimSummaryHist2010 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2010 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2010
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales2010 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20102 WHERE NetReserves>0 Order by AgreementID
--------------------- RECREATE AGGREGATE TABLES IF NEEDED
Commit Transaction 
PRINT 'Done With 2010'

EXEC ShrinkLogFile;

Truncate Table FactSales2011

Begin Transaction
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Period')
DROP INDEX [Idx_FactSales2011_Period] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Account')
DROP INDEX [Idx_FactSales2011_Account] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_NationalAccount')
DROP INDEX [Idx_FactSales2011_NationalAccount] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_NewUsed')
DROP INDEX [Idx_FactSales2011_NewUsed] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Partner')
DROP INDEX [Idx_FactSales2011_Partner] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Partner_Prod')
DROP INDEX [Idx_FactSales2011_Partner_Prod] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_PName_Other')
DROP INDEX [Idx_FactSales2011_PName_Other] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_PRD_PRF')
DROP INDEX [Idx_FactSales2011_PRD_PRF] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_ProductType_Period')
DROP INDEX [Idx_FactSales2011_ProductType_Period] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'idx_FactSales2011_ProductType_Period_Term')
DROP INDEX [idx_FactSales2011_ProductType_Period_Term] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_State')
DROP INDEX [Idx_FactSales2011_State] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_UniqueIdx')
DROP INDEX [Idx_FactSales2011_UniqueIdx] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'idx_FactSales2011_PName')
DROP INDEX [idx_FactSales2011_PName] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2011 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2011 H (NOLOCK)
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
--WHERE ADMPSTDAT=20110131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales2011 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2011 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2011 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2011
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
Commit Transaction;
PRINT 'Done Fact Data for 2011. Starting Earnings'
EXEC ShrinkLogFile;
Begin Transaction
INSERT FactSales2011 ( 
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
         	
       From  ClaimSummaryHist2011 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2011 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2011
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales2011 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20112 WHERE NetReserves>0 Order by AgreementID
	

--------------------- RECREATE AGGREGATE TABLES IF NEEDED
Commit Transaction 
PRINT 'Done With 2011'

EXEC ShrinkLogFile;


Truncate Table FactSales2012;

Begin Transaction
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Period')
DROP INDEX [Idx_FactSales2012_Period] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Account')
DROP INDEX [Idx_FactSales2012_Account] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_NationalAccount')
DROP INDEX [Idx_FactSales2012_NationalAccount] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_NewUsed')
DROP INDEX [Idx_FactSales2012_NewUsed] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Partner')
DROP INDEX [Idx_FactSales2012_Partner] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Partner_Prod')
DROP INDEX [Idx_FactSales2012_Partner_Prod] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_PName_Other')
DROP INDEX [Idx_FactSales2012_PName_Other] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_PRD_PRF')
DROP INDEX [Idx_FactSales2012_PRD_PRF] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_ProductType_Period')
DROP INDEX [Idx_FactSales2012_ProductType_Period] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'idx_FactSales2012_ProductType_Period_Term')
DROP INDEX [idx_FactSales2012_ProductType_Period_Term] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_State')
DROP INDEX [Idx_FactSales2012_State] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_UniqueIdx')
DROP INDEX [Idx_FactSales2012_UniqueIdx] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'idx_FactSales2012_PName')
DROP INDEX [idx_FactSales2012_PName] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2012 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2012 H (NOLOCK)
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
--WHERE ADMPSTDAT=20120131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales2012 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2012 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2012 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2012
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
Commit Transaction
PRINT 'Done With FactData on 2012. Starting Earning'

EXEC ShrinkLogFile;

Begin Transaction

INSERT FactSales2012 ( 
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
         	
       From  ClaimSummaryHist2012 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2012 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2012
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales2012 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20122 WHERE NetReserves>0 Order by AgreementID
	
--------------------- RECREATE AGGREGATE TABLES IF NEEDED
Commit Transaction
PRINT 'Done with 2012'

EXEC ShrinkLogFile;

Truncate Table FactSales2013
Begin Transaction
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Period')
DROP INDEX [Idx_FactSales2013_Period] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Account')
DROP INDEX [Idx_FactSales2013_Account] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_NationalAccount')
DROP INDEX [Idx_FactSales2013_NationalAccount] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_NewUsed')
DROP INDEX [Idx_FactSales2013_NewUsed] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Partner')
DROP INDEX [Idx_FactSales2013_Partner] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Partner_Prod')
DROP INDEX [Idx_FactSales2013_Partner_Prod] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_PName_Other')
DROP INDEX [Idx_FactSales2013_PName_Other] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_PRD_PRF')
DROP INDEX [Idx_FactSales2013_PRD_PRF] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_ProductType_Period')
DROP INDEX [Idx_FactSales2013_ProductType_Period] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'idx_FactSales2013_ProductType_Period_Term')
DROP INDEX [idx_FactSales2013_ProductType_Period_Term] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_State')
DROP INDEX [Idx_FactSales2013_State] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_UniqueIdx')
DROP INDEX [Idx_FactSales2013_UniqueIdx] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'idx_FactSales2013_PName')
DROP INDEX [idx_FactSales2013_PName] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2013 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2013 H (NOLOCK)
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
--WHERE ADMPSTDAT=20130131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

--UPDATE FactSales2013 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2013 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2013 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2013
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
COMMIT TRANSACTION;
PRINT 'DONE with Fact Data 2013. Starting Earning'

EXEC ShrinkLogFile;

Begin Transaction;
INSERT FactSales2013 ( 
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
         	
       From  ClaimSummaryHist2013 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2013 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2013
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales2013 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20132 WHERE NetReserves>0 Order by AgreementID
	
--------------------- RECREATE AGGREGATE TABLES IF NEEDED
Commit Transaction
PRINT 'DONE With 2013'
EXEC ShrinkLogFile;

--Truncate Table SalesFact2014

Begin Transaction

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Period')
DROP INDEX [Idx_FactSales2014_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Account')
DROP INDEX [Idx_FactSales2014_Account] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_NationalAccount')
DROP INDEX [Idx_FactSales2014_NationalAccount] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_NewUsed')
DROP INDEX [Idx_FactSales2014_NewUsed] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Partner')
DROP INDEX [Idx_FactSales2014_Partner] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Partner_Prod')
DROP INDEX [Idx_FactSales2014_Partner_Prod] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_PName_Other')
DROP INDEX [Idx_FactSales2014_PName_Other] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_PRD_PRF')
DROP INDEX [Idx_FactSales2014_PRD_PRF] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_ProductType_Period')
DROP INDEX [Idx_FactSales2014_ProductType_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'idx_FactSales2014_ProductType_Period_Term')
DROP INDEX [idx_FactSales2014_ProductType_Period_Term] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_State')
DROP INDEX [Idx_FactSales2014_State] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_UniqueIdx')
DROP INDEX [Idx_FactSales2014_UniqueIdx] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'idx_FactSales2014_PName')
DROP INDEX [idx_FactSales2014_PName] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )


--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2014 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2014 H (NOLOCK)
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

--UPDATE FactSales2014 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2014 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2014 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2014
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
Commit Transaction
PRINT 'Done with Fact Data 2014. Starting Earnings.'

EXEC ShrinkLogFile;
Begin Transaction 

INSERT FactSales2014 ( 
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
         	
       From  ClaimSummaryHist2014 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2014 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2014
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

UPDATE FactSales2014 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20142 WHERE NetReserves>0 Order by AgreementID
	-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Period] ON [dbo].[FactSales2014] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Account] ON [dbo].[FactSales2014] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_NationalAccount] ON [dbo].[FactSales2014] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_NewUsed] ON [dbo].[FactSales2014] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Partner] ON [dbo].[FactSales2014] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Partner_Prod] ON [dbo].[FactSales2014] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_PName_Other] ON [dbo].[FactSales2014] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_PRD_PRF] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_ProductType_Period] ON [dbo].[FactSales2014] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_FactSales2014_ProductType_Period_Term] ON [dbo].[FactSales2014] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_State] ON [dbo].[FactSales2014] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_UniqueIdx] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_FactSales2014_PName] ON [dbo].[FactSales2014] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED
Commit Transaction
PRINT 'Done with 2014. FINAL! Congrats!.'

EXEC ShrinkLogFile;
	-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2009] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Period] ON [dbo].[FactSales2009] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Account] ON [dbo].[FactSales2009] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_NationalAccount] ON [dbo].[FactSales2009] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_NewUsed] ON [dbo].[FactSales2009] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Partner] ON [dbo].[FactSales2009] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Partner_Prod] ON [dbo].[FactSales2009] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_PName_Other] ON [dbo].[FactSales2009] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_PRD_PRF] ON [dbo].[FactSales2009] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_ProductType_Period] ON [dbo].[FactSales2009] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_FactSales2009_ProductType_Period_Term] ON [dbo].[FactSales2009] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_State] ON [dbo].[FactSales2009] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_UniqueIdx] ON [dbo].[FactSales2009] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_FactSales2009_PName] ON [dbo].[FactSales2009] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]

EXEC ShrinkLogFile;

	-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2010] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Period] ON [dbo].[FactSales2010] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Account] ON [dbo].[FactSales2010] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_NationalAccount] ON [dbo].[FactSales2010] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_NewUsed] ON [dbo].[FactSales2010] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Partner] ON [dbo].[FactSales2010] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Partner_Prod] ON [dbo].[FactSales2010] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_PName_Other] ON [dbo].[FactSales2010] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_PRD_PRF] ON [dbo].[FactSales2010] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_ProductType_Period] ON [dbo].[FactSales2010] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_FactSales2010_ProductType_Period_Term] ON [dbo].[FactSales2010] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_State] ON [dbo].[FactSales2010] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_UniqueIdx] ON [dbo].[FactSales2010] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_FactSales2010_PName] ON [dbo].[FactSales2010] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]

EXEC ShrinkLogFile;

CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2011] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Period] ON [dbo].[FactSales2011] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Account] ON [dbo].[FactSales2011] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_NationalAccount] ON [dbo].[FactSales2011] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_NewUsed] ON [dbo].[FactSales2011] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Partner] ON [dbo].[FactSales2011] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Partner_Prod] ON [dbo].[FactSales2011] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_PName_Other] ON [dbo].[FactSales2011] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_PRD_PRF] ON [dbo].[FactSales2011] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_ProductType_Period] ON [dbo].[FactSales2011] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_FactSales2011_ProductType_Period_Term] ON [dbo].[FactSales2011] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_State] ON [dbo].[FactSales2011] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_UniqueIdx] ON [dbo].[FactSales2011] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_FactSales2011_PName] ON [dbo].[FactSales2011] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]

EXEC ShrinkLogFile;

-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2012] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Period] ON [dbo].[FactSales2012] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Account] ON [dbo].[FactSales2012] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_NationalAccount] ON [dbo].[FactSales2012] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_NewUsed] ON [dbo].[FactSales2012] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Partner] ON [dbo].[FactSales2012] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Partner_Prod] ON [dbo].[FactSales2012] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_PName_Other] ON [dbo].[FactSales2012] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_PRD_PRF] ON [dbo].[FactSales2012] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_ProductType_Period] ON [dbo].[FactSales2012] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_FactSales2012_ProductType_Period_Term] ON [dbo].[FactSales2012] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_State] ON [dbo].[FactSales2012] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_UniqueIdx] ON [dbo].[FactSales2012] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_FactSales2012_PName] ON [dbo].[FactSales2012] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]

EXEC ShrinkLogFile;
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2013] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Period] ON [dbo].[FactSales2013] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Account] ON [dbo].[FactSales2013] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_NationalAccount] ON [dbo].[FactSales2013] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_NewUsed] ON [dbo].[FactSales2013] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Partner] ON [dbo].[FactSales2013] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Partner_Prod] ON [dbo].[FactSales2013] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_PName_Other] ON [dbo].[FactSales2013] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_PRD_PRF] ON [dbo].[FactSales2013] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_ProductType_Period] ON [dbo].[FactSales2013] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_FactSales2013_ProductType_Period_Term] ON [dbo].[FactSales2013] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_State] ON [dbo].[FactSales2013] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_UniqueIdx] ON [dbo].[FactSales2013] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_FactSales2013_PName] ON [dbo].[FactSales2013] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]

EXEC ShrinkLogFile;

	-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales20072008] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Period] ON [dbo].[FactSales20072008] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Account] ON [dbo].[FactSales20072008] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_NationalAccount] ON [dbo].[FactSales20072008] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_NewUsed] ON [dbo].[FactSales20072008] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Partner] ON [dbo].[FactSales20072008] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Partner_Prod] ON [dbo].[FactSales20072008] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_PName_Other] ON [dbo].[FactSales20072008] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_PRD_PRF] ON [dbo].[FactSales20072008] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_ProductType_Period] ON [dbo].[FactSales20072008] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_FactSales20072008_ProductType_Period_Term] ON [dbo].[FactSales20072008] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_State] ON [dbo].[FactSales20072008] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_UniqueIdx] ON [dbo].[FactSales20072008] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_FactSales20072008_PName] ON [dbo].[FactSales20072008] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]

EXEC ShrinkLogFile;
GO

/****** Object:  StoredProcedure [dbo].[_ETL_T2T3_GetTier23SalesData]    Script Date: 4/10/2014 10:32:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[_ETL_T2T3_GetTier23SalesData]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2014')
   DROP TABLE [dbo].[SalesDisbDataHist2014]

CREATE TABLE [dbo].[SalesDisbDataHist2014](
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
CONSTRAINT [pk_SalesDisbDataHist2014] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
) ON [FactData2014]		






INSERT [SalesDisbDataHist2014] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2014 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2014_5Keys] ON [dbo].[SalesDisbDataHist2014] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_AADREGION] ON [dbo].[SalesDisbDataHist2014] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2014] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_D_T_TYP] ON [dbo].[SalesDisbDataHist2014] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_NWUSNA] ON [dbo].[SalesDisbDataHist2014] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_Partner] ON [dbo].[SalesDisbDataHist2014] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PCat] ON [dbo].[SalesDisbDataHist2014] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PCoverage] ON [dbo].[SalesDisbDataHist2014] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PName] ON [dbo].[SalesDisbDataHist2014] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PType] ON [dbo].[SalesDisbDataHist2014] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_SalesMgr] ON [dbo].[SalesDisbDataHist2014] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_TERM] ON [dbo].[SalesDisbDataHist2014] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_VendorID] ON [dbo].[SalesDisbDataHist2014] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]



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
FROM SalesDisbDataHist2014 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2014 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2014 					
					
UPDATE SalesDisbDataHist2014 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2014 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2014 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2014 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2014 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2014 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2014) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2014) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2014) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2014) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2014) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2014) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2014) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2014) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2014) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2014) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2014) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2014) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2014 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2014 D 
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
		 From SalesDisbDataHist2014 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2014 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2014 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2014 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2014 
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


--select * From SalesDisbDataHist2014 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2014 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2014
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2014 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2014 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2014
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2014 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2014 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2014
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2014')
   DROP TABLE [dbo].[ClaimSummaryHist2014]
   
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
INTO ClaimSummaryHist2014		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2014_AYPYRMON] ON [dbo].[ClaimSummaryHist2014] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2014_5Keys] ON [dbo].[ClaimSummaryHist2014] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

Delete ClaimSummaryHist2014
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2014 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2014')
   DROP TABLE ClaimsHist2014
   
	CREATE TABLE [dbo].[ClaimsHist2014](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2014]

INSERT dbo.ClaimsHist2014 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2014 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2014_PRDPRTDAT] ON [dbo].[ClaimsHist2014] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2014_5Keys] ON [dbo].[ClaimsHist2014] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2014 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2014 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2014 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2014 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2014 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2014 Where PRDAGRCOD=''

Delete ClaimsHist2014 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2014)

UPDATE ClaimsHist2014 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Period')
DROP INDEX [Idx_FactSales2014_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Account')
DROP INDEX [Idx_FactSales2014_Account] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_NationalAccount')
DROP INDEX [Idx_FactSales2014_NationalAccount] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_NewUsed')
DROP INDEX [Idx_FactSales2014_NewUsed] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Partner')
DROP INDEX [Idx_FactSales2014_Partner] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Partner_Prod')
DROP INDEX [Idx_FactSales2014_Partner_Prod] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_PName_Other')
DROP INDEX [Idx_FactSales2014_PName_Other] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_PRD_PRF')
DROP INDEX [Idx_FactSales2014_PRD_PRF] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_ProductType_Period')
DROP INDEX [Idx_FactSales2014_ProductType_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'idx_FactSales2014_ProductType_Period_Term')
DROP INDEX [idx_FactSales2014_ProductType_Period_Term] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_State')
DROP INDEX [Idx_FactSales2014_State] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_UniqueIdx')
DROP INDEX [Idx_FactSales2014_UniqueIdx] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'idx_FactSales2014_PName')
DROP INDEX [idx_FactSales2014_PName] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2014 for this period.
--Delete FactSales2014 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2014 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2014 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2014 H (NOLOCK)
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

--UPDATE FactSales2014 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2014 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2014 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2014
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2014 FS GROUP BY FS.AgreementID
INSERT FactSales2014 ( 
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
         	
       From  ClaimSummaryHist2014 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2014 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2014 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2014
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Period] ON [dbo].[FactSales2014] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Account] ON [dbo].[FactSales2014] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_NationalAccount] ON [dbo].[FactSales2014] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_NewUsed] ON [dbo].[FactSales2014] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Partner] ON [dbo].[FactSales2014] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Partner_Prod] ON [dbo].[FactSales2014] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_PName_Other] ON [dbo].[FactSales2014] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_PRD_PRF] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_ProductType_Period] ON [dbo].[FactSales2014] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_FactSales2014_ProductType_Period_Term] ON [dbo].[FactSales2014] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_State] ON [dbo].[FactSales2014] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_UniqueIdx] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_FactSales2014_PName] ON [dbo].[FactSales2014] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED




GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2014]    Script Date: 4/10/2014 10:32:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2014]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2014')
   DROP TABLE [dbo].[SalesDisbDataHist2014]

CREATE TABLE [dbo].[SalesDisbDataHist2014](
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
CONSTRAINT [pk_SalesDisbDataHist2014] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
) ON [FactData2014]		






INSERT [SalesDisbDataHist2014] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2014 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2014_5Keys] ON [dbo].[SalesDisbDataHist2014] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_AADREGION] ON [dbo].[SalesDisbDataHist2014] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2014] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_D_T_TYP] ON [dbo].[SalesDisbDataHist2014] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_NWUSNA] ON [dbo].[SalesDisbDataHist2014] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_Partner] ON [dbo].[SalesDisbDataHist2014] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PCat] ON [dbo].[SalesDisbDataHist2014] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PCoverage] ON [dbo].[SalesDisbDataHist2014] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PName] ON [dbo].[SalesDisbDataHist2014] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_PType] ON [dbo].[SalesDisbDataHist2014] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_SalesMgr] ON [dbo].[SalesDisbDataHist2014] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_TERM] ON [dbo].[SalesDisbDataHist2014] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2014_VendorID] ON [dbo].[SalesDisbDataHist2014] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]



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
FROM SalesDisbDataHist2014 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2014 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2014 					
					
UPDATE SalesDisbDataHist2014 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2014 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2014 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2014 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2014 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2014 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2014) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2014) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2014) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2014) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2014) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2014) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2014) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2014) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2014) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2014) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2014) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2014) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2014 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2014 D 
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
		 From SalesDisbDataHist2014 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2014 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2014 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2014 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2014 
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


--select * From SalesDisbDataHist2014 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2014 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2014
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2014 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2014 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2014
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2014 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2014 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2014
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2014')
   DROP TABLE [dbo].[ClaimSummaryHist2014]
   
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
INTO ClaimSummaryHist2014		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2014_AYPYRMON] ON [dbo].[ClaimSummaryHist2014] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2014_5Keys] ON [dbo].[ClaimSummaryHist2014] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

Delete ClaimSummaryHist2014
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2014 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2014')
   DROP TABLE ClaimsHist2014
   
	CREATE TABLE [dbo].[ClaimsHist2014](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2014]

INSERT dbo.ClaimsHist2014 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2014 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2014_PRDPRTDAT] ON [dbo].[ClaimsHist2014] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2014_5Keys] ON [dbo].[ClaimsHist2014] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2014 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2014 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2014 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2014 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2014 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2014 Where PRDAGRCOD=''

Delete ClaimsHist2014 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2014)

UPDATE ClaimsHist2014 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Period')
DROP INDEX [Idx_FactSales2014_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Account')
DROP INDEX [Idx_FactSales2014_Account] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_NationalAccount')
DROP INDEX [Idx_FactSales2014_NationalAccount] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_NewUsed')
DROP INDEX [Idx_FactSales2014_NewUsed] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Partner')
DROP INDEX [Idx_FactSales2014_Partner] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_Partner_Prod')
DROP INDEX [Idx_FactSales2014_Partner_Prod] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_PName_Other')
DROP INDEX [Idx_FactSales2014_PName_Other] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_PRD_PRF')
DROP INDEX [Idx_FactSales2014_PRD_PRF] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_ProductType_Period')
DROP INDEX [Idx_FactSales2014_ProductType_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'idx_FactSales2014_ProductType_Period_Term')
DROP INDEX [idx_FactSales2014_ProductType_Period_Term] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_State')
DROP INDEX [Idx_FactSales2014_State] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_FactSales2014_UniqueIdx')
DROP INDEX [Idx_FactSales2014_UniqueIdx] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'idx_FactSales2014_PName')
DROP INDEX [idx_FactSales2014_PName] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2014]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2014] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2014 for this period.
--Delete FactSales2014 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2014 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2014 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2014 H (NOLOCK)
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

--UPDATE FactSales2014 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2014 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2014 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2014
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2014 FS GROUP BY FS.AgreementID
INSERT FactSales2014 ( 
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
         	
       From  ClaimSummaryHist2014 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2014 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2014 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2014
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Period] ON [dbo].[FactSales2014] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Account] ON [dbo].[FactSales2014] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_NationalAccount] ON [dbo].[FactSales2014] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_NewUsed] ON [dbo].[FactSales2014] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Partner] ON [dbo].[FactSales2014] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_Partner_Prod] ON [dbo].[FactSales2014] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_PName_Other] ON [dbo].[FactSales2014] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_PRD_PRF] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_ProductType_Period] ON [dbo].[FactSales2014] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_FactSales2014_ProductType_Period_Term] ON [dbo].[FactSales2014] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_State] ON [dbo].[FactSales2014] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [Idx_FactSales2014_UniqueIdx] ON [dbo].[FactSales2014] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]
CREATE NONCLUSTERED INDEX [idx_FactSales2014_PName] ON [dbo].[FactSales2014] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2014]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2013]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2013]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2013')
   DROP TABLE [dbo].[SalesDisbDataHist2013]

CREATE TABLE [dbo].[SalesDisbDataHist2013](
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
CONSTRAINT [pk_SalesDisbDataHist2013] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
) ON [FactData2013]		






INSERT [SalesDisbDataHist2013] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2013 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2013_5Keys] ON [dbo].[SalesDisbDataHist2013] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_AADREGION] ON [dbo].[SalesDisbDataHist2013] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2013] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_D_T_TYP] ON [dbo].[SalesDisbDataHist2013] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_NWUSNA] ON [dbo].[SalesDisbDataHist2013] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_Partner] ON [dbo].[SalesDisbDataHist2013] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_PCat] ON [dbo].[SalesDisbDataHist2013] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_PCoverage] ON [dbo].[SalesDisbDataHist2013] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_PName] ON [dbo].[SalesDisbDataHist2013] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_PType] ON [dbo].[SalesDisbDataHist2013] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_SalesMgr] ON [dbo].[SalesDisbDataHist2013] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_TERM] ON [dbo].[SalesDisbDataHist2013] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2013_VendorID] ON [dbo].[SalesDisbDataHist2013] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]



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
FROM SalesDisbDataHist2013 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2013 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2013 					
					
UPDATE SalesDisbDataHist2013 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2013 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2013 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2013 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2013 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2013 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2013) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2013) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2013) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2013) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2013) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2013) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2013) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2013) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2013) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2013) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2013) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2013) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2013 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2013 D 
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
		 From SalesDisbDataHist2013 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2013 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2013 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2013 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2013 
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


--select * From SalesDisbDataHist2013 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2013 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2013
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2013 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2013 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2013
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2013 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2013 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2013
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2013')
   DROP TABLE [dbo].[ClaimSummaryHist2013]
   
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
INTO ClaimSummaryHist2013		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2013_AYPYRMON] ON [dbo].[ClaimSummaryHist2013] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2013_5Keys] ON [dbo].[ClaimSummaryHist2013] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]

Delete ClaimSummaryHist2013
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2013 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2013')
   DROP TABLE ClaimsHist2013
   
	CREATE TABLE [dbo].[ClaimsHist2013](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2013]

INSERT dbo.ClaimsHist2013 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2013 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2013_PRDPRTDAT] ON [dbo].[ClaimsHist2013] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2013_5Keys] ON [dbo].[ClaimsHist2013] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2013 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2013 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2013 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2013 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2013 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2013 Where PRDAGRCOD=''

Delete ClaimsHist2013 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2013)

UPDATE ClaimsHist2013 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Period')
DROP INDEX [Idx_FactSales2013_Period] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Account')
DROP INDEX [Idx_FactSales2013_Account] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_NationalAccount')
DROP INDEX [Idx_FactSales2013_NationalAccount] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_NewUsed')
DROP INDEX [Idx_FactSales2013_NewUsed] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Partner')
DROP INDEX [Idx_FactSales2013_Partner] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_Partner_Prod')
DROP INDEX [Idx_FactSales2013_Partner_Prod] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_PName_Other')
DROP INDEX [Idx_FactSales2013_PName_Other] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_PRD_PRF')
DROP INDEX [Idx_FactSales2013_PRD_PRF] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_ProductType_Period')
DROP INDEX [Idx_FactSales2013_ProductType_Period] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'idx_FactSales2013_ProductType_Period_Term')
DROP INDEX [idx_FactSales2013_ProductType_Period_Term] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_State')
DROP INDEX [Idx_FactSales2013_State] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_FactSales2013_UniqueIdx')
DROP INDEX [Idx_FactSales2013_UniqueIdx] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'idx_FactSales2013_PName')
DROP INDEX [idx_FactSales2013_PName] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2013]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2013] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2013 for this period.
--Delete FactSales2013 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2013 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2013 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2013 H (NOLOCK)
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

--UPDATE FactSales2013 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2013 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2013 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2013
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2013 FS GROUP BY FS.AgreementID
INSERT FactSales2013 ( 
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
         	
       From  ClaimSummaryHist2013 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2013 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2013 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2013
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Period] ON [dbo].[FactSales2013] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Account] ON [dbo].[FactSales2013] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_NationalAccount] ON [dbo].[FactSales2013] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_NewUsed] ON [dbo].[FactSales2013] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Partner] ON [dbo].[FactSales2013] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_Partner_Prod] ON [dbo].[FactSales2013] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_PName_Other] ON [dbo].[FactSales2013] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_PRD_PRF] ON [dbo].[FactSales2013] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_ProductType_Period] ON [dbo].[FactSales2013] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_FactSales2013_ProductType_Period_Term] ON [dbo].[FactSales2013] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_State] ON [dbo].[FactSales2013] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [Idx_FactSales2013_UniqueIdx] ON [dbo].[FactSales2013] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]
CREATE NONCLUSTERED INDEX [idx_FactSales2013_PName] ON [dbo].[FactSales2013] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2013]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2012]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2012]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2012')
   DROP TABLE [dbo].[SalesDisbDataHist2012]

CREATE TABLE [dbo].[SalesDisbDataHist2012](
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
CONSTRAINT [pk_SalesDisbDataHist2012] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
) ON [FactData2012]		






INSERT [SalesDisbDataHist2012] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2012 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2012_5Keys] ON [dbo].[SalesDisbDataHist2012] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_AADREGION] ON [dbo].[SalesDisbDataHist2012] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2012] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_D_T_TYP] ON [dbo].[SalesDisbDataHist2012] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_NWUSNA] ON [dbo].[SalesDisbDataHist2012] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_Partner] ON [dbo].[SalesDisbDataHist2012] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_PCat] ON [dbo].[SalesDisbDataHist2012] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_PCoverage] ON [dbo].[SalesDisbDataHist2012] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_PName] ON [dbo].[SalesDisbDataHist2012] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_PType] ON [dbo].[SalesDisbDataHist2012] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_SalesMgr] ON [dbo].[SalesDisbDataHist2012] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_TERM] ON [dbo].[SalesDisbDataHist2012] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2012_VendorID] ON [dbo].[SalesDisbDataHist2012] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]



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
FROM SalesDisbDataHist2012 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2012 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2012 					
					
UPDATE SalesDisbDataHist2012 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2012 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2012 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2012 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2012 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2012 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2012) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2012) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2012) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2012) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2012) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2012) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2012) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2012) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2012) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2012) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2012) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2012) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2012 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2012 D 
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
		 From SalesDisbDataHist2012 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2012 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2012 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2012 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2012 
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


--select * From SalesDisbDataHist2012 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2012 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2012
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2012 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2012 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2012
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2012 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2012 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2012
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2012')
   DROP TABLE [dbo].[ClaimSummaryHist2012]
   
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
INTO ClaimSummaryHist2012		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2012_AYPYRMON] ON [dbo].[ClaimSummaryHist2012] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2012_5Keys] ON [dbo].[ClaimSummaryHist2012] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]

Delete ClaimSummaryHist2012
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2012 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2012')
   DROP TABLE ClaimsHist2012
   
	CREATE TABLE [dbo].[ClaimsHist2012](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2012]

INSERT dbo.ClaimsHist2012 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2012 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2012_PRDPRTDAT] ON [dbo].[ClaimsHist2012] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2012_5Keys] ON [dbo].[ClaimsHist2012] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2012 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2012 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2012 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2012 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2012 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2012 Where PRDAGRCOD=''

Delete ClaimsHist2012 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2012)

UPDATE ClaimsHist2012 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Period')
DROP INDEX [Idx_FactSales2012_Period] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Account')
DROP INDEX [Idx_FactSales2012_Account] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_NationalAccount')
DROP INDEX [Idx_FactSales2012_NationalAccount] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_NewUsed')
DROP INDEX [Idx_FactSales2012_NewUsed] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Partner')
DROP INDEX [Idx_FactSales2012_Partner] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_Partner_Prod')
DROP INDEX [Idx_FactSales2012_Partner_Prod] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_PName_Other')
DROP INDEX [Idx_FactSales2012_PName_Other] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_PRD_PRF')
DROP INDEX [Idx_FactSales2012_PRD_PRF] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_ProductType_Period')
DROP INDEX [Idx_FactSales2012_ProductType_Period] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'idx_FactSales2012_ProductType_Period_Term')
DROP INDEX [idx_FactSales2012_ProductType_Period_Term] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_State')
DROP INDEX [Idx_FactSales2012_State] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_FactSales2012_UniqueIdx')
DROP INDEX [Idx_FactSales2012_UniqueIdx] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'idx_FactSales2012_PName')
DROP INDEX [idx_FactSales2012_PName] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2012]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2012] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2012 for this period.
--Delete FactSales2012 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2012 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2012 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2012 H (NOLOCK)
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

--UPDATE FactSales2012 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2012 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2012 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2012
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2012 FS GROUP BY FS.AgreementID
INSERT FactSales2012 ( 
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
         	
       From  ClaimSummaryHist2012 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2012 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2012 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2012
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Period] ON [dbo].[FactSales2012] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Account] ON [dbo].[FactSales2012] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_NationalAccount] ON [dbo].[FactSales2012] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_NewUsed] ON [dbo].[FactSales2012] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Partner] ON [dbo].[FactSales2012] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_Partner_Prod] ON [dbo].[FactSales2012] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_PName_Other] ON [dbo].[FactSales2012] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_PRD_PRF] ON [dbo].[FactSales2012] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_ProductType_Period] ON [dbo].[FactSales2012] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_FactSales2012_ProductType_Period_Term] ON [dbo].[FactSales2012] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_State] ON [dbo].[FactSales2012] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [Idx_FactSales2012_UniqueIdx] ON [dbo].[FactSales2012] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]
CREATE NONCLUSTERED INDEX [idx_FactSales2012_PName] ON [dbo].[FactSales2012] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2012]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2011]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2011]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2011')
   DROP TABLE [dbo].[SalesDisbDataHist2011]

CREATE TABLE [dbo].[SalesDisbDataHist2011](
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
CONSTRAINT [pk_SalesDisbDataHist2011] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
) ON [FactData2011]		






INSERT [SalesDisbDataHist2011] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2011 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2011_5Keys] ON [dbo].[SalesDisbDataHist2011] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_AADREGION] ON [dbo].[SalesDisbDataHist2011] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2011] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_D_T_TYP] ON [dbo].[SalesDisbDataHist2011] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_NWUSNA] ON [dbo].[SalesDisbDataHist2011] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_Partner] ON [dbo].[SalesDisbDataHist2011] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_PCat] ON [dbo].[SalesDisbDataHist2011] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_PCoverage] ON [dbo].[SalesDisbDataHist2011] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_PName] ON [dbo].[SalesDisbDataHist2011] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_PType] ON [dbo].[SalesDisbDataHist2011] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_SalesMgr] ON [dbo].[SalesDisbDataHist2011] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_TERM] ON [dbo].[SalesDisbDataHist2011] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2011_VendorID] ON [dbo].[SalesDisbDataHist2011] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]



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
FROM SalesDisbDataHist2011 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2011 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2011 					
					
UPDATE SalesDisbDataHist2011 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2011 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2011 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2011 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2011 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2011 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2011) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2011) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2011) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2011) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2011) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2011) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2011) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2011) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2011) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2011) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2011) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2011) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2011 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2011 D 
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
		 From SalesDisbDataHist2011 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2011 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2011 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2011 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2011 
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


--select * From SalesDisbDataHist2011 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2011 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2011
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2011 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2011 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2011
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2011 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2011 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2011
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2011')
   DROP TABLE [dbo].[ClaimSummaryHist2011]
   
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
INTO ClaimSummaryHist2011		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2011_AYPYRMON] ON [dbo].[ClaimSummaryHist2011] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2011_5Keys] ON [dbo].[ClaimSummaryHist2011] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]

Delete ClaimSummaryHist2011
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2011 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2011')
   DROP TABLE ClaimsHist2011
   
	CREATE TABLE [dbo].[ClaimsHist2011](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2011]

INSERT dbo.ClaimsHist2011 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2011 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2011_PRDPRTDAT] ON [dbo].[ClaimsHist2011] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2011_5Keys] ON [dbo].[ClaimsHist2011] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2011 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2011 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2011 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2011 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2011 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2011 Where PRDAGRCOD=''

Delete ClaimsHist2011 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2011)

UPDATE ClaimsHist2011 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Period')
DROP INDEX [Idx_FactSales2011_Period] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Account')
DROP INDEX [Idx_FactSales2011_Account] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_NationalAccount')
DROP INDEX [Idx_FactSales2011_NationalAccount] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_NewUsed')
DROP INDEX [Idx_FactSales2011_NewUsed] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Partner')
DROP INDEX [Idx_FactSales2011_Partner] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_Partner_Prod')
DROP INDEX [Idx_FactSales2011_Partner_Prod] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_PName_Other')
DROP INDEX [Idx_FactSales2011_PName_Other] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_PRD_PRF')
DROP INDEX [Idx_FactSales2011_PRD_PRF] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_ProductType_Period')
DROP INDEX [Idx_FactSales2011_ProductType_Period] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'idx_FactSales2011_ProductType_Period_Term')
DROP INDEX [idx_FactSales2011_ProductType_Period_Term] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_State')
DROP INDEX [Idx_FactSales2011_State] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_FactSales2011_UniqueIdx')
DROP INDEX [Idx_FactSales2011_UniqueIdx] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'idx_FactSales2011_PName')
DROP INDEX [idx_FactSales2011_PName] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2011]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2011] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2011 for this period.
--Delete FactSales2011 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2011 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2011 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2011 H (NOLOCK)
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

--UPDATE FactSales2011 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2011 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2011 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2011
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2011 FS GROUP BY FS.AgreementID
INSERT FactSales2011 ( 
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
         	
       From  ClaimSummaryHist2011 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2011 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2011 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2011
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Period] ON [dbo].[FactSales2011] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Account] ON [dbo].[FactSales2011] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_NationalAccount] ON [dbo].[FactSales2011] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_NewUsed] ON [dbo].[FactSales2011] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Partner] ON [dbo].[FactSales2011] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_Partner_Prod] ON [dbo].[FactSales2011] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_PName_Other] ON [dbo].[FactSales2011] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_PRD_PRF] ON [dbo].[FactSales2011] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_ProductType_Period] ON [dbo].[FactSales2011] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_FactSales2011_ProductType_Period_Term] ON [dbo].[FactSales2011] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_State] ON [dbo].[FactSales2011] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [Idx_FactSales2011_UniqueIdx] ON [dbo].[FactSales2011] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]
CREATE NONCLUSTERED INDEX [idx_FactSales2011_PName] ON [dbo].[FactSales2011] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2011]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2010]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2010]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2010')
   DROP TABLE [dbo].[SalesDisbDataHist2010]

CREATE TABLE [dbo].[SalesDisbDataHist2010](
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
CONSTRAINT [pk_SalesDisbDataHist2010] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
) ON [FactData2010]		






INSERT [SalesDisbDataHist2010] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2010 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2010_5Keys] ON [dbo].[SalesDisbDataHist2010] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_AADREGION] ON [dbo].[SalesDisbDataHist2010] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2010] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_D_T_TYP] ON [dbo].[SalesDisbDataHist2010] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_NWUSNA] ON [dbo].[SalesDisbDataHist2010] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_Partner] ON [dbo].[SalesDisbDataHist2010] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_PCat] ON [dbo].[SalesDisbDataHist2010] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_PCoverage] ON [dbo].[SalesDisbDataHist2010] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_PName] ON [dbo].[SalesDisbDataHist2010] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_PType] ON [dbo].[SalesDisbDataHist2010] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_SalesMgr] ON [dbo].[SalesDisbDataHist2010] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_TERM] ON [dbo].[SalesDisbDataHist2010] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2010_VendorID] ON [dbo].[SalesDisbDataHist2010] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]



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
FROM SalesDisbDataHist2010 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2010 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2010 					
					
UPDATE SalesDisbDataHist2010 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2010 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2010 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2010 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2010 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2010 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2010) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2010) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2010) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2010) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2010) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2010) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2010) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2010) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2010) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2010) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2010) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2010) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2010 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2010 D 
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
		 From SalesDisbDataHist2010 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2010 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2010 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2010 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2010 
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


--select * From SalesDisbDataHist2010 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2010 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2010
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2010 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2010 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2010
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2010 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2010 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2010
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2010')
   DROP TABLE [dbo].[ClaimSummaryHist2010]
   
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
INTO ClaimSummaryHist2010		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2010_AYPYRMON] ON [dbo].[ClaimSummaryHist2010] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2010_5Keys] ON [dbo].[ClaimSummaryHist2010] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]

Delete ClaimSummaryHist2010
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2010 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2010')
   DROP TABLE ClaimsHist2010
   
	CREATE TABLE [dbo].[ClaimsHist2010](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2010]

INSERT dbo.ClaimsHist2010 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2010 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2010_PRDPRTDAT] ON [dbo].[ClaimsHist2010] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2010_5Keys] ON [dbo].[ClaimsHist2010] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2010 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2010 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2010 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2010 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2010 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2010 Where PRDAGRCOD=''

Delete ClaimsHist2010 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2010)

UPDATE ClaimsHist2010 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Period')
DROP INDEX [Idx_FactSales2010_Period] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Account')
DROP INDEX [Idx_FactSales2010_Account] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_NationalAccount')
DROP INDEX [Idx_FactSales2010_NationalAccount] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_NewUsed')
DROP INDEX [Idx_FactSales2010_NewUsed] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Partner')
DROP INDEX [Idx_FactSales2010_Partner] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_Partner_Prod')
DROP INDEX [Idx_FactSales2010_Partner_Prod] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_PName_Other')
DROP INDEX [Idx_FactSales2010_PName_Other] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_PRD_PRF')
DROP INDEX [Idx_FactSales2010_PRD_PRF] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_ProductType_Period')
DROP INDEX [Idx_FactSales2010_ProductType_Period] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'idx_FactSales2010_ProductType_Period_Term')
DROP INDEX [idx_FactSales2010_ProductType_Period_Term] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_State')
DROP INDEX [Idx_FactSales2010_State] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_FactSales2010_UniqueIdx')
DROP INDEX [Idx_FactSales2010_UniqueIdx] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'idx_FactSales2010_PName')
DROP INDEX [idx_FactSales2010_PName] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2010]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2010] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2010 for this period.
--Delete FactSales2010 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2010 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2010 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2010 H (NOLOCK)
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

--UPDATE FactSales2010 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2010 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2010 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2010
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2010 FS GROUP BY FS.AgreementID
INSERT FactSales2010 ( 
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
         	
       From  ClaimSummaryHist2010 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2010 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2010 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2010
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Period] ON [dbo].[FactSales2010] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Account] ON [dbo].[FactSales2010] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_NationalAccount] ON [dbo].[FactSales2010] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_NewUsed] ON [dbo].[FactSales2010] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Partner] ON [dbo].[FactSales2010] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_Partner_Prod] ON [dbo].[FactSales2010] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_PName_Other] ON [dbo].[FactSales2010] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_PRD_PRF] ON [dbo].[FactSales2010] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_ProductType_Period] ON [dbo].[FactSales2010] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_FactSales2010_ProductType_Period_Term] ON [dbo].[FactSales2010] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_State] ON [dbo].[FactSales2010] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [Idx_FactSales2010_UniqueIdx] ON [dbo].[FactSales2010] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]
CREATE NONCLUSTERED INDEX [idx_FactSales2010_PName] ON [dbo].[FactSales2010] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2010]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2009]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2009]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))

IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist2009')
   DROP TABLE [dbo].[SalesDisbDataHist2009]

CREATE TABLE [dbo].[SalesDisbDataHist2009](
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
CONSTRAINT [pk_SalesDisbDataHist2009] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
) ON [FactData2009]		






INSERT [SalesDisbDataHist2009] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist2009 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist2009_5Keys] ON [dbo].[SalesDisbDataHist2009] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_AADREGION] ON [dbo].[SalesDisbDataHist2009] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist2009] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_D_T_TYP] ON [dbo].[SalesDisbDataHist2009] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_NWUSNA] ON [dbo].[SalesDisbDataHist2009] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_Partner] ON [dbo].[SalesDisbDataHist2009] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_PCat] ON [dbo].[SalesDisbDataHist2009] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_PCoverage] ON [dbo].[SalesDisbDataHist2009] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_PName] ON [dbo].[SalesDisbDataHist2009] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_PType] ON [dbo].[SalesDisbDataHist2009] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_SalesMgr] ON [dbo].[SalesDisbDataHist2009] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_TERM] ON [dbo].[SalesDisbDataHist2009] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist2009_VendorID] ON [dbo].[SalesDisbDataHist2009] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]



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
FROM SalesDisbDataHist2009 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist2009 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist2009 					
					
UPDATE SalesDisbDataHist2009 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist2009 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist2009 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist2009 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist2009 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist2009 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist2009) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist2009) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist2009) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist2009) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist2009) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist2009) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist2009) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist2009) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist2009) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist2009) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist2009) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist2009) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist2009 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist2009 D 
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
		 From SalesDisbDataHist2009 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist2009 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist2009 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist2009 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist2009 
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


--select * From SalesDisbDataHist2009 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist2009 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist2009
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist2009 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist2009 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2009
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist2009 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist2009 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist2009
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist2009')
   DROP TABLE [dbo].[ClaimSummaryHist2009]
   
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
INTO ClaimSummaryHist2009		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2009_AYPYRMON] ON [dbo].[ClaimSummaryHist2009] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist2009_5Keys] ON [dbo].[ClaimSummaryHist2009] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]

Delete ClaimSummaryHist2009
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2009 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist2009')
   DROP TABLE ClaimsHist2009
   
	CREATE TABLE [dbo].[ClaimsHist2009](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData2009]

INSERT dbo.ClaimsHist2009 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist2009 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2009_PRDPRTDAT] ON [dbo].[ClaimsHist2009] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist2009_5Keys] ON [dbo].[ClaimsHist2009] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist2009 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2009 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist2009 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist2009 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist2009 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist2009 Where PRDAGRCOD=''

Delete ClaimsHist2009 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist2009)

UPDATE ClaimsHist2009 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Period')
DROP INDEX [Idx_FactSales2009_Period] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Account')
DROP INDEX [Idx_FactSales2009_Account] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_NationalAccount')
DROP INDEX [Idx_FactSales2009_NationalAccount] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_NewUsed')
DROP INDEX [Idx_FactSales2009_NewUsed] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Partner')
DROP INDEX [Idx_FactSales2009_Partner] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_Partner_Prod')
DROP INDEX [Idx_FactSales2009_Partner_Prod] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_PName_Other')
DROP INDEX [Idx_FactSales2009_PName_Other] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_PRD_PRF')
DROP INDEX [Idx_FactSales2009_PRD_PRF] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_ProductType_Period')
DROP INDEX [Idx_FactSales2009_ProductType_Period] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'idx_FactSales2009_ProductType_Period_Term')
DROP INDEX [idx_FactSales2009_ProductType_Period_Term] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_State')
DROP INDEX [Idx_FactSales2009_State] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_FactSales2009_UniqueIdx')
DROP INDEX [Idx_FactSales2009_UniqueIdx] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'idx_FactSales2009_PName')
DROP INDEX [idx_FactSales2009_PName] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales2009]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales2009] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales2009 for this period.
--Delete FactSales2009 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2009 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2009 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist2009 H (NOLOCK)
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

--UPDATE FactSales2009 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales2009 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist2009 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2009
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales2009 FS GROUP BY FS.AgreementID
INSERT FactSales2009 ( 
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
         	
       From  ClaimSummaryHist2009 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales2009 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales2009 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2009
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Period] ON [dbo].[FactSales2009] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Account] ON [dbo].[FactSales2009] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_NationalAccount] ON [dbo].[FactSales2009] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_NewUsed] ON [dbo].[FactSales2009] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Partner] ON [dbo].[FactSales2009] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_Partner_Prod] ON [dbo].[FactSales2009] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_PName_Other] ON [dbo].[FactSales2009] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_PRD_PRF] ON [dbo].[FactSales2009] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_ProductType_Period] ON [dbo].[FactSales2009] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_FactSales2009_ProductType_Period_Term] ON [dbo].[FactSales2009] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_State] ON [dbo].[FactSales2009] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [Idx_FactSales2009_UniqueIdx] ON [dbo].[FactSales2009] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]
CREATE NONCLUSTERED INDEX [idx_FactSales2009_PName] ON [dbo].[FactSales2009] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2009]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData20072008]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData20072008]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))
-- GetTier23SalesData20072008 19000000, 20140131

-- GetTier23SalesData20072008 19000000, 19921231
-- GetTier23SalesData20072008 19930000, 19961231
-- GetTier23SalesData20072008 19970000, 19991231
-- GetTier23SalesData20072008 20000000, 20021231
-- GetTier23SalesData20072008 20030000, 20041231
-- GetTier23SalesData20072008 20050000, 200720081231
IF EXISTS(Select * FROM sysobjects Where Name ='SalesDisbDataHist20072008')
   DROP TABLE [dbo].[SalesDisbDataHist20072008]

CREATE TABLE [dbo].[SalesDisbDataHist20072008](
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
CONSTRAINT [pk_SalesDisbDataHist20072008] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
) ON [FactData20072008]		






INSERT [SalesDisbDataHist20072008] 
		(ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, 
		 ADMTRNTYP, CUSTFNAME, CUSTLNAME, ADMDISTYP, ADMDISCOD, Amt, 
		 AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, PRDSTS, TERM, NWUSNA,
		 AGMPSTDAT, ADMPSTDAT, AADREGION)
		 
SELECT  D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX,  
		D.ADMTRNTYP, AGMCUSFNM, AGMCUSLNM, ADMDISTYP, D.ADMDISCOD, SUM(D.ADMDISAMT) Amt, 		
		A.AGMPRGCOD, D.ADMPRDCOD, PLN.APVALPVAL AGDPLNCOD,P.APVALPVAL PRDSTS, TERM.APVNUMVAL TERM, V.APVALPVAL NewUsedNA,
		A.AGMPSTDAT, D.ADMPSTDAT,
		ADDR.AADREGION
		


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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
AND ADMPSTDAT between @FromPeriod AND @ToPeriod
GROUP BY D.ADMCLICOD, D.ADMACCCOD, D.ADMAGRCOD, D.ADMAGRSFX, D.ADMPRDCOD, AGMCUSFNM,AGMCUSLNM, D.ADMTRNTYP,D.ADMDISTYP, D.ADMDISCOD,
A.AGMPRGCOD, PLN.APVALPVAL, P.APVALPVAL, TERM.APVNUMVAL, V.APVALPVAL,
A.AGMPSTDAT, D.ADMPSTDAT,ADDR.AADREGION

UpDATE SalesDisbDataHist20072008 SET 
ADMCLICOD=ltrim(rtrim(ADMCLICOD)), 
AGMPRGCOD=ltrim(rtrim(AGMPRGCOD)),
ADMPRDCOD=ltrim(rtrim(ADMPRDCOD)),
AGDPLNCOD=ltrim(rtrim(AGDPLNCOD)),
ADMACCCOD=ltrim(rtrim(ADMACCCOD)),
ADMAGRCOD=ltrim(rtrim(ADMAGRCOD)),
ADMAGRSFX=ltrim(rtrim(ADMAGRSFX)),
NWUSNA=CASE WHEN ltrim(rtrim(NWUSNA))='' THEN 'N/A' ELSE ltrim(rtrim(NWUSNA)) END,
PRDSTS=CASE WHEN ltrim(rtrim(PRDSTS))='' THEN 'N/A' ELSE ltrim(rtrim(PRDSTS)) END



CREATE NONCLUSTERED INDEX [Idx_SalesDisbDataHist20072008_5Keys] ON [dbo].[SalesDisbDataHist20072008] 
(
	[ADMCLICOD] ASC,
	[ADMACCCOD] ASC,
	[ADMAGRCOD] ASC,
	[ADMAGRSFX] ASC,
	[ADMPRDCOD] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_AADREGION] ON [dbo].[SalesDisbDataHist20072008] 
(
	[AADREGION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_AG_AD_PSTDAT] ON [dbo].[SalesDisbDataHist20072008] 
(
	[AGMPSTDAT] ASC,
	[ADMPSTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_D_T_TYP] ON [dbo].[SalesDisbDataHist20072008] 
(
	[ADMDISTYP] ASC,
	[ADMTRNTYP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_NWUSNA] ON [dbo].[SalesDisbDataHist20072008] 
(
	[NWUSNA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_Partner] ON [dbo].[SalesDisbDataHist20072008] 
(
	[Partner] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_PCat] ON [dbo].[SalesDisbDataHist20072008] 
(
	[ProductCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_PCoverage] ON [dbo].[SalesDisbDataHist20072008] 
(
	[Coverage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_PName] ON [dbo].[SalesDisbDataHist20072008] 
(
	[ProductName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_PType] ON [dbo].[SalesDisbDataHist20072008] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_SalesMgr] ON [dbo].[SalesDisbDataHist20072008] 
(
	[SalesManager] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_TERM] ON [dbo].[SalesDisbDataHist20072008] 
(
	[TERM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_SalesDisbDataHist20072008_VendorID] ON [dbo].[SalesDisbDataHist20072008] 
(
	[VendorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]



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
FROM SalesDisbDataHist20072008 D 
INNER JOIN #CRMData CRM ON CRM.AccountNumber=D.ADMACCCOD


UPDATE D SET VendorID=S.VendorID,
			SalesManager=S.SalesManager,
			VendorStatus=SantanderStatus,
			VendorName=BusinessName
FROM SalesDisbDataHist20072008 D 
INNER JOIN 
			(SELECT EFGAccountNum COLLATE SQL_Latin1_General_CP1_CI_AS AccountNumber,
					VendorID,
					SalesManager COLLATE SQL_Latin1_General_CP1_CI_AS SalesManager,
					SantanderStatus,
					BusinessName
					FROM 
					[sv-sql05].SGUARD_PORTAL.DBO.TBLVENDORSUPDATED ) AS S ON S.AccountNumber=D.ADMACCCOD

--Select distinct Partner, VendorID, SalesManager, VendorStatus, VendorName, AccountName, ADMACCCOD From SalesDisbDataHist20072008 					
					
UPDATE SalesDisbDataHist20072008 SET VendorID=-1, SalesManager='N/A', VendorStatus=2, VendorName='N/A' WHERE ISNULL(VendorID, -1)=-1


UPDATE SalesDisbDataHist20072008 SET ProductType=NULL, ProductCategory=NULL, ProductName=NULL, Coverage=NULL, Partner=NULL

UPDATE D SET ProductType=M.[Type], ProductCategory=M.Category, ProductName=M.ProductName, Coverage=M.Coverage, Partner=M.Partner
FROM SalesDisbDataHist20072008 D 
INNER JOIN MasterProductMatrix M ON D.ADMCLICOD=M.CLICOD AND D.AGMPRGCOD=M.CPROG AND D.ADMPRDCOD=M.CPROD AND D.AGDPLNCOD=M.CPLAN


UPDATE D SET ProductType='UNKNOWN', ProductCategory='UNKNOWN', ProductName='UNKNOWN'
FROM SalesDisbDataHist20072008 D 
WHERE D.ProductCategory IS NULL

UPDATE SalesDisbDataHist20072008 Set Coverage='N/A' Where Coverage IS NULL

UPDATE SalesDisbDataHist20072008 Set Partner='EFG' Where Partner IS NULL


------------------ CREATE THE DIMENSIONAL MODEL ---------------------- First DIMS
INSERT DimPartner (PartnerName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.Partner,  0, 1, GETDATE(), GETDATE(), P.Partner From
(Select Distinct Partner From SalesDisbDataHist20072008) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
WHERE DP.PartnerID IS NULL


INSERT DimNationalAccount (PartnerID, NationalAccountName, NationalAccountSrcID, Status, StatusCode, StatusDesc, dimType, Active, FromDate, UpdateDate, SourceKey)
Select DP.PartnerID, VendorName, VendorID, VendorStatus, CASE VendorStatus WHEN 2 THEN 'A' WHEN 1 THEN 'I' ELSE 'N/A' END, CASE VendorStatus WHEN 2 THEN 'Active' WHEN 1 THEN 'Inactive' ELSE 'N/A' END, 0, 1, GETDATE(), GETDATE(), VendorID
From
(Select Distinct Partner, VendorID, VendorStatus, VendorName From SalesDisbDataHist20072008) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner 
LEFT JOIN DimNationalAccount NA ON NA.NationalAccountSrcID=ISNULL(P.VendorID, -1)
AND DP.PartnerID=NA.PartnerID
WHERE NA.NationalAccountID IS NULL

INSERT DimVehicleState (VehicleStateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE P.NWUSNA WHEN 'N' Then 'New'
				     WHEN 'U' Then 'Used'
				     ELSE P.NWUSNA END, 0, 1, GETDATE(), GETDATE(), P.NWUSNA From
(Select Distinct NWUSNA  From SalesDisbDataHist20072008) P
LEFT JOIN DimVehicleState D ON D.SourceKey=P.NWUSNA
WHERE D.VehicleStateID IS NULL


INSERT DimProductStatus (ProductStatusName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select PRDSTS, 0, 1, GETDATE(), GETDATE(), P.PRDSTS From
(Select Distinct PRDSTS  From SalesDisbDataHist20072008) P
LEFT JOIN DimProductStatus D ON D.SourceKey=P.PRDSTS
WHERE D.ProductStatusID IS NULL


INSERT DimState (StateCode, StateName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select CASE WHEN AADREGION='' THEN 'N/A' ELSE AADREGION END, CASE WHEN AADREGION='' THEN '_Blank' ELSE AADREGION END, 0, 1, GETDATE(), GETDATE(), P.AADREGION From
(Select Distinct  AADREGION=ltrim(rtrim(AADREGION)) From SalesDisbDataHist20072008) P
LEFT JOIN DimState D ON D.SourceKey=P.AADREGION
WHERE D.StateID IS NULL

INSERT DimTerms (TermName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.TermName,  0, 1, GETDATE(), GETDATE(), SrcKey From
(Select Distinct  TermName=Convert(Numeric(18,0), TERM), SrcKey=TERM From SalesDisbDataHist20072008) P
LEFT JOIN DimTerms D ON D.SourceKey=P.SrcKey
WHERE D.TermID IS NULL
Order by P.TermName

INSERT DimSalesManager (SalesManagerName, NationalAccountID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.SalesManager, NA.NationalAccountID, 0, 1, GETDATE(), GETDATE(), P.SalesManager From
(Select Distinct  Partner, VendorID=ISNULL(VendorID,-1), SalesManager=ISNULL(SalesManager, 'N/A') From SalesDisbDataHist20072008) P
LEFT JOIN DimPartner DP ON DP.PartnerName=P.Partner
LEFT JOIN DimNationalAccount NA ON NA.SourceKey=ISNULL(P.VendorID, -1) AND NA.PartnerID=DP.PartnerID
LEFT JOIN DimSalesManager D ON D.SourceKey=ISNULL(P.SalesManager, 'N/A') And D.NationalAccountID=NA.NationalAccountID
WHERE D.SalesManagerID IS NULL
Order by P.SalesManager

INSERT DimAccount (AccountName, EFGAccountCode, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.AccountName, P.ADMACCCOD,  0, 1, GETDATE(), GETDATE(), P.ADMACCCOD From
(Select Distinct  ADMACCCOD, AccountName=ISNULL(AccountName,'_Missing in CRM'), SrcKey=ISNULL(AccountName,'_Missing in CRM')+'|'+ADMACCCOD  From SalesDisbDataHist20072008) P
LEFT JOIN DimAccount D ON D.SourceKey=P.SrcKey
WHERE D.AccountID IS NULL
Order by P.AccountName

INSERT DimCoverage (CoverageName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select Coverage,  0, 1, GETDATE(), GETDATE(), Coverage From
(Select Distinct  Coverage=LTRIM(rtrim(Coverage))  From SalesDisbDataHist20072008) P
LEFT JOIN DimCoverage D ON D.SourceKey=P.Coverage
WHERE D.CoverageID IS NULL
Order by P.Coverage

INSERT DimProductCategory (ProductCategoryName, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductCategory,  0, 1, GETDATE(), GETDATE(), ProductCategory From
(Select Distinct  ProductCategory  From SalesDisbDataHist20072008) P
LEFT JOIN DimProductCategory D ON D.SourceKey=P.ProductCategory
WHERE D.ProductCategoryID IS NULL
Order by P.ProductCategory


INSERT DimProductType (ProductTypeName, ProductCategoryID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select ProductType, PC.ProductCategoryID, 0, 1, GETDATE(), GETDATE(), ProductType From
(Select Distinct  ProductCategory, ProductType  From SalesDisbDataHist20072008) P
LEFT JOIN DimProductType D ON D.SourceKey=P.ProductType
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
WHERE D.ProductTypeID IS NULL 
Order by P.ProductType

INSERT DimProductName (ProductName, ProductTypeID, dimType, Active, FromDate, UpdateDate, SourceKey)
Select P.ProductName, PC.ProductTypeID, 0, 1, GETDATE(), GETDATE(), P.ProductName From
(Select Distinct  ProductType, ProductName  From SalesDisbDataHist20072008) P
LEFT JOIN DimProductName D ON D.SourceKey=P.ProductName
LEFT JOIN DimProductType PC ON PC.SourceKey=P.ProductType 
WHERE D.ProductNameID IS NULL 
Order by P.ProductName

INSERT DimAgreement (CustomerName, CustomerFirstName, CustomerLastName, dimType, Active, FromDate, UpdateDate, SourceCLICOD, SourceACCCOD, SourceAGRCOD, SourceAGRSFX, SourcePRDCOD, SourcePLNCOD, AgreementStatusID)
Select P.CUSTNAME, CUSTFNAME, CUSTLNAME, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD, P.ADMACCCOD, P.ADMAGRCOD, P.ADMAGRSFX, P.ADMPRDCOD, P.AGDPLNCOD, 0
FROM
( 
	Select CUSTNAME=CUSTFNAME+' '+CUSTLNAME, CUSTFNAME, CUSTLNAME, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, AGDPLNCOD=MIN(AGDPLNCOD) From SalesDisbDataHist20072008 
    GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, CUSTFNAME, CUSTLNAME

) P 
  LEFT JOIN DimAgreement D ON D.SourceCLICOD=P.ADMCLICOD AND D.SourceACCCOD=P.ADMACCCOD AND D.SourceAGRCOD=P.ADMAGRCOD
  AND D.SourceAGRSFX=P.ADMAGRSFX AND D.SourcePRDCOD=P.ADMPRDCOD
WHERE D.CustomerName IS NULL 

INSERT DimPlan (PlanName,PlanDesc,dimType,Active,FromDate,UpdateDate)
Select CPlan, MIN(cp.PlanDesc),0, 1, GETDATE(), GETDATE() From 
(
		Select Distinct CPlan, PlanDesc 
		FROM SalesDisbDataHist20072008 D 
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
		 From SalesDisbDataHist20072008 H
LEFT JOIN DimAgreementStatus DS ON DS.SourceKey=H.PRDSTS
WHERE DS.AgreementStatusID IS NULL
Group By PRDSTS



UPDATE  A SET AgreementStatusID=D.AgreementStatusID
--Select COUNT(*) 
FROM DimAgreement A 
INNER JOIN (SELECT ID=MAX(ID),ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD FROM SalesDisbDataHist20072008 GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD) AS  H ON SourceACCCOD=H.ADMACCCOD AND SourceCLICOD=H.ADMCLICOD AND SourceAGRCOD=H.ADMAGRCOD AND SourceAGRSFX=H.ADMAGRSFX AND SourcePRDCOD=H.ADMPRDCOD 
INNER JOIN SalesDisbDataHist20072008 LS ON LS.ID=H.ID
INNER JOIN DimAgreementStatus D ON D.SourceKey=LS.PRDSTS


INSERT  DimFourPartProductKey(Name, ClientCode, ProgramCode, ProductCode, PlanCode, dimType, Active, FromDate, UPdateDate, SourceKey, ProductNameID)
Select ISNULL(P.ADMCLICOD,'')+ ' '+ISNULL(P.AGMPRGCOD,'')+ ' '+ISNULL(P.ADMPRDCOD,'')+' '+ISNULL(P.AGDPLNCOD,''), P.ADMCLICOD, P.AGMPRGCOD, P.ADMPRDCOD, P.AGDPLNCOD, 0, 1, GETDATE(), GETDATE(), P.ADMCLICOD+ '|'+P.AGMPRGCOD+ '|'+P.ADMPRDCOD+'|'+P.AGDPLNCOD, PN.ProductNameID
FROM
( Select ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName From SalesDisbDataHist20072008 
   GROUP BY ADMCLICOD, AGMPRGCOD, ADMPRDCOD, AGDPLNCOD, ProductName) P
INNER JOIN DimProductName PN ON  PN.ProductName=P.ProductName
  LEFT JOIN DimFourPartProductKey D ON D.ClientCode=P.ADMCLICOD AND D.ProgramCode=P.AGMPRGCOD AND D.ProductCode=P.ADMPRDCOD
  AND D.PlanCode=P.AGDPLNCOD
WHERE D.KeyID IS NULL 

-- PLEASE CHECK drop table #tmp
		Select ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMPSTDAT, ADMTRNTYP, Sum(Amt) Amt
		INTO #tmp
		From SalesDisbDataHist20072008 
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


--select * From SalesDisbDataHist20072008 where ADMAGRCOD in (SElect distinct ADMAGRCOD from #tmp2)
--and ADMDISTYP='RESV'
--order by ADMPSTDAT, ADMAGRCOD


-- Update SalesDisbDataHist20072008 SET GrossAmount=0, NetAmount=0
UPDATE SalesDisbDataHist20072008
SET GrossAmount=CASE WHEN ADMTRNTYP='CUR' AND ADMPSTDAT=AGMPSTDAT THEN Amt ELSE 0 END,							
    NetAmount=Amt
WHERE ADMDISTYP='RESV'	


-- Update SalesDisbDataHist20072008 SET GrossCount=0, NetCount=0

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
-- SELECT count(*) 
FROM SalesDisbDataHist20072008 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist20072008
	WHERE ADMDISTYP='RESV'
	GROUP BY ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD, ADMTRNTYP, ADMPSTDAT, AGMPSTDAT
) AS FirstRec on FirstRec.ID=Y.ID

UPDATE Y 
SET GrossCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 0 END,
NetCount=CASE WHEN Y.ADMTRNTYP='CUR' AND Y.ADMPSTDAT=Y.AGMPSTDAT THEN 1 ELSE 
CASE WHEN (Y.ADMTRNTYP ='CAN') THEN -1 ELSE CASE WHEN (Y.ADMTRNTYP ='REN') THEN 1 ELSE 0 END END END
FROM SalesDisbDataHist20072008 Y
INNER JOIN (
	SELECT ID=MIN(ID) 
	FROM SalesDisbDataHist20072008 D
			LEFT JOIN (
				SELECT Distinct ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, ADMPRDCOD
				FROM SalesDisbDataHist20072008
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

IF EXISTS(Select * FROM sysobjects Where Name ='ClaimSummaryHist20072008')
   DROP TABLE [dbo].[ClaimSummaryHist20072008]
   
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
INTO ClaimSummaryHist20072008		
FROM I400DASQL.EFGAS400.SESCSEFG.SCAGREP
WHERE  AEPYRMON BETWEEN @PYRMONFROM AND @PYRMONTO 
GROUP BY 
AEPCLICOD,
AEPACCCOD,
AEPAGRCOD,
AEPAGRSFX,
AEPPRDCOD,
AEPYRMON


CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist20072008_AYPYRMON] ON [dbo].[ClaimSummaryHist20072008] 
(
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]

CREATE NONCLUSTERED INDEX [idx_ClaimSummaryHist20072008_5Keys] ON [dbo].[ClaimSummaryHist20072008] 
(
	[AEPCLICOD] ASC,
	[AEPACCCOD] ASC,
	[AEPAGRCOD] ASC,
	[AEPAGRSFX] ASC,
	[AEPPRDCOD] ASC,
	[AEPYRMON] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]

Delete ClaimSummaryHist20072008
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist20072008 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
-------- Claims
-- 
IF EXISTS(Select * From sys.objects where name = 'ClaimsHist20072008')
   DROP TABLE ClaimsHist20072008
   
	CREATE TABLE [dbo].[ClaimsHist20072008](
		[PRDCLICOD] [varchar](3) NOT NULL,
		[PRDACCCOD] [varchar](10) NOT NULL,
		[PRDAGRCOD] [varchar](20) NOT NULL,
		[PRDAGRSFX] [varchar](3) NOT NULL,
		[PRDPRDCOD] [varchar](10) NOT NULL,
		[PRDCLMTID] [numeric](11, 0) NOT NULL,
		[PRDPAYSTS] [CHAR](1) NOT NULL,
		[PRDPRTDATMIN] bigint  NULL,
		[PRDPRTDAT] int  NULL
	) ON [FactData20072008]

INSERT dbo.ClaimsHist20072008 (PRDCLICOD, PRDACCCOD, PRDAGRCOD, PRDAGRSFX, PRDPRDCOD, PRDCLMTID, PRDPAYSTS, PRDPRTDATMIN)
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

UPDATE ClaimsHist20072008 SET PRDPRTDAT=LEFT(PRDPRTDATMIN,6)

CREATE NONCLUSTERED INDEX [idx_ClaimsHist20072008_PRDPRTDAT] ON [dbo].[ClaimsHist20072008] 
(
	[PRDPRTDAT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]

CREATE NONCLUSTERED INDEX [idx_ClaimsHist20072008_5Keys] ON [dbo].[ClaimsHist20072008] 
(
	PRDCLICOD ASC,
	PRDACCCOD ASC,
	PRDAGRCOD ASC,
	PRDAGRSFX ASC,
	PRDPRDCOD ASC,
	PRDPRTDAT ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]


-- REMOVE VOIDED CLAIMS
Delete CL
--Select *
From dbo.ClaimsHist20072008 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist20072008 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT


Delete CL
--Select *
From dbo.ClaimsHist20072008 CL
INNER JOIN 
(	Select PRDCLMTID, PRDPRTDAT FROM dbo.ClaimsHist20072008 WHERE PRDPAYSTS='V'
	GROUP BY PRDCLMTID, PRDPRTDAT 
) AS Voided on Voided.PRDCLMTID=CL.PRDCLMTID AND voided.PRDPRTDAT=CL.PRDPRTDAT

Delete ClaimsHist20072008 Where PRDCLMTID=0 OR PRDPRTDAT=0

Delete ClaimsHist20072008 Where PRDAGRCOD=''

Delete ClaimsHist20072008 Where PRDPRTDAT>(Select MAX(AEPYRMON) FROM ClaimSummaryHist20072008)

UPDATE ClaimsHist20072008 
SET PRDCLICOD=LTRIM(RTRIM(PRDCLICOD)),
PRDACCCOD=LTRIM(RTRIM(PRDACCCOD)),
PRDAGRCOD=LTRIM(RTRIM(PRDAGRCOD)),
PRDAGRSFX=LTRIM(RTRIM(PRDAGRSFX)),
PRDPRDCOD=LTRIM(RTRIM(PRDPRDCOD))

------------------ DROP INDEXES FREOM FACT 
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Period')
DROP INDEX [Idx_FactSales20072008_Period] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Account')
DROP INDEX [Idx_FactSales20072008_Account] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_NationalAccount')
DROP INDEX [Idx_FactSales20072008_NationalAccount] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_NewUsed')
DROP INDEX [Idx_FactSales20072008_NewUsed] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Partner')
DROP INDEX [Idx_FactSales20072008_Partner] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_Partner_Prod')
DROP INDEX [Idx_FactSales20072008_Partner_Prod] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_PName_Other')
DROP INDEX [Idx_FactSales20072008_PName_Other] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_PRD_PRF')
DROP INDEX [Idx_FactSales20072008_PRD_PRF] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_ProductType_Period')
DROP INDEX [Idx_FactSales20072008_ProductType_Period] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'idx_FactSales20072008_ProductType_Period_Term')
DROP INDEX [idx_FactSales20072008_ProductType_Period_Term] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_State')
DROP INDEX [Idx_FactSales20072008_State] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_FactSales20072008_UniqueIdx')
DROP INDEX [Idx_FactSales20072008_UniqueIdx] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'idx_FactSales20072008_PName')
DROP INDEX [idx_FactSales20072008_PName] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales20072008]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales20072008] WITH ( ONLINE = OFF )

------------------------- DELETE FactSales20072008 for this period.
--Delete FactSales20072008 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales20072008 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales20072008 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM SalesDisbDataHist20072008 H (NOLOCK)
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

--UPDATE FactSales20072008 SET AmendedReserves=ISNULL(CASE WHEN Period<>AgreementPostedPeriod THEN CURAmt ELSE 0.0 END,0.0)+ISNULL(AMDAmt, 0.0)
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales20072008 FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN ClaimSummaryHist20072008 H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist20072008
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

-------------- INSERT EARNINGS RECORDS
SELECT ID=MIn(ID) into #tmp3 FROM FactSales20072008 FS GROUP BY FS.AgreementID
INSERT FactSales20072008 ( 
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
         	
       From  ClaimSummaryHist20072008 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					--AND A.AgreementID=147089
	   INNER JOIN FactSales20072008 FS ON A.AgreementID=FS.AgreementID AND ID IN (SELECT ID FROM #tmp3)	
	   LEFT JOIN FactSales20072008 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist20072008
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 
	
	-------------------- RECREATE INDEXES --------------------------------------------------
	
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Period] ON [dbo].[FactSales20072008] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Account] ON [dbo].[FactSales20072008] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_NationalAccount] ON [dbo].[FactSales20072008] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_NewUsed] ON [dbo].[FactSales20072008] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Partner] ON [dbo].[FactSales20072008] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_Partner_Prod] ON [dbo].[FactSales20072008] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_PName_Other] ON [dbo].[FactSales20072008] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_PRD_PRF] ON [dbo].[FactSales20072008] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_ProductType_Period] ON [dbo].[FactSales20072008] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_FactSales20072008_ProductType_Period_Term] ON [dbo].[FactSales20072008] 
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_State] ON [dbo].[FactSales20072008] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [Idx_FactSales20072008_UniqueIdx] ON [dbo].[FactSales20072008] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]
CREATE NONCLUSTERED INDEX [idx_FactSales20072008_PName] ON [dbo].[FactSales20072008] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData20072008]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2006]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[_ETL_IDL_T2T3_GetTier23SalesData2006]
@FromPeriod bigint,
@ToPeriod bigint
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;
Declare @PYRMONFROM int = Convert(int, LEFT(Convert(Varchar, @FromPeriod),6))
Declare @PYRMONTO int = Convert(int, LEFT(Convert(Varchar, @ToPeriod),6))
-- GetTier23SalesData2006 19000000, 20140131

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
																  PLN.APVFLDCOD = '~MVPLNCOD' AND PLN.apvflddsc NOT like 'Cov%'
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
							  
	  							  

							  WHERE ADMEFRTYN = 'Y' AND (ADMDISTYP='RESV' 
							                              OR ADMDISCOD IN ('ASGDFADM','BASEADMIN','CANCELFEE','CLAIMRESV','EFGADMIN','EXCINS','OKWARACT','RASADMIN','REPOF','ROADADMIN'))

							 
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
LEFT JOIN DimProductCategory PC ON PC.SourceKey=P.ProductCategory --AND D.ProductCategoryID=PC.ProductCategoryID
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

Delete ClaimSummaryHist2006
WHERE ISNULL(AEPCLMITD,0)=0 AND ISNULL(AEPCLMCM,0)=0 AND ISNULL(AEPERNCM,0)=0 AND ISNULL(AEPERNITD,0)=0

UPDATE ClaimSummaryHist2006 
SET AEPCLICOD=LTRIM(RTRIM(AEPCLICOD)),
AEPACCCOD=LTRIM(RTRIM(AEPACCCOD)),
AEPAGRCOD=LTRIM(RTRIM(AEPAGRCOD)),
AEPAGRSFX=LTRIM(RTRIM(AEPAGRSFX)),
AEPPRDCOD=LTRIM(RTRIM(AEPPRDCOD))
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
--Delete FactSales2006 Where Period Between @FromPeriod And @ToPeriod
Truncate Table FactSales2006 
--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2006 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


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
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_UniqueIdx] ON [dbo].[FactSales2006] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_FactSales2006_PName] ON [dbo].[FactSales2006] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED



GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_BuildFact]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[_ETL_IDL_T2T3_BuildFact]
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;

TRUNCATE TABLE FactSales

EXEC ShrinkLogFile;

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
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_FactSales_UniqueIdx')
DROP INDEX [Idx_FactSales_UniqueIdx] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'idx_FactSales_PName')
DROP INDEX [idx_FactSales_PName] ON [dbo].[FactSales] WITH ( ONLINE = OFF )
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FactSales]') AND name = N'Idx_u_AgreementID_Period')
DROP INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales] WITH ( ONLINE = OFF )

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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


 FROM Staging.dbo.SalesDisbDataHist H (NOLOCK)
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

EXEC ShrinkLogFile;
 
		 
UPDATE FS SET 
EarnedReserves=ISNULL(AEPERNCM,0),
EarnedReservesITD=ISNULL(AEPERNITD,0),
ClaimsPaid=ISNULL(AEPCLMCM,0),
ClaimsPaidITD=ISNULL(AEPCLMITD,0),
ClaimsCount=ISNULL(CH.Claims,0),
ClaimsPaidCount=ISNULL(CH.Claims,0),
UnearnedReserves=FS.NetReserves-AEPERNCM

       From FactSales FS 
		INNER JOIN DimAgreement A ON A.AgreementID=FS.AgreementID
		INNER JOIN Staging.dbo.ClaimSummaryHist H ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD
					 AND LEFT(FS.Period,6)=H.AEPYRMON							 
		LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From Staging.dbo.ClaimsHist
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT

EXEC ShrinkLogFile;

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
EXEC ShrinkLogFile;
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
         	
       From  Staging.dbo.ClaimSummaryHist H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From Staging.dbo.ClaimsHist
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

EXEC ShrinkLogFile;

UPDATE FactSales Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

EXEC ShrinkLogFile;

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales2 WHERE NetReserves>0 Order by AgreementID
	-------------------- RECREATE INDEXES --------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX [Idx_u_AgreementID_Period] ON [dbo].[FactSales] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
CREATE NONCLUSTERED INDEX [Idx_FactSales_Period] ON [dbo].[FactSales] 
(
	[Period] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_Account] ON [dbo].[FactSales] 
(
	[AccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_NationalAccount] ON [dbo].[FactSales] 
(
	[NationalAccountID] ASC,
	[SalesManagerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_NewUsed] ON [dbo].[FactSales] 
(
	[VehicleStateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_Partner] ON [dbo].[FactSales] 
(
	[PartnerID] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_Partner_Prod] ON [dbo].[FactSales] 
(
	[PartnerID] ASC
)
INCLUDE ( [ProductNameID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_PName_Other] ON [dbo].[FactSales] 
(
	[ProductNameID] ASC,
	[PartnerID] ASC,
	[Period] ASC
)
INCLUDE ( [AccountID],
[SalesManagerID],
[StateID],
[NationalAccountID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_PRD_PRF] ON [dbo].[FactSales] 
(
	[Period] ASC,
	[ProductNameID] ASC,
	[AccountID] ASC,
	[SalesManagerID] ASC,
	[StateID] ASC,
	[NationalAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
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
[GrossReserves]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_State] ON [dbo].[FactSales] 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [Idx_FactSales_UniqueIdx] ON [dbo].[FactSales] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]
CREATE NONCLUSTERED INDEX [idx_FactSales_PName] ON [dbo].[FactSales] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED
EXEC ShrinkLogFile;


GO

/****** Object:  StoredProcedure [dbo].[_ETL_T2T3_ProcessReportsParameters]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[_ETL_T2T3_ProcessReportsParameters]
AS
Truncate Table T2T3ReportsParameters
INSERT T2T3ReportsParameters
SELECT Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID
From FactSalesAggregate (NOLOCK)
WHERE Period>=20080131
Group By Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID


--Select * From #tmp t
--left join T2T3ReportsParameters p on p.Period=t.Period And p.PartnerID=t.PartnerID And p.ProductCategoryID=t.ProductCategoryID and p.ProductNameID=t.ProductNameID and p.ProductTypeID=t.ProductTypeID
--Where p.Period is null

--Select * From T2T3ReportsParameters p
--left join  #tmp t on p.Period=t.Period And p.PartnerID=t.PartnerID And p.ProductCategoryID=t.ProductCategoryID and p.ProductNameID=t.ProductNameID and p.ProductTypeID=t.ProductTypeID
--Where t.Period is null

--Select * FROM 
--(
--SELECT Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID
--From FactSalesAggregate (NOLOCK)
--WHERE Period<20080131
--Group By Period, PartnerID, ProductNameID, ProductTypeID, ProductCategoryID
--) AS t
--left join T2T3ReportsParameters p on p.PartnerID=t.PartnerID And p.ProductCategoryID=t.ProductCategoryID and p.ProductNameID=t.ProductNameID and p.ProductTypeID=t.ProductTypeID
--Where p.Period is null


GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_CompressHistory]    Script Date: 4/10/2014 10:32:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[_ETL_IDL_T2T3_CompressHistory]
AS
SET TRANSACTION ISOLaTION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

Begin Transaction
IF exists(Select * from sys.objects where name = 'HistoryCandidates' and type='u') 
	 drop table T3Permutations

Select ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, 
NationalAccountID, TermID, AgreementID,PlanID, FourPartKeyID,
Period=MAX(Period),AgreementPostedPeriod=MAX(AgreementPostedPeriod),CancelCount=Sum(CancelCount), ClaimsCount=Sum(ClaimsCount), 
ClaimsPaidCount=Sum(ClaimsPaidCount), NetContractCount=Sum(NetContractCount),GrossContractCount=Sum(GrossContractCount), CURCount=Sum(CURCount), 
AMDCount=Sum(AMDCount), CANCount=Sum(CANCount), RENCount=Sum(RENCount), CURAmt=Sum(CURAmt), CANAmt=Sum(CANAmt), AMDAmt=Sum(AMDAmt), RENAmt=Sum(RENAmt), 
ClaimsPaid=Sum(ClaimsPaid), EarnedReserves=Sum(EarnedReserves), NetReserves=Sum(NetReserves), GrossReserves=Sum(GrossReserves), 
UnearnedReserves=Sum(UnearnedReserves), NetWrittenReserves=Sum(NetWrittenReserves), GrossWrittenReserves=Sum(GrossWrittenReserves), 
PremiumReserves=Sum(PremiumReserves), AmendedReserves=Sum(AmendedReserves), ClaimsPaidITD=99999999, EarnedReservesITD=99999999, LastPostedPeriod=MAX(Period), ETLExtractDateTime=MAX(ETLExtractDateTime), ETLUpdateDateTime=MAX(ETLUpdateDateTime)
Into StagingSales.dbo.HistoryCandidates 
From FactSales2006 
Group by  ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, 
TermID, AgreementID,PlanID, FourPartKeyID
Commit Transaction

EXEC StagingSales.dbo.shrinklogfile;


Begin Transaction
UPDATE t Set ClaimsPaidITD=FS.ClaimsPaidITD, EarnedReservesITD=FS.EarnedReservesITD, LastPostedPeriod=t.Period
From Staging.dbo.HistoryCandidates t
INNER JOIN FactSales2006 FS ON FS.Period=t.Period AND FS.AgreementID=t.AgreementID
Commit Transaction

exec StagingSales.dbo.shrinklogfile;

Truncate Table FactSales2006


INSERT FactSales2006 (
Period, ProductNameID, ProductTypeID, ProductCategoryID, CoverageID, PartnerID, AccountID, SalesManagerID, StateID, VehicleStateID, NationalAccountID, 
TermID, AgreementID,PlanID, FourPartKeyID,AgreementPostedPeriod,CancelCount, ClaimsCount, ClaimsPaidCount, NetContractCount,
GrossContractCount, CURCount, AMDCount, CANCount, RENCount, CURAmt, CANAmt, AMDAmt, RENAmt, ClaimsPaid, EarnedReserves, NetReserves, 
GrossReserves, UnearnedReserves, NetWrittenReserves,GrossWrittenReserves, PremiumReserves, AmendedReserves,FS.ClaimsPaidITD,FS.EarnedReservesITD, LastPostedPeriod, ETLExtractDateTime, ETLUpdateDateTime
  )
Select 
20061231, t.ProductNameID, t.ProductTypeID, t.ProductCategoryID, t.CoverageID, t.PartnerID, t.AccountID, t.SalesManagerID, t.StateID, t.VehicleStateID, t.NationalAccountID, 
t.TermID, t.AgreementID,t.PlanID, t.FourPartKeyID,t.AgreementPostedPeriod,t.CancelCount, t.ClaimsCount, t.ClaimsPaidCount, t.NetContractCount,
t.GrossContractCount, t.CURCount, t.AMDCount, t.CANCount, t.RENCount, t.CURAmt, t.CANAmt, t.AMDAmt, t.RENAmt, t.ClaimsPaid, t.EarnedReserves, t.NetReserves, 
t.GrossReserves, t.UnearnedReserves, t.NetWrittenReserves,t.GrossWrittenReserves, t.PremiumReserves, t.AmendedReserves,t.ClaimsPaidITD,t.EarnedReservesITD, LastPostedPeriod, ETLExtractDateTime, ETLUpdateDateTime
From Prior2007.dbo.HistoryCandidates t

exec shrinklogfile;


GO

/****** Object:  StoredProcedure [dbo].[_ETL_IDL_T2T3_BuildFact2006]    Script Date: 4/10/2014 10:32:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[_ETL_IDL_T2T3_BuildFact2006]
AS
SET TRANsACTION ISOLATION LEVEL READ UNCOMMITTED;

TRUNCATE TABLE FactSales2006

EXEC ShrinkLogFile;

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

--------------- FILL THE FACT ---------------------------------------------------
INSERT FactSales2006 ( 
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
RENAmt=ISNULL(Sum(CASE WHEN ADMTRNTYP='REN' THEN H.NetAmount ELSE 0 END),0), GetDate(), GetDate()


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
--WHERE ADMPSTDAT=20060131
GROUP BY CAL.DATEID, AGMPSTDAT, AGR.AgreementID, AN.AccountID, PRT.PartnerID, NA.NationalAccountID, SM.SalesManagerID, 
         ST.StateID, pc.ProductCategoryID, pt.ProductTypeID, pn.ProductNameID, cv.CoverageID, 
         tm.TermID, vs.VehicleStateID, PLN.PlanID, FPPK.KeyID

EXEC ShrinkLogFile;
 
		 
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

EXEC ShrinkLogFile;

-------------- INSERT EARNINGS RECORDS For Dimensional Lookups
INSERT BaseAgreementData (AgreementID, AccountID, PartnerID, NationalAccountID, SalesManagerID, StateID, ProductCategoryID, ProductTypeID, ProductNameID, CoverageID, TermID, VehicleStateID, PlanID, FourPartKeyID, AgreementPostedPeriod, NetReserves )
SELECT FS.AgreementID, AccountID=MIN(FS.AccountID), PartnerID=MIN(FS.PartnerID), NationalAccountID=MIN(FS.NationalAccountID), SalesManagerID=MIN(FS.SalesManagerID), 
	StateID=MIN(FS.StateID), ProductCategoryID=MIN(FS.ProductCategoryID), ProductTypeID=MIN(FS.ProductTypeID), ProductNameID=MIN(FS.ProductNameID), CoverageID=MIN(FS.CoverageID),   
	TermID=MIN(FS.TermID), VehicleStateID=MIN(FS.VehicleStateID), PlanID=MIN(FS.PlanID), FourPartKeyID=MIN(FS.FourPartKeyID), AgreementPostedPeriod=MIN(FS.AgreementPostedPeriod), NetReserves=0	
FROM FactSales FS (NOLOCK)
LEFT JOIN BaseAgreementData BA (NOLOCK) ON BA.AgreementID=FS.AgreementID
WHERE BA.AgreementID IS NULL
Group by FS.AgreementID
----------------------------------------------------
EXEC ShrinkLogFile;
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
         	
       From  ClaimSummaryHist2006 H
       INNER JOIN Calendar C ON C.CalendarDate=DateAdd(d, -1, DateADD(m, 1 , Convert(DateTime, LEFT(H.AEPYRMON,4) + RIGHT(H.AEPYRMON,2)	+ '01')))
       INNER JOIN  DimAgreement A ON A.SourceCLICOD=H.AEPCLICOD AND A.SourceACCCOD=H.AEPACCCOD 
					AND A.SourceAGRCOD=H.AEPAGRCOD AND A.SourceAGRSFX=H.AEPAGRSFX AND
					A.SourcePRDCOD=H.AEPPRDCOD		
	   INNER JOIN BaseAgreementData BA ON BA.AgreementID=A.AgreementID
	   LEFT JOIN FactSales2006 FS2 ON FS2.AgreementID=A.AgreementID AND FS2.Period=C.DateID
	   LEFT JOIN 
		(Select  PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD,PRDPRTDAT ,Claims=ISNULL(COUNT(distinct PRDCLMTID),0)
			From ClaimsHist2006
			Group by PRDCLICOD,PRDACCCOD,PRDAGRCOD,PRDAGRSFX,PRDPRDCOD, PRDPRTDAT
			) AS CH ON CH.PRDCLICOD=H.AEPCLICOD AND CH.PRDACCCOD=H.AEPACCCOD AND CH.PRDAGRCOD=AEPAGRCOD AND CH.PRDAGRSFX=H.AEPAGRSFX AND CH.PRDPRDCOD=H.AEPPRDCOD AND H.AEPYRMON=CH.PRDPRTDAT
	WHERE FS2.ID IS NULL 

EXEC ShrinkLogFile;

UPDATE FactSales2006 Set UnearnedReserves=NetReserves-EarnedReserves Where NetReserves>0

EXEC ShrinkLogFile;

	--Select Agreementid, NetReserves, EarnedREserves, UnearnedReserves from FactSales20062 WHERE NetReserves>0 Order by AgreementID
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
CREATE NONCLUSTERED INDEX [Idx_FactSales2006_UniqueIdx] ON [dbo].[FactSales2006] 
(
	[Period] ASC,
	[AgreementID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]
CREATE NONCLUSTERED INDEX [idx_FactSales2006_PName] ON [dbo].[FactSales2006] 
(
	[ProductNameID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [FactData2006]

--------------------- RECREATE AGGREGATE TABLES IF NEEDED
EXEC ShrinkLogFile;


GO

/****** Object:  StoredProcedure [dbo].[_ETL_T2T3_AggregateFactSales]    Script Date: 4/10/2014 10:32:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[_ETL_T2T3_AggregateFactSales]
@Period bigint
--AggregateFactSales 201402

AS 

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



GO














