USE [RptDataDaily_Dev]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesRoleEmailedReports]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesRoleEmailedReports]
GO

CREATE TABLE [dbo].[SecSalesRoleEmailedReports](
	[EmailedReportID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
CONSTRAINT [PK_SalesRoleEmailedReport] PRIMARY KEY CLUSTERED 
(
	[EmailedReportID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesPostedReports]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesPostedReports]
GO
CREATE TABLE [dbo].[SecSalesPostedReports](
	[PostedReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [varchar](350) NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SecSalesPostedReports] PRIMARY KEY CLUSTERED 
(
	[PostedReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesUserEmailSub]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesUserEmailSub]
GO
CREATE TABLE [dbo].[SecSalesUserEmailSub](
	[UserID] [varchar](250) NOT NULL,
	[EmailedReportID] [int] NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SecSalesUserEmailSub] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[EmailedReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesEmailedReports]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesEmailedReports]
GO
CREATE TABLE [dbo].[SecSalesEmailedReports](
	[EmailedReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [varchar](350) NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SecSalesEmailedReports] PRIMARY KEY CLUSTERED 
(
	[EmailedReportID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesUserRoles]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesUserRoles]
GO
CREATE TABLE [dbo].[SecSalesUserRoles](
	[RoleID] [int] NOT NULL,
	[UserID] [varchar](250) NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SecSalesUserRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesRoles]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesRoles]
GO
CREATE TABLE [dbo].[SecSalesRoles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](350) NOT NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SecSalesRoles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesUsersDataAccess]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesUsersDataAccess]
GO
CREATE TABLE [dbo].[SecSalesUsersDataAccess](
	[AccessID] bigint IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](250) NOT NULL,
	[LOBID] [int] NOT NULL,
	[RepID] [int] NULL,
	[FullAccessLOB] [bit] NULL,
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,		
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SecSalesUsersDataPermission] PRIMARY KEY CLUSTERED 
(
	[AccessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecSalesUsers]') AND type in (N'U'))
DROP TABLE [dbo].[SecSalesUsers]
GO
CREATE TABLE [dbo].[SecSalesUsers](
	[UserID] [varchar](250) NOT NULL,
	[Domain] [varchar](250) NOT NULL,
	[FirstName] [varchar](350) NULL,
	[LastName] [varchar](350) NULL,
	[Email] [varchar](350) NULL,
	[isActive] [bit] NOT NULL Default(1),
	[CreatedBy] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
	[ADWhenCreated] [datetime] NULL ,
	[ADWhenChanged] [datetime] NULL ,
 CONSTRAINT [PK_SecSalesUsers] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalesLOBRep]') AND type in (N'U'))
DROP TABLE [dbo].[SalesLOBRep]
GO
CREATE TABLE [dbo].[SalesLOBRep](
	[RepID] [int] NOT NULL,
	[LOBID] [int] NOT NULL,
	[LOB] [varchar] (340) NOT NULL,
	[Rep] [varchar] (340) NOT NULL,
	[UpdatedBy] [varchar](255) NULL,
	[Deleted] [bit] NULL Default(0),
	[CreatedDate] [datetime] NULL Default(GetDate()),
	[UpdatedDate] [datetime] NULL Default(GetDate()),
 CONSTRAINT [PK_SalesLOBRep] PRIMARY KEY CLUSTERED 
(
	[RepID] ASC,
	[LOBID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- FK
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesUsers_SecSalesUsersDataAccess')
	ALTER TABLE dbo.SecSalesUsersDataAccess DROP CONSTRAINT FK_SecSalesUsers_SecSalesUsersDataAccess
ALTER TABLE dbo.SecSalesUsersDataAccess WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesUsers_SecSalesUsersDataAccess FOREIGN KEY (UserID) REFERENCES dbo.SecSalesUsers(UserID) 
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_Sales_LOB_SecSalesUsersDataAccess')
	ALTER TABLE dbo.SecSalesUsersDataAccess DROP CONSTRAINT FK_Sales_LOB_SecSalesUsersDataAccess
ALTER TABLE dbo.SecSalesUsersDataAccess WITH NOCHECK ADD CONSTRAINT
	FK_Sales_LOB_SecSalesUsersDataAccess FOREIGN KEY (LOBID) REFERENCES dbo.SalesLOB(LOBID) 
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_Sales_Rep_SecSalesUsersDataAccess')
	ALTER TABLE dbo.SecSalesUsersDataAccess DROP CONSTRAINT FK_Sales_Rep_SecSalesUsersDataAccess
ALTER TABLE dbo.SecSalesUsersDataAccess WITH NOCHECK ADD CONSTRAINT
	FK_Sales_Rep_SecSalesUsersDataAccess FOREIGN KEY (RepID) REFERENCES dbo.SalesRep(RepID) 	
GO	 
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesUsers_SecSalesUser
')
	ALTER TABLE dbo.SecSalesUserRoles DROP CONSTRAINT FK_SecSalesUsers_SecSalesUserRoles
ALTER TABLE dbo.SecSalesUserRoles WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesUsers_SecSalesUserRoles FOREIGN KEY (UserID) REFERENCES dbo.SecSalesUsers(UserID)
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesRoles_SecSalesUserRoles')
	ALTER TABLE dbo.SecSalesUserRoles DROP CONSTRAINT FK_SecSalesRoles_SecSalesUserRoles

ALTER TABLE dbo.SecSalesUserRoles WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesRoles_SecSalesUserRoles FOREIGN KEY (RoleID) REFERENCES dbo.SecSalesRoles(RoleID)
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesUsers_SecSalesUserEmailSub')
	ALTER TABLE dbo.SecSalesUserEmailSub DROP CONSTRAINT FK_SecSalesUsers_SecSalesUserEmailSub

ALTER TABLE dbo.SecSalesUserEmailSub WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesUsers_SecSalesUserEmailSub FOREIGN KEY (UserID) REFERENCES dbo.SecSalesUsers(UserID)
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesEmailedReports_SecSalesUserEmailSub')
	ALTER TABLE dbo.SecSalesUserEmailSub DROP CONSTRAINT FK_SecSalesEmailedReports_SecSalesUserEmailSub

ALTER TABLE dbo.SecSalesUserEmailSub 
WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesEmailedReports_SecSalesUserEmailSub FOREIGN KEY (EmailedReportID) REFERENCES dbo.SecSalesEmailedReports(EmailedReportID)
	
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesRoles_SecSalesRoleEmailedReports')
	ALTER TABLE dbo.SecSalesRoleEmailedReports DROP CONSTRAINT FK_SecSalesRoles_SecSalesRoleEmailedReports

ALTER TABLE dbo.SecSalesRoleEmailedReports WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesRoles_SecSalesRoleEmailedReports FOREIGN KEY (RoleID) REFERENCES dbo.SecSalesRoles(RoleID)
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SecSalesEmailedReports_SecSalesRoleEmailedReports')
	ALTER TABLE dbo.SecSalesRoleEmailedReports DROP CONSTRAINT FK_SecSalesEmailedReports_SecSalesRoleEmailedReports

ALTER TABLE dbo.SecSalesRoleEmailedReports WITH NOCHECK ADD CONSTRAINT
	FK_SecSalesEmailedReports_SecSalesRoleEmailedReports FOREIGN KEY (EmailedReportID) REFERENCES dbo.SecSalesEmailedReports(EmailedReportID)
GO
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SalesLOB_SalesLOBRep')
	ALTER TABLE dbo.SalesLOBRep DROP CONSTRAINT FK_SalesLOB_SalesLOBRep


ALTER TABLE dbo.SalesLOBRep WITH NOCHECK ADD CONSTRAINT
	FK_SalesLOB_SalesLOBRep FOREIGN KEY (LOBID) REFERENCES dbo.SalesLOB(LOBID)
GO		
IF EXISTS(Select * from sys.objects  WHERE [type]='F' AND name ='FK_SalesRep_SalesLOBRep')
	ALTER TABLE dbo.SalesLOBRep DROP CONSTRAINT FK_SalesRep_SalesLOBRep

ALTER TABLE dbo.SalesLOBRep WITH NOCHECK ADD CONSTRAINT
	FK_SalesRep_SalesLOBRep FOREIGN KEY (RepID) REFERENCES dbo.SalesRep(RepID)
GO --FK NOCHECK
ALTER TABLE dbo.SecSalesUsersDataAccess
	NOCHECK CONSTRAINT FK_SecSalesUsers_SecSalesUsersDataAccess	 
GO
ALTER TABLE dbo.SecSalesUserRoles
	NOCHECK CONSTRAINT FK_SecSalesUsers_SecSalesUserRoles
GO
ALTER TABLE dbo.SecSalesUserRoles
	NOCHECK CONSTRAINT FK_SecSalesRoles_SecSalesUserRoles

GO
ALTER TABLE dbo.SecSalesUsersDataAccess
	NOCHECK CONSTRAINT FK_Sales_LOB_SecSalesUsersDataAccess
GO
ALTER TABLE dbo.SecSalesUsersDataAccess
	NOCHECK CONSTRAINT FK_Sales_Rep_SecSalesUsersDataAccess
GO		
ALTER TABLE dbo.SecSalesUserEmailSub
	NOCHECK CONSTRAINT FK_SecSalesUsers_SecSalesUserEmailSub 
GO
ALTER TABLE dbo.SecSalesUserEmailSub
	NOCHECK CONSTRAINT FK_SecSalesEmailedReports_SecSalesUserEmailSub
GO
ALTER TABLE dbo.SecSalesRoleEmailedReports
	NOCHECK CONSTRAINT FK_SecSalesRoles_SecSalesRoleEmailedReports
GO
ALTER TABLE dbo.SecSalesRoleEmailedReports
	NOCHECK CONSTRAINT FK_SecSalesEmailedReports_SecSalesRoleEmailedReports	
GO	
ALTER TABLE dbo.SalesLOBRep
	NOCHECK CONSTRAINT FK_SalesRep_SalesLOBRep	
GO
ALTER TABLE dbo.SalesLOBRep
	NOCHECK CONSTRAINT FK_SalesLOB_SalesLOBRep		
GO
INSERT SalesRep(Rep, UpdatedBy)
SELECT Distinct EFG_Rep, 'system' From dbo.[SAL002_Tier1_Sales_YTD]
Order by EFG_Rep 
GO
INSERT SalesLOB(LOB, UpdatedBy)
SELECT Distinct LOB, 'system' From dbo.[SAL002_Tier1_Sales_YTD]
Order by LOB
GO
INSERT [SalesLOBRep](RepID, LOBID, LOB, Rep, UpdatedBy)
Select Distinct LOBID, RepID, SL.LOB, SR.Rep, 'system' From dbo.[SAL002_Tier1_Sales_YTD] y
INNER JOIN SalesLOB SL on SL.LOB=y.LOB
INNER JOIN SalesRep SR on SR.Rep=y.EFG_Rep
GO
INSERT SecSalesRoles (RoleName,CreatedBy,UpdatedBy)
SELECT 'Executives', 'system','system' UNION
SELECT 'LOB Management', 'system','system' UNION
SELECT 'LOB Rep', 'system','system'
GO

--dbcc CHECKIDENT(SecSalesEmailedReports, RESEED,0)
--Select * from SecSalesEmailedReports 
INSERT SecSalesEmailedReports (ReportName,CreatedBy,UpdatedBy)
SELECT 'LOB Production Report by Product','system','system' UNION
SELECT 'Revenue Disbursements by LOB','system','system' UNION
SELECT 'LOB Revenue Trend','system','system' UNION
SELECT 'Production Report by Account Group','system','system' UNION
SELECT 'Production Report by Account','system','system' UNION
SELECT 'LOB Revenue Trend by Account Group','system','system' UNION
SELECT 'Month Account Performance to Plan by Rep for LOB','system','system' UNION
SELECT 'Month Account Performance to Plan by Account Group','system','system' UNION
SELECT 'Net Monthly Account Performance by Rep','system','system' UNION
SELECT 'Gross Monthly Account Performance by Representative','system','system' UNION
SELECT 'Revenue Trend by Rep','system','system' UNION
SELECT 'LOB Revenue Trend by Account Group','system','system' UNION
SELECT 'LOB Revenue Trend by Account','system','system' UNION
SELECT 'Month Account Performance to Plan by Account Group','system','system' UNION
SELECT 'Month Account Performance to Plan by Account','system','system' UNION
SELECT 'Month Account Performance to Plan by Product','system','system' UNION
SELECT 'Net Monthly Account Performance by Account Group','system','system' UNION
SELECT 'Net Monthly Account Performance by Account','system','system' UNION
SELECT 'Gross Monthly Account Performance by Account Group','system','system' UNION
SELECT 'Gross Monthly Account Performance by Account','system','system'

-- Select * from [SecSalesRoleEmailedReports]
INSERT [SecSalesRoleEmailedReports](EmailedReportID, RoleID, CreatedBy, UpdatedBy)
SELECT EmailedReportID, 1, 'system', 'system' from SecSalesEmailedReports
WHERE ReportName IN 
('LOB Production Report by Product'
,'Revenue Disbursements by LOB'
,'LOB Revenue Trend')
UNION
SELECT EmailedReportID, 2, 'system', 'system' from SecSalesEmailedReports
WHERE ReportName IN 
(
'Production Report by Account Group'
,'Production Report by Account'
,'LOB Revenue Trend by Account Group'
,'Month Account Performance to Plan by Rep for LOB'
,'Month Account Performance to Plan by Account Group'
,'Net Monthly Account Performance by Rep'
,'Gross Monthly Account Performance by Representative'
,'Revenue Trend by Rep')
UNION
SELECT EmailedReportID, 3, 'system', 'system' from SecSalesEmailedReports
WHERE ReportName IN 
(
'LOB Revenue Trend by Account Group'
,'LOB Revenue Trend by Account'
,'Month Account Performance to Plan by Account Group'
,'Month Account Performance to Plan by Account'
,'Month Account Performance to Plan by Product'
,'Net Monthly Account Performance by Account Group'
,'Net Monthly Account Performance by Account'
,'Gross Monthly Account Performance by Account Group'
,'Gross Monthly Account Performance by Account')

INSERT [SecSalesPostedReports] (ReportName, CreatedBy, UpdatedBy)
SELECT 'Gross Monthly Account Performance by Product','system','system' UNION
SELECT 'LOB Production Variance by Counts','system','system' UNION
SELECT 'LOB Production Variance by Revenue','system','system' UNION
SELECT 'Net Monthly Account Performance by Product','system','system' UNION
SELECT 'Product Contract Counts','system','system' UNION
SELECT 'Production Vairance by Revenue by Account','system','system' UNION
SELECT 'Production Variance by Counts by Account','system','system' UNION
SELECT 'Production Variance by Counts by Account Group','system','system' UNION
SELECT 'Production Variance by Revenue by Account Group','system','system' UNION
SELECT 'Revenue by Channel','system','system' UNION
SELECT 'Revenue by Product','system','system' UNION
SELECT 'Revenue Trend by Account','system','system' UNION
SELECT 'Revenue Trend by Account Group','system','system' UNION
SELECT 'Revenue Trend by Product','system','system' UNION
SELECT 'Revenue Trend by TransactionType','system','system' 

--select UserID, * from [SecSalesUsers]
INSERT [SecSalesUsers]
	([UserID],[Domain], [FirstName],[LastName], [Email], [CreatedBy],	[UpdatedBy], [ADWhenCreated], [ADWhenChanged])
SELECT distinct SAMAccountName, 'EFG-DOMAIN', FirstName, LastName, EmailAddress, 'system', 'system',WhenCreated, WhenChanged
FROM EFGDW.dbo.AD_Group_Members
where ObjectCategory like '%Person%'
and userAccountControl&2<>2 and not emailaddress is null

-- Provision ----
select * from SecSalesRoles

INSERT [SecSalesUserRoles]
	(RoleID,UserID,CreatedBy,UpdatedBy)
SELECT 1, UserID, 'system', 'system' FROM SecSalesUsers 
Where Email in ('mshipp@efgusa.com', 'uvarati@efgusa.com', 'sluce@efgusa.com', 'amaqsood@efgusa.com', 'malsbrook@efgusa.com')

--select * from [SecSalesUsersDataAccess]
INSERT [SecSalesUsersDataAccess]
	([UserID], [LOBID], [FullAccessLOB],	[CreatedBy], [UpdatedBy])
SELECT 	ur.[UserID], sl.LOBID,1,'system', 'system' from [SecSalesUserRoles] ur, [SalesLOB] sl





Select LOB from SecSalesUsersDataAccess DA
INNER JOIN dbo.SalesLOB LOB ON LOB.LOBID=DA.LOBID
Where UserID='amaqsood' and DA.FullAccessLOB=1 And DA.Deleted=0









