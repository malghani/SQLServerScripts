
CREATE TABLE [ETL_SourceDataFilter](
	[FilterID] [bigint] IDENTITY(1,1) NOT NULL,
	[ReportTier] [varchar](30) NOT NULL,
	[FilterType] [varchar](30) NOT NULL,
	[FieldName] [varchar](30) NULL,
	[FieldValue] [varchar](200) NULL,
	[BeginDate] DateTime NULL,
	[EndDate] DateTime NULL,
	[Notes]  Varchar(1000) NULL,
	[Description]  Varchar(1000) NULL	
 CONSTRAINT [PK_ETL_SourceDataFilter] PRIMARY KEY CLUSTERED 
(
	[FilterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT ETL_SourceDataFilter
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='ASGDFADM',  BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='ASSURANT DEFERRED ADMIN FEE'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='BASEADMIN', BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='ADMINISTRATION FEES'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='CANCELFEE', BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='CANCEL FEE'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='CLAIMRESV', BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='ADDITIONAL CLAIM RESERVES'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='EFGADMIN',  BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='EFG (OLD FIMMAS) ADMIN FEE'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='EXCINS',	BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='ASSURANT EXCESS INSURANCE'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='OKWARACT',  BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='OK WARRANTY ACT'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='RASADMIN',  BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='RAS (OLD FIMMAS) ADMIN FEE'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='ROADADMIN', BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='ROADSIDE ADMIN FEE'  UNION
Select ReportTier='Sales Tier 1', FilterType='Include Only',  FiledName='ADMDISCOD', ADMDISCOD='REPOF',		BeginDate=GetDate(), NULL, Notes='Sales Disbursments (ADMDISCOD) from the SCAGRDM table in AS400', [Desc]='REPS OVERFUND' 

