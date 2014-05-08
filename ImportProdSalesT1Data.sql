
Truncate Table [dbo].[AD_Groups]
INSERT [dbo].[AD_Groups] (CN, DN, Email, ADSPath, sAMAccountName, WhenCreated, WhenChanged, userAccountControl)
Select * from [SV-SQLPRODVM].EFGSales.dbo.AD_Groups

delete dbo.SecSalesUserRole
delete dbo.SecSalesUserDataAccess
delete [dbo].[SecSalesUser]
delete [dbo].[ADUser]

INSERT [dbo].[ADUser]
Select * from [SV-SQLPRODVM].EFGSales.dbo.[ADUser]

INSERT [dbo].[SecSalesUser]
Select * from [SV-SQLPRODVM].EFGSales.dbo.[SecSalesUser]

SET IDENTITY_INSERT [SecSalesUserDataAccess] ON
INSERT [dbo].SecSalesUserDataAccess (AccessID, SalesUserID, LOBID, RepID, FullAccessLOB, RoleID, CreatedBy, UpdatedBy, Deleted, CreatedDate, UpdatedDate)
Select * from [SV-SQLPRODVM].EFGSales.dbo.SecSalesUserDataAccess
SET IDENTITY_INSERT [SecSalesUserDataAccess] OFF

INSERT dbo.SecSalesUserRole 
Select * from [SV-SQLPRODVM].EFGSales.dbo.SecSalesUserRole

SET IDENTITY_INSERT [ADGroup] ON
delete [dbo].[ADGroup]
INSERT [dbo].[ADGroup] (GroupID, GroupName, DateCreated)
Select * from [SV-SQLPRODVM].EFGSales.dbo.ADGroup
SET IDENTITY_INSERT [ADGroup] OFF



Truncate Table [dbo].[ADUserGroup]
INSERT [dbo].[ADUserGroup] (GroupID, UserID)
Select * from [SV-SQLPRODVM].EFGSales.dbo.[ADUserGroup]

truncate table [dbo].[ETL_Log]
SET IDENTITY_INSERT [dbo].[ETL_Log] ON
INSERT [dbo].[ETL_Log] (LogID, ReportTier, ScheduledDataSet, ETLRunDateTime, PostPeriod, PostDate, Success, ExceptionMessage, RecordCount, Parameters, ProcedureName)
Select * From [SV-SQLPRODVM].EFGSales.[dbo].[ETL_Log]
SET IDENTITY_INSERT [dbo].[ETL_Log] OFF

drop table [AD_Group_Members] 
Select * into [dbo].[AD_Group_Members] From [SV-SQLPRODVM].EFGSales.[dbo].[AD_Group_Members]

truncate table [dbo].[SAL002_Tier1_Sales]
SET IDENTITY_INSERT [dbo].[SAL002_Tier1_Sales] ON
INSERT [dbo].[SAL002_Tier1_Sales] (ID, APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD, Disbursement_Code, Disbursement_Amount, NON_CANCELFEE_STATUS, ETLDateTime, LOB, cprog, cprod, cplan, Program_Code, Product_Category, Super_Category, Src_LOB, Src_EFG_Rep, AGMPSTDAT, ADMENTDAT, ADMEFFDAT, ADMRECDAT, GrossAmount, GrossCount, NetAmount, NetCount, TXPostDate, AGRPostDate, TXEntryDate, TXEffectiveDate, TXRecordDate, ProductName, ProductType, ProductCategory)
Select * From [SV-SQLPRODVM].EFGSales.[dbo].[SAL002_Tier1_Sales]
SET IDENTITY_INSERT [dbo].[SAL002_Tier1_Sales] OFF

truncate table [dbo].[SAL002_Tier1_Sales_YTD]
SET IDENTITY_INSERT [dbo].[SAL002_Tier1_Sales_YTD] ON
INSERT [dbo].[SAL002_Tier1_Sales_YTD] (ID, APVALPVAL, ADMPSTDAT, ADMCLICOD, ADMACCCOD, ADMAGRCOD, ADMAGRSFX, EFG_Rep, Account_Group, Dealer_Name, ADMTRNTYP, ADMDISTYP, AGMPRGCOD, Disbursement_Code, Disbursement_Amount, NON_CANCELFEE_STATUS, ETLDateTime, LOB, cprog, cprod, cplan, Program_Code, Product_Category, Super_Category, Src_LOB, Src_EFG_Rep, AGMPSTDAT, ADMENTDAT, ADMEFFDAT, ADMRECDAT, GrossAmount, GrossCount, NetAmount, NetCount, TXPostDate, AGRPostDate, TXEntryDate, TXEffectiveDate, TXRecordDate, ProductName, ProductType, ProductCategory)
Select * From [SV-SQLPRODVM].EFGSales.[dbo].[SAL002_Tier1_Sales_YTD]
SET IDENTITY_INSERT [dbo].[SAL002_Tier1_Sales_YTD] OFF



