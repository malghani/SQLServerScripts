
--------------- SUSPENSIONS------------------------------------------------------
						 
Alter table [dbo].[SAL002_Tier1_Sales_YTD]
	alter column Disbursement_Amount numeric(18,2) not null

GO
Alter table [dbo].[SAL002_Tier1_Sales]
	alter column Disbursement_Amount numeric(18,2) not null


	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------
	----------------- ETL SP -----------------------------

GO
CREATE TABLE [dbo].[SuspendDetail](
	[Client] [varchar](3) NOT NULL,
	[Account] [varchar](10) NOT NULL,
	[contract] [varchar](20) NOT NULL,
	[SFX] [varchar](3) NOT NULL,
	[FirstName] [varchar](35) NOT NULL,
	[LastName] [varchar](35) NOT NULL,
	[PurchaseDate] [numeric](8, 0) NOT NULL,
	[Amount] [numeric](4, 2) NOT NULL,
	[PostDate] [int] NOT NULL,
	[LOB] [varchar](40) NOT NULL,
	[AsOfClosed] [bit] NOT NULL,
	[SrcLOB] [varchar](40) NULL,
	[ETLDate] [datetime] NULL,
	[PostPeriodDate] [datetime] NULL
) ON [PRIMARY]

GO


----------------------------------------- 

